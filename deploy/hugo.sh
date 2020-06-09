#!/bin/sh -e

cd /home/app/site
hugo -w --minify >> log/hugo.log 2>&1
