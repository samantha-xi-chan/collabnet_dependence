### 环境配置

如果应用场景涉及容器执行（例如代码模糊测试场景下的 工程创建和编译 测试任务的执行）, 则需要根据如下步骤安装
```bash
apt install -y docker.io=24.0.5-0ubuntu1~22.04.1
apt install -y s3fs
echo "DefaultLimitNOFILE=1048576" >> /etc/systemd/system.conf
```

### 部署准备
- 拷贝文件内容至指定目录, 目录内容结构如下
```bash
# root@node-013:/opt/node_manager# ls -alh
total 25M
drwxr-xr-x 3 root root 4.0K Dec 19 06:16 .
drwxr-xr-x 4 root root 4.0K Dec 19 06:16 ..
drwxr-xr-x 2 root root 4.0K Dec 19 06:16 config
-rwxr-xr-x 1 root root  25M Dec 19 06:16 node_manager
-rw-r--r-- 1 root root   60 Dec 19 06:16 node_manager.md5sum
-rw-r--r-- 1 root root  272 Dec 19 06:16 node_manager.service
```
- 修改以上 config/app.yaml 文件中的IP地址为实际环境的服务地址（可以填写 K8S的地址）

### 部署安装

```bash
systemctl stop  node_manager.service || echo 'stop service end'
cp /opt/node_manager/node_manager.service /etc/systemd/system/
ls /opt/node_manager/
systemctl enable   node_manager.service
systemctl restart  node_manager.service
systemctl status   node_manager.service
```


### 问题定位
本次版本有较大更新，部署时如果出现问题建议采用如下步骤排查
- 确保 K8S yaml中指定的的业务镜像版本已成功部署（ 同样的版本号可能对应不同的镜像实例 请注意确认摘要信息。 K8S 使用确认有点复杂，如果K8S不熟 建议直接在 干净的linux机器上部署，避免造成研发力量浪费）
- 确保 K8S 所在主机 /mnt 目录可写入空间 不低于 400 GB
- 确保在Node上 apt install s3fs -y 已成功执行 （如果应用场景不涉及workflow调度执行，这个操作可省略）
- 确保 node_manager 已按如下步骤安装部署， 且是在 以上第一个步骤成功执行完成后 做了 node_manager 的重启 （出于简化方案的考虑, 建议重启整个 node所在操作系统 ，建议直接在 干净的linux机器上部署，避免造成研发力量浪费）
- 确保 app.yaml 中的配置地址是正确的
- 重要的事情再重复一下： 建议直接在 干净的linux机器上部署，避免造成研发力量浪费，避免前后部署的不兼容脏数据干扰


### 命令参考
查看服务日志
```bash
journalctl -u node_manager -f  -n 100
```


### 版本关键特性
- 脚本自动执行: 当node_manager 启动时 会自动执行 config/init.sh 脚本（如果脚本不存在 则不执行），用于宿主机自动初始化的业务配置。 脚本内容参考如下 
```bash
# 错误示范如下
reboot
sleep 9999

# 正确示范如下
echo core >/proc/sys/kernel/core_pattern
ulimit -c unlimited
echo 0 > /proc/sys/kernel/randomize_va_space

```

