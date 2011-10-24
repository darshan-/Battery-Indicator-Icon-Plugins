#!/bin/bash

# TODO: Use rsync or similar?

loc="linode:bi-icon-plugins"

scp plugins.html $loc/index.html
scp plugins.css $loc/
scp -r images $loc/
scp -r icons $loc/
