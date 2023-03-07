# Run Linux on Series Development Boards : AXU2CG-E, AXU3EG, AXU4EV-E, AXU5EV-E / 在系列开发板：AXU2CG-E、AXU3EG、AXU4EV-E、AXU5EV-E上使用Linux
---
---
## Content in this path / 本路径中的内容 
	│
	└─── linux
		│
		├── hardware
		│	│
		│	├── AXU2CG-E 
		│	│	│
		│	│	└─ design_1_wrapper.xsa	
		│	│		//hardware description file of AXU2CG-E development board 
		│	│		//AXU2CG-E开发板的硬件描述文件
		│	│
		│	├── AXU3CG 
		│	│	│
		│	│	└─ design_1_wrapper.xsa	
		│	│		//hardware description file of AXU3EG development board
		│	│		//AXU3EG开发板的硬件描述文件
		│	│
		│	├── AXU4EV-E 
		│	│	│
		│	│	└─ design_1_wrapper.xsa	
		│	│		//hardware description file of AXU4EV-E development board
		│	│		//AXU4EV-E开发板的硬件描述文件
		│	│
		│	└── AXU5EV-E 
		│		│	
		│	 	└─ design_1_wrapper.xsa	
		│	 		//hardware description file of AXU5EV-E development board 
		│	 		//AXU5EV-E开发板的硬件描述文件
		│
		├── petalinux
		│	//petalinux project folder
		│	//petalinux工程文件夹
		│
		├── documents_EN
		│	│ //English documents
		│	│
		│	├──  make_sd_for_runnging_linux.md	
		│	│	//bout how to make an SD card for running Linux on the development board
		│	│
		│	├──  use_petalinux_to_make_linux.md	
		│	│	//about how to use Petalinux to make Linux running on the development board
		│	│
		│	└──  use_peripherals_interfaces.md
		│	 	//about how to use the peripherals and interfaces on the development board
		│
		├── documents_CN
		│	│ //中文文档
		│	│
		│	├──  make_sd_for_runnging_linux.md	
		│	│	//关于如何制作用于在开发板上运行Linux的SD卡
		│	│
		│	├──  use_petalinux_to_make_linux.md
		│	│	//关于如何使用etalinux制作在开发板上运行的Linux
		│	│
		│	└──  use_peripherals_interfaces.md
		│	 	//关于如何使用开发板上的外设和接口
		│
		├── auto_config_petalinux_hardware.sh	
		│	//shell script that automatically sets the hardware description file
		│	//自动设置硬件描述文件的shell脚本
		│
		├── set_offline_sstate_and_downloads.sh
		│	//shell script for setting up offline or online compilation
		│	//设置离线或在线编译的shell脚本
		│
		└── README.md
			//This document
			//本文档
---
---
## Documentation Guidelines / 文档指引
- If you want to quickly start a Linux on the development board, please refer to [make_sd_for_runnging_linux.md](./documents_EN/make_sd_for_runnging_linux.md)\
如果你想快速在开发板上启动Linux，请参考[make_sd_for_runnging_linux.md](./documents_CN/make_sd_for_runnging_linux.md)

- If you want to use Petalinux tool to configure the petalinux project we provide, please refer to [use_petalinux_to_make_linux.md](./documents_EN/use_petalinux_to_make_linux.md)\
如果你想用Petalinux工具来配置我们提供的petalinux工程，请参考[use_petalinux_to_make_linux.md](./documents_CN/use_petalinux_to_make_linux.md)

- If you have successfully started Linux on the development board, and now want to know what interfaces are on the development board and how to use them, please refer to [use_peripherals_interfaces.md](./documents_EN/use_peripherals_interfaces.md)\
如果你已经成功在开发板上启动了Linux，现在想知道开发板上有哪些接口以及如何使用，请参考[use_peripherals_interfaces.md](./documents_CN/use_peripherals_interfaces.md)
---
---
- Visit [ALINX Official Website](https://www.alinx.com) for more information.\
访问[ALINX官方网站](https://www.alinx.com)以获取更多信息。

