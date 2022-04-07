# FIO 磁盘性能测试工具

 fio 是一个IO测试工具，可以运行在Linux、Windows等多种系统之上，可以用来测试本地磁盘、网络存储等的性能。支持多客户端并发测试（server、client模式），支持文件级、对象级存储测试，更对多种主流的存储如GlusterFS、CephFS等有专用测试引擎，测试结果包括IOPS、BW、lat等多种数据。

# fio 工具安装

可参考：https://access.redhat.com/solutions/3780861
    
    yum install fio -y

# fio 相关参数
    filename=/dev/sdb1   # 测试文件名称，通常选择需要测试的盘的 data 目录
    direct=1             # 测试过程绕过机器自带的 buffer。使测试结果更真实
    rw=randwrite         # 测试随机写的 I/O
    rw=randrw            # 测试随机写和读的 I/O
    bs=16k               # 单次 io 的块文件大小为 16k
    bsrange=512-2048     # 同上，提定数据块的大小范围
    size=5G              # 本次的测试文件大小为 5g，以每次 4k 的 io 进行测试
    numjobs=30           # 本次的测试线程为 30 个
    runtime=1000         # 测试时间 1000 秒，如果不写则一直将 5g 文件分 4k 每次写完为止
    ioengine=psync       # io 引擎使用 psync, libaio方式
    rwmixwrite=30        # 在混合读写的模式下，写占 30%
    group_reporting      # 关于显示结果的，汇总每个进程的信息
    lockmem=1G           # 只使用 1g 内存进行测试
    zero_buffers         # 用 0 初始化系统 buffer
    nrfiles=8            # 每个进程生成文件的数量
 # 单机测试
    # 顺序读
    fio -filename=/dev/sda -direct=1 -iodepth 1 -thread -rw=read -ioengine=psync -bs=16k -size=200G -numjobs=30 -runtime=1000 -group_reporting -name=mytest

    # 顺序写
    fio -filename=/dev/sda -direct=1 -iodepth 1 -thread -rw=write -ioengine=psync -bs=16k -size=200G -numjobs=30 -runtime=1000 -group_reporting -name=mytest

    # 随机读
    fio -filename=/dev/sda -direct=1 -iodepth 1 -thread -rw=randread -ioengine=psync -bs=16k -size=200G -numjobs=30 -runtime=1000 -group_reporting -name=mytest

    # 随机写
    fio -filename=/dev/sda -direct=1 -iodepth 1 -thread -rw=randwrite -ioengine=psync -bs=16k -size=200G -numjobs=30 -runtime=1000 -group_reporting -name=mytest
    

 # 生成 fio.conf
    复制下面的配置内容，将 directory=/path/to/test 修改为你测试硬盘挂载目录的地址，并另存为 fio.conf
    [global]
    ioengine=libaio
    direct=1
    thread=1
    norandommap=1
    randrepeat=0
    runtime=60
    ramp_time=6
    size=1g
    directory=/path/to/test

    [read4k-rand]
    stonewall
    group_reporting
    bs=4k
    rw=randread
    numjobs=8
    iodepth=32

    [read64k-seq]
    stonewall
    group_reporting
    bs=64k
    rw=read
    numjobs=4
    iodepth=8

    [write4k-rand]
    stonewall
    group_reporting
    bs=4k
    rw=randwrite
    numjobs=2
    iodepth=4

    [write64k-seq]
    stonewall
    group_reporting
    bs=64k
    rw=write
    numjobs=2
    iodepth=4
# 测试 fio.conf
    fio fio.conf
# 并行测试
 
   可参考提供的脚本：https://github.com/Hugo-Hsiao/Disk_Tools
 
    #mun hosts fio 有多少个fio主机，添加几个，./==.fio文件
    fio --client=192.168.115.50,8765 /root/randread.fio --client=192.168.115.51,8765 /root/randread.fio --client=192.168.115.52,8765 /root/randread.fio --       client=192.168.115.53,8765 /root/randread.fio --client=192.168.115.54,8765 /root/randread.fio --client=192.168.115.55,8765 /root/randread.fio   
