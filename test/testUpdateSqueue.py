# -*- coding: utf-8 -*-

'''
Test updateSqueue

Created on  2019-03-28

@author: Aaron Kitzmiller <aaron_kitzmiller@harvard.edu>
@copyright: 2019 The Presidents and Fellows of Harvard College.
All rights reserved.
@license: GPL v2.0
'''
import unittest, os
import MySQLdb
from slurm import updateSqueue

os.environ['SQUEUE_COMMAND'] = os.path.join(os.path.dirname(__file__), 'squeue')
SQL_DSN = {
    "host"      : os.environ.get("UPDATE_SQUEUE_HOSTNAME","db-internal"),
    "db"        : os.environ.get("UPDATE_SQUEUE_DATABASE","portal"),
    "user"      : os.environ.get("UPDATE_SQUEUE_USERNAME","squeuedb"),
    "passwd"    : os.environ.get("UPDATE_SQUEUE_PASSWORD","squeuedb"),
}


@unittest.skipUnless(os.system('%s --help' % os.environ.get('SQUEUE_COMMAND')) == 0, 'SQUEUE_COMMAND does not work')
class TestUpdateSqueue(unittest.TestCase):
    '''
    Test updateSqueue
    '''
    def setUp(self):
        '''
        Delete the existing contents
        '''
        connection = MySQLdb.connect(**SQL_DSN)
        cursor = connection.cursor()
        cursor.execute('delete from jobs_squeueresults')
        cursor.execute('delete from jobs_squeueq')
        cursor.close()

    def testUpdateSqueuel(self):
        '''
        Update squeue table with test results.  Verify total row count and several fields from a row
        '''
        updateSqueue.main(once=True)
        connection = MySQLdb.connect(**SQL_DSN)
        cursor = connection.cursor()
        cursor.execute('select count(*) from jobs_squeueresults')
        row = cursor.fetchone()

        self.assertTrue(row[0] == 33466, 'Incorrect number of squeue results %d' % row[0])

        cursor.execute('select * from jobs_squeueresults where jobid = %s',['4747730_943'])
        desc = cursor.description
        result = [ dict(zip([col[0] for col in desc], row)) for row in cursor.fetchall()][0]
        self.assertTrue(result['account'] == 'coull_lab')
        self.assertTrue(result['work_dir'] == '/n/scratchlfs/coull_lab/jlee/Project_Viva/2_SparseCCA_Power/Scripts/Dir_SparseCCA_Power_n400/Scenario_2')
        self.assertTrue(result['submit_time'] == '2019-03-26T02:39:25')
        self.assertTrue(result['licenses'] == '(null)')

