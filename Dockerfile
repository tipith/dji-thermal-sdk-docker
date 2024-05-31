# syntax=docker/dockerfile:1
FROM ubuntu:latest

ARG URL="https://terra-1-g.djicdn.com/2640963bcd8e45c0a4f0cb9829739d6b/TSDK/v1.5%20(10.0.1-EA220%E7%BA%A2%E5%A4%96%E4%BA%8C%E4%BE%9B%E3%80%8110.0-EP300)/dji_thermal_sdk_v1.5_20240507.zip"

RUN apt-get update
RUN apt-get -y install wget unzip libtiff-tools g++-multilib imagemagick exiftool

RUN mkdir -p /app/djithermal
RUN wget "$URL" -O /app/djithermal/dji_thermal_sdk.zip
RUN cd /app/djithermal && unzip /app/djithermal/dji_thermal_sdk.zip
RUN chmod a+rx /app/djithermal/utility/bin/linux/release_x64/*
RUN chmod a+rx /app/djithermal/tsdk-core/lib/linux/release_x64/*

RUN cp /app/djithermal/tsdk-core/lib/linux/release_x64/* /usr/lib
RUN cp /app/djithermal/utility/bin/linux/release_x64/* /usr/bin

ENV PATH="${PATH}:/app/djithermal/utility/bin/linux/release_x64"