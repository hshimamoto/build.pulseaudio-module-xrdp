#!/bin/bash

cid=$(docker create pulseaudio)
docker cp $cid:/pulseaudio-module-xrdp-ubuntu20.04.tar.gz .
docker rm $cid
