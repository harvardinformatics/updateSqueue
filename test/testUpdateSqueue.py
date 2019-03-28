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
from slurm import updateSqueue

os.environ['SQUEUE_COMMAND'] = os.path.join(os.path.dirname(__file__), 'squeue')

@unittest.skipUnless(os.system('%s -h' % os.environ.get('SQUEUE_COMMAND')) == 0)
class TestUpdateSqueue(unittest.TestCase):
    '''
    Test updateSqueue
    '''
    def testUpdateSqueuel(self):
        '''
        Can we update the squeue table?
        '''
        updateSqueue.main(once=True)


