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
    "host"      : os.environ.get("SQUEUE_HOSTNAME","db-internal"),
    "db"        : os.environ.get("SQUEUE_DATABASE","portal"),
    "user"      : os.environ.get("SQUEUE_USERNAME","squeuedb"),
    "passwd"    : os.environ.get("SQUEUE_PASSWORD","squeuedb"),
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
        Can we update the squeue table?
        '''
        updateSqueue.main(once=True)
        connection = MySQLdb.connect(**SQL_DSN)
        cursor = connection.cursor()
        cursor.execute('select count(*) from jobs_squeueresults')
        row = cursor.fetchone()

        self.assertTrue(row[0] == 33466, 'Incorrect number of squeue results %d' % row[0])

