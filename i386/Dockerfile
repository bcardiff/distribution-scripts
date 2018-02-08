FROM i386/ubuntu:16.04

ADD ./omnibus/Gemfile* /omnibus/

RUN /bin/bash -c 'apt-get update \
 && apt-get install -y curl git gnupg build-essential software-properties-common \
 && apt-add-repository -y ppa:rael-gc/rvm \
 && apt-get update \
 && apt-get install -y rvm'

RUN /bin/bash -l -c 'rvm install ruby-2.4.2 --disable-binary \
 && rvm --default use ruby-2.4.2 \
 && ruby --version \
 && gem install bundler --no-rdoc --no-ri'

RUN /bin/bash -l -c 'echo "Preparing omnibus" \
 && apt-get -q -y install git reprepro dpkg-sig fakeroot \
 && git config --global user.email "crystal@manas.tech" \
 && git config --global user.name "Crystal Team" \
 && cd /omnibus \
 && bundle install --jobs=8'
