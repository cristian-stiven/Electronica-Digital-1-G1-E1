transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/dasa1/OneDrive/Documents/Coding\ projects/Electronica-Digital-1-G1-E1/Proyecto/src {C:/Users/dasa1/OneDrive/Documents/Coding projects/Electronica-Digital-1-G1-E1/Proyecto/src/House.v}
vlog -vlog01compat -work work +incdir+C:/Users/dasa1/OneDrive/Documents/Coding\ projects/Electronica-Digital-1-G1-E1/Proyecto/src {C:/Users/dasa1/OneDrive/Documents/Coding projects/Electronica-Digital-1-G1-E1/Proyecto/src/Move.v}
vlog -vlog01compat -work work +incdir+C:/Users/dasa1/OneDrive/Documents/Coding\ projects/Electronica-Digital-1-G1-E1/Proyecto/src {C:/Users/dasa1/OneDrive/Documents/Coding projects/Electronica-Digital-1-G1-E1/Proyecto/src/Motor.v}
vlog -vlog01compat -work work +incdir+C:/Users/dasa1/OneDrive/Documents/Coding\ projects/Electronica-Digital-1-G1-E1/Proyecto/src {C:/Users/dasa1/OneDrive/Documents/Coding projects/Electronica-Digital-1-G1-E1/Proyecto/src/Leds.v}
vlog -vlog01compat -work work +incdir+C:/Users/dasa1/OneDrive/Documents/Coding\ projects/Electronica-Digital-1-G1-E1/Proyecto/src {C:/Users/dasa1/OneDrive/Documents/Coding projects/Electronica-Digital-1-G1-E1/Proyecto/src/BTt.v}
vlog -vlog01compat -work work +incdir+C:/Users/dasa1/OneDrive/Documents/Coding\ projects/Electronica-Digital-1-G1-E1/Proyecto/src {C:/Users/dasa1/OneDrive/Documents/Coding projects/Electronica-Digital-1-G1-E1/Proyecto/src/BTr.v}

vlog -vlog01compat -work work +incdir+C:/Users/dasa1/OneDrive/Documents/Coding\ projects/Electronica-Digital-1-G1-E1/Proyecto/src {C:/Users/dasa1/OneDrive/Documents/Coding projects/Electronica-Digital-1-G1-E1/Proyecto/src/House-tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  House-tb

add wave *
view structure
view signals
run -all
