#!/usr/bin/env python
# encoding: utf-8

"""
Copyright (c) 2019
Harvard FAS Research Computing
All rights reserved.
Created on Oct 21, 2019

@author: Aaron Kitzmiller
"""
from __future__ import print_function

import os, select, subprocess, socket, logging
import sys, time
from datetime import datetime
import MySQLdb

logging.basicConfig(
    format='%(asctime)s %(message)s',
    level=logging.getLevelName(os.environ.get('UPDATE_SQUEUE_LOGLEVEL', 'INFO'))
)
logger = logging.getLogger()

# sleep interval between squeue executions
sleepytime =  10

# Number of times squeue can fail before giving up
MAX_FAIL_COUNT = 5

# Error email details
SMTP_HOST = os.environ.get("SQUEUE_SMTP_HOST","rcsmtp.rc.fas.harvard.edu")
FROM_ADDR = "root@sa01.rc.fas.harvard.edu"
TO_ADDRS = ["akitzmiller@g.harvard.edu"]

#
# List of fields as they appear in the squeue --format %all output
#
SQUEUE_FIELDS = {
"%a" : "account",
"%b" : "gres",
"%c" : "min_cpus",
"%d" : "min_tmp_disk",
"%e" : "end_time",
"%f" : "features",
"%g" : "group",
"%h" : "shared",
"%i" : "jobid",
"%j" : "name",
"%k" : "comment",
"%l" : "timelimit",
"%m" : "min_memory",
"%n" : "req_nodes",
"%o" : "command",
"%Q" : "priority",
"%q" : "qos",
"%r" : "reason",
"%u" : "user",
"%v" : "reservation",
"%y" : "nice",
"%B" : "exec_host",
"%C" : "cpus",
"%D" : "nodes",
"%E" : "dependency",
"%F" : "array_job_id",
"%K" : "array_task_id",
"%L" : "time_left",
"%M" : "time",
"%N" : "node_list",
"%O" : "contiguous",
"%P" : "partition",
"%R" : "nodelistreason",
"%S" : "start_time",
"%T" : "state",
"%U" : "user",
"%V" : "submit_time",
"%W" : "licenses",
"%Z" : "work_dir"
}
orderedkeys = sorted(SQUEUE_FIELDS.keys())
formatstring = ":::".join(orderedkeys)
print(formatstring)

SQL_DSN = {
    "host"      : os.environ.get("SQUEUE_HOST","db-internal"),
    "db"        : os.environ.get("SQUEUE_DB","portal"),
    "user"      : os.environ.get("SQUEUE_USER","squeuedb"),
    "passwd"    : os.environ.get("SQUEUE_PASSWD","squeuedb"),
}

SQUEUE_COMMAND = os.environ.get('SQUEUE_COMMAND', '/usr/bin/squeue')

MAX_ATTEMPTS = 5
CONNECTION_WAIT = 2

INTEGER_FIELDS = [
    "priority",
    "contiguous",
    "array_job_id",
    "nodes",
    "cpus",
    "nice",
    "min_cpus",
]

def main(once=False):
    '''
    main loop

    If once is True, will execute one time and then break.

    '''
    failcount = 0

    connection = None
    connection_attempts = 0
    while connection is None and connection_attempts < MAX_ATTEMPTS:
        try:
            connection = MySQLdb.connect(**SQL_DSN)
        except Exception as e:
            time.sleep(CONNECTION_WAIT)
            connection_attempts += 1
    connection.autocommit = False

    squeueq_sql = '''
        select id from jobs_squeueq limit 1
    '''
    cursor = connection.cursor()
    cursor.execute(sql,[user,partitionre,jobsre,statesre])
    row = cursor.fetchone()
    cursor.close()

    squeueq_id = int(row[0])

    while True:
        # Run the squeue command
        squeuecmd = "%s --format='%s' -h" % (SQUEUE_COMMAND, formatstring)
        p = subprocess.Popen(
            squeuecmd,
            shell=True,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE
        )
        stdout, stderr = p.communicate()

        # If it's successful process the pipe-separated lines
        if p.returncode != 0:
            failcount += 1
            logger.info("squeue command %s has failed.\n%s" % (squeuecmd,stderr))
        elif stdout == "":
            logger.info("No jobs in the queue\n")

            # If there are no results, delete any that are there
            # and update the SqueueQ
            sql = '''
                delete from jobs_squeueresults
            '''
            cursor = connection.cursor()
            cursor.execute(sql)
            sql = '''
                update jobs_squeueq set lastupdate = %s where id = %s
            '''
            cursor.execute(sql,[datetime.now().strftime('%Y-%m-%d %H:%M:%S'), squeueq_id])
            connection.commit()

            failcount = 0
        else:
            squeueresults = []
            lines = stdout.strip().split("\n")
            for line in lines:
                try:
                    sr = {}
                    values = line.strip().split(":::")
                    for i,key in enumerate(orderedkeys):
                        field = SQUEUE_FIELDS[key]
                        v = values[i].strip()
                        if (v == "(null)" or v == "N/A") and field in INTEGER_FIELDS:
                            v = 0
                        sr[field] = v
                    squeueresults.append(sr)
                except Exception as e:
                    logger.info("The following line failed to parse %s\n%s" % (line,str(e)))
            #
            # Delete existing results and insert new ones
            # in a single transaction
            #
            cursor = connection.cursor()
            cursor.execute("delete from jobs_squeueresults")
            sql = '''
                insert into jobs_squeueresults (
                    squeueq_id,
                    account,
                    gres,
                    min_cpus,
                    min_tmp_disk,
                    end_time,
                    features,
                    group,
                    shared,
                    jobid,
                    name,
                    comment,
                    timelimit,
                    min_memory,
                    req_nodes,
                    command,
                    priority,
                    qos,
                    reason,
                    user,
                    reservation,
                    nice,
                    exec_host,
                    cpus,
                    nodes,
                    dependency,
                    array_job_id,
                    array_task_id,
                    time_left,
                    time,
                    node_list,
                    contiguous,
                    partition,
                    nodelistreason,
                    start_time,
                    state,
                    user,
                    submit_time,
                    licenses,
                    work_dir
                ) values (
                    %(squeueq_id)i,
                    %(account)s,
                    %(gres)s,
                    %(min_cpus)i,
                    %(min_tmp_disk)s,
                    %(end_time)s,
                    %(features)s,
                    %(group)s,
                    %(shared)s,
                    %(jobid)s,
                    %(name)s,
                    %(comment)s,
                    %(timelimit)s,
                    %(min_memory)s,
                    %(req_nodes)s,
                    %(command)s,
                    %(priority)s,
                    %(qos)s,
                    %(reason)s,
                    %(user)s,
                    %(reservation)s,
                    %(nice)i,
                    %(exec_host)s,
                    %(cpus)i,
                    %(nodes)i,
                    %(dependency)s,
                    %(array_job_id)i,
                    %(array_task_id)s,
                    %(time_left)s,
                    %(time)s,
                    %(node_list)s,
                    %(contiguous)i,
                    %(partition)s,
                    %(nodelistreason)s,
                    %(start_time)s,
                    %(state)s,
                    %(user)s,
                    %(submit_time)s,
                    %(licenses)s,
                    %(work_dir)s
                )
            '''
            for sr in squeueresults:
                cursor.execute(sql,sr)

            cursor.execute("update jobs_squeueq set lastupdate = %s where id = %s",[datetime.now().strftime('%Y-%m-%d %H:%M:%S'), squeueq_id])
            connection.commit()
            failcount = 0
        if once:
            break
        time.sleep(sleepytime)


if __name__ == "__main__":
    sys.exit(main())
