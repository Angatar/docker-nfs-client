FROM alpine:latest

# USAGE
# $ docker build -t nfs-client .
# $ docker run -it --privileged=true --net=host -v vol:/mnt/nfs-1:shared -e SERVER=X.X.X.X -e SHARE=shared_path nfs-client
#    or detached:
#       $ docker run -itd --privileged=true --net=host -v vol:/mnt/nfs-1:shared -e SERVER=X.X.X.X -e SHARE=shared_path nfs-client
#    or with some more options:
#       $ docker run -itd \
#             --name nfs-vols \
#             --restart=always \
#             --privileged=true \
#             --net=host \
#             -v /mnt/host:/mnt/container \
#             -e SERVER=192.168.0.9 \
#             -e SHARE=movies \
#             -e MOUNT_OPTIONS="nfsvers=3,ro" \
#             -e FSTYPE=nfs3 \
#             -e MOUNTPOINT=/mnt/host/mnt/nfs-1 \
#                nfs-client

#to enable nfs3 simply switch the FSTYPE to nfs and set nfsvers=3 
ENV FSTYPE nfs4
ENV MOUNT_OPTIONS nfsvers=4
ENV MOUNTPOINT /mnt/nfs-1

RUN apk update && apk add nfs-utils && rm -rf /var/cache/apk/*

# https://github.com/rancher/os/issues/641#issuecomment-157006575
RUN rm /sbin/halt /sbin/poweroff /sbin/reboot

ADD entry.sh /usr/local/bin/entry.sh

ENTRYPOINT ["/usr/local/bin/entry.sh"]
