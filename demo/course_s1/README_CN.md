# Xilinx Zynq UltraScale+ MPSoC 系列 AXU2CG-E、AXU3EG、AXU4EV-E、AXU5EV-E开发板
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
## 开发环境
* Vivado 2020.1
* AXU2CG-E、AXU3EG、AXU4EV-E、AXU5EV-E开发板

## 芯片型号
* AXU2CG-E 芯片型号：xczu2cg-sfvc784-1-e
* AXU3EG   芯片型号：xczu3eg-sfvc784-1-e
* AXU4EV-E 芯片型号：xczu4ev-sfvc784-1-i
* AXU5EV-E 芯片型号：xczu5ev-sfvc784-2-i

不同的开发板在项目文件夹下的`name.tcl`文件中更改`create_project -force $proj_name $work_dir/$proj_name -part xazu3eg-sfvc784-1-i`命令下对应的芯片型号

eg：使用AXU5EV-E开发板,创建`01_led_project`项目，打开文件夹中`led.tcl`文件，替换第7行代码中`xazu3eg-sfvc784-1-i`为`xczu5ev-sfvc784-2-i`

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