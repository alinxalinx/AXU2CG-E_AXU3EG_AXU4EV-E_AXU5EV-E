# Xilinx Zynq UltraScale+ MPSoC 系列开发板AXU2CG-E、AXU3EG、AXU4EV-E、AXU5EV-E  
## 开发板介绍
### 开发板简介
开发板的整个结构，继承了我们一贯的核心板+扩展板的模式来设计的。核心板和扩展板之间使用高速板间连接器连接，底板包含1 路 M.2 接口、1 路 DP 接口、4 路 USB3.0接口、2 路千兆以太网接口、2 路 UART 串口接口、1 路 SD 卡接口、2 个 40 针扩展接口、2路 CAN 总线接口，2 路 RS485 接口，1 路 MIPI 接口和一些按键 LED。
### 关键特性
  1. 1 路 M.2 接口，PCIEx1(ps),速率6Gbps 
  2. 1 路DP输出接口，mini DP(ps)，最高支持4kx2k@30fps输出   
  3. 4 路USB3.0接口，usb(ps),速率5.0Gbps,扁型 USB 接口(USB Type A) 
  4. 2 路千兆以太网接口，jl2121,一路ps，一路pl,rgmii接口   
  5. 2 个uart转usb，一个ps，一个pl   
  6. 1 个Micro SD 卡座(ps) 
  7. 2 路40针扩展口,2.54mm间距,1路5v,2 路3.3v,3 路gnd，IO 口 34 路。扩展口的 IO 电平标准为 3.3V   
  8. 2 路 CAN 通信接口(ps) 
  9. 2 路 485 通信接口(pl) 
  10. 1 路mipi接口（pl）,15PIN的FPC连接器，2个lane数据，1对时钟  
  11. 1 个RTC实时时钟，32.768KHz无源时钟(ps)
  12. EEPROM和温度传感器，1片 EEROM 4Kbit(2x256x8bit)(ps)，一片LM75温度芯片(ps)，精度为0.5度 
  13. 3 个led灯，1个电源，1个pl控制，1个ps控制  
  14. 3 个按键，1个复位按键 RESET 和 2 个用户按键  
  15. 尺寸200mm x 111mm   
  16. 电源12v/3A


# AXU2CG-E/AXU3EG/AXU4EV-E/AXU5EV-E 例程
## 例程描述
此项目为开发板出厂例程，支持板卡上的大部分外设。
## 开发环境及需求
* Vivado 2020.1
* AXU2CG-E/AXU3EG/AXU4EV-E/AXU5EV-E开发板
## 创建Vivado工程
* 下载最新的ZIP包。
* 创建新的工程文件夹.
* 解压下载的ZIP包到此工程文件夹中。
* 对于不同的开发板，请打开**\<archive extracted location\>/vivado/auto_create_project/project_info.tcl**文件，选择一个器件并且保存。

xczu2cg-sfvc784-1-e适用于AXU2CG-E  
xczu3eg-sfvc784-1-e适用于AXU3EG  
xczu4ev-sfvc784-1-i适用于AXU4EV-E  
xczu5ev-sfvc784-2-i适用于AXU5EV-E  
```
set devicePart "xczu2cg-sfvc784-1-e" 
#set devicePart "xczu3eg-sfvc784-1-e"
#set devicePart "xczu4ev-sfvc784-1-i"
#set devicePart "xczu5ev-sfvc784-2-i"
set runs_jobs 5
```

有两种方法创建Vivado工程，如下所示：
### 利用Vivado tcl console创建Vivado工程
1. 打开Vivado软件并且利用**cd**命令进入"**auto_create_project**"目录，并回车
```
cd \<archive extracted location\>/vivado/auto_create_project
```
2. 输入 **source ./create_project.tcl** 并且回车
```
source ./create_project.tcl
```

### 利用bat创建Vivado工程
1. 在 "**auto_create_project**" 文件夹, 有个 "**create_project.bat**"文件, 右键以编辑模式打开，并且修改vivado路径为本主机vivado安装路径，保存并关闭。
```
CALL E:\XilinxVitis\Vivado\2020.1\bin\vivado.bat -mode batch -source create_project.tcl
PAUSE
```
2. 在Windows下双击bat文件即可。


更多信息, 请访问[ALINX网站] (https://www.alinx.com)