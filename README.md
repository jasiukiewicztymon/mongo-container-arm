# Mongo docker image for ARM

This docker image has been made after problems with the fact running arm64v8 Mongo docker image on Raspberry 3 with ubuntu server 22.04 64bit. So if you have a similar problem I hope I have resolved your problem ;)

## Build

Firstly download the dockerfile and one time this is done do this command:

```sh
sudo docker build -t <name> .
```

## Problem with restart and config reload?

If you have problems with:

```sh
systemctl restart mongod
```

And your Mongodb config doesn't reload do this:

```sh
# Search for mongo db run service command 
ps -ax | grep '/usr/bin/mongod --config /etc/mongod.conf'
# kill this / those processes with the pid num
kill <pid_num>
```

After stopping the mongod processes reload it:

```sh
systemctl start mongod
```

## Problems

In case of problems open a PR.
