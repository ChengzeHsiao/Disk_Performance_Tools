# FIO 磁盘性能测试工具

 Fio是一个IO测试工具，可以运行在Linux、Windows等多种系统之上，可以用来测试本地磁盘、网络存储等的性能。支持多客户端并发测试（server、client模式），支持文件级、对象级存储测试，更对多种主流的存储如GlusterFS、CephFS等有专用测试引擎。测试结果包括IOPS、BW、lat等多种数据

# fio 工具安装

可参考：https://access.redhat.com/solutions/3780861

# fio 相关参数

     ioengine=libaio  　　  io引擎使用libaio方式
     group_reporting 　　 关于显示结果的，汇总每个进程的信息
     direct=1 　　　　　   测试过程绕过机器自带的buffer，使测试结果更真实
     name=testsda 　　　指定job的名字
     numjobs=1 　　　　 本次的测试线程为1
     runtime=1800 　　    测试时间为1800秒
     iodepth=64 　　　　 测试的IO深度，即每次会给磁盘的IO请求数
     rw=randread 　　　 测试随机读的I/O
     rw=read                    测试顺序读的I/O
     iodepth=64               测试的IO深度，即每次会给磁盘的IO请求数
     bs=512k                   单次io的块文件大小为512 k
     filename=/dev/sda   
    
# fio 测试方案

 # 单机测试
   
     fio -ioengine=libaio -group_reporting -direct=1 -name=testsda -numjobs=1 --time_based --runtime=1800 -iodepth=64 -rw=randread -bs=512k -filename=/dev/sda   
    
 # 并行测试
 
   可参考提供的脚本：https://github.com/Hugo-Hsiao/Disk_Tools
 
    #mun hosts fio 有多少个fio主机，添加几个，./==.fio文件
    fio --client=192.168.115.50,8765 /root/randread.fio --client=192.168.115.51,8765 /root/randread.fio --client=192.168.115.52,8765 /root/randread.fio --       client=192.168.115.53,8765 /root/randread.fio --client=192.168.115.54,8765 /root/randread.fio --client=192.168.115.55,8765 /root/randread.fio   
