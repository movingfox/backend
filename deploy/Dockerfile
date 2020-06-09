# Use phusion/passenger-full as base image. To make your builds reproducible, make
# sure you lock down to a specific version, not to `latest`!
# See https://github.com/phusion/passenger-docker/blob/master/Changelog.md for
# a list of version numbers.
FROM phusion/passenger-customizable:1.0.9
MAINTAINER Fox "code@steamcomputing.com"

# Set correct environment variables.
ENV HOME /root

# Use baseimage-docker's init process.
CMD ["/sbin/my_init"]

RUN apt-get update && apt-get upgrade -y -o Dpkg::Options::="--force-confold"
RUN apt-get install -y apt-utils tzdata
RUN apt-get install -y gnupg2 gnumeric imagemagick
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install -y yarn

# If you're using the 'customizable' variant, you need to explicitly opt-in
# for features. Uncomment the features you want:
#
#   Build system and git.
RUN /pd_build/utilities.sh
#   Ruby support.
RUN /pd_build/ruby-2.6.*.sh

#   Python support.
#RUN /pd_build/python.sh
#   Node.js and Meteor support.
#RUN /pd_build/nodejs.sh

# Opt-in for Redis if you're using the 'customizable' image.
RUN /pd_build/redis.sh

# Enable the Redis service.
RUN rm -f /etc/service/redis/down
# FIXME
# Fix redis config: bind -- config for passenger-full:1.0.1
RUN sed -i 's/^bind 127.0.0.1 ::1/bind 127.0.0.1/' /etc/redis/redis.conf

# Opt-in for Memcached if you're using the 'customizable' image.
#RUN /pd_build/memcached.sh

# Enable the memcached service.
#RUN rm -f /etc/service/memcached/down

# Nginx and Passenger are disabled by default. Enable them like so:
RUN rm -f /etc/service/nginx/down
RUN rm /etc/nginx/sites-enabled/default

ADD nginx/upload_size.conf  /etc/nginx/conf.d/
ADD nginx/env.conf          /etc/nginx/main.d/
ADD nginx/site.conf         /etc/nginx/sites-enabled/

RUN gem update --system && gem update && gem clean
RUN gem uninstall fileutils && gem update fileutils --default
RUN gem install bundler

# Linux distributions' hugo packages are usually too old, so install our own instead 
ADD hugo_extended_Linux-64bit.deb /tmp
RUN apt-get install /tmp/hugo_extended_Linux-64bit.deb
RUN rm /tmp/hugo_extended_Linux-64bit.deb

# Add services to runit, but it seems not working 
ADD hugo    /etc/service/
ADD sidekiq /etc/service/

# Setup container's environment
RUN usermod  -u 1100 app
RUN groupmod -g 1100 app
RUN chown -R app:app /home/app
WORKDIR /home/app/site

# Setup git's global user settings
RUN setuser app git config --global user.email code@steamcomputing.com
RUN setuser app git config --global user.name  Fox Chao

# Clean up apt-get when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
