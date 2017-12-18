# Crystal dependency builder

This image is for building the required crystal compiler dependencies from sources.

The private key must be placed in `./abuild/crystal@manas....rsa` and `.rsa.pub`.
The generated binaries will be at `./packages`.


## Build docker image

```
$ docker build -t crystal-deps-builder .
```

## One time key generation

```
$ docker run --rm -it -v $(pwd)/abuild:/home/builder/.abuild crystal-deps-builder sh
$ abuild-keygen -n
```

Note that `Dockerfile` references, in `PACKAGER_PRIVKEY`, the `.rsa` file.

## Build dependencies

```
$ docker run --rm -it -v $(pwd)/abuild:/home/builder/.abuild -v $(pwd)/packages:/packages crystal-deps-builder sh
docker $ sudo cp ~/.abuild/*.pub /etc/apk/keys/
docker $ git clone https://github.com/alpinelinux/aports.git
docker $ cd aports && git checkout v3.7.0
docker $ cd ~/aports/main/zlib && abuild
docker $ cd ~/aports/main/yaml && abuild
docker $ cd ~/aports/main/pcre && abuild -R
docker $ cd ~/aports/main/gc && abuild -R
docker $ cd ~/aports/main/libevent && abuild -R
docker $ cd ~/aports/community/llvm4 && abuild -R
```
