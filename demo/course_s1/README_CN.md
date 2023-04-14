# Xilinx Zynq UltraScale+ MPSoC 系列  
## AXU3EG 开发板简介
- 芯驿电子科技(上海)有限公司 基于XILINX Zynq UltraScale+ MPSoCs开发平台的开发板(型号:AXU3EG)2020款正式发布了,为了让您对此开发平台可以快速了解,我们编写了此用户手册。
- 这款MPSoCs开发平台采用核心板加扩展板的模式,方便用户对核心板的二次开发利用。核心板使用XILINX Zynq UltraScale+ EG芯片ZU3EG的解决方案,它采用Processing System(PS)+Programmable Logic(PL)技术将双核ARM Cortex-A53 和FPGA 可编程逻辑集成在一颗芯片上。另外核心板上PS端带有4片共4GB高速DDR4 SDRAM芯片,1片8GB的eMMC存储芯片和1片256Mb的QSPI FLASH芯片;核心板上PL端带有1片1GB的DDR4 SDRAM芯片 。
- 在底板设计上我们为用户扩展了丰富的外围接口,比如1个FMC LPC接口、1路SATA M.2接口、1路DP接口、1个USB3.0接口、1路千兆以太网接口、1路UART串口接口、1路SD卡接口、2个40针扩展接口、2路CAN总线接口,2路RS485接口等等。满足用户各种高速数据交换,数据存储,视频传输处理,深度学习,人工智能以及工业控制的要求,是一款"专业级“的ZYNQ开发平台。为高速数据传输和交换,数据处理的前期验证和后期应用提供了可能。相信这样的一款产品非常适合从事MPSoCs开发的学生、工程师等群体。

## AXU3EG 开发板接口及功能
- ZU3EG核心板
  由ZU3EG+4GB DDR4(PS)+1GB DDR4(PL)+8GB eMMC FLASH + 256Mb QSPI FLASH组成,另外有2个晶振提供时钟,一个单端33.3333MHz晶振提供给PS系统,一个差分200MHz晶振提供给PL逻辑DDR参考时钟。

- M.2接口
  1路PCIEx1标准的M.2接口,用于连接M.2的SSD固态硬盘,通信速度高达6Gbps。

- DP输出接口
  1路标准的Display Port输出显示接口,用于视频图像的显示。最高支持4K@30Hz或者1080P@60Hz输出。

- USB3.0接口
  4路USB3.0 HOST接口,USB接口类型为TYPE A。用于连接外部的USB外设,比如连接鼠标,键盘,U盘等等。

- 千兆以太网接口 
  2路10/100M/1000M以太网RJ45接口,PS和PL各1路。用于和电脑或其它网络设备进行以太网数据交换。

- USB Uart接口
  2路Uart转USB接口,PS和PL各1路。用于和电脑通信,方便用户调试。串口芯片采用Silicon Labs CP2102GM的USB-UAR芯片, USB接口采用MINI USB接口。

- Micro SD卡座
  1路Micro SD卡座,用于存储操作系统镜像和文件系统。

- 40针扩展口
  2个40针2.54mm间距的扩展口,可以外接黑金的各种模块(双目摄像头,TFT LCD屏,高速AD模块等等)。扩展口包含5V电源1路,3.3V电源2路,地3路,IO口34路。
  
- CAN通信接口 
  2路CAN总线接口,选用TI公司的SN65HVD232芯片,接口采用4Pin的绿色接线端子。

- 485通信接口 
  2路485通信接口,选用MAXIM公司的MAX3485芯片。接口采用6Pin的绿色接线端子。

- MIPI接口 
  2个LANE的MIPI摄像头输入接口,用于连接MIPI摄像头模块(AN5641)。

- JTAG调试口
  1个10针2.54mm标准的JTAG口,用于FPGA程序的下载和调试,用户可以通过XILINX下载器对ZU3EG系统进行调试和下载。

- 温湿度传感器
  板载1片温湿度传感器芯片LM75,用于检测板子周围环境的温度和湿度。

