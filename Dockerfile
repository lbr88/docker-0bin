FROM ubuntu:16.04
MAINTAINER Lars Bo Rasmussen <lrasmussen@aio-it.dk>

# update system
RUN apt-get -y update && apt-get upgrade

# get the packages needed from apt
RUN apt-get install -y python-pip unzip yui-compressor

# get modules from pip
RUN pip install --upgrade pip
RUN pip install sigtools
RUN pip install lockfile
# This is already installed but have had an error with module had no attribute "util" when running without this.
RUN pip install clize

# lets work in root
WORKDIR /root

# fetch app and unpack
ADD https://github.com/sametmax/0bin/archive/master.zip /root/master.zip
RUN unzip master.zip
RUN rm master.zip

# working in the new appdir
WORKDIR /root/0bin-master

#compress js and css files
RUN ./compress.sh

#remove yui-compressor and it's dependencies
RUN apt-get -y --purge remove yui-compressor
RUN apt-get -y autoremove

# clear the cache
RUN apt-get -y clean

# copy the config
ADD default_settings.py /root/0bin-master/zerobin/default_settings.py

#listining on 8000
EXPOSE 8000

ENTRYPOINT ["/usr/bin/python", "zerobin.py", "runserver"]
