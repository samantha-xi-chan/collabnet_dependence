# .  .  ubuntu 22.04 LTS
echo "DefaultLimitNOFILE=1048576" >> /etc/systemd/system.conf


(cd s3fs && \
dpkg -i ./mailcap_3.70+nmu1ubuntu1_all.deb && \
dpkg -i ./mime-support_3.66_all.deb && \
dpkg -i ./libfuse2_2.9.9-5ubuntu3_amd64.deb && \
dpkg -i ./s3fs_1.89-1_amd64.deb && \
date )

echo "pwd: "
pwd

(cd docker-ce && \
dpkg -i containerd.io_1.6.4-4.1_amd64.deb && \
dpkg -i docker-ce-cli_24.0.5-2_amd64.deb  && \
dpkg -i docker-ce_20.10.7~3-0~ubuntu-xenial_amd64.deb && \
date )

cp -rf ./node_manager /opt
# 
systemctl stop  node_manager.service || echo 'stop service end'
cp /opt/node_manager/node_manager.service /etc/systemd/system/
ls /opt/node_manager/
systemctl enable   node_manager.service
systemctl restart  node_manager.service
systemctl status   node_manager.service
# journalctl -u node_manager -f  -n 100





# ref: 
# rpm install 
# https://blog.csdn.net/qyq88888/article/details/131263828
