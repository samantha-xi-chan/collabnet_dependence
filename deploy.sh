# .  .  ubuntu 22.04 LTS
echo "DefaultLimitNOFILE=1048576" >> /etc/systemd/system.conf


current_dir="$(cd "$(dirname "$0")" && pwd)"
echo "$current_dir：$current_dir"
cd $current_dir

if ! command -v s3fs &> /dev/null; then
    echo "s3fs not installed , installing"
(cd s3fs && \
dpkg -i ./mailcap_3.70+nmu1ubuntu1_all.deb && \
dpkg -i ./mime-support_3.66_all.deb && \
dpkg -i ./libfuse2_2.9.9-5ubuntu3_amd64.deb && \
dpkg -i ./s3fs_1.89-1_amd64.deb && \
date )    
fi    

echo "pwd: "
pwd

if ! command -v docker &> /dev/null; then
    echo "docker not installed , installing"
(cd docker-ce && \
dpkg -i containerd.io_1.6.4-4.1_amd64.deb && \
dpkg -i docker-ce-cli_24.0.5-2_amd64.deb  && \
dpkg -i docker-ce_20.10.7~3-0~ubuntu-xenial_amd64.deb && \
date )
fi

cp -rf $current_dir/node_manager /opt
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
