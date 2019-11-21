#!/bin/bash
# script to add dep and user in image
apt-get update -y && useradd -m test && apt-get install -y sudo
