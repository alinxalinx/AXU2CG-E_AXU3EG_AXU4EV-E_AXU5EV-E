# To run Linux on the series development boards AXU2CG-E, AXU3EG, AXU4EV-E, AXU5EV-E 
---
## The contents in this path 
	│
	└── linux
		│
		├── hardware
		│	│
		│	├── AXU2CG-E 
		│	│	│
		│	│	└── design_1_wrapper.xsa	//The hardware description file for the AXU2CG-E development board.
		│	│
		│	├── AXU3CG 
		│	│	│
		│	│	└── design_1_wrapper.xsa	//The hardware description file for the AXU3EG development board.
		│	│
		│	├── AXU4EV-E 
		│	│	│
		│	│	└── design_1_wrapper.xsa	//The hardware description file for the AXU4EV-E development board.
		│	│
		│	└── AXU5EV-E 
		│		│	
		│	 	└── design_1_wrapper.xsa	//The hardware description file for the AXU5EV-E development board.
		│
		├── petalinux	//The PetaLinux project folder.
		│
		├── auto_config_petalinux_hardware.sh	//The shell script for automatically configuring the hardware description file.
		│
		├── set_offline_sstate_and_downloads.sh	//The shell script for setting up offline or online compilation.
		│
		├── README_CN.md	//中文的README文档
		│
		└── README_EN.md	//This document
