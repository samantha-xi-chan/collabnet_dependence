
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



