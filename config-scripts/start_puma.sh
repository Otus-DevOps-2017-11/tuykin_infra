#!/bin/bash

sudo su appuser
cd /home/appuser/reddit
puma -d
ps aux | grep puma
