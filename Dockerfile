FROM ubuntu
RUN apt update
RUN apt install -y systemctl gnupg wget libssl-dev dpkg
RUN touch /usr/lib/systemd/system/mongod.service
RUN echo $' \n\
[Unit]\n\
Description=MongoDB Database Server\n\
Documentation=https://docs.mongodb.org/manual\n\
After=network-online.target\n\
Wants=network-online.target\n\
\n\
[Service]\n\
User=mongodb\n\
Group=mongodb\n\
EnvironmentFile=-/etc/default/mongod\n\
ExecStart=/usr/bin/mongod --config /etc/mongod.conf\n\
PIDFile=/var/run/mongodb/mongod.pid\n\
# file size\n\
LimitFSIZE=infinity\n\
# cpu time\n\
LimitCPU=infinity\n\
# virtual memory size\n\
LimitAS=infinity\n\
# open files\n\
LimitNOFILE=64000\n\
# processes/threads\n\
LimitNPROC=64000\n\
# locked memory\n\
LimitMEMLOCK=infinity\n\
# total threads (user+kernel)\n\
TasksMax=infinity\n\
TasksAccounting=false\n\
\n\
# Recommended limits for mongod as specified in\n\
# https://docs.mongodb.com/manual/reference/ulimit/#recommended-ulimit-settings\n\
\n\
[Install]\n\
WantedBy=multi-user.target' >> /usr/lib/systemd/system/mongod.service
RUN wget http://ports.ubuntu.com/pool/main/o/openssl/libssl1.1_1.1.1f-1ubuntu2_arm64.deb
RUN dpkg -i /libssl1.1_1.1.1f-1ubuntu2_arm64.deb
RUN wget -qO - https://www.mongodb.org/static/pgp/server-4.4.asc | apt-key add -
RUN echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/4.4 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-4.4.list
RUN apt update
RUN apt install mongodb-org -y
CMD ["systemctl", "start", "mongod"]
