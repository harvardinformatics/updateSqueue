# -*- coding: utf-8 -*-

'''
setup for updateSqueue

Created on  2019-03-28

@author: Aaron Kitzmiller <aaron_kitzmiller@harvard.edu>
@copyright: 2019 The Presidents and Fellows of Harvard College. All rights reserved.
@license: GPL v2.0
'''

import re
from setuptools import setup, find_packages

def getVersion():
    """
    Retrieve the version number from the __init__ file
    """
    version = '0.0.0'
    with open('slurm/__init__.py', 'r') as f:
        contents = f.read().strip()

    m = re.search(r"__version__ = '([\d\.]+)'", contents)
    if m:
        version = m.group(1)
    return version


setup(
    name="updateSqueue",
    version=getVersion(),
    author='Aaron Kitzmiller <aaron_kitzmiller@harvard.edu>',
    author_email='aaron_kitzmiller@harvard.edu',
    description='Updates shared table of squeue results',
    license='LICENSE',
    include_package_data=True,
    url='https://github.com/harvardinformatics/updateSqueue',
    packages=find_packages(),
    long_description='URLs for FAS Informatics services',
    classifiers=[
        "Development Status :: 3 - Alpha",
        "Topic :: Utilities",
    ],
    entry_points={
        'console_scripts': [
            'updateSqueue=slurm.updateSqueue:main',
        ]
    },
)