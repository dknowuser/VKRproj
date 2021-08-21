transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+E:/VKRproj/top/Float32LibRtlSrc {E:/VKRproj/top/Float32LibRtlSrc/Float32Mul.v}
vlog -vlog01compat -work work +incdir+E:/VKRproj/top/Float32LibRtlSrc {E:/VKRproj/top/Float32LibRtlSrc/Float32Add.v}
vlog -vlog01compat -work work +incdir+E:/VKRproj/top {E:/VKRproj/top/float_to_int_converter.v}
vlog -vlog01compat -work work +incdir+E:/VKRproj/top {E:/VKRproj/top/int_to_float_converter.v}
vlog -sv -work work +incdir+E:/VKRproj/top {E:/VKRproj/top/top.sv}