---
## To Creat and Use a PETALINUX Project
- About the version of the XILINX development kit: **Please be sure to use the 2020.1 version of the XILINX development kit**, including Vivado, Petalinux and others.
- About **offline compilation**: petalinux project will obtain a lot of necessary resources from the Internet when compiling, and the compilation speed also depends on the network speed. If the network is unstable, the compilation may fail after waiting for a long time. In short, there are many disadvantages. Therefore **It is strongly recommended to use offline compilation**, first download the offline resource package required for offline compilation: [sstate_aarch64_2020.1.tar.gz](https://xilinx-ax-dl.entitlenow.com/dl/ul/2020/06/01/R210329478/sstate_aarch64_2020.1.tar.gz?hash=EqeKX8hOtjjXirWfThN0NA&expires=1677753350&filename=sstate_aarch64_2020.1.tar.gz) , [downloads_2020.1.tar.gz](https://xilinx-ax-dl.entitlenow.com/dl/ul/2020/06/01/R210329480/downloads_2020.1.tar.gz?hash=zfojKvkf1j-MM0E3Ba9UkQ&expires=1677753365&filename=downloads_2020.1.tar.gz) from AMD|XILINX official website to the folder of the Ubuntu system and decompress it (you can delete the compressed package after decompression is complete). As shown below:\
![](./.images_for_README/3.png)\
Record the paths of these two packages, pay attention to the **bold** part:\
/home/alinx/Downloads/petalinux_offline_pkg/sstate_aarch64_2020.1/**aarch64**
**file://**/home/alinx/Downloads/petalinux_offline_pkg/downloads_2020.1/**downloads**\
Let\'s talk about this first, and then I will introduce how to set up offline compilation of petalinux projects through these two paths later.
### Method 1: Use the *PETALINUX project folder* in this path
1. Copy all the files in this path to the Ubuntu system folder, as shown below:\
![](./.images_for_README/1.png)
2. Open the terminal in this path and set the environment variables of petalinux.\
If your petalinux tool is installed in the */opt/pkg/petalinux* path like mine, use the following command to set the environment variable:\
`source /opt/pkg/petalinux/settings.sh`\
![](./.images_for_README/2.png)
3. If you don't need or want to use offline compilation, you can skip this step. Use the *set_offline_sstate_and_downloads.sh* script to set up offline compilation:\
![](./.images_for_README/6.png)\
Enter 1 to set offline compilation, enter 2 to restore online compilation, enter any other value to exit the script, here I choose 1. Because my sstate resource package path is the same as the default setting, so just press Enter. If your sstate resource bundle path is different from the default path, you need to enter your path here and press Enter:\
![](./.images_for_README/7.png)\
Then the downloads resource package path is also set in the same way. Press Enter and wait for the prompt *offline package set over*:\
![](./.images_for_README/8.png)
4. Use the hardware description file in the *hardware* path to configure the hardware information of the petalinux project. You can use the *auto_config_petalinux_hardware.sh* script to complete the settings, as shown below:\
![](./.images_for_README/4.png)\
Complete the operation according to the prompts and select your development board model. I will take AXU2CG-E as an example:\
![](./.images_for_README/5.png)
5. Now you can compile the petalinux project, enter the following command in the terminal to compile the project and package BOOT.bin:\
`petalinux-build && petalinux-package --boot --u-boot --fsbl --fpga --force`\
Even with offline compilation, the first compilation of each project will take a long time. Wait patiently for the compilation to complete:\
![](./.images_for_README/9.png)\
The compilation is successful!!! and BOOT.bin is packaged:\
![](./.images_for_README/10.png)
6. Check the petalinux project */image/linux* path, here is the result file of compilation and packaging. We need the four files BOOT.bin, image.ub, boot.scr and rootfs.tar.gz to start LINUX on the development board:\
![](./.images_for_README/11.png)

### Method 2: Create a PETALINUX project using the BSP package in the RELEASE version
1. Copy the bsp file to the Ubuntu system folder, take AXU4EV-E as an example, as shown below:\
![](./.images_for_README/12.png)
2. Open the terminal in the current path and set the environment variable of petalinux.\
If your petalinux tool is installed in the /opt/pkg/petalinux path like mine, use the following command to set the environment variable:\
`source /opt/pkg/petalinux/settings.sh`
![](./.images_for_README/13.png)
3. Use the following command to create a petalinux project through the petalinux bsp package:\
`petalinux-create -t project -n petalinux -s ./AXU4EV-E.bsp`\
![](./.images_for_README/14.png)
4. If you need to configure offline compilation, refer to the step **[3]** of **Method 1**。
5. The petalinux project created using the bsp package does not require any settings, enter the petalinux project path\
`cd ./petalinux/`\
Just compile and package BOOT.bin directly:\
`petalinux-build && petalinux-package --boot --u-boot --fsbl --fpga --force`\
![](./.images_for_README/15.png)\
After compiling and packaging, the resulting file is in the */image/linux* path of the petalinux project:\
![](./.images_for_README/11.png)
---
## To Run LINUX on the development board
1. Take booting from SD card as an example, adjust the DIP switch on the development board to the state of booting from SD card, as shown in the figure below:\
![](./.images_for_README/17.png)\
The DIP switch is at this position on the development board:\
![](./.images_for_README/16.png)
2. Next you need to make an SD card for booting Linux. Connect the SD card (e.g. via a card reader) to the Ubuntu system, then open the Disks tool in the Ubuntu system:\
![](./.images_for_README/18.png)\
My SD card is **31 GB Drive** here. Select it, and you can see that there are three areas in the SD card:\
a. FAT type partition named **BOOT**\
b. Ext4 type partition named **ROOTFS**\
c. Free Space\
![](./.images_for_README/19.png)\
This is the state we need. If your SD card is also in this state (there is no strict requirement on the size of the partition), just skip step [2]. But in order to demonstrate a complete process, I will restore the SD to the state of no partition, select the corresponding partition, click the \" **-** \" icon to delete the current partition, and finally become the state as shown below:\
![](./.images_for_README/20.png)\
Click \" **+** \" icon to create a new partition, the first partition needs to be in **FAT** format, the size allocation is 2G, and the name is **BOOT**:\
![](./.images_for_README/21.png)\
![](./.images_for_README/22.png)\
Click the **Create** button to complete the partition creation, click the \"**▶**\" button to mount the partition:\
![](./.images_for_README/23.png)\
Click **Free Space**, use similar steps to create a second partition, select **Ext4** as the format, allocate 20G in size (adjust according to your actual needs and restrictions), and name it **ROOTFS**:\
![](./.images_for_README/24.png)\
![](./.images_for_README/25.png)\
The final state is as shown in the figure below. Note that both partitions need to be mounted:\
![](./.images_for_README/26.png)
3. After the SD card partition is completed, copy the files needed to start the system to the corresponding partition. \
Copy *boot.scr*, *BOOT.bin*, *image.ub* three files to **BOOT** partition:\
![](./.images_for_README/27.png)\
Unzip *rootfs.tar.gz* to the **ROOTFS** partition with root authority, open the terminal at the path where *rootfs.tar.gz* is located, and enter the following command:\
`sudo tar zxvf ./rootfs.tar.gz -C /media/alinx/ROOTFS/ && sync`\
![](./.images_for_README/28.png)\
![](./.images_for_README/29.png)
4. Eject the SD card and insert it into the SD card slot of the development board:\
![](./.images_for_README/30.png)\
Connect PS_UART to PC (the driver of CP210x needs to be installed on the PC):\
![](./.images_for_README/31.png)
Open the serial port tool, select the COM port we just connected, set the baud rate to 115200, close the flow control, and click the OK button:\
![](./.images_for_README/32.png)\
Connect the 12V power supply:\
![](./.images_for_README/33.png)\
You can see the output information in the serial port tool:\
![](./.images_for_README/34.png)\
The system has been successfully started. Enter the username **root** and the password **root** to log in to the system.
---
## Verify the interfaces and peripherals on the development board
- AXU2CG-E, AXU3EG, AXU4EV-E, AXU5EV-E development boards have these interfaces and peripherals:\
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
⑫EMMC(not visible in the picture)\
⑬EEPRM(not visible in the picture)\
⑭QSPI FLASH(not visible in the picture)\
⑮DS1308(not visible in the picture)\
In the Linux system on the development board made earlier, we integrated some scripts in the *~/shells_for_testing_peripheral_devices/* path to test these interfaces and peripherals:\
![](./.images_for_README/36.png)\
Next we look at how to test or use these interfaces and peripherals.
### ①DP
Connect the DP to the monitor, and you can see the desktop of Macthbox after the system starts, which is enough to show that the DP interface is intact:\
![](./.images_for_README/37.png)
### ②PS_UART
PS_UART is used in the terminal window of Linux, connect PS_UART to PC, open the corresponding COM with serial port tool, after starting the development board, you can see the printing information in the serial port tool, then PS_UART is intact.
### ③PL_UART
Connect PL_UART to any USB port on the development board:\
![](./.images_for_README/38.png)\
Run *pl_uart_to_self_usb_test.sh* script in *~/shells_for_testing_peripheral_devices/* :\
![](./.images_for_README/39.png)\
The output " *pl uart to self usb test OK* " means that PL_UART is intact, and this script also verifies that the USB interface is intact.
### ④RS485 x 2
There are two RS485 on the development board, connect them:\
![](./.images_for_README/40.png) ![](./.images_for_README/41.png)\
Run the *rs485_test.sh* script in *~/shells_for_testing_peripheral_devices/* :\
![](./.images_for_README/42.png)\
As shown in the figure above, the two-way sending and receiving test is OK, and the interface is intact.
### ⑤CAN x 2
There are two paths on the development board, connect them:\
![](./.images_for_README/43.png) ![](./.images_for_README/44.png)\
Run the *can_test.sh* script in *~/shells_for_testing_peripheral_devices/* :\
![](./.images_for_README/45.png)
### ⑥MIPI
Connect the display to the DP port, connect the MIPI camera to the MIPI port, and run the *mipi_test.sh* script in *~/shells_for_testing_peripheral_devices/* (*ps: press **ctrl+c** to exit the script.*):\
![](./.images_for_README/47.png)\
Show where the camera image is displayed:\
![](./.images_for_README/46.png)
### ⑦LEDS、KEYS
There are three groups of LEDs and KEY on the development board. The first group is the POWER indicator light and the RESET button, the second group is the LED and KEY on the PS side, and the third group is the LED and KEY on the PL side. After power on, the default POWER and PL_LED are on:\
![](./.images_for_README/48.png)\
Run the *leds_keys_test.sh* script in *~/shells_for_testing_peripheral_devices/* (*ps: Press **ctrl+c** to exit the script.*). Then you can use PS_KEY to control PS_LED to turn on or off, and PL_KEY to control PS_LED to turn on or off:\
![](./.images_for_README/49.png)
### ⑧M.2
Connect the SSD to the M.2 interface of the development board (please do not operate with power):\
![](./.images_for_README/50.png)\
Then start the development board and run the *m.2_ssd_test.sh* script in *~/shells_for_testing_peripheral_devices/* :\
![](./.images_for_README/51.png)\
Depending on the usage of your SSD, the information will be printed differently, but as long as the M.2 interface and the SSD are intact, it will definitely output " *ssd read write OK* ".
### ⑨PS_ETH、⑩PL_ETH
Connect PS_ETH and PL_ETH to LAN:\
![](./.images_for_README/52.png)\
Run the *m.2_ssd_test.sh* script in *~/shells_for_testing_peripheral_devices/*. This script can be followed by a parameter, which is the address you want to ping. For example, I pinged Baidu here. If no parameter is added, the default ping is *www .google.com*:\
![](./.images_for_README/53.png)\
Finally, the ping result and the link speed of the network port will be displayed.
### ⑪USB x 4
In the test of PL_UART, also verify the USB port. In fact, common USB devices can be used directly on this system. For example, the mouse and keyboard can be used directly with the desktop. If you want to test the U disk, you can use the *usb_drive_test.sh* script in *~/shells_for_testing_peripheral_devices/* (*ps: this system does not support the NTFS file system, so the U disk with NTFS partition cannot be used directly*):\
![](./.images_for_README/54.png)
### ⑫EMMC
Run the *emmc_test.sh* script in *~/shells_for_testing_peripheral_devices/* :\
![](./.images_for_README/55.png)
### ⑬EEPRM
Run the *eeprom_test.sh* script in *~/shells_for_testing_peripheral_devices/* :\
![](./.images_for_README/56.png)
### ⑭QSPI FLASH
Run *qspi_flash_test.sh* script in *~/shells_for_testing_peripheral_devices/* :\
![](./.images_for_README/57.png)
### ⑮DS1308
Run the *ds1308_test.sh* script in *~/shells_for_testing_peripheral_devices/* :\
![](./.images_for_README/58.png)

---
Visit [ALINX Official Website](https://www.alinx.com) for more information.