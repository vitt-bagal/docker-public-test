ARG Distro
FROM s390x/ubuntu:${Distro}

COPY ./build.sh /root/
