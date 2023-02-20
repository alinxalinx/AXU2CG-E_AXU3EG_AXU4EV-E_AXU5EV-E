# Xilinx Zynq UltraScale+MPSoC series development board AXU2CG-E, AXU3EG, AXU4EV-E, AXU5EV-E  
## Introduction to development board  
### Introduction to development board  
The whole structure of the development board is designed by inheriting our consistent pattern of core board+expansion board. The core board and expansion board are connected by high-speed inter-board connectors. The backplane includes 1 channel M.2 interface, 1 channel DP interface, 4 channels USB3.0 interface, 2 channels Gigabit Ethernet interface, 2 channels UART serial interface, 1 channel SD card interface, 2 40-pin expansion interfaces, 2 channels CAN bus interface, 2 channels RS485 interface, 1 channel MIPI interface and some key LEDs.  
### Key characteristics  
1. 1-way M.2 interface, PCIEx1 (ps), speed 6Gbps  
2. 1-channel DP output interface, mini DP (ps), maximum support 4kx2k@30fps Output  
3. 4-way USB3.0 interface, usb (ps), speed 5.0Gbps, flat USB interface (USB Type A)  
4. 2-way Gigabit Ethernet interface, jl2121, 1-way ps, 1-way pl, rgmii interface  
5. Two uart to usb, one ps and one pl  
6. 1 Micro SD card holder (ps)  
7. Two 40-pin expansion ports, 2.54mm spacing, one 5v, two 3.3v, three gnd, and 34 IO ports. The IO level standard of the expansion port is 3.3V  
8. 2-way CAN communication interface (ps)  
9. 2-way 485 communication interface (pl)  
10. 1 channel mipi interface (pl), 15PIN FPC connector, 2 lane data, 1 pair of clock  
11. 1 RTC real-time clock, 32.768KHz passive clock (ps)  
12. EEPROM and temperature sensor, one EEPROM 4Kbit (2x256x8bit) (ps), one LM75 temperature chip (ps), with an accuracy of 0.5 degrees  
13. 3 led lights, 1 power supply, 1 pl control, 1 ps control  
14. 3 keys, 1 reset key RESET and 2 user keys  
15. Size 200mm x 111mm  
16. Power supply 12v/3A

# AXU2CG-E/AXU3EG/AXU4EV-E/AXU5EV-E Demo Project
## Description
This is vivado factory demo project for ALINX board.
## Requirement
* Vivado 2020.1
* AXU2CG-E/AXU3EG/AXU4EV-E/AXU5EV-E Development Board
## Create Vivado Project
* Download recent release ZIP archive.
* Create new project folder.
* Extract the download ZIP to the new project folder.
* For different development board, please open **\<archive extracted location\>/vivado/auto_create_project/project_info.tcl**
Choose one devicePart and save.
>xczu2cg-sfvc784-1-e is for AXU2CG-E
>xczu3eg-sfvc784-1-e is for AXU3EG
>xczu4ev-sfvc784-1-i is for AXU4EV-E
>xczu5ev-sfvc784-2-i is for AXU5EV-E
```
set devicePart "xczu2cg-sfvc784-1-e" 
#set devicePart "xczu3eg-sfvc784-1-e"
#set devicePart "xczu4ev-sfvc784-1-i"
#set devicePart "xczu5ev-sfvc784-2-i"
set runs_jobs 5
```

There are two methods to create vivado project as below:
### Create Vivado Project in Vivado tcl console
1. Open Vivado software and switch to "**auto_create_project**" path with **cd** command and **Enter**
```
cd \<archive extracted location\>/vivado/auto_create_project
```
2. Type **source ./create_project.tcl** and **Enter**
```
source ./create_project.tcl
```

### Create Vivado Project using bat
1. In "**auto_create_project**" folder, there is "**create_project.bat**", open it in edit mode, and change vivado software installation path with your own path. Save and close.
```
CALL E:\XilinxVitis\Vivado\2020.1\bin\vivado.bat -mode batch -source create_project.tcl
PAUSE
```
2. Double click bat file in Windows environment


For more information, please post on the [ALINX Website] (https://www.alinx.com/en).