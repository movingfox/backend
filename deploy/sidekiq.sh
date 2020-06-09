#!/bin/sh -e

cd /home/app/site
bundle exec sidekiq -C config/sidekiq.yml >> log/sidekiq.log 2>&1

