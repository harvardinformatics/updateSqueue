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
FROM_ADDR = "ifx@fas.harvard.edu"
TO_ADDRS = ["ifx@fas.harvard.edu"]

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
    "host"      : os.environ.get("UPDATE_SQUEUE_HOSTNAME","db-internal"),
    "db"        : os.environ.get("UPDATE_SQUEUE_DATABASE","portal"),
    "user"      : os.environ.get("UPDATE_SQUEUE_USERNAME","squeuedb"),
    "passwd"    : os.environ.get("UPDATE_SQUEUE_PASSWORD","squeuedb"),
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

    if connection is None:
        raise Exception('Cannot connect to database after %d attempts' % MAX_ATTEMPTS)

    connection.autocommit = False

    cursor = connection.cursor()
    cursor.execute('select id from jobs_squeueq limit 1')
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
            logger.error("squeue command %s has failed.\n%s" % (squeuecmd,stderr))
        elif stdout == "":
            logger.info("No jobs in the queue\n")

            # If there are no results, delete any that are there
            # and update the SqueueQ
            cursor = connection.cursor()
            cursor.execute('delete from jobs_squeueresults')
            sql = '''
                update jobs_squeueq set lastupdate = %s where id = %s
            '''
            cursor.execute(sql,[datetime.now().strftime('%Y-%m-%d %H:%M:%S'), squeueq_id])
            connection.commit()

            failcount = 0
        else:
            logger.debug('Squeue results found')
            squeueresults = []
            lines = stdout.decode('utf8').strip().split("\n")
            for line in lines:
                if line.startswith('EXEC_HOST:::'):
                    continue
                try:
                    sr = {}
                    values = line.strip().split(":::")
                    for i,key in enumerate(orderedkeys):
                        field = SQUEUE_FIELDS[key]
                        v = values[i].strip()
                        if field == 'command':
                            v = v[-255:]
                        if field == 'reason':
                            v = v[:50]
                        if field == 'array_task_id':
                            v = v[:50]
                        if field == 'nodelistreason':
                            v = v[:2000]
                        if field == 'workdir':
                            v = v[:2000]
                        if field in INTEGER_FIELDS:
                            if (v == "(null)" or v == "N/A"):
                                v = "0"
                            v = int(v)
                        sr[field] = v
                    squeueresults.append(sr)
                except Exception as e:
                    logger.info("The following line failed to parse %s\n%s" % (line,str(e)))

            logger.debug('%d squeue result lines', len(squeueresults))
            #
            # Delete existing results and insert new ones
            # in a single transaction
            #
            cursor = connection.cursor()
            cursor.execute("delete from jobs_squeueresults")
            sql = '''
                insert into jobs_squeueresults (
                    `squeueq_id`, `exec_host`,`cpus`,`nodes`,`dependency`,`array_job_id`,`array_task_id`,`time_left`,`time`,`node_list`,`contiguous`,`partition`,`priority`,`nodelistreason`,`start_time`,`state`,`submit_time`,`licenses`,`work_dir`,`account`,`gres`,`min_cpus`,`min_tmp_disk`,`end_time`,`features`,`group`,`shared`,`jobid`,`name`,`comment`,`timelimit`,`min_memory`,`req_nodes`,`command`,`qos`,`reason`,`user`,`reservation`,`nice`, `exc_nodes`
                ) values (
                    %s,            %s,        %s,     %s,         %s,            %s,         %s,           %s,         %s,      %s,       %s,           %s,         %s,          %s,           %s,          %s,       %s,         %s,       %s,      %s,         %s,     %s,          %s,         %s,      %s,           %s,      %s,   %s,      %s,      %s,          %s,           %s,         %s,      %s,  %s,       %s,  %s,         %s,       %s,    'null'
                )
            '''
            for sr in squeueresults:
                try:
                    ks = [squeueq_id] + [sr[SQUEUE_FIELDS[k]] for k in orderedkeys if not k == '%U']
                    cursor.execute(sql,ks)
                except Exception as e:
                    logger.error('Unable to store squeue line: %s\n%s' % (str(e), repr(ks)))


            cursor.execute("update jobs_squeueq set lastupdate = %s where id = %s",[datetime.now().strftime('%Y-%m-%d %H:%M:%S'), squeueq_id])
            connection.commit()
            failcount = 0
        if once:
            logger.debug('Only doing this once.')
            break
        time.sleep(sleepytime)


if __name__ == "__main__":
    sys.exit(main())
