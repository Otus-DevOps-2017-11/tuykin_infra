#!/bin/bash

cd $HOME/reddit
puma -d
ps aux | grep puma
