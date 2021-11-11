#!/usr/bin/env python

import os
import setuptools

def load_version():
    """Execute dcm2bids.version in a global dictionary"""
    global_dict = {}
    with open(os.path.join("dcm2bids", "version.py")) as _:
        exec(_.read(), global_dict)
    return global_dict

VERSION = load_version()["__version__"]

if __name__ == '__main__':
    setuptools.setup(version=VERSION)