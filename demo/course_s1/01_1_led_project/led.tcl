
#设置项目名称和工作目录
set proj_name "vivado_led"
set work_dir [pwd]
#创建工程
#**********************************************************************************************************
create_project -force $proj_name $work_dir/$proj_name -part xazu3eg-sfvc784-1-i
# Create 'sources_1' fileset (if not found)；file mkdir创建ip、new、bd三个子文件
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
#************************************************************************************************************
#添加源文件
add_files -fileset sources_1  -copy_to $work_dir/$proj_name/$proj_name.srcs/sources_1/new -force -quiet [glob -nocomplain $work_dir/src/design/*.v]
add_files -fileset sim_1  -copy_to $work_dir/$proj_name/$proj_name.srcs/sim_1/new -force -quiet [glob -nocomplain $work_dir/src/testbench/*.v]
#添加约束文件
add_files -fileset constrs_1  -copy_to $work_dir/$proj_name/$proj_name.srcs/constrs_1/new -force -quiet [glob -nocomplain $work_dir/src/constraints/*.xdc]
# 添加IP
# 创建一个新的 ILA IP
create_ip -name ila -vendor xilinx.com -library ip -version 6.2 -module_name ila -dir $work_dir/$proj_name/$proj_name.srcs/sources_1/ip
set_property -dict [list CONFIG.C_PROBE0_WIDTH {32} CONFIG.C_NUM_OF_PROBES {2} CONFIG.Component_Name {ila}] [get_ips ila]
#set_property -dict [list CONFIG.C_PROBE4_WIDTH {128} CONFIG.C_PROBE3_WIDTH {8} CONFIG.C_PROBE2_WIDTH {32} CONFIG.C_PROBE1_WIDTH {16} CONFIG.C_DATA_DEPTH {2048} CONFIG.C_NUM_OF_PROBES {5} CONFIG.C_ENABLE_ILA_AXI_MON {false} CONFIG.C_MONITOR_TYPE {Native}] [get_ips ila_0]
generate_target {instantiation_template} [get_files $work_dir/$proj_name/$proj_name.srcs/sources_1/ip/ila/ila.xci]
update_compile_order -fileset sources_1
generate_target all [get_files  $work_dir/$proj_name/$proj_name.srcs/sources_1/ip/ila/ila.xci]
catch { config_ip_cache -export [get_ips -all ila] }
export_ip_user_files -of_objects [get_files $work_dir/$proj_name/$proj_name.srcs/sources_1/ip/ila/ila.xci] -no_script -sync -force -quiet
create_ip_run [get_files -of_objects [get_fileset sources_1] $work_dir/$proj_name/$proj_name.srcs/sources_1/ip/ila/ila.xci]
launch_runs ila_synth_1 -jobs 5
export_simulation -of_objects [get_files $work_dir/$proj_name/$proj_name.srcs/sources_1/ip/ila/ila.xci] -directory $work_dir/$proj_name/vivado_led.ip_user_files/sim_scripts -ip_user_files_dir $work_dir/$proj_name/vivado_led.ip_user_files -ipstatic_source_dir $work_dir/$proj_name/vivado_led.ip_user_files/ipstatic -lib_map_path [list {modelsim=$work_dir/$proj_name/vivado_led.cache/compile_simlib/modelsim} {questa=$work_dir/$proj_name/vivado_led.cache/compile_simlib/questa} {riviera=$work_dir/$proj_name/vivado_led.cache/compile_simlib/riviera} {activehdl=$work_dir/$proj_name/vivado_led.cache/compile_simlib/activehdl}] -use_ip_compiled_libs -force -quiet
#生成Block Design
#source $work_dir/vivado_project/$proj_name.srcs/sources_1/bd/my_bd/my_bd.tcl
#*************************************************************************************************************
# 综合
launch_runs synth_1 -jobs 5
wait_on_run synth_1
# 设置顶层文件属性
#set_property top_auto_detect true [current_project]
set_property top_file "/$work_dir/$proj_name/$proj_name.srcs/sources_1/new/led.v" [current_fileset]
#运行综合、实现和生成比特流
#synth_design -to_current_top
#指定综合顶层模块为“led”
synth_design -top led
#执行逻辑综合优化，主要是优化逻辑电路的面积、时钟频率、功耗等指标
opt_design
#执行布局，将逻辑元素映射到物理位置，并考虑时序约束
place_design
#执行布线，将物理电路中的逻辑元素通过信号线连接在一起
route_design
#将比特流写入到指定的文件中，即生成.bit文件。-force参数用于强制覆盖已有的文件
write_bitstream -force $work_dir/$proj_name.bit
#生成用于调试的信号探针，将信号探针写入到指定的文件中，即生成.ltx文件
write_debug_probes -file $work_dir/$proj_name.ltx