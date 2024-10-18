#! /bin/sh -e

mkdir -p "$MOUNTPOINT"

if [ "$SERVER" = "" ]; then
rpc.statd & rpcbind -f & echo "docker NFS client with rpcbind ENABLED... if you wish to mount the mountpoint in this container USE THE FOLLOWING SYNTAX instead:
$ docker run -itd --privileged=true --net=host -v vol:/mnt/nfs-1:shared -e SERVER= X.X.X.X -e SHARE=shared_path d3fk/nfs-client" & more
else
rpc.statd & rpcbind -f &
mount -t "$FSTYPE" -o "$MOUNT_OPTIONS" "$SERVER:$SHARE" "$MOUNTPOINT"
fi
mount | grep nfs

while true; do sleep 1000; done
