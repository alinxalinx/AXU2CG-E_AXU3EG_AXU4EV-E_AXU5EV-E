# Xilinx Zynq UltraScale+ MPSoC Series AXU2CG-E、AXU3EG、AXU4EV-E、AXU5EV-E Development board
# AXU2CG-E_AXU3EG_AXU4EV-E_AXU5EV-E/demo/course_s1 directory
## course_s1 File structure
 ```
 course_s1
    ├── 01_led_project/                     # Folder containing Tcl script(s) for recovering Vivado project, including required source files.
    │   │
    │   ├── led.tcl                         # Tcl script files used for creating Vivado project.
    │   │  
    │   ├── led.bat                         # Batch script files.
    │   │  
    │   ├── src/ 
    │   │    ├── block_design/              # Block design source files.
    │   │    │     └── *.bd
    │   │    ├── constraints/               # Constraint source files. 
    │   │    │     └── *.xdc
    │   │    ├── design/                    # Design source files.
    │   │    │     ├── *.v
    │   │    │     └── *.vhd
    │   │    └──testbench/                  # Simulation stimulus source files.
    │   │          ├── *.v
    │   │          └── *.vhd
    │   ├── ips/                            # IP directory
    │   │    ├── sys_ip/                    # Directory for storing IP source files used in the design.
    │   │    │     └── *.xci
    │   │    │     
    │   │    └── my_ip/                     # Directory for storing custom IP source files.
    │   │          └── *.xci
    │   │
    │   └── *.coe                           # If there is a .coe file, it will also be placed in the same directory as the .tcl file.
    │     
    ├── 02_pll_project/  
    ├── 03_ram_project/                     
    ├── 04_rom_project/                         
    ├── ...                        
    ├── 16_an108_project/ 
    ├── 17_ad9767_project/ 
    │   
    ├── README_CN.md                         # User instructions for course_s1 document in Chinese.
    ├── README.md                            # User instructions for course_s1 document in English.
    └── Documents/                           # Documentation for AXU3EG_s1 tutorial.
        ├── images/                          # Directory for storing images required for technical documentation.
        │    ├── images_0/  
        │    │    └── *.png          
        │    ├── ...
        │    └── images_20/                  # Images required for Chapter 20 of the tutorial.   
        │
        ├── Ultrascale_MPSoC_CN.rst          # Introduction to Ultrascale MPSoC (Multi-Processor System on Chip) in Chinese.
        ├── Ultrascale_MPSoC_EN.rst          # Documentation for Ultrascale MPSoC (Multi-Processor System on Chip) in English.
        ├── ...
        ├── 01_pl_led_CN.rst                 # Tutorial for LED experiment in Chinese for Programmable Logic (PL).
        ├── 01_pl_led_EN.rst                 # Tutorial for LED experiment in English for Programmable Logic (PL).
        ├── 02_pll_CN.rst
        ├── 03_ram_CN.rst  
        ├── ....     
        ├── 17_ad9767_CN.rst                 # Tutorial for AD9767 Dual-Channel Sine Wave Generation Experiment in Chinese.
        └── 17_ad9767_EN.rst                 # Tutorial for AD9767 Dual-Channel Sine Wave Generation Experiment in English.
 ```
## Development environment
* Vivado 2020.1
* AXU2CG-E、AXU3EG、AXU4EV-E、AXU5EV-E开发板

## Chip model
* AXU2CG-E Chip model：xczu2cg-sfvc784-1-e
* AXU3EG   Chip model：xczu3eg-sfvc784-1-e
* AXU4EV-E Chip model：xczu4ev-sfvc784-1-i
* AXU5EV-E Chip model：xczu5ev-sfvc784-2-i

In the`name.tcl`file under the project folder for different development boards, you can change the chip model in the`create_project -force $proj_name $work_dir/$proj_name -part xazu3eg-sfvc784-1-i`command to the appropriate chip model.
eg：To create a project named`01_led_project`using the AXU5EV-E development board, To open the`led.tcl`file in the folder,Replace`xazu3eg-sfvc784-1-i`with`xczu5ev-sfvc784-2-i`in the 7th line of code.
## Process of creating a Vivado project using Tcl scripts
Taking the example of the "01_led_project" project.

Method 1：
* Download the demo/course_s1 package from GitHub using Git.
* Open the Tcl console in Vivado tool.
* Navigate to the directory of "01_led_project" using the command "cd" in the Tcl console.
* Run the ".tcl" script with the command "source ./led.tcl" in the Tcl console.
* Wait for a few minutes for the "vivado_led" project creation to complete.

Method 2：
* Download the demo/course_s1 package from GitHub using Git.
* Open the "01_led_project" folder.
* Double-click the "led.bat" file to run the batch script on Windows.
* Please wait for a few minutes for the "vivado_led" project to be created.
* Navigate to the newly created "vivado_led" project folder and double-click on the .xpr file to open the Vivado project GUI interface.

Note: The .tcl file name to run with the "source" command may vary for different projects!
## Related tutorial documentation
The corresponding .rst file under AXU2CG-E_AXU3EG_AXU4EV-E_AXU5EV-E/demo/course_s1/Documents.

If you have any technical questions, please feel free to visit the [ALINX website](https://www.alinx.com) and consult their technical support!