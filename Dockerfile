ARG Distro
FROM s390x/ubuntu:${Distro}

COPY ./build.sh /root/

# default for 100m
CMD sleep 6000 
