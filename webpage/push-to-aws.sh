#!/bin/bash

# TODO: Use rsync or similar!

scp plugins.html aws:~/aws.darshancomputing.com/bi/icon-plugins/index.html
scp plugins.css aws:~/aws.darshancomputing.com/bi/icon-plugins/
scp images/* aws:~/aws.darshancomputing.com/bi/icon-plugins/images/
scp apks/* aws:~/aws.darshancomputing.com/bi/icon-plugins/apks/
