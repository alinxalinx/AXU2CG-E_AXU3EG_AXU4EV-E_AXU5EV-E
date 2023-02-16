set tclpath [pwd]
#puts "INFO: Creating new project in $tclpath"
cd $tclpath
set src_dir $tclpath/src


#create project path
cd ..
set projpath [pwd]
#set rootpath [pwd]
#file mkdir project
#set projpath $rootpath/project
#cd $rootpath/project

source $projpath/auto_create_project/project_info.tcl


if {[string equal $devicePart "xczu2cg-sfvc784-1-e" ]} {
  puts "xczu2cg-sfvc784-1-e"
  set projName "axu2cg_e_trd"
} elseif {[string equal $devicePart "xczu3eg-sfvc784-1-e" ]} {
  puts "xczu3eg-sfvc784-1-e"
  set projName "axu3eg_trd"
} elseif {[string equal $devicePart "xczu4ev-sfvc784-1-i" ]} {
  puts "xczu4ev-sfvc784-1-i"
  set projName "axu4ev_e_trd"
} elseif {[string equal $devicePart "xczu5ev-sfvc784-2-i" ]} {
  puts "xczu5ev-sfvc784-2-i"
  set projName "axu5ev_e_trd"
} else {
  puts "Wrong Part!"
  return 0
}





create_project -force $projName $projpath -part $devicePart

# Create 'sources_1' fileset (if not found)
if {[string equal [get_filesets -quiet sources_1] ""]} {
  create_fileset -srcset sources_1
}

file mkdir $projpath/$projName.srcs/sources_1/ip
file mkdir $projpath/$projName.srcs/sources_1/new

# Create 'constrs_1' fileset (if not found)
if {[string equal [get_filesets -quiet constrs_1] ""]} {
  create_fileset -constrset constrs_1
}
file mkdir $projpath/$projName.srcs/constrs_1/new

# Create 'sim_1' fileset (if not found)
if {[string equal [get_filesets -quiet constrs_1] ""]} {
  create_fileset -simset sim_1
}
file mkdir $projpath/$projName.srcs/sim_1/new

#set ip repo
# set_property  ip_repo_paths  $projpath/ip_repo [current_project]

set bdname "design_1"
create_bd_design $bdname

open_bd_design $projpath/$projName.srcs/sources_1/bd/$bdname/$bdname.bd

create_bd_cell -type ip -vlnv xilinx.com:ip:zynq_ultra_ps_e:3.3 zynq_ultra_ps_e_0

source $projpath/auto_create_project/ps_config.tcl
set_ps_config zynq_ultra_ps_e_0

set_property -dict [list CONFIG.PSU__USE__IRQ0 {1}] [get_bd_cells zynq_ultra_ps_e_0]
set_property -dict [list CONFIG.PSU__USE__IRQ1 {1}] [get_bd_cells zynq_ultra_ps_e_0]
set_property -dict [list CONFIG.PSU__USE__M_AXI_GP0 {1}] [get_bd_cells zynq_ultra_ps_e_0]
set_property -dict [list CONFIG.PSU__USE__S_AXI_GP2 {1}] [get_bd_cells zynq_ultra_ps_e_0]
set_property -dict [list CONFIG.PSU__USE__S_AXI_GP3 {1}] [get_bd_cells zynq_ultra_ps_e_0]
set_property -dict [list CONFIG.PSU__GPIO_EMIO__PERIPHERAL__ENABLE {1}] [get_bd_cells zynq_ultra_ps_e_0]
set_property -dict [list CONFIG.PSU__I2C0__PERIPHERAL__ENABLE {1} CONFIG.PSU__I2C0__PERIPHERAL__IO {EMIO}] [get_bd_cells zynq_ultra_ps_e_0]
set_property -dict [list CONFIG.PSU__UART1__PERIPHERAL__ENABLE {1} CONFIG.PSU__UART1__PERIPHERAL__IO {EMIO}] [get_bd_cells zynq_ultra_ps_e_0]


source $tclpath/pl_config.tcl

regenerate_bd_layout

validate_bd_design
save_bd_design		 

make_wrapper -files [get_files $projpath/$projName.srcs/sources_1/bd/$bdname/$bdname.bd] -top
# add_files -norecurse $projpath/$projName.srcs/sources_1/bd/$bdname/hdl/$bdWrapperName.v 
add_files -norecurse [glob -nocomplain $projpath/$projName.srcs/sources_1/bd/$bdname/hdl/*.v]

puts $bdname
append bdWrapperName $bdname "_wrapper"
puts $bdWrapperName
set_property top $bdWrapperName [current_fileset]

#add_files -fileset sources_1  -copy_to $projpath/$projName.srcs/sources_1/new -force -quiet [glob -nocomplain $src_dir/hdl/*.v]
#update_compile_order -fileset sources_1
add_files -fileset constrs_1  -copy_to $projpath/$projName.srcs/constrs_1/new -force -quiet [glob -nocomplain $src_dir/constraints/*.xdc]
#add_files -fileset sim_1  -copy_to $projpath/$projName.srcs/sim_1/new -force -quiet [glob -nocomplain $src_dir/simulation/*.v]



# launch_runs impl_1 -to_step write_bitstream -jobs $runs_jobs
# wait_on_run impl_1 

# write_hw_platform -fixed -force -include_bit -file $projpath/$bdWrapperName.xsa

# close_project

