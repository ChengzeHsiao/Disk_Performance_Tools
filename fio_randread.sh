#!/bin/bash
#mun hosts fio 有多少个fio主机，添加几个，./==.fio文件
fio --client=192.168.115.50,8765 /root/randread.fio --client=192.168.115.51,8765 /root/randread.fio --client=192.168.115.52,8765 /root/randread.fio --client=192.168.115.53,8765 /root/randread.fio --client=192.168.115.54,8765 /root/randread.fio --client=192.168.115.55,8765 /root/randread.fio
