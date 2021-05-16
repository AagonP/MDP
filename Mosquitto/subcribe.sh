#!/bin/bash

# mosquito_sub -h [host] -p [port] -u [IO_USERNAME] -P [IO_KEY] -t [topic]


if [[ "$1" == "-h" ]] ; then
    echo
    echo "Use this command:"
    echo "  bash subcribe.sh [feed]"
    echo
    echo "Feed:"
    echo "  ""infrared-sensor"
    echo "  ""light-sensor"
    echo "  ""moisture-sensor"
    echo "  ""pump"
    echo "  ""temp-sensor"
    echo
    echo "Eg: bash publish.sh temp-sensor"
    exit 1
fi

if [[ -z "$1" ]] ; then
    echo "  Error: No topic"
    exit 1
fi

#Default args
# $1 = topic_name

# Default 
host_name="io.adafruit.com"
port=1883                   
IO_USERNAME="pmhieu58"  # Set your Adafruit username here
IO_KEY="aio_TyFS72TlW1Yh6JLDiTtQITZxX1Nz" # set your Adafruit server key here
#Feeds
user_feeds_path="pmhieu58/feeds/"
# infrared_sensor="infrared-sensor"
# light_sensor="light-sensor"
# moisture_sensor="moisture-sensor"
# pump="pump"
# temp_sensor="temp-sensor"

#Choose which device to subcribe to
topic_name=$user_feeds_path$1
echo "  Subcribing to: "$1

mosquitto_sub -h $host_name -p $port -u $IO_USERNAME -P $IO_KEY -t $topic_name