- EEPROM
  1片IIC接口的EEPROM 24LC04;

- RTC实时时钟
  1路内置的RTC实时时钟;

- LED灯
  5个发光二极管LED, 核心板上2个,底板上3个。核心板上1个电源指示灯和1个DONE配置指示灯,。底板上有1个电源指示灯,2个用户指示灯。
  
- 按键
  3个按键,1个复位按键, 2个用户按键。


# AXU2CG-E_AXU3EG_AXU4EV-E_AXU5EV-E/demo/course_s1 目录
## course_s1文件结构
 ```
 course_s1
    ├── 01_led_project/                     # 用于恢复vivado工程的Tcl脚本文件夹（包括所需源文件）
    │   │
    │   ├── led.tcl                         # tcl脚本文件用于创建vivado工程
    │   │  
    │   ├── led.bat                         # 批处理文件
    │   │  
    │   ├── src/ 
    │   │    ├── block_design/              # 块设计源文件
    │   │    │     └── *.bd
    │   │    ├── constraints/               # 约束源文件 
    │   │    │     └── *.xdc
    │   │    ├── design/                    # 设计源文件
    │   │    │     ├── *.v
    │   │    │     └── *.vhd
    │   │    └──testbench/                  # 仿真激励源文件
    │   │          ├── *.v
    │   │          └── *.vhd
    │   ├── ips/                            # IP目录
    │   │    ├── sys_ip/                    # 调用的IP源文件存放目录
    │   │    │     └── *.xci
    │   │    │     
    │   │    └── my_ip/                     # 自己写的IP源文件存放目录
    │   │          └── *.xci
    │   │
    │   └── *.coe                           # 如果有.coe文件也将置于.tcl的同级目录下
    │     
    ├── 02_pll_project/  
    ├── 03_ram_project/                     
    ├── 04_rom_project/                         
    ├── ...                        
    ├── 16_an108_project/ 
    ├── 17_ad9767_project/ 
    │   
    ├── README_CN.md                         # course_s1文档中文使用说明
    │      
    └── Documents/                           # AXU3EG_s1教程文档
        ├── images/                          # 存放技术文档所需图片
        │    ├── images_0/  
        │    │    └── *.png          
        │    ├── ...
        │    └── images_20/                  # 第二十章教程所需的图片   
        │
        ├── Ultrascale_MPSoC_CN.rst          # 中文Ultrascale_MPSoC简介
        ├── ...
        ├── 01_pl_led_CN.rst                 # 中文PL的led实验教程
        ├── 02_pll_CN.rst
        ├── 03_ram_CN.rst  
        ├── ....     
        └── 17_ad9767_CN.rst                 # 中文AD9767双通道正弦波产生实验教程
 ```
## 开发环境及需求
* Vivado 2020.1
* AXU3EG开发板
* xczu3eg-sfvc784-1-e芯片型号

## Tcl文件夹创建vivado工程流程
以01_led_project项目为例

方法一：
* 通过git在GitHub上下载demo/course_s1包。
* 打开vivado工具中的Tcl控制台。
* 命令窗cd进入01_led_project文件路径。
* source ./led.tcl命令运行.tcl脚本。
* 等待几分钟完成vivado_led的项目创建。

方法二：
* 通过git在GitHub上下载demo/course_s1包。
* 打开01_led_project文件夹。
* Windows双击led.bat运行.bat脚本。
* 等待几分钟完成vivado_led的项目创建。
* 进入新创建的vivado_led项目文件下双击.xpr文件即可打开创建好的vivado项目GUI界面。

注意：不同项目在运行source命令时运行的.tcl文件名是不同的！
## 相关教程文档
在AXU2CG-E_AXU3EG_AXU4EV-E_AXU5EV-E/demo/course_s1/Documents下的对应名称.rst文件


如有任何技术问题, 欢迎进入[ALINX网站] (https://www.alinx.com)技术支持进行咨询！