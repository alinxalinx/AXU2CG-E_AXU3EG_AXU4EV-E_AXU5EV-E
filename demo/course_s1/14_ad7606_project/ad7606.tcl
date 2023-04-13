
#设置项目名称和工作目录
set proj_name "vivado_hdmi_char"
set work_dir [pwd]
#创建工程
#**********************************************************************************************************
create_project -force $proj_name $work_dir/$proj_name -part xazu3eg-sfvc784-1-i
# Create 'sources_1' fileset (if not found)
if {[string equal [get_filesets -quiet sources_1] ""]} {
  create_fileset -srcset sources_1
}
file mkdir $work_dir/$proj_name/$proj_name.srcs/sources_1/ip
file mkdir $work_dir/$proj_name/$proj_name.srcs/sources_1/new
file mkdir $work_dir/$proj_name/$proj_name.srcs/sources_1/bd
# Create 'constrs_1' fileset (if not found)
if {[string equal [get_filesets -quiet constrs_1] ""]} {
  create_fileset -constrset constrs_1
}
file mkdir $work_dir/$proj_name/$proj_name.srcs/constrs_1/new
# Create 'sim_1' fileset (if not found)
if {[string equal [get_filesets -quiet sim_1] ""]} {
  create_fileset -simset sim_1
}
file mkdir $work_dir/$proj_name/$proj_name.srcs/sim_1/new
#*********************************************************************************************************
#添加源文件
add_files -fileset sources_1  -copy_to $work_dir/$proj_name/$proj_name.srcs/sources_1/new -force -quiet [glob -nocomplain $work_dir/src/design/*.v]
add_files -fileset sources_1  -copy_to $work_dir/$proj_name/$proj_name.srcs/sources_1/new -force -quiet [glob -nocomplain $work_dir/src/design/i2c_master/*.v]
add_files -fileset sim_1  -copy_to $work_dir/$proj_name/$proj_name.srcs/sim_1/new -force -quiet [glob -nocomplain $work_dir/src/testbench/*.v]
#添加约束文件
add_files -fileset constrs_1  -copy_to $work_dir/$proj_name/$proj_name.srcs/constrs_1/new -force -quiet [glob -nocomplain $work_dir/src/constraints/*.xdc]
# 添加IP的.xci文件
add_files -fileset sources_1  -copy_to $work_dir/$proj_name/$proj_name.srcs/sources_1/ip -force -quiet [glob -nocomplain $work_dir/ips/sys_ip/*.xci]
# 添加coe文件
add_files -fileset sources_1  -copy_to $work_dir/$proj_name/$proj_name.srcs -force -quiet [glob -nocomplain $work_dir/*.coe]
#生成Block Design
#source $work_dir/vivado_project/$proj_name.srcs/sources_1/bd/my_bd/my_bd.tcl
#**********************************************************************************************************
# 综合
launch_runs synth_1 -jobs 5
wait_on_run synth_1
# 设置顶层文件属性
#set_property top_auto_detect true [current_project]
set_property top_file "/$work_dir/$proj_name/$proj_name.srcs/sources_1/new/top.v" [current_fileset]
#运行综合、实现和生成比特流
#synth_design -to_current_top
synth_design -top top
opt_design
place_design
route_design
write_bitstream -force $work_dir/$proj_name.bit
