# 在系列开发板AXU2CG-E、AXU3EG、AXU4EV-E、AXU5EV-E上使用Linux
---
## 本路径中的内容 
	│
	└── linux
		│
		├── hardware
		│	│
		│	├── AXU2CG-E 
		│	│	│
		│	│	└── design_1_wrapper.xsa	//AXU2CG-E开发板的硬件描述文件
		│	│
		│	├── AXU3CG 
		│	│	│
		│	│	└── design_1_wrapper.xsa	//AXU3EG开发板的硬件描述文件
		│	│
		│	├── AXU4EV-E 
		│	│	│
		│	│	└── design_1_wrapper.xsa	//AXU4EV-E开发板的硬件描述文件
		│	│
		│	└── AXU5EV-E 
		│		│	
		│	 	└── design_1_wrapper.xsa	//AXU5EV-E开发板的硬件描述文件
		│
		├── petalinux	//petalinux工程文件夹
		│
		├── auto_config_petalinux_hardware.sh	//自动设置硬件描述文件的shell脚本
		│
		├── set_offline_sstate_and_downloads.sh	//设置离线或在线编译的shell脚本
		│
		├── README_CN.md	//本文档
		│
		└── README_EN.md	//English README 
---
## 创建和使用PETALINUX工程
- 关于XILINX开发套件的版本：**请务必使用2020.1版本的XILINX开发套件**，包括Vivado、Petalinux以及其他。
- 关于**离线编译**：petalinux工程编译时会从网上获取大量的必要资源，编译速度也依赖于网速，如果网络不稳定还有可能在等待很久之后编译失败，总之有很多弊端。因此**强烈建议使用离线编译**，首先从AMD|XILINX官网下载离线编译所需要的离线资源包[sstate_aarch64_2020.1.tar.gz](https://xilinx-ax-dl.entitlenow.com/dl/ul/2020/06/01/R210329478/sstate_aarch64_2020.1.tar.gz?hash=EqeKX8hOtjjXirWfThN0NA&expires=1677753350&filename=sstate_aarch64_2020.1.tar.gz)、[downloads_2020.1.tar.gz](https://xilinx-ax-dl.entitlenow.com/dl/ul/2020/06/01/R210329480/downloads_2020.1.tar.gz?hash=zfojKvkf1j-MM0E3Ba9UkQ&expires=1677753365&filename=downloads_2020.1.tar.gz)到Ubuntu系统的文件夹中并解压（解压完成后可以删除压缩包）。如下图：\
![](./.images_for_README/3.png)\
记录这两个包的路径，注意**加粗**的部分：\
/home/alinx/Downloads/petalinux_offline_pkg/sstate_aarch64_2020.1/**aarch64**
**file://**/home/alinx/Downloads/petalinux_offline_pkg/downloads_2020.1/**downloads**\
先说到这里，后面再介绍如何通过这两个路径来设置petalinux工程的离线编译。
### 方法一：使用本路径中的*PETALINUX工程文件夹*
1. 把本路径中的所有文件拷贝到Ubuntu系统的文件夹中，如下图：\
![](./.images_for_README/1.png)
2. 在这个路径中打开终端，设置petalinux的环境变量。\
如果你的petalinux工具和我一样安装在 */opt/pkg/petalinux* 路径，则使用下面命令来设置环境变量：\
`source /opt/pkg/petalinux/settings.sh`\
![](./.images_for_README/2.png)
3. 如果你不需要或者不想使用离线编译，则可以跳过这一步。使用*set_offline_sstate_and_downloads.sh* 脚本设置离线编译：\
![](./.images_for_README/6.png)\
输入1设置离线编译，输入2恢复成在线编译，输入其他任意值退出脚本，这里我选择1。因为我的sstate资源包路径和默认的设置相同，所以直接按回车就可以了。如果你的sstate资源包路径和默认的路径不同，则需要在这里输入你的路径然后按回车：\
![](./.images_for_README/7.png)\
然后downloads资源包路径也是一样的设置。按回车等待提示*offline package set over*：\
![](./.images_for_README/8.png)
4. 使用*hardware*路径中的硬件描述文件来配置petalinux工程的硬件信息，可以使用*auto_config_petalinux_hardware.sh*脚本来完成设置，如下图：\
![](./.images_for_README/4.png)\
根据提示完成操作，选择你的开发板型号，我以AXU2CG-E为例：\
![](./.images_for_README/5.png)
5. 现在就可以编译petalinux工程了，在终端中输入下面的命令编译工程并在编译完成后打包BOOT.bin：\
`petalinux-build && petalinux-package --boot --u-boot --fsbl --fpga --force`\
即使是使用离线编译，每个工程的第一次编译都会花上较长的时间。耐心等待编译完成：\
![](./.images_for_README/9.png)\
编译成功!!!并且打包了BOOT.bin：\
![](./.images_for_README/10.png)
6. 查看petalinux工程 */image/linux* 路径，这里就是编译和打包的结果文件。我们需要其中的BOOT.bin、image.ub、boot.scr以及rootfs.tar.gz这四个文件，在开发板上启动LINUX：\
![](./.images_for_README/11.png)

### 方法二：使用RELEASE版本中的BSP包创建PETALINUX工程
1. 把bsp文件拷贝到Ubuntu系统的文件夹中，以AXU4EV-E为例，如下图：\
![](./.images_for_README/12.png)
2. 在当前路径中打开终端，设置petalinux的环境变量。\
如果你的petalinux工具和我一样安装在 /opt/pkg/petalinux 路径，则使用下面命令来设置环境变量：
`source /opt/pkg/petalinux/settings.sh`
![](./.images_for_README/13.png)
3. 用下面的命令，通过petalinux的bsp包来创建petalinux工程：\
`petalinux-create -t project -n petalinux -s ./AXU4EV-E.bsp`\
![](./.images_for_README/14.png)
4. 如果需要配置离线编译，参考**方法一**的步骤 **[3]**。
5. 使用bsp包创建的petalinux工程不需任何设置，进入petalinux工程路径\
`cd ./petalinux/`\
直接编译并打包BOOT.bin即可：\
`petalinux-build && petalinux-package --boot --u-boot --fsbl --fpga --force`\
![](./.images_for_README/15.png)\
编译和打包完成后，结果文件在petalinux工程的 */image/linux* 路径中：\
![](./.images_for_README/11.png)
---
## 在开发板上启动LINUX
1. 以SD卡启动为例，把开发板上的拨码开关调整到从SD卡启动的状态，如下图：\
![](./.images_for_README/17.png)\
拨码开关在开发板的这个位置：\
![](./.images_for_README/16.png)
2. 接下来需要制作用于启动Linux的SD卡。把SD卡(例如通过读卡器)连接到Ubuntu系统，然后在Ubuntu系统中打开Disks工具：\
![](./.images_for_README/18.png)\
我的SD卡是这里的**31 GB Drive**。选则它，可以看到SD卡中有三块区域分别是：\
a. 名为**BOOT**的FAT类型的分区\
b. 名为**ROOTFS**的Ext4类型的分区\
c. Free Space\
![](./.images_for_README/19.png)\
这也就是我们需要的状态，如果你的SD卡也是这样的状态(对分区的大小没有严格要求)，跳过这步骤[2]即可。但是为了演示一个完整的流程，我先把SD恢复成没有分过区的状态，选择对应的分区，点击\" **-** \"图标可以删除当前分区，最终变成如下图的状态：\
![](./.images_for_README/20.png)\
点击\" **+** \"图标可以创建新的分区，第一个分区需要是**FAT**格式，大小分配2G，名字命名为**BOOT**：\
![](./.images_for_README/21.png)\
![](./.images_for_README/22.png)\
点击**Create**按钮完成分区创建，点击\"**▶**\"按钮挂载分区：\
![](./.images_for_README/23.png)\
点击**Free Space**，用类似的步骤创建第二个分区，格式选**Ext4**，大小分配20G(根据你的实际需求和限制调整)，命名为**ROOTFS**：\
![](./.images_for_README/24.png)\
![](./.images_for_README/25.png)\
最终状态如下图，注意，需要把两个分区都挂载上：\
![](./.images_for_README/26.png)
3. SD卡分区完成后，把启动系统需要的文件拷贝到对应分区。\
把*boot.scr* 、*BOOT.bin* 、*image.ub* 三个文件拷贝到**BOOT**分区：\
![](./.images_for_README/27.png)\
把*rootfs.tar.gz* 用root权限解压到**ROOTFS**分区，在*rootfs.tar.gz* 所在路径打开终端，输入下面的命令：\
`sudo tar zxvf ./rootfs.tar.gz -C /media/alinx/ROOTFS/ && sync`\
![](./.images_for_README/28.png)\
![](./.images_for_README/29.png)
4. 弹出SD卡，插到开发板的SD卡槽中：\
![](./.images_for_README/30.png)\
连接PS_UART到PC(PC上需要安装CP210x的驱动)：\
![](./.images_for_README/31.png)
打开串口工具，选择我们刚才连接的COM口，波特率设置为115200，关闭流控制，点击OK按钮：\
![](./.images_for_README/32.png)\
连接12V电源：\
![](./.images_for_README/33.png)\
可以看到串口工具中输出信息：\
![](./.images_for_README/34.png)\
系统已经成功启动，输入用户名**root**、密码**root**可以登陆系统。
---
## 验证开发板上的接口和外设
- AXU2CG-E、AXU3EG、AXU4EV-E、AXU5EV-E开发板上有这些接口和外设：\
![](./.images_for_README/35.png)\
①DP\
②PS_UART\
③PL_UART\
④RS485 x 2\
⑤CAN x 2\
⑥MIPI\
⑦LEDS、KEYS\
⑧M.2\
⑨PS_ETH\
⑩PL_ETH\
⑪USB x 4\
⑫EMMC(图中不可见)\
⑬EEPRM(图中不可见)\
⑭QSPI FLASH(图中不可见)\
⑮DS1308(图中不可见)\
在前面制作的开发板上的Linux系统中，我们集成了一些脚本在 *~/shells_for_testing_peripheral_devices/* 路径中，用于测试这些接口：\
![](./.images_for_README/36.png)\
接下来我们来看如何测试或使用这些接口和外设。
### ①DP
把DP连接到显示器上，系统启动后可以看到Macthbox的桌面，这足以说明DP接口是完好的：\
![](./.images_for_README/37.png)
### ②PS_UART
PS_UART用于Linux的终端窗口，把PS_UART连接到PC，用串口工具打开对应的COM，启动开发板后可以看到
串口工具中打印信息，那么PS_UART就是完好的。
### ③PL_UART
把PL_UART连接到开发板的任意一个USB口上：\
![](./.images_for_README/38.png)\
运行 *~/shells_for_testing_peripheral_devices/* 中的 *pl_uart_to_self_usb_test.sh* 脚本：\
![](./.images_for_README/39.png)\
输出" *pl uart to self usb test OK* "说明PL_UART完好，这个脚本同时也验证了USB接口完好。
### ④RS485 x 2
开发板上有两路RS485，将他们互联：\
![](./.images_for_README/40.png) ![](./.images_for_README/41.png)\
运行 *~/shells_for_testing_peripheral_devices/* 中的 *rs485_test.sh* 脚本：\
![](./.images_for_README/42.png)\
如上图所示，双向收发测试OK，接口完好。
### ⑤CAN x 2
开发板上有两路，将他们互联：\
![](./.images_for_README/43.png) ![](./.images_for_README/44.png)\
运行 *~/shells_for_testing_peripheral_devices/* 中的 *can_test.sh* 脚本：\
![](./.images_for_README/45.png)
### ⑥MIPI
连接显示器到DP口，连接MIPI摄像头到MIPI口，运行 *~/shells_for_testing_peripheral_devices/* 中的 *mipi_test.sh* 脚本(*ps：按**ctrl+c**组合键退出该脚本。*)：\
![](./.images_for_README/47.png)\
显示其中显示摄像头图像：\
![](./.images_for_README/46.png)
### ⑦LEDS、KEYS
开发板上有三组LED和KEY。第一组是POWER指示灯和RESET按钮，第二组是PS端的LED和KEY，第三组是PL端的LED和KEY。上电后默认POWER和PL_LED点亮：\
![](./.images_for_README/48.png)\
运行 *~/shells_for_testing_peripheral_devices/* 中的 *leds_keys_test.sh* 脚本(*ps：按**ctrl+c**组合键退出该脚本。*)。然后可以用PS_KEY控制PS_LED点亮和熄灭，PL_KEY控制PS_LED点亮和熄灭：\
![](./.images_for_README/49.png)
### ⑧M.2
在开发板的M.2接口上接上SSD(请不要带电操作)：\
![](./.images_for_README/50.png)\
然后启动开发板，运行 *~/shells_for_testing_peripheral_devices/* 中的 *m.2_ssd_test.sh* 脚本\
![](./.images_for_README/51.png)\
根据你的SSD的使用情况会用不同打印信息，但只要M.2接口和SSD是完好的最终肯定会输出" *ssd read write OK* "。
### ⑨PS_ETH、⑩PL_ETH
连接PS_ETH和PL_ETH到局域网：\
![](./.images_for_README/52.png)\
运行 *~/shells_for_testing_peripheral_devices/* 中的 *m.2_ssd_test.sh* 脚本，这个脚本后可以带一个参数，即你想ping的地址，比如这里我ping了一下百度，如果不加参数则默认ping *www.google.com* ：\
![](./.images_for_README/53.png)\
最后会显示ping的结果和网口link的速度。
### ⑪USB x 4
在PL_UART的测试用，也验证USB口。实际上常用USB设备都可以直接在这个系统上使用。比如鼠标键盘，可以直接配合桌面来使用。如果测试U盘的话可以使用 *~/shells_for_testing_peripheral_devices/* 中的 *usb_drive_test.sh* 脚本( *ps：这个系统是不支持NTFS文件系统的，所以NTFS分区的U盘无法直接使用* )：\
![](./.images_for_README/54.png)
### ⑫EMMC
运行 *~/shells_for_testing_peripheral_devices/* 中的 *emmc_test.sh* 脚本：\
![](./.images_for_README/55.png)
### ⑬EEPRM
运行 *~/shells_for_testing_peripheral_devices/* 中的 *eeprom_test.sh* 脚本：\
![](./.images_for_README/56.png)
### ⑭QSPI FLASH
运行 *~/shells_for_testing_peripheral_devices/* 中的 *qspi_flash_test.sh* 脚本：\
![](./.images_for_README/57.png)
### ⑮DS1308
运行 *~/shells_for_testing_peripheral_devices/* 中的 *ds1308_test.sh* 脚本：\
![](./.images_for_README/58.png)

---
访问[ALINX官方网站](https://www.alinx.com)以获取更多信息。