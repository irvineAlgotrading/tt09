/**
 * Copyright 2020 The SkyWater PDK Authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 * SPDX-License-Identifier: Apache-2.0
 */

`ifndef SKY130_FD_IO__TOP_AMUXSPLITV2_V
`define SKY130_FD_IO__TOP_AMUXSPLITV2_V

/**
 * top_amuxsplitv2: Analog Mux Splitter
 *
 * The amux splitter cell is used to break the AMUX that forms a ring by itself
 * if the GPIO's are abutted.  This is useful for large chips that would require
 * a part of the AMUX to have different functionality from other.  Also, it
 * allows the flexibility to have groups of IO's on different IO domains.
 */

`timescale 1ns/1ps
`default_nettype none

module sky130_fd_io__top_amuxsplitv2 ( amuxbus_a_l, amuxbus_a_r, amuxbus_b_l, amuxbus_b_r
`ifdef USE_POWER_PINS    
    ,vccd, vcchib, vdda, vddio, vddio_q, vssa, vssd, vssio, vssio_q, vswitch
`endif    
    ,enable_vdda_h, hld_vdda_h_n,
    switch_aa_sl, switch_aa_sr, switch_aa_s0,
    switch_bb_sl, switch_bb_sr, switch_bb_s0
    );

`ifdef USE_POWER_PINS

  inout vssio_q;
  inout vcchib;
  inout vdda;
  inout vssa;
  inout vccd;
  inout vddio_q;
  inout vddio;
  inout vswitch;
  inout vssio;
  inout vssd;
    
`else

  supply0 vssio_q;
  supply1 vcchib;
  supply1 vdda;
  supply0 vssa;
  supply1 vccd;
  supply1 vddio_q;
  supply1 vddio;
  supply1 vswitch;
  supply0 vssio;
  supply0 vssd;

`endif
 
 input  switch_aa_sl, switch_aa_sr, switch_aa_s0,
        switch_bb_sl, switch_bb_sr, switch_bb_s0;
 
  inout amuxbus_b_r;
  inout amuxbus_a_l;
  inout amuxbus_b_l;
  inout amuxbus_a_r;
  input enable_vdda_h;
  input hld_vdda_h_n;
 


  reg switch_aa_sl_final,  switch_bb_sl_final;
  reg switch_aa_sr_final,  switch_bb_sr_final;
  reg switch_aa_s0_final,  switch_bb_s0_final;


  parameter MAX_WARNING_COUNT = 100;


//===================================================================================================================================================

// POWER-GOOD Definitions 


`ifdef USE_POWER_PINS

	wire  pwr_good_lv 	= (vdda===1)  && (vswitch===1)  && (vssa===0)   && (vccd===1);
	
	wire  pwr_good_hv 	= (vdda===1)  && (vswitch===1)  && (vssa===0) && (vssd===0);  
	
`else

	wire  pwr_good_lv 	= 1'b1;
	
	wire  pwr_good_hv   	= 1'b1;
	

`endif



//======================================================================================================================================================================
reg notifier_switch_aa_sl,notifier_switch_aa_sr,notifier_switch_aa_s0,notifier_switch_bb_sl,notifier_switch_bb_sr,notifier_switch_bb_s0,notifier_enable_vdda_h;

wire    switch_aa_sl_buf, switch_aa_sr_buf, switch_aa_s0_buf,switch_bb_sl_buf, switch_bb_sr_buf, switch_bb_s0_buf, hld_vdda_h_n_buf;

wire     switch_aa_sl_del, switch_aa_sr_del, switch_aa_s0_del, switch_bb_sl_del, switch_bb_sr_del, switch_bb_s0_del,hld_vdda_h_n_del; 

`ifdef FUNCTIONAL
	
	assign hld_vdda_h_n_buf = hld_vdda_h_n;
	assign  switch_aa_sl_buf = switch_aa_sl ;
	assign  switch_aa_sr_buf = switch_aa_sr ;
	assign switch_aa_s0_buf  = switch_aa_s0;
	assign  switch_bb_sl_buf = switch_bb_sl;
	assign  switch_bb_sr_buf = switch_bb_sr;
	assign  switch_bb_s0_buf = switch_bb_s0;

`else
	assign hld_vdda_h_n_buf = hld_vdda_h_n_del;
	assign switch_aa_sl_buf = switch_aa_sl_del;
	assign switch_aa_sr_buf = switch_aa_sr_del;
	assign switch_aa_s0_buf  = switch_aa_s0_del;
	assign  switch_bb_sl_buf =  switch_bb_sl_del;
	assign switch_bb_sr_buf = switch_bb_sr_del;
	assign switch_bb_s0_buf = switch_bb_s0_del;



specify

      
    $width  (negedge hld_vdda_h_n,	      (15.500:0:15.500));
    $width  (posedge hld_vdda_h_n,	      (15.500:0:15.500));
   
    specparam tsetup = 5;
    specparam thold = 5;

    $setuphold (posedge enable_vdda_h,    negedge hld_vdda_h_n,    tsetup, thold,  notifier_enable_vdda_h); 


    $setuphold (negedge hld_vdda_h_n, posedge switch_aa_sl,   tsetup, thold,  notifier_switch_aa_sl,   enable_vdda_h==1'b1, enable_vdda_h==1'b1, hld_vdda_h_n_del, switch_aa_sl_del); 
   $setuphold (negedge hld_vdda_h_n, negedge switch_aa_sl,   tsetup, thold,  notifier_switch_aa_sl,   enable_vdda_h==1'b1, enable_vdda_h==1'b1, hld_vdda_h_n_del, switch_aa_sl_del); 

    $setuphold (negedge hld_vdda_h_n, posedge switch_aa_sr,   tsetup, thold,  notifier_switch_aa_sr,   enable_vdda_h==1'b1, enable_vdda_h==1'b1, hld_vdda_h_n_del, switch_aa_sr_del);
    $setuphold (negedge hld_vdda_h_n, negedge switch_aa_sr,   tsetup, thold,  notifier_switch_aa_sr,   enable_vdda_h==1'b1, enable_vdda_h==1'b1, hld_vdda_h_n_del, switch_aa_sr_del); 

   $setuphold (negedge hld_vdda_h_n, posedge switch_aa_s0,   tsetup, thold,  notifier_switch_aa_s0,   enable_vdda_h==1'b1, enable_vdda_h==1'b1, hld_vdda_h_n_del, switch_aa_s0_del); 
   $setuphold (negedge hld_vdda_h_n, negedge switch_aa_s0,   tsetup, thold,  notifier_switch_aa_s0,   enable_vdda_h==1'b1, enable_vdda_h==1'b1, hld_vdda_h_n_del, switch_aa_s0_del);

 $setuphold (negedge hld_vdda_h_n, posedge switch_bb_sl,   tsetup, thold,  notifier_switch_bb_sl,   enable_vdda_h==1'b1, enable_vdda_h==1'b1, hld_vdda_h_n_del, switch_bb_sl_del);
  $setuphold (negedge hld_vdda_h_n, negedge switch_bb_sl,   tsetup, thold,  notifier_switch_bb_sl,   enable_vdda_h==1'b1, enable_vdda_h==1'b1, hld_vdda_h_n_del, switch_bb_sl_del); 

    $setuphold (negedge hld_vdda_h_n, posedge switch_bb_sr,   tsetup, thold,  notifier_switch_bb_sr,   enable_vdda_h==1'b1, enable_vdda_h==1'b1, hld_vdda_h_n_del, switch_bb_sr_del); 
   $setuphold (negedge hld_vdda_h_n, negedge switch_bb_sr,   tsetup, thold,  notifier_switch_bb_sr,   enable_vdda_h==1'b1, enable_vdda_h==1'b1, hld_vdda_h_n_del, switch_bb_sr_del); 

    $setuphold (negedge hld_vdda_h_n, posedge switch_bb_s0,   tsetup, thold,  notifier_switch_bb_s0,   enable_vdda_h==1'b1, enable_vdda_h==1'b1, hld_vdda_h_n_del, switch_bb_s0_del); 
    $setuphold (negedge hld_vdda_h_n, negedge switch_bb_s0,   tsetup, thold,  notifier_switch_bb_s0,   enable_vdda_h==1'b1, enable_vdda_h==1'b1, hld_vdda_h_n_del, switch_bb_s0_del); 
 
 endspecify

`endif








//======================================================================================================================================================================

// Switch functionality 

wire switch_aa_mid, switch_bb_mid;


// T-Switch (amuxbus_a_l <---> amuxbus_a_r)

tranif1  x_aa_sl ( amuxbus_a_l,   switch_aa_mid, switch_aa_sl_final);

tranif1  x_aa_sr ( amuxbus_a_r,   switch_aa_mid, switch_aa_sr_final);

bufif1   x_aa_s0 ( switch_aa_mid, vssa, 	 switch_aa_s0_final);



// T-Switch (amuxbus_b_l <---> amuxbus_b_r)

tranif1  x_bb_sl ( amuxbus_b_l,   switch_bb_mid, switch_bb_sl_final);

tranif1  x_bb_sr ( amuxbus_b_r,   switch_bb_mid, switch_bb_sr_final);

bufif1   x_bb_s0 ( switch_bb_mid, vssa, 	 switch_bb_s0_final);


//========================================================================================================================================================================

// Level-shifted digital inputs - switch_aa_sl, switch_aa_sr, switch_aa_s0

always @(*)
begin : LSH_switch_aa_sl
		
	if ( (^enable_vdda_h===1'bx && hld_vdda_h_n_buf!==0) || (^hld_vdda_h_n_buf===1'bx && enable_vdda_h!==0) || !pwr_good_hv)
	begin
		switch_aa_sl_final 	<= 1'bx;
	end
	else if (enable_vdda_h===0 || hld_vdda_h_n_buf ===0 )
	begin
		switch_aa_sl_final 	<= 1'b0;
	end
	else
	begin
		switch_aa_sl_final 	<= (^switch_aa_sl_buf	=== 1'bx || !pwr_good_lv) ? 1'bx : switch_aa_sl_buf;
	end
end

always @(notifier_switch_aa_sl or notifier_enable_vdda_h)
begin
     disable LSH_switch_aa_sl; switch_aa_sl_final <= 1'bx;
end


always @(*)
begin : LSH_switch_aa_sr
		
	if ( (^enable_vdda_h===1'bx  && hld_vdda_h_n_buf!==0) || (^hld_vdda_h_n_buf===1'bx && enable_vdda_h!==0 )|| !pwr_good_hv)
	begin
		switch_aa_sr_final 	<= 1'bx;
	end
	else if (enable_vdda_h===0 || hld_vdda_h_n_buf ===0)
	begin
		switch_aa_sr_final 	<= 1'b0;
	end
	else
	begin
		switch_aa_sr_final 	<= (^switch_aa_sr_buf	=== 1'bx || !pwr_good_lv) ? 1'bx : switch_aa_sr_buf;
	end
end

always @(notifier_switch_aa_sr or notifier_enable_vdda_h)
begin
     disable LSH_switch_aa_sr; switch_aa_sr_final <= 1'bx;
end


always @(*)
begin : LSH_switch_aa_s0
		
	if ( (^enable_vdda_h===1'bx  && hld_vdda_h_n_buf!==0) || (^hld_vdda_h_n_buf===1'bx && enable_vdda_h!==0) || !pwr_good_hv)
	begin
		switch_aa_s0_final 	<= 1'bx;
	end
	else if (enable_vdda_h===0 || hld_vdda_h_n_buf ===0)
	begin
		switch_aa_s0_final 	<= 1'b0;
	end
	else
	begin
		switch_aa_s0_final 	<= (^switch_aa_s0_buf	=== 1'bx || !pwr_good_lv) ? 1'bx : switch_aa_s0_buf;
	end
end


always @(notifier_switch_aa_s0 or notifier_enable_vdda_h)
begin
     disable LSH_switch_aa_s0; switch_aa_s0_final <= 1'bx;
end


//========================================================================================================================================================================

// Level-shifted digital inputs - switch_bb_sl, switch_bb_sr, switch_bb_s0


always @(*)
begin : LSH_switch_bb_sl
		
	if ( (^enable_vdda_h===1'bx  && hld_vdda_h_n_buf!==0) || (^hld_vdda_h_n_buf===1'bx && enable_vdda_h!==0) || !pwr_good_hv)
	begin
		switch_bb_sl_final 	<= 1'bx;
	end
	else if (enable_vdda_h===0 || hld_vdda_h_n_buf ===0)
	begin
		switch_bb_sl_final 	<= 1'b0;
	end
	else
	begin
		switch_bb_sl_final 	<= (^switch_bb_sl_buf	=== 1'bx || !pwr_good_lv) ? 1'bx : switch_bb_sl_buf;
	end
end

always @(notifier_switch_bb_sl or notifier_enable_vdda_h)
begin
     disable LSH_switch_bb_sl; switch_bb_sl_final <= 1'bx;
end


always @(*)
begin : LSH_switch_bb_sr
		
	if ( (^enable_vdda_h===1'bx  && hld_vdda_h_n_buf!==0) || (^hld_vdda_h_n_buf===1'bx && enable_vdda_h!==0) || !pwr_good_hv)
	begin
		switch_bb_sr_final 	<= 1'bx;
	end
	else if (enable_vdda_h===0 || hld_vdda_h_n_buf ===0)
	begin
		switch_bb_sr_final 	<= 1'b0;
	end
	else
	begin
		switch_bb_sr_final 	<= (^switch_bb_sr_buf	=== 1'bx || !pwr_good_lv) ? 1'bx : switch_bb_sr_buf;
	end
end

always @(notifier_switch_bb_sr or notifier_enable_vdda_h)
begin
     disable LSH_switch_bb_sr; switch_bb_sr_final <= 1'bx;
end


always @(*)
begin : LSH_switch_bb_s0
		
	if ((^enable_vdda_h===1'bx  && hld_vdda_h_n_buf!==0) ||(^hld_vdda_h_n_buf===1'bx && enable_vdda_h!==0)  || !pwr_good_hv)
	begin
		switch_bb_s0_final 	<= 1'bx;
	end
	else if (enable_vdda_h===0 || hld_vdda_h_n_buf ===0)
	begin
		switch_bb_s0_final 	<= 1'b0;
	end

	else
	begin
		switch_bb_s0_final 	<= (^switch_bb_s0_buf	=== 1'bx || !pwr_good_lv) ? 1'bx : switch_bb_s0_buf;
	end
end

always @(notifier_switch_bb_s0 or notifier_enable_vdda_h)
begin
     disable LSH_switch_bb_s0; switch_bb_s0_final <= 1'bx;
end


//==================================================================================================================================================
 
// ERROR message flagged if illegal switch_sel combinations are detected 

// M0S8 SAS / BROS : Location (where this Error message is specified is to be determined

reg dis_err_msgs;
integer flag_error_short_ar_br, flag_error_short_al_bl, flag_error_illegal_inputs_aa,flag_error_illegal_inputs_bb,msg_count_pad,msg_count_pad1;




initial
begin
  
  dis_err_msgs = 1'b1;
    
  msg_count_pad  = 0; 
  msg_count_pad1 = 0;

  flag_error_short_ar_br	= 0;  
  flag_error_short_al_bl	= 0;  
  flag_error_illegal_inputs_aa	= 0;  
  flag_error_illegal_inputs_bb	= 0;
  
  `ifdef S8IOM0S8_TOP_AMUXSPLITV2_DIS_ERR_MSGS
  `else
    #1;
    dis_err_msgs = 1'b0;
  `endif
end



//=========================================================================================================================================================================

// ERROR MESSAGES FOR DETECTING ILLEGAL (INDIVIDUAL) COMBINATIONS OF T-SWITCH CONTROL INPUTS

wire #100 error_illegal_inputs_aa = ({switch_aa_sl_final,switch_aa_sr_final,switch_aa_s0_final} === 3'b010) || ({switch_aa_sl_final,switch_aa_sr_final,switch_aa_s0_final} === 3'b100);

wire #100 error_illegal_inputs_bb = ({switch_bb_sl_final,switch_bb_sr_final,switch_bb_s0_final} === 3'b010) || ({switch_bb_sl_final,switch_bb_sr_final,switch_bb_s0_final} === 3'b100);

event event_error_illegal_inputs_aa, event_error_illegal_inputs_bb;


always @(error_illegal_inputs_aa) 
begin
  	if (!dis_err_msgs) 
  	begin
    		if (error_illegal_inputs_aa===1) 
		begin

			msg_count_pad = msg_count_pad + 1;

			->event_error_illegal_inputs_aa;

			if (msg_count_pad <= MAX_WARNING_COUNT)
			begin
			$display("\n ===ERROR=== sky130_fd_io__top_amuxsplitv2 :  Illegal combination of T-switch select signals for AMUXBUS_A_L -- AMUXBUS_A_R : switch_aa_sl = %b,switch_aa_sr = %b,switch_aa_s0 = %b. Legal combinations are (sl,sr,s0) = 000, 001, 011, 101, 110, 111 %m\n", 
			switch_aa_sl_final,switch_aa_sr_final,switch_aa_s0_final, $stime);
			end

			else
			if (msg_count_pad == MAX_WARNING_COUNT+1)
			begin
				$display("\n ===WARNING=== sky130_fd_io__top_amuxsplitv2 :  Further WARNING messages will be suppressed as the message count has exceeded 100 %m\n",$stime);
			end
	
		end
	end
end



always @(error_illegal_inputs_bb) 
begin
  	if (!dis_err_msgs) 
  	begin
    		if (error_illegal_inputs_bb===1) 
		begin
		
			msg_count_pad1 = msg_count_pad1 + 1;
		
			->event_error_illegal_inputs_bb;

			if (msg_count_pad1 <= MAX_WARNING_COUNT)
			begin
			$display("\n ===ERROR=== sky130_fd_io__top_amuxsplitv2 :  Illegal combination of T-switch select signals for AMUXBUS_B_L -- AMUXBUS_B_R : switch_bb_sl = %b,switch_bb_sr = %b,switch_bb_s0 = %b. Legal combinations are (sl,sr,s0) = 000, 001, 011, 101, 110, 111 %m\n", 
			switch_bb_sl_final,switch_bb_sr_final,switch_bb_s0_final, $stime);

			end
			else
			if (msg_count_pad1 == MAX_WARNING_COUNT+1)
			begin
				$display("\n ===WARNING=== sky130_fd_io__top_amuxsplitv2 :  Further WARNING messages will be suppressed as the message count has exceeded 100 %m\n",$stime);

			end
			
		end
	end
end


//======================================================================================================================================================================   
  
 
 
endmodule

`default_nettype wire
`endif  // SKY130_FD_IO__TOP_AMUXSPLITV2_V


//--------EOF---------

/**
 * Copyright 2020 The SkyWater PDK Authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 * SPDX-License-Identifier: Apache-2.0
 */

`ifndef SKY130_FD_IO__TOP_ANALOG_PAD_V
`define SKY130_FD_IO__TOP_ANALOG_PAD_V

/**
 * top_analog_pad:  Analog Pad.
 *
 * Verilog top module.
 */

`timescale 1ns/1ps
`default_nettype none

module sky130_fd_io__top_analog_pad (amuxbus_a, amuxbus_b, pad, pad_core 
`ifdef USE_POWER_PINS
		   	   ,vccd, vcchib, vdda, vddio, vddio_q, vssa, vssd, vssio, vssio_q, vswitch
`endif	
    );	

    inout amuxbus_a;
    inout amuxbus_b;
    inout pad;
    inout pad_core;
    
`ifdef USE_POWER_PINS    
    
    inout vccd;
    inout vcchib;
    inout vdda;
    inout vddio;
    inout vddio_q;
    inout vssa;
    inout vssd;
    inout vssio;
    inout vssio_q;
    inout vswitch;
    wire pwr_good = vddio===1 && vssio===0;

`else
    
    supply1 vccd;
    supply1 vcchib;
    supply1 vdda;
    supply1 vddio;
    supply1 vddio_q;
    supply0 vssa;
    supply0 vssd;
    supply0 vssio;
    supply0 vssio_q;
    supply1 vswitch;
    wire pwr_good = 1;

`endif    
   
    wire pad_sw = pwr_good===1 ? 1'b1 : 1'bx;
    
    tranif1 x_pad (pad, pad_core, pad_sw); 
    

endmodule

`default_nettype wire
`endif  // SKY130_FD_IO__TOP_ANALOG_PAD_V


//--------EOF---------

/**
 * Copyright 2020 The SkyWater PDK Authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 * SPDX-License-Identifier: Apache-2.0
 */

`ifndef SKY130_FD_IO__TOP_GPIO_OVTV2_V
`define SKY130_FD_IO__TOP_GPIO_OVTV2_V

/**
 * top_gpio_ovtv2: General Purpose I/0.
 *
 * Verilog top module.
 *
 * WARNING: This file is autogenerated, do not modify directly!
 */

`timescale 1ns / 1ps
`default_nettype none

`ifdef USE_POWER_PINS

`ifdef FUNCTIONAL
/*
 * Copyright 2020 The SkyWater PDK Authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 * SPDX-License-Identifier: Apache-2.0
*/

module sky130_fd_io__top_gpio_ovtv2 ( IN, IN_H, TIE_HI_ESD, TIE_LO_ESD, AMUXBUS_A,
                                      AMUXBUS_B, PAD, PAD_A_ESD_0_H, PAD_A_ESD_1_H, PAD_A_NOESD_H,
                                      VCCD, VCCHIB,VDDA, VDDIO, VDDIO_Q, VSSA, VSSD, VSSIO, VSSIO_Q, VSWITCH,
                                      ANALOG_EN, ANALOG_POL, ANALOG_SEL, DM, ENABLE_H, ENABLE_INP_H, ENABLE_VDDA_H, ENABLE_VDDIO, ENABLE_VSWITCH_H, HLD_H_N,
                                      HLD_OVR, IB_MODE_SEL, INP_DIS, OE_N, OUT, SLOW, SLEW_CTL, VTRIP_SEL, HYS_TRIM, VINREF );
input OUT;
input OE_N;
input HLD_H_N;
input ENABLE_H;
input ENABLE_INP_H;
input ENABLE_VDDA_H;
input ENABLE_VDDIO;
input ENABLE_VSWITCH_H;
input INP_DIS;
input VTRIP_SEL;
input HYS_TRIM;
input SLOW;
input [1:0] SLEW_CTL;
input HLD_OVR;
input ANALOG_EN;
input ANALOG_SEL;
input ANALOG_POL;
input [2:0] DM;
input [1:0] IB_MODE_SEL;
input VINREF;
inout VDDIO;
inout VDDIO_Q;
inout VDDA;
inout VCCD;
inout VSWITCH;
inout VCCHIB;
inout VSSA;
inout VSSD;
inout VSSIO_Q;
inout VSSIO;
inout PAD;
inout PAD_A_NOESD_H,PAD_A_ESD_0_H,PAD_A_ESD_1_H;
inout AMUXBUS_A;
inout AMUXBUS_B;
output IN;
output IN_H;
output TIE_HI_ESD, TIE_LO_ESD;
wire hld_h_n_del;
wire hld_h_n_buf;
reg [2:0] dm_final;
reg [1:0] slew_ctl_final;
reg slow_final, vtrip_sel_final, inp_dis_final, out_final, oe_n_final, hld_ovr_final, hys_trim_final, analog_en_final,analog_en_vdda, analog_en_vswitch,analog_en_vddio_q;
reg [1:0] ib_mode_sel_final;
wire [2:0] dm_del;
wire [1:0] slew_ctl_del;
wire [1:0] ib_mode_sel_del;
wire slow_del, vtrip_sel_del, inp_dis_del, out_del, oe_n_del, hld_ovr_del, hys_trim_del;
wire [2:0] dm_buf;
wire [1:0] slew_ctl_buf;
wire [1:0] ib_mode_sel_buf;
wire slow_buf, vtrip_sel_buf, inp_dis_buf, out_buf, oe_n_buf, hld_ovr_buf, hys_trim_buf;
reg notifier_dm, notifier_slow, notifier_oe_n, notifier_out, notifier_vtrip_sel, notifier_hld_ovr, notifier_inp_dis;
reg notifier_slew_ctl, notifier_ib_mode_sel, notifier_hys_trim;
reg notifier_enable_h, notifier, dummy_notifier1;
assign hld_h_n_buf 	= HLD_H_N;
assign hld_ovr_buf 	= HLD_OVR;
assign dm_buf 		= DM;
assign inp_dis_buf 	= INP_DIS;
assign vtrip_sel_buf 	= VTRIP_SEL;
assign slow_buf 	= SLOW;
assign oe_n_buf 	= OE_N;
assign out_buf 		= OUT;
assign ib_mode_sel_buf 	= IB_MODE_SEL;
assign slew_ctl_buf	= SLEW_CTL;
assign hys_trim_buf 	= HYS_TRIM;
wire  pwr_good_amux	         = ((hld_h_n_buf===0 || ENABLE_H===0) ? 1:(VCCD===1))  && (VSSD===0) && (VSSA===0) && (VSSIO_Q===0);
wire  pwr_good_output_driver     = (VDDIO===1)   && (VDDIO_Q===1)&& (VSSIO===0)   && (VSSD===0)  && (VSSA===0) ;
wire  pwr_good_hold_ovr_mode     = (VDDIO_Q===1) && (VDDIO===1)  && (VSSD===0)    && (VCCHIB===1);
wire  pwr_good_active_mode       = (VDDIO_Q===1) && (VDDIO===1)  && (VSSD===0)    && (VCCD===1);
wire  pwr_good_hold_mode         = (VDDIO_Q===1) && (VDDIO===1)  && (VSSD===0);
wire  pwr_good_active_mode_vdda  = (VDDA===1)  && (VSSD===0)   && (VCCD===1);
wire  pwr_good_hold_mode_vdda    = (VDDA===1)    && (VSSD===0);
wire  pwr_good_inpbuff_hv        = (VDDIO_Q===1) && (inp_dis_final===0 && dm_final!==3'b000 && ib_mode_sel_final===2'b01 ? VCCHIB===1 : 1) && (VSSD===0);
wire  pwr_good_inpbuff_lv        = (VDDIO_Q===1) && (VSSD===0)   && (VCCHIB===1);
wire  pwr_good_analog_en_vdda    = (VDDA===1)  && (VSSD===0) && (VSSA===0) ;
wire  pwr_good_analog_en_vddio_q = (VDDIO_Q ===1)  && (VSSD===0) && (VSSA===0) ;
wire  pwr_good_analog_en_vswitch = (VSWITCH ===1)  && (VSSD===0) && (VSSA===0) ;
wire  pwr_good_amux_vccd   	 = ((hld_h_n_buf===0 || ENABLE_H===0) ? 1:(VCCD===1));
parameter MAX_WARNING_COUNT = 100;
wire pad_tristate = oe_n_final === 1 || dm_final === 3'b000 || dm_final === 3'b001;
wire x_on_pad  =  !pwr_good_output_driver
     || (dm_final !== 3'b000 	&& dm_final !== 3'b001 		&& oe_n_final===1'bx)
     || (^dm_final[2:0] === 1'bx 	&& oe_n_final===1'b0)
     || (slow_final===1'bx 	&& dm_final !== 3'b000		&& dm_final !== 3'b001 && oe_n_final===1'b0)
     || (slow_final===1'b1 	&& ^slew_ctl_final[1:0] ===1'bx 	&& dm_final === 3'b100 && oe_n_final===1'b0);
`ifdef SKY130_FD_IO_TOP_GPIO_OVTV2_SLOW_BEHV
parameter SLOW_1_DELAY= 70 ;
parameter SLOW_0_DELAY= 40;
`else
parameter SLOW_1_DELAY= 0;
parameter SLOW_0_DELAY= 0;
`endif
`ifdef SKY130_FD_IO_TOP_GPIO_OVTV2_SLEW_BEHV
parameter SLEW_00_DELAY= 127 ;
parameter SLEW_01_DELAY= 109;
parameter SLEW_10_DELAY= 193;
parameter SLEW_11_DELAY= 136;
`else
parameter SLEW_00_DELAY= 0 ;
parameter SLEW_01_DELAY= 0;
parameter SLEW_10_DELAY= 0;
parameter SLEW_11_DELAY= 0;
`endif
integer slow_1_delay,slow_0_delay,slow_delay,slew_00_delay,slew_01_delay,slew_10_delay,slew_11_delay;
initial slow_1_delay = SLOW_1_DELAY;
initial slow_0_delay = SLOW_0_DELAY;
initial slew_00_delay = SLEW_00_DELAY;
initial slew_01_delay = SLEW_01_DELAY;
initial slew_10_delay = SLEW_10_DELAY;
initial slew_11_delay = SLEW_11_DELAY;
always @(*)
begin
    if (SLOW===1)
    begin
        if (DM[2]===1 && DM[1]===0 && DM[0]===0)
        begin
`ifdef SKY130_FD_IO_TOP_GPIO_OVTV2_SLEW_BEHV
            if (SLEW_CTL[1] ===0 && SLEW_CTL[0] ===0)
                slow_delay = 	slew_00_delay;
            else if (SLEW_CTL[1] ===0 && SLEW_CTL[0] ===1)
                slow_delay = 	slew_01_delay;
            else if (SLEW_CTL[1] ===1 && SLEW_CTL[0] ===0)
                slow_delay = 	slew_10_delay;
            else if (SLEW_CTL[1] ===1 && SLEW_CTL[0] ===1)
                slow_delay = 	slew_11_delay;
`else
            slow_delay = slow_1_delay;
`endif
        end
        else
            slow_delay = slow_1_delay;
    end
    else
        slow_delay = slow_0_delay;
end
bufif1 (pull1, strong0) #slow_delay dm2 (PAD, out_final, x_on_pad===1 ? 1'bx : (pad_tristate===0 && dm_final===3'b010));
bufif1 (strong1, pull0) #slow_delay dm3 (PAD, out_final, x_on_pad===1 ? 1'bx : (pad_tristate===0 && dm_final===3'b011));
bufif1 (highz1, strong0) #slow_delay dm4 (PAD, out_final, x_on_pad===1 ? 1'bx : (pad_tristate===0 && dm_final===3'b100));
bufif1 (strong1, highz0) #slow_delay dm5 (PAD, out_final, x_on_pad===1 ? 1'bx : (pad_tristate===0 && dm_final===3'b101));
bufif1 (strong1, strong0) #slow_delay dm6 (PAD, out_final, x_on_pad===1 ? 1'bx : (pad_tristate===0 && dm_final===3'b110));
bufif1 (pull1, pull0)  #slow_delay dm7 (PAD, out_final, x_on_pad===1 ? 1'bx : (pad_tristate===0 && dm_final===3'b111));
tran pad_esd_1 (PAD,PAD_A_NOESD_H);
tran pad_esd_2 (PAD,PAD_A_ESD_0_H);
tran pad_esd_3 (PAD,PAD_A_ESD_1_H);
wire x_on_in_hv  =  (ENABLE_H===0  && ^ENABLE_INP_H===1'bx)
     || (inp_dis_final===1'bx  && ^dm_final[2:0]!==1'bx && dm_final !== 3'b000)
     || (^ENABLE_H===1'bx)
     || (inp_dis_final===0 	       		&& ^dm_final[2:0] === 1'bx)
     || (^ib_mode_sel_final===1'bx  	&& inp_dis_final===0  		&& dm_final !== 3'b000)
     || (vtrip_sel_final===1'bx    		&& inp_dis_final===0        	&& dm_final !== 3'b000		&& ib_mode_sel_final===2'b00)
     || (^ENABLE_VDDIO===1'bx    		&& inp_dis_final===0        	&& dm_final !== 3'b000		&& ib_mode_sel_final===2'b01)
     || (ib_mode_sel_final[1]===1'b1	&& VINREF !== 1'b1    		&& inp_dis_final===0      	&& dm_final !== 3'b000)
     || (ib_mode_sel_final[1]===1'b1	&& hys_trim_final===1'bx	&& inp_dis_final===0      	&& dm_final !== 3'b000);
wire x_on_in_lv  =  (ENABLE_H===0  && ^ENABLE_VDDIO===1'bx)
     || (ENABLE_H===0  && ^ENABLE_INP_H===1'bx)
     || (inp_dis_final===1'bx  && ^dm_final[2:0]!==1'bx && dm_final !== 3'b000)
     || (^ENABLE_H===1'bx)
     || (inp_dis_final===0 	       		&& ^dm_final[2:0] === 1'bx)
     || (^ib_mode_sel_final===1'bx  	&& inp_dis_final===0  		&& dm_final !== 3'b000)
     || (vtrip_sel_final===1'bx    		&& inp_dis_final===0        	&& dm_final !== 3'b000		&& ib_mode_sel_final===2'b00)
     || (^ENABLE_VDDIO===1'bx    		&& inp_dis_final===0        	&& dm_final !== 3'b000	)
     || (ib_mode_sel_final[1]===1'b1	&& VINREF !== 1'b1    		&& inp_dis_final===0      	&& dm_final !== 3'b000)
     || (ib_mode_sel_final[1]===1'b1	&& hys_trim_final===1'bx	&& inp_dis_final===0      	&& dm_final !== 3'b000);
wire disable_inp_buff = ENABLE_H===1 ? (dm_final===3'b000 || inp_dis_final===1) : ENABLE_INP_H===0;
assign IN_H = (x_on_in_hv===1 || pwr_good_inpbuff_hv===0) ? 1'bx : (disable_inp_buff===1 ? 0 : (^PAD===1'bx ? 1'bx : PAD));
wire disable_inp_buff_lv = ENABLE_H===1 ? (dm_final===3'b000 || inp_dis_final===1) : ENABLE_VDDIO===0;
assign IN   = (x_on_in_lv ===1 || pwr_good_inpbuff_lv===0) ? 1'bx : (disable_inp_buff_lv===1 ? 0 : (^PAD===1'bx ? 1'bx : PAD));
assign TIE_HI_ESD = VDDIO===1'b1 ? 1'b1 : 1'bx;
assign TIE_LO_ESD = VSSIO===1'b0 ? 1'b0 : 1'bx;
wire functional_mode_amux = (pwr_good_analog_en_vdda ===1 && pwr_good_analog_en_vddio_q ===1 && pwr_good_analog_en_vswitch ===1 );
wire x_on_analog_en_vdda = (pwr_good_analog_en_vdda !==1
                            || (functional_mode_amux ==1 && (ENABLE_H !==0 && ^hld_h_n_buf === 1'bx) || (hld_h_n_buf!== 0 && ^ENABLE_H=== 1'bx) || pwr_good_amux_vccd !==1 )
                            || (functional_mode_amux ==1 && (hld_h_n_buf ===1 && ENABLE_H===1 && ^ANALOG_EN === 1'bx && ENABLE_VDDA_H ===1 && ENABLE_VSWITCH_H===1 ) || (hld_h_n_buf ===1 && ENABLE_H===1 && ANALOG_EN ===0 && ^ENABLE_VDDA_H ===1'bx) ));
wire zero_on_analog_en_vdda = ( (pwr_good_analog_en_vdda ===1 && ENABLE_VDDA_H ===0)
                                || (pwr_good_analog_en_vdda ===1 && pwr_good_analog_en_vddio_q ===1 && hld_h_n_buf===0)
                                || (pwr_good_analog_en_vdda ===1 && pwr_good_analog_en_vddio_q ===1 && ENABLE_H===0)
                                ||  (pwr_good_analog_en_vdda ===1 && pwr_good_analog_en_vddio_q ===1 && pwr_good_amux_vccd && ANALOG_EN===0) );
wire x_on_analog_en_vddio_q =  ( pwr_good_analog_en_vddio_q !==1
                                 || (functional_mode_amux ==1 && (ENABLE_H !==0 && ^hld_h_n_buf === 1'bx) || (hld_h_n_buf!== 0 && ^ENABLE_H=== 1'bx) || pwr_good_amux_vccd !==1 )
                                 || (functional_mode_amux ==1 && (hld_h_n_buf ===1 && ENABLE_H===1 && ^ANALOG_EN === 1'bx && ENABLE_VDDA_H ===1 && ENABLE_VSWITCH_H===1 ) ));
wire zero_on_analog_en_vddio_q =  ( (pwr_good_analog_en_vddio_q ===1 && hld_h_n_buf===0)
                                    || (pwr_good_analog_en_vddio_q ===1 && ENABLE_H===0)
                                    ||  (pwr_good_analog_en_vddio_q ===1 && pwr_good_amux_vccd && ANALOG_EN===0) );
wire x_on_analog_en_vswitch = (pwr_good_analog_en_vswitch !==1
                               || (functional_mode_amux ==1 && (ENABLE_H !==0 && ^hld_h_n_buf === 1'bx) || (hld_h_n_buf!== 0 && ^ENABLE_H=== 1'bx) || pwr_good_amux_vccd !==1 )
                               || (functional_mode_amux ==1 && (hld_h_n_buf ===1 && ENABLE_H===1 && ^ANALOG_EN === 1'bx && ENABLE_VDDA_H ===1 && ENABLE_VSWITCH_H===1 ) || (hld_h_n_buf ===1 && ENABLE_H===1 && ANALOG_EN ===0 && ^ENABLE_VSWITCH_H ===1'bx) ));
wire  zero_on_analog_en_vswitch =   ( (pwr_good_analog_en_vswitch ===1 && ENABLE_VSWITCH_H ===0)
                                      || (pwr_good_analog_en_vswitch ===1 && pwr_good_analog_en_vddio_q ===1 && hld_h_n_buf===0)
                                      || (pwr_good_analog_en_vswitch ===1 && pwr_good_analog_en_vddio_q ===1 && ENABLE_H===0)
                                      ||  (pwr_good_analog_en_vswitch ===1 && pwr_good_analog_en_vddio_q ===1 && pwr_good_amux_vccd && ANALOG_EN===0) );
always @(*)
begin : LATCH_dm
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode || (ENABLE_H===1 && ^hld_h_n_buf===1'bx))
    begin
        dm_final 	<= 3'bxxx;
    end
    else if (ENABLE_H===0)
    begin
        dm_final 	<= 3'b000;
    end
    else if (hld_h_n_buf===1)
    begin
        dm_final 	<= (^dm_buf[2:0]	=== 1'bx	|| !pwr_good_active_mode) ? 3'bxxx : dm_buf;
    end
end
always @(notifier_enable_h or notifier_dm)
begin
    disable LATCH_dm; dm_final <= 3'bxxx;
end
always @(*)
begin : LATCH_inp_dis
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode || (ENABLE_H===1 && ^hld_h_n_buf===1'bx))
    begin
        inp_dis_final 	<= 1'bx;
    end
    else if (ENABLE_H===0)
    begin
        inp_dis_final 	<= 1'b1;
    end
    else if (hld_h_n_buf===1)
    begin
        inp_dis_final 	<= (^inp_dis_buf === 1'bx	|| !pwr_good_active_mode) ? 1'bx : inp_dis_buf;
    end
end
always @(notifier_enable_h or notifier_inp_dis)
begin
    disable LATCH_inp_dis; inp_dis_final <= 1'bx;
end
always @(*)
begin : LATCH_ib_mode_sel
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode || (ENABLE_H===1 && ^hld_h_n_buf===1'bx))
    begin
        ib_mode_sel_final 	<= 2'bxx;
    end
    else if (ENABLE_H===0)
    begin
        ib_mode_sel_final 	<= 2'b00;
    end
    else if (hld_h_n_buf===1)
    begin
        ib_mode_sel_final 	<= (^ib_mode_sel_buf[1:0]	=== 1'bx	|| !pwr_good_active_mode) ? 2'bxx : ib_mode_sel_buf;
    end
end
always @(notifier_enable_h or notifier_ib_mode_sel)
begin
    disable LATCH_ib_mode_sel; ib_mode_sel_final <= 2'bxx;
end
always @(*)
begin : LATCH_slew_ctl_final
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode || (ENABLE_H===1 && ^hld_h_n_buf===1'bx))
    begin
        slew_ctl_final 	<= 2'bxx;
    end
    else if (ENABLE_H===0)
    begin
        slew_ctl_final 	<= 2'b00;
    end
    else if (hld_h_n_buf===1)
    begin
        slew_ctl_final 	<= (^slew_ctl_buf[1:0] === 1'bx || !pwr_good_active_mode) ? 2'bxx : slew_ctl_buf;
    end
end
always @(notifier_enable_h or notifier_slew_ctl)
begin
    disable LATCH_slew_ctl_final; slew_ctl_final <= 2'bxx;
end
always @(*)
begin : LATCH_vtrip_sel
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode || (ENABLE_H===1 && ^hld_h_n_buf===1'bx))
    begin
        vtrip_sel_final 	<= 1'bx;
    end
    else if (ENABLE_H===0)
    begin
        vtrip_sel_final 	<= 1'b0;
    end
    else if (hld_h_n_buf===1)
    begin
        vtrip_sel_final 	<= (^vtrip_sel_buf === 1'bx	|| !pwr_good_active_mode) ? 1'bx : vtrip_sel_buf;
    end
end
always @(notifier_enable_h or notifier_vtrip_sel)
begin
    disable LATCH_vtrip_sel; vtrip_sel_final <= 1'bx;
end
always @(*)
begin : LATCH_hys_trim
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode || (ENABLE_H===1 && ^hld_h_n_buf===1'bx))
    begin
        hys_trim_final 	<= 1'bx;
    end
    else if (ENABLE_H===0)
    begin
        hys_trim_final 	<= 1'b0;
    end
    else if (hld_h_n_buf===1)
    begin
        hys_trim_final 	<= (^hys_trim_buf === 1'bx	|| !pwr_good_active_mode) ? 1'bx : hys_trim_buf;
    end
end
always @(notifier_enable_h or notifier_hys_trim)
begin
    disable LATCH_hys_trim; hys_trim_final <= 1'bx;
end
always @(*)
begin : LATCH_slow
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode || (ENABLE_H===1 && ^hld_h_n_buf===1'bx))
    begin
        slow_final 	<= 1'bx;
    end
    else if (ENABLE_H===0)
    begin
        slow_final 	<= 1'b0;
    end
    else if (hld_h_n_buf===1)
    begin
        slow_final 	<= (^slow_buf === 1'bx	|| !pwr_good_active_mode) ? 1'bx : slow_buf;
    end
end
always @(notifier_enable_h or notifier_slow)
begin
    disable LATCH_slow; slow_final <= 1'bx;
end
always @(*)
begin : LATCH_hld_ovr
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode || (ENABLE_H===1 && ^hld_h_n_buf===1'bx))
    begin
        hld_ovr_final 	<= 1'bx;
    end
    else if (ENABLE_H===0)
    begin
        hld_ovr_final 	<= 1'b0;
    end
    else if (hld_h_n_buf===1)
    begin
        hld_ovr_final 	<= (^hld_ovr_buf === 1'bx	|| !pwr_good_active_mode) ? 1'bx : hld_ovr_buf;
    end
end
always @(notifier_enable_h or notifier_hld_ovr)
begin
    disable LATCH_hld_ovr; hld_ovr_final <= 1'bx;
end
always @(*)
begin : LATCH_oe_n
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode || (ENABLE_H===1 && (^hld_h_n_buf===1'bx || (hld_h_n_buf===0 && hld_ovr_final===1'bx)|| (hld_h_n_buf===1 && hld_ovr_final===1'bx))))
    begin
        oe_n_final 	<= 1'bx;
    end
    else if (ENABLE_H===0)
    begin
        oe_n_final 	<= 1'b1;
    end
    else if (hld_h_n_buf===1 || hld_ovr_final===1)
    begin
        oe_n_final  	<= (^oe_n_buf  === 1'bx  || !pwr_good_hold_ovr_mode) ? 1'bx   : oe_n_buf;
    end
end
always @(notifier_enable_h or notifier_oe_n)
begin
    disable LATCH_oe_n; oe_n_final <= 1'bx;
end
always @(*)
begin : LATCH_out
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode || (ENABLE_H===1 && (^hld_h_n_buf===1'bx ||(hld_h_n_buf===0 &&  hld_ovr_final===1'bx)||(hld_h_n_buf===1 &&  hld_ovr_final===1'bx))))
    begin
        out_final 	<= 1'bx;
    end
    else if (ENABLE_H===0)
    begin
        out_final 	<= 1'b1;
    end
    else if (hld_h_n_buf===1 || hld_ovr_final===1)
    begin
        out_final  	<= (^out_buf  === 1'bx  || !pwr_good_hold_ovr_mode) ? 1'bx   : out_buf;
    end
end
always @(notifier_enable_h or notifier_out)
begin
    disable LATCH_out; out_final <= 1'bx;
end
always @(*)
begin
    if (x_on_analog_en_vdda ===1 )
    begin
        analog_en_vdda <= 1'bx;
    end
    else if ( zero_on_analog_en_vdda ===1 )
    begin
        analog_en_vdda <= 1'b0;
    end
    else if (x_on_analog_en_vdda !==1 && zero_on_analog_en_vdda !==1)
    begin
        analog_en_vdda <= ANALOG_EN;
    end
    if (x_on_analog_en_vddio_q  ===1 )
    begin
        analog_en_vddio_q  <= 1'bx;
    end
    else if ( zero_on_analog_en_vddio_q ===1 )
    begin
        analog_en_vddio_q  <= 1'b0;
    end
    else if ( x_on_analog_en_vddio_q !==1 && zero_on_analog_en_vddio_q !==1)
    begin
        analog_en_vddio_q  <= ANALOG_EN;
    end
    if (x_on_analog_en_vswitch  ===1 )
    begin
        analog_en_vswitch  <= 1'bx;
    end
    else if ( zero_on_analog_en_vswitch ===1 )
    begin
        analog_en_vswitch  <= 1'b0;
    end
    else if (x_on_analog_en_vswitch !==1 && zero_on_analog_en_vswitch !==1)
    begin
        analog_en_vswitch  <= ANALOG_EN;
    end
    if ( (analog_en_vswitch ===1'bx && analog_en_vdda ===1'bx) || (analog_en_vswitch ===1'bx && analog_en_vddio_q ===1'bx) || (analog_en_vddio_q ===1'bx && analog_en_vdda ===1'bx ) )
    begin
        analog_en_final  <= 1'bx;
    end
    else if (analog_en_vdda ===1'bx && (analog_en_vddio_q ===1 ||analog_en_vswitch===1 ))
    begin
        analog_en_final  <= 1'bx;
    end
    else if (analog_en_vddio_q ===1'bx && (analog_en_vdda ===1 ||analog_en_vswitch===1 ))
    begin
        analog_en_final  <= 1'bx;
    end
    else if (analog_en_vswitch===1'bx && (analog_en_vdda ===1 || analog_en_vddio_q ===1 ))
    begin
        analog_en_final  <= 1'bx;
    end
    else if ((analog_en_vdda ===0 && analog_en_vddio_q ===0 )|| (analog_en_vdda ===0 && analog_en_vswitch===0 ) ||  (analog_en_vddio_q ===0 && analog_en_vswitch===0 ))
    begin
        analog_en_final  <=0;
    end
    else if (analog_en_vdda ===1 && analog_en_vddio_q ===1 &&  analog_en_vswitch ===1)
    begin
        analog_en_final  <=1;
    end
end
wire [2:0] amux_select = {ANALOG_SEL, ANALOG_POL, out_buf};
wire invalid_controls_amux = 	(analog_en_final===1'bx && inp_dis_final===1)
     || !pwr_good_amux
     || (analog_en_final===1 && ^amux_select[2:0] === 1'bx && inp_dis_final===1);
wire enable_pad_amuxbus_a = invalid_controls_amux  ? 1'bx : (amux_select===3'b001 || amux_select===3'b010) && (analog_en_final===1);
wire enable_pad_amuxbus_b = invalid_controls_amux  ? 1'bx : (amux_select===3'b101 || amux_select===3'b110) && (analog_en_final===1);
wire enable_pad_vssio_q   = invalid_controls_amux  ? 1'bx : (amux_select===3'b100 || amux_select===3'b000) && (analog_en_final===1);
wire enable_pad_vddio_q   = invalid_controls_amux  ? 1'bx : (amux_select===3'b011 || amux_select===3'b111) && (analog_en_final===1);
tranif1 pad_amuxbus_a 	(PAD, AMUXBUS_A, enable_pad_amuxbus_a);
tranif1 pad_amuxbus_b 	(PAD, AMUXBUS_B, enable_pad_amuxbus_b);
bufif1 pad_vddio_q	(PAD, VDDIO_Q,   enable_pad_vddio_q);
bufif1 pad_vssio_q   	(PAD, VSSIO_Q,   enable_pad_vssio_q);
reg dis_err_msgs;
integer msg_count_pad,msg_count_pad1,msg_count_pad2,msg_count_pad3,msg_count_pad4,msg_count_pad5,msg_count_pad6,msg_count_pad7,msg_count_pad8,msg_count_pad9,msg_count_pad10,msg_count_pad11,msg_count_pad12;
initial
begin
    dis_err_msgs = 1'b1;
    msg_count_pad  = 0;
    msg_count_pad1 = 0;
    msg_count_pad2 = 0;
    msg_count_pad3 = 0;
    msg_count_pad4 = 0;
    msg_count_pad5 = 0;
    msg_count_pad6 = 0;
    msg_count_pad7 = 0;
    msg_count_pad8 = 0;
    msg_count_pad9 = 0;
    msg_count_pad10 = 0;
    msg_count_pad11 = 0;
    msg_count_pad12  = 0;
`ifdef SKY130_FD_IO_TOP_GPIO_OVTV2_DIS_ERR_MSGS
`else
    #1;
    dis_err_msgs = 1'b0;
`endif
end
wire #100 error_enable_vddio = (ENABLE_VDDIO===0 && ENABLE_H===1);
event event_error_enable_vddio;
always @(error_enable_vddio)
begin
    if (!dis_err_msgs)
    begin
        if (error_enable_vddio===1)
        begin
            msg_count_pad = msg_count_pad + 1;
            ->event_error_enable_vddio;
            if (msg_count_pad <= MAX_WARNING_COUNT)
            begin
                $display(" ===ERROR=== sky130_fd_io__top_gpio_ovtv2 :  Enable_h (= %b) and ENABLE_VDDIO (= %b) are complement of each other. This is an illegal combination as ENABLE_VDDIO and ENABLE_H are the same input signals IN different power domains %m", ENABLE_H, ENABLE_VDDIO, $stime);
            end
            else
                if (msg_count_pad == MAX_WARNING_COUNT+1)
                begin
                    $display(" ===WARNING=== sky130_fd_io__top_gpio_ovtv2 :  Further WARNING messages will be suppressed as the message count has exceeded 100 %m",$stime);
                end
        end
    end
end
wire #100 error_vdda = ( VDDA===1 && VDDIO_Q !==1 && ENABLE_VDDA_H===1 );
event event_error_vdda;
always @(error_vdda)
begin
    if (!dis_err_msgs)
    begin
        if (error_vdda===1)
        begin
            msg_count_pad1 = msg_count_pad1 + 1;
            ->event_error_vdda;
            if (msg_count_pad1 <= MAX_WARNING_COUNT)
            begin
                $display(" ===ERROR=== sky130_fd_io__top_gpio_ovtv2 : ENABLE_VDDA_H (= %b) cannot be 1 when VDDA (= %b) and VDDIO_Q (= %b) %m",ENABLE_VDDA_H, VDDA,VDDIO_Q,$stime);
            end
            else
                if (msg_count_pad1 == MAX_WARNING_COUNT+1)
                begin
                    $display(" ===WARNING=== sky130_fd_io__top_gpio_ovtv2 :  Further WARNING messages will be suppressed as the message count has exceeded 100 %m",$stime);
                end
        end
    end
end
wire #100 error_vdda2 = ( VDDA===1 && VDDIO_Q ===1 && VSWITCH !==1 && ENABLE_H===1 && hld_h_n_buf ===1  &&  VCCD===1 && ANALOG_EN ===1 );
event event_error_vdda2;
always @(error_vdda2)
begin
    if (!dis_err_msgs)
    begin
        if (error_vdda2===1)
        begin
            msg_count_pad2 = msg_count_pad2 + 1;
            ->event_error_vdda2;
            if (msg_count_pad2 <= MAX_WARNING_COUNT)
            begin
                $display(" ===ERROR=== sky130_fd_io__top_gpio_ovtv2 : ANALOG_EN (= %b) cannot be 1 when VDDA (= %b) , VDDIO_Q (= %b) , VSWITCH(= %b), ENABLE_H (= %b),hld_h_n_buf (= %b) and VCCD (= %b)   %m",ANALOG_EN,VDDA,VDDIO_Q,VSWITCH,ENABLE_H,hld_h_n_buf,VCCD,$stime);
            end
            else
                if (msg_count_pad2 == MAX_WARNING_COUNT+1)
                begin
                    $display(" ===WARNING=== sky130_fd_io__top_gpio_ovtv2 :  Further WARNING messages will be suppressed as the message count has exceeded 100 %m",$stime);
                end
        end
    end
end
wire #100 error_vdda3 =  ( VDDA===1 && VDDIO_Q ===1 && VSWITCH !==1 && ENABLE_H===1 && hld_h_n_buf ===1  && VCCD !==1 );
event event_error_vdda3;
always @(error_vdda3)
begin
    if (!dis_err_msgs)
    begin
        if (error_vdda3===1)
        begin
            msg_count_pad3 = msg_count_pad3 + 1;
            ->event_error_vdda3;
            if (msg_count_pad3 <= MAX_WARNING_COUNT)
            begin
                $display(" ===ERROR=== sky130_fd_io__top_gpio_ovtv2 : VCCD (= %b) cannot be any value other than 1 when VDDA (= %b) , VDDIO_Q (= %b) , VSWITCH(= %b), ENABLE_H (= %b) and hld_h_n_buf (= %b) %m",VCCD,VDDA,VDDIO_Q,VSWITCH,ENABLE_H,hld_h_n_buf,$stime);
            end
            else
                if (msg_count_pad3 == MAX_WARNING_COUNT+1)
                begin
                    $display(" ===WARNING=== sky130_fd_io__top_gpio_ovtv2 :  Further WARNING messages will be suppressed as the message count has exceeded 100 %m",$stime);
                end
        end
    end
end
wire #100 error_vswitch1 =  (VDDA !==1 && VDDIO_Q !==1 && VSWITCH ===1 && (ENABLE_VSWITCH_H===1)) ;
event event_error_vswitch1;
always @(error_vswitch1)
begin
    if (!dis_err_msgs)
    begin
        if (error_vswitch1===1)
        begin
            msg_count_pad4 = msg_count_pad4 + 1;
            ->event_error_vswitch1;
            if (msg_count_pad4 <= MAX_WARNING_COUNT)
            begin
                $display(" ===ERROR=== sky130_fd_io__top_gpio_ovtv2 : ENABLE_VSWITCH_H (= %b) cannot be 1 when VDDA (= %b) , VDDIO_Q (= %b) & VSWITCH(= %b) %m",ENABLE_VSWITCH_H,VDDA,VDDIO_Q,VSWITCH,$stime);
            end
            else
                if (msg_count_pad4 == MAX_WARNING_COUNT+1)
                begin
                    $display(" ===WARNING=== sky130_fd_io__top_gpio_ovtv2 :  Further WARNING messages will be suppressed as the message count has exceeded 100 %m",$stime);
                end
        end
    end
end
wire #100 error_vswitch2 =   (VDDA !==1 && VDDIO_Q !==1 && VSWITCH ===1 && VCCD===1 && ANALOG_EN===1);
event event_error_vswitch2;
always @(error_vswitch2)
begin
    if (!dis_err_msgs)
    begin
        if (error_vswitch2===1)
        begin
            msg_count_pad5 = msg_count_pad5 + 1;
            ->event_error_vswitch2;
            if (msg_count_pad5 <= MAX_WARNING_COUNT)
            begin
                $display(" ===ERROR=== sky130_fd_io__top_gpio_ovtv2 : ANALOG_EN (= %b) cannot be 1 when VDDA (= %b) , VDDIO_Q (= %b) , VSWITCH(= %b)  & VCCD(= %b) %m",ANALOG_EN,VDDA,VDDIO_Q,VSWITCH,VCCD,$stime);
            end
            else
                if (msg_count_pad5 == MAX_WARNING_COUNT+1)
                begin
                    $display(" ===WARNING=== sky130_fd_io__top_gpio_ovtv2 :  Further WARNING messages will be suppressed as the message count has exceeded 100 %m",$stime);
                end
        end
    end
end
wire #100 error_vswitch3 =   (VDDA ===1 && VDDIO_Q !==1 && VSWITCH ===1 && ENABLE_VSWITCH_H===1);
event event_error_vswitch3;
always @(error_vswitch3)
begin
    if (!dis_err_msgs)
    begin
        if (error_vswitch3===1)
        begin
            msg_count_pad6 = msg_count_pad6 + 1;
            ->event_error_vswitch3;
            if (msg_count_pad6 <= MAX_WARNING_COUNT)
            begin
                $display(" ===ERROR=== sky130_fd_io__top_gpio_ovtv2 : ENABLE_VSWITCH_H(= %b) cannot be 1 when VDDA (= %b) , VDDIO_Q (= %b) & VSWITCH(= %b) %m",ENABLE_VSWITCH_H,VDDA,VDDIO_Q,VSWITCH,$stime);
            end
            else
                if (msg_count_pad6 == MAX_WARNING_COUNT+1)
                begin
                    $display(" ===WARNING=== sky130_fd_io__top_gpio_ovtv2 :  Further WARNING messages will be suppressed as the message count has exceeded 100 %m",$stime);
                end
        end
    end
end
wire #100 error_vswitch4 =  (VDDA !==1 && VDDIO_Q ===1 && VSWITCH ===1 && ENABLE_VSWITCH_H===1);
event event_error_vswitch4;
always @(error_vswitch4)
begin
    if (!dis_err_msgs)
    begin
        if (error_vswitch4===1)
        begin
            msg_count_pad7 = msg_count_pad7 + 1;
            ->event_error_vswitch4;
            if (msg_count_pad7 <= MAX_WARNING_COUNT)
            begin
                $display(" ===ERROR=== sky130_fd_io__top_gpio_ovtv2 : ENABLE_VSWITCH_H(= %b) cannot be 1 when VDDA (= %b) , VDDIO_Q (= %b) & VSWITCH(= %b) %m",ENABLE_VSWITCH_H,VDDA,VDDIO_Q,VSWITCH,$stime);
            end
            else
                if (msg_count_pad7 == MAX_WARNING_COUNT+1)
                begin
                    $display(" ===WARNING=== sky130_fd_io__top_gpio_ovtv2 :  Further WARNING messages will be suppressed as the message count has exceeded 100 %m",$stime);
                end
        end
    end
end
wire #100 error_vswitch5 =  (VDDA !==1 && VDDIO_Q ===1 && VSWITCH ===1 && ENABLE_H ===1 && hld_h_n_buf ===1 && VCCD ===1 && ANALOG_EN===1);
event event_error_vswitch5;
always @(error_vswitch5)
begin
    if (!dis_err_msgs)
    begin
        if (error_vswitch5===1)
        begin
            msg_count_pad8 = msg_count_pad8 + 1;
            ->event_error_vswitch5;
            if (msg_count_pad8 <= MAX_WARNING_COUNT)
            begin
                $display(" ===ERROR=== sky130_fd_io__top_gpio_ovtv2 : ANALOG_EN(= %b) cannot be 1 when VDDA (= %b) , VDDIO_Q (= %b) , VSWITCH(= %b),ENABLE_H (= %b),hld_h_n_buf (= %b) and VCCD (= %b) %m",ANALOG_EN,VDDA,VDDIO_Q,VSWITCH,ENABLE_H,hld_h_n_buf,VCCD,$stime);
            end
            else
                if (msg_count_pad8 == MAX_WARNING_COUNT+1)
                begin
                    $display(" ===WARNING=== sky130_fd_io__top_gpio_ovtv2 :  Further WARNING messages will be suppressed as the message count has exceeded 100 %m",$stime);
                end
        end
    end
end
wire #100 error_vddio_q1 =  (VDDA !==1 && VDDIO_Q ===1 && VSWITCH !==1 && ENABLE_H ===1 && hld_h_n_buf ===1 && VCCD!==1);
event event_error_vddio_q1;
always @(error_vddio_q1)
begin
    if (!dis_err_msgs)
    begin
        if (error_vddio_q1===1)
        begin
            msg_count_pad9 = msg_count_pad9 + 1;
            ->event_error_vddio_q1;
            if (msg_count_pad9 <= MAX_WARNING_COUNT)
            begin
                $display(" ===ERROR=== sky130_fd_io__top_gpio_ovtv2 : VCCD(= %b) cannot be any value other than 1 when VDDA (= %b) , VDDIO_Q (= %b) , VSWITCH(= %b),ENABLE_H (= %b) and hld_h_n_buf (= %b)  %m",VCCD,VDDA,VDDIO_Q,VSWITCH,ENABLE_H,hld_h_n_buf,$stime);
            end
            else
                if (msg_count_pad9 == MAX_WARNING_COUNT+1)
                begin
                    $display(" ===WARNING=== sky130_fd_io__top_gpio_ovtv2 :  Further WARNING messages will be suppressed as the message count has exceeded 100 %m",$stime);
                end
        end
    end
end
wire #100 error_vddio_q2 =  (VDDA !==1 && VDDIO_Q ===1 && VSWITCH !==1 && ENABLE_H ===1 && hld_h_n_buf ===1 && VCCD ===1 && ANALOG_EN===1);
event event_error_vddio_q2;
always @(error_vddio_q2)
begin
    if (!dis_err_msgs)
    begin
        if (error_vddio_q2===1)
        begin
            msg_count_pad10 = msg_count_pad10 + 1;
            ->event_error_vddio_q2;
            if (msg_count_pad10 <= MAX_WARNING_COUNT)
            begin
                $display(" ===ERROR=== sky130_fd_io__top_gpio_ovtv2 : ANALOG_EN(= %b) cannot be 1 when VDDA (= %b) , VDDIO_Q (= %b) , VSWITCH(= %b),ENABLE_H (= %b) , hld_h_n_buf (= %b) && VCCD (= %b) %m",ANALOG_EN, VDDA,VDDIO_Q,VSWITCH,ENABLE_H,hld_h_n_buf,VCCD,$stime);
            end
            else
                if (msg_count_pad10 == MAX_WARNING_COUNT+1)
                begin
                    $display(" ===WARNING=== sky130_fd_io__top_gpio_ovtv2 :  Further WARNING messages will be suppressed as the message count has exceeded 100 %m",$stime);
                end
        end
    end
end
wire #100 error_supply_good = ( VDDA ===1 && VDDIO_Q ===1 && VSWITCH ===1  && ENABLE_H ===1 && hld_h_n_buf ===1 && VCCD ===1 &&  ANALOG_EN===1 && ENABLE_VSWITCH_H !==1 && ENABLE_VSWITCH_H !==0 );
event event_error_supply_good;
always @(error_supply_good)
begin
    if (!dis_err_msgs)
    begin
        if (error_supply_good===1)
        begin
            msg_count_pad11 = msg_count_pad11 + 1;
            ->event_error_supply_good;
            if (msg_count_pad11 <= MAX_WARNING_COUNT)
            begin
                $display(" ===ERROR=== sky130_fd_io__top_gpio_ovtv2 : ENABLE_VSWITCH_H(= %b) should be either 1 or 0 when VDDA (= %b) , VDDIO_Q (= %b) , VSWITCH(= %b), ENABLE_H (= %b), hld_h_n_buf (= %b) ,VCCD (= %b) and ANALOG_EN(= %b)  %m",ENABLE_VSWITCH_H, VDDA,VDDIO_Q,VSWITCH,ENABLE_H,hld_h_n_buf,VCCD,ANALOG_EN,$stime);
            end
            else
                if (msg_count_pad11 == MAX_WARNING_COUNT+1)
                begin
                    $display(" ===WARNING=== sky130_fd_io__top_gpio_ovtv2 :  Further WARNING messages will be suppressed as the message count has exceeded 100 %m",$stime);
                end
        end
    end
end
wire #100 error_vdda_vddioq_vswitch2 = ( VDDA ===1 && VDDIO_Q ===1 && VSWITCH ===1 && ENABLE_H ===1 && hld_h_n_buf ===1 && VCCD ===1 &&  ANALOG_EN===1 && ENABLE_VDDA_H !==1 && ENABLE_VDDA_H !==0 );
event event_error_vdda_vddioq_vswitch2;
always @(error_vdda_vddioq_vswitch2)
begin
    if (!dis_err_msgs)
    begin
        if (error_vdda_vddioq_vswitch2===1)
        begin
            msg_count_pad12 = msg_count_pad12 + 1;
            ->event_error_vdda_vddioq_vswitch2;
            if (msg_count_pad12 <= MAX_WARNING_COUNT)
            begin
                $display(" ===ERROR=== sky130_fd_io__top_gpio_ovtv2 : ENABLE_VDDA_H(= %b) should be either 1 or 0 when VDDA (= %b) , VDDIO_Q (= %b) , VSWITCH(= %b), ENABLE_H (= %b), hld_h_n_buf (= %b) ,VCCD (= %b) and ANALOG_EN(= %b)  %m",ENABLE_VDDA_H, VDDA,VDDIO_Q,VSWITCH,ENABLE_H,hld_h_n_buf,VCCD,ANALOG_EN,$stime);
            end
            else
                if (msg_count_pad12 == MAX_WARNING_COUNT+1)
                begin
                    $display(" ===WARNING=== sky130_fd_io__top_gpio_ovtv2 :  Further WARNING messages will be suppressed as the message count has exceeded 100 %m",$stime);
                end
        end
    end
end
endmodule
`else  // FUNCTIONAL
/*
 * Copyright 2020 The SkyWater PDK Authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 * SPDX-License-Identifier: Apache-2.0
*/

module sky130_fd_io__top_gpio_ovtv2 ( IN, IN_H, TIE_HI_ESD, TIE_LO_ESD, AMUXBUS_A,
                                      AMUXBUS_B, PAD, PAD_A_ESD_0_H, PAD_A_ESD_1_H, PAD_A_NOESD_H,
                                      VCCD, VCCHIB,VDDA, VDDIO, VDDIO_Q, VSSA, VSSD, VSSIO, VSSIO_Q, VSWITCH,
                                      ANALOG_EN, ANALOG_POL, ANALOG_SEL, DM, ENABLE_H, ENABLE_INP_H, ENABLE_VDDA_H, ENABLE_VDDIO, ENABLE_VSWITCH_H, HLD_H_N,
                                      HLD_OVR, IB_MODE_SEL, INP_DIS, OE_N, OUT, SLOW, SLEW_CTL, VTRIP_SEL, HYS_TRIM, VINREF );
input OUT;
input OE_N;
input HLD_H_N;
input ENABLE_H;
input ENABLE_INP_H;
input ENABLE_VDDA_H;
input ENABLE_VDDIO;
input ENABLE_VSWITCH_H;
input INP_DIS;
input VTRIP_SEL;
input HYS_TRIM;
input SLOW;
input [1:0] SLEW_CTL;
input HLD_OVR;
input ANALOG_EN;
input ANALOG_SEL;
input ANALOG_POL;
input [2:0] DM;
input [1:0] IB_MODE_SEL;
input VINREF;
inout VDDIO;
inout VDDIO_Q;
inout VDDA;
inout VCCD;
inout VSWITCH;
inout VCCHIB;
inout VSSA;
inout VSSD;
inout VSSIO_Q;
inout VSSIO;
inout PAD;
inout PAD_A_NOESD_H,PAD_A_ESD_0_H,PAD_A_ESD_1_H;
inout AMUXBUS_A;
inout AMUXBUS_B;
output IN;
output IN_H;
output TIE_HI_ESD, TIE_LO_ESD;
wire hld_h_n_del;
wire hld_h_n_buf;
reg [2:0] dm_final;
reg [1:0] slew_ctl_final;
reg slow_final, vtrip_sel_final, inp_dis_final, out_final, oe_n_final, hld_ovr_final, hys_trim_final, analog_en_final,analog_en_vdda, analog_en_vswitch,analog_en_vddio_q;
reg [1:0] ib_mode_sel_final;
wire [2:0] dm_del;
wire [1:0] slew_ctl_del;
wire [1:0] ib_mode_sel_del;
wire slow_del, vtrip_sel_del, inp_dis_del, out_del, oe_n_del, hld_ovr_del, hys_trim_del;
wire [2:0] dm_buf;
wire [1:0] slew_ctl_buf;
wire [1:0] ib_mode_sel_buf;
wire slow_buf, vtrip_sel_buf, inp_dis_buf, out_buf, oe_n_buf, hld_ovr_buf, hys_trim_buf;
reg notifier_dm, notifier_slow, notifier_oe_n, notifier_out, notifier_vtrip_sel, notifier_hld_ovr, notifier_inp_dis;
reg notifier_slew_ctl, notifier_ib_mode_sel, notifier_hys_trim;
reg notifier_enable_h, notifier, dummy_notifier1;
assign hld_h_n_buf 	= hld_h_n_del;
assign hld_ovr_buf 	= hld_ovr_del;
assign dm_buf 		= dm_del;
assign inp_dis_buf 	= inp_dis_del;
assign vtrip_sel_buf 	= vtrip_sel_del;
assign slow_buf 	= slow_del;
assign oe_n_buf 	= oe_n_del;
assign out_buf 		= out_del;
assign ib_mode_sel_buf 	= ib_mode_sel_del;
assign slew_ctl_buf	= slew_ctl_del;
assign hys_trim_buf 	= hys_trim_del;
specify
    ( INP_DIS => IN) = (0:0:0 , 0:0:0);
    ( INP_DIS => IN_H) = (0:0:0 , 0:0:0);
    if (  IB_MODE_SEL[1]==1'b0 & IB_MODE_SEL[0]==1'b1  ) ( PAD => IN) = (0:0:0 , 0:0:0);
    if (  IB_MODE_SEL[1]==1'b0 & IB_MODE_SEL[0]==1'b1  ) ( PAD => IN_H) = (0:0:0 , 0:0:0);
    if (  OE_N==1'b0 & DM[2]==1'b1 & DM[1]==1'b1 & DM[0]==1'b0 & SLOW==1'b0 ) ( OUT => PAD) = (0:0:0 , 0:0:0);
    if (  OE_N==1'b0 & DM[2]==1'b1 & DM[1]==1'b1 & DM[0]==1'b0 & SLOW==1'b1 ) ( OUT => PAD) = (0:0:0 , 0:0:0);
    if (  OE_N==1'b0 & DM[2]==1'b1 & DM[1]==1'b0 & DM[0]==1'b0 & SLOW==1'b0 ) ( OUT => PAD) = (0:0:0 , 0:0:0, 0:0:0, 0:0:0, 0:0:0, 0:0:0);
    if (  DM[2]==1'b1 & DM[1]==1'b0 & DM[0]==1'b0 & SLOW==1'b1 & SLEW_CTL[1]==1'b0 & SLEW_CTL[0]==1'b0 ) ( OE_N => PAD) = (0:0:0 , 0:0:0, 0:0:0, 0:0:0, 0:0:0, 0:0:0);
    if (  OE_N==1'b0 & DM[2]==1'b1 & DM[1]==1'b1 & DM[0]==1'b1 & SLOW==1'b0 ) ( OUT => PAD ) = (0:0:0 , 0:0:0);
    if (  DM[2]==1'b1 & DM[1]==1'b0 & DM[0]==1'b0 & SLOW==1'b1 & SLEW_CTL[1]==1'b0 & SLEW_CTL[0]==1'b1 ) ( OE_N => PAD) = (0:0:0 , 0:0:0, 0:0:0, 0:0:0, 0:0:0, 0:0:0);
    if (  OE_N==1'b0 & DM[2]==1'b1 & DM[1]==1'b1 & DM[0]==1'b1 & SLOW==1'b1 ) ( OUT => PAD) = (0:0:0 , 0:0:0);
    if (  OE_N==1'b0 & DM[2]==1'b1 & DM[1]==1'b0 & DM[0]==1'b1 & SLOW==1'b0 ) ( OUT => PAD) = (0:0:0 , 0:0:0, 0:0:0, 0:0:0, 0:0:0, 0:0:0);
    if (  DM[2]==1'b1 & DM[1]==1'b1 & DM[0]==1'b0 & SLOW==1'b0 ) ( OE_N => PAD) = (0:0:0 , 0:0:0, 0:0:0, 0:0:0, 0:0:0, 0:0:0);
    if (  OE_N==1'b0 & DM[2]==1'b1 & DM[1]==1'b0 & DM[0]==1'b1 & SLOW==1'b1 ) ( OUT => PAD ) = (0:0:0 , 0:0:0, 0:0:0, 0:0:0, 0:0:0, 0:0:0);
    if (  DM[2]==1'b1 & DM[1]==1'b1 & DM[0]==1'b0 & SLOW==1'b1 ) ( OE_N => PAD) = (0:0:0 , 0:0:0, 0:0:0, 0:0:0, 0:0:0, 0:0:0);
    if (  DM[2]==1'b1 & DM[1]==1'b0 & DM[0]==1'b0 & SLOW==1'b1 & SLEW_CTL[1]==1'b1 & SLEW_CTL[0]==1'b0 ) ( OE_N => PAD) = (0:0:0 , 0:0:0, 0:0:0, 0:0:0, 0:0:0, 0:0:0);
    if (  DM[2]==1'b1 & DM[1]==1'b0 & DM[0]==1'b0 & SLOW==1'b0 ) ( OE_N => PAD) = (0:0:0 , 0:0:0, 0:0:0, 0:0:0, 0:0:0, 0:0:0);
    if (  IB_MODE_SEL[1]==1'b1 & HYS_TRIM==1'b0  ) ( PAD => IN) = (0:0:0 , 0:0:0);
    if (  IB_MODE_SEL[1]==1'b1 & HYS_TRIM==1'b0  ) ( PAD => IN_H) = (0:0:0 , 0:0:0);
    if (  DM[2]==1'b1 & DM[1]==1'b0 & DM[0]==1'b0 & SLOW==1'b1 & SLEW_CTL[1]==1'b1 & SLEW_CTL[0]==1'b1 ) ( OE_N => PAD) = (0:0:0 , 0:0:0, 0:0:0, 0:0:0, 0:0:0, 0:0:0);
    if (  DM[2]==1'b1 & DM[1]==1'b1 & DM[0]==1'b1 & SLOW==1'b0 ) ( OE_N => PAD) = (0:0:0 , 0:0:0, 0:0:0, 0:0:0, 0:0:0, 0:0:0);
    if (  IB_MODE_SEL[1]==1'b1 & HYS_TRIM==1'b1  ) ( PAD => IN) = (0:0:0 , 0:0:0);
    if (  IB_MODE_SEL[1]==1'b1 & HYS_TRIM==1'b1  ) ( PAD => IN_H) = (0:0:0 , 0:0:0);
    if (  DM[2]==1'b1 & DM[1]==1'b1 & DM[0]==1'b1 & SLOW==1'b1 ) ( OE_N => PAD) = (0:0:0 , 0:0:0, 0:0:0, 0:0:0, 0:0:0, 0:0:0);
    if (  OE_N==1'b0 & DM[2]==1'b1 & DM[1]==1'b0 & DM[0]==1'b0 & SLOW==1'b1 & SLEW_CTL[1]==1'b1 & SLEW_CTL[0]==1'b0 ) ( OUT=>  PAD) = (0:0:0 , 0:0:0, 0:0:0, 0:0:0, 0:0:0, 0:0:0);
    if (  DM[2]==1'b1 & DM[1]==1'b0 & DM[0]==1'b1 & SLOW==1'b0 ) ( OE_N => PAD) = (0:0:0 , 0:0:0, 0:0:0, 0:0:0, 0:0:0, 0:0:0);
    if (  OE_N==1'b0 & DM[2]==1'b1 & DM[1]==1'b0 & DM[0]==1'b0 & SLOW==1'b1 & SLEW_CTL[1]==1'b1 & SLEW_CTL[0]==1'b1 ) ( OUT => PAD) = (0:0:0 , 0:0:0, 0:0:0, 0:0:0, 0:0:0, 0:0:0);
    if (  DM[2]==1'b1 & DM[1]==1'b0 & DM[0]==1'b1 & SLOW==1'b1 ) ( OE_N => PAD) = (0:0:0 , 0:0:0, 0:0:0, 0:0:0, 0:0:0, 0:0:0);
    if (  DM[2]==1'b0 & DM[1]==1'b1 & DM[0]==1'b0 & SLOW==1'b0 ) ( OE_N => PAD ) = (0:0:0 , 0:0:0, 0:0:0, 0:0:0, 0:0:0, 0:0:0);
    if (  DM[2]==1'b0 & DM[1]==1'b1 & DM[0]==1'b0 & SLOW==1'b1 ) ( OE_N => PAD) = (0:0:0 , 0:0:0, 0:0:0, 0:0:0, 0:0:0, 0:0:0);
    if (  DM[2]==1'b0 & DM[1]==1'b1 & DM[0]==1'b1 & SLOW==1'b0 ) ( OE_N => PAD) = (0:0:0 , 0:0:0, 0:0:0, 0:0:0, 0:0:0, 0:0:0);
    if (  DM[2]==1'b0 & DM[1]==1'b1 & DM[0]==1'b1 & SLOW==1'b1 ) ( OE_N => PAD) = (0:0:0 , 0:0:0, 0:0:0, 0:0:0, 0:0:0, 0:0:0);
    if (  OE_N==1'b0 & DM[2]==1'b0 & DM[1]==1'b1 & DM[0]==1'b0 & SLOW==1'b0 ) ( OUT => PAD) = (0:0:0 , 0:0:0);
    if (  OE_N==1'b0 & DM[2]==1'b1 & DM[1]==1'b0 & DM[0]==1'b0 & SLOW==1'b1 & SLEW_CTL[1]==1'b0 & SLEW_CTL[0]==1'b0 ) ( OUT => PAD) = (0:0:0 , 0:0:0, 0:0:0, 0:0:0, 0:0:0, 0:0:0);
    if (  OE_N==1'b0 & DM[2]==1'b0 & DM[1]==1'b1 & DM[0]==1'b0 & SLOW==1'b1 ) ( OUT => PAD) = (0:0:0 , 0:0:0);
    if (  OE_N==1'b0 & DM[2]==1'b1 & DM[1]==1'b0 & DM[0]==1'b0 & SLOW==1'b1 & SLEW_CTL[1]==1'b0 & SLEW_CTL[0]==1'b1 ) ( OUT => PAD) = (0:0:0 , 0:0:0, 0:0:0, 0:0:0, 0:0:0, 0:0:0);
    if (  IB_MODE_SEL[1]==1'b0 & IB_MODE_SEL[0]==1'b0 & VTRIP_SEL==1'b0  ) ( PAD => IN) = (0:0:0 , 0:0:0);
    if (  IB_MODE_SEL[1]==1'b0 & IB_MODE_SEL[0]==1'b0 & VTRIP_SEL==1'b0  ) ( PAD => IN_H) = (0:0:0 , 0:0:0);
    if (  OE_N==1'b0 & DM[2]==1'b0 & DM[1]==1'b1 & DM[0]==1'b1 & SLOW==1'b0 ) ( OUT => PAD) = (0:0:0 , 0:0:0);
    if (  IB_MODE_SEL[1]==1'b0 & IB_MODE_SEL[0]==1'b0 & VTRIP_SEL==1'b1  ) ( PAD => IN) = (0:0:0 , 0:0:0);
    if (  IB_MODE_SEL[1]==1'b0 & IB_MODE_SEL[0]==1'b0 & VTRIP_SEL==1'b1  ) ( PAD => IN_H) = (0:0:0 , 0:0:0);
    if (  OE_N==1'b0 & DM[2]==1'b0 & DM[1]==1'b1 & DM[0]==1'b1 & SLOW==1'b1 ) ( OUT => PAD) = (0:0:0 , 0:0:0);
    $width  (negedge HLD_H_N,	      (15.500:0:15.500));
    $width  (posedge HLD_H_N,	      (15.500:0:15.500));
    $width  (negedge HLD_OVR,	      (15.500:0:15.500));
    $width  (posedge HLD_OVR,	      (15.500:0:15.500));
    specparam tsetup = 5;
    specparam tsetup1 = 0;
    specparam thold = 5;
    $setuphold (posedge ENABLE_H,     negedge HLD_H_N,      tsetup, thold,  notifier_enable_h);
    $setuphold (posedge ENABLE_VDDIO, posedge ENABLE_H,     tsetup1, thold,  notifier_enable_h);
    $setuphold (negedge ENABLE_H,     negedge ENABLE_VDDIO, tsetup1, thold,  notifier_enable_h);
    $setuphold (negedge HLD_H_N, posedge HLD_OVR,    tsetup, thold,  notifier_hld_ovr,   ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, hld_ovr_del);
    $setuphold (negedge HLD_H_N, negedge HLD_OVR,    tsetup, thold,  notifier_hld_ovr,   ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, hld_ovr_del);
    $setuphold (negedge HLD_H_N, posedge DM[2],      tsetup, thold,  notifier_dm,	 ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, dm_del[2]);
    $setuphold (negedge HLD_H_N, negedge DM[2],      tsetup, thold,  notifier_dm,	 ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, dm_del[2]);
    $setuphold (negedge HLD_H_N, posedge DM[1],      tsetup, thold,  notifier_dm,	 ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, dm_del[1]);
    $setuphold (negedge HLD_H_N, negedge DM[1],      tsetup, thold,  notifier_dm,	 ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, dm_del[1]);
    $setuphold (negedge HLD_H_N, posedge DM[0],      tsetup, thold,  notifier_dm,	 ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, dm_del[0]);
    $setuphold (negedge HLD_H_N, negedge DM[0],      tsetup, thold,  notifier_dm,	 ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, dm_del[0]);
    $setuphold (negedge HLD_H_N, posedge INP_DIS,    tsetup, thold,  notifier_inp_dis,   ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, inp_dis_del);
    $setuphold (negedge HLD_H_N, negedge INP_DIS,    tsetup, thold,  notifier_inp_dis,   ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, inp_dis_del);
    $setuphold (negedge HLD_H_N, posedge VTRIP_SEL,  tsetup, thold,  notifier_vtrip_sel, ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, vtrip_sel_del);
    $setuphold (negedge HLD_H_N, negedge VTRIP_SEL,  tsetup, thold,  notifier_vtrip_sel, ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, vtrip_sel_del);
    $setuphold (negedge HLD_H_N, posedge HYS_TRIM,   tsetup, thold,  notifier_hys_trim,  ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, hys_trim_del);
    $setuphold (negedge HLD_H_N, negedge HYS_TRIM,   tsetup, thold,  notifier_hys_trim,  ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, hys_trim_del);
    $setuphold (negedge HLD_H_N, posedge SLOW,       tsetup, thold,  notifier_slow,	 ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, slow_del);
    $setuphold (negedge HLD_H_N, negedge SLOW,       tsetup, thold,  notifier_slow,	 ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, slow_del);
    $setuphold (negedge HLD_H_N, posedge OE_N,       tsetup, thold,  notifier_oe_n,	 ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, oe_n_del);
    $setuphold (negedge HLD_H_N, negedge OE_N,       tsetup, thold,  notifier_oe_n,	 ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, oe_n_del);
    $setuphold (negedge HLD_H_N, posedge OUT,        tsetup, thold,  notifier_out,	 ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, out_del);
    $setuphold (negedge HLD_H_N, negedge OUT,        tsetup, thold,  notifier_out,	 ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, out_del);
    $setuphold (negedge HLD_H_N, posedge SLEW_CTL[1],   tsetup, thold,  notifier_slew_ctl,  	ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, slew_ctl_del[1]);
    $setuphold (negedge HLD_H_N, negedge SLEW_CTL[1],   tsetup, thold,  notifier_slew_ctl,  	ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, slew_ctl_del[1]);
    $setuphold (negedge HLD_H_N, posedge SLEW_CTL[0],   tsetup, thold,  notifier_slew_ctl,  	ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, slew_ctl_del[0]);
    $setuphold (negedge HLD_H_N, negedge SLEW_CTL[0],   tsetup, thold,  notifier_slew_ctl,  	ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, slew_ctl_del[0]);
    $setuphold (negedge HLD_H_N, posedge IB_MODE_SEL[1], tsetup, thold,  notifier_ib_mode_sel,  ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, ib_mode_sel_del[1]);
    $setuphold (negedge HLD_H_N, negedge IB_MODE_SEL[1], tsetup, thold,  notifier_ib_mode_sel,  ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, ib_mode_sel_del[1]);
    $setuphold (negedge HLD_H_N, posedge IB_MODE_SEL[0], tsetup, thold,  notifier_ib_mode_sel,  ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, ib_mode_sel_del[0]);
    $setuphold (negedge HLD_H_N, negedge IB_MODE_SEL[0], tsetup, thold,  notifier_ib_mode_sel,  ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, ib_mode_sel_del[0]);
    $setuphold (posedge HLD_H_N, posedge HLD_OVR,    tsetup, thold,  notifier_hld_ovr,   ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, hld_ovr_del);
    $setuphold (posedge HLD_H_N, negedge HLD_OVR,    tsetup, thold,  notifier_hld_ovr,   ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, hld_ovr_del);
    $setuphold (posedge HLD_H_N, posedge DM[2],      tsetup, thold,  notifier_dm,	 ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, dm_del[2]);
    $setuphold (posedge HLD_H_N, negedge DM[2],      tsetup, thold,  notifier_dm,	 ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, dm_del[2]);
    $setuphold (posedge HLD_H_N, posedge DM[1],      tsetup, thold,  notifier_dm,	 ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, dm_del[1]);
    $setuphold (posedge HLD_H_N, negedge DM[1],      tsetup, thold,  notifier_dm,	 ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, dm_del[1]);
    $setuphold (posedge HLD_H_N, posedge DM[0],      tsetup, thold,  notifier_dm,	 ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, dm_del[0]);
    $setuphold (posedge HLD_H_N, negedge DM[0],      tsetup, thold,  notifier_dm,	 ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, dm_del[0]);
    $setuphold (posedge HLD_H_N, posedge INP_DIS,    tsetup, thold,  notifier_inp_dis,   ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, inp_dis_del);
    $setuphold (posedge HLD_H_N, negedge INP_DIS,    tsetup, thold,  notifier_inp_dis,   ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, inp_dis_del);
    $setuphold (posedge HLD_H_N, posedge VTRIP_SEL,  tsetup, thold,  notifier_vtrip_sel, ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, vtrip_sel_del);
    $setuphold (posedge HLD_H_N, negedge VTRIP_SEL,  tsetup, thold,  notifier_vtrip_sel, ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, vtrip_sel_del);
    $setuphold (posedge HLD_H_N, posedge HYS_TRIM,   tsetup, thold,  notifier_hys_trim,  ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, hys_trim_del);
    $setuphold (posedge HLD_H_N, negedge HYS_TRIM,   tsetup, thold,  notifier_hys_trim,  ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, hys_trim_del);
    $setuphold (posedge HLD_H_N, posedge SLOW,       tsetup, thold,  notifier_slow,	 ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, slow_del);
    $setuphold (posedge HLD_H_N, negedge SLOW,       tsetup, thold,  notifier_slow,	 ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, slow_del);
    $setuphold (posedge HLD_H_N, posedge OE_N,       tsetup, thold,  notifier_oe_n,	 ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, oe_n_del);
    $setuphold (posedge HLD_H_N, negedge OE_N,       tsetup, thold,  notifier_oe_n,	 ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, oe_n_del);
    $setuphold (posedge HLD_H_N, posedge OUT,        tsetup, thold,  notifier_out,	 ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, out_del);
    $setuphold (posedge HLD_H_N, negedge OUT,        tsetup, thold,  notifier_out,	 ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, out_del);
    $setuphold (posedge HLD_H_N, posedge SLEW_CTL[1],   tsetup, thold,  notifier_slew_ctl,  	ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, slew_ctl_del[1]);
    $setuphold (posedge HLD_H_N, negedge SLEW_CTL[1],   tsetup, thold,  notifier_slew_ctl,  	ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, slew_ctl_del[1]);
    $setuphold (posedge HLD_H_N, posedge SLEW_CTL[0],   tsetup, thold,  notifier_slew_ctl,  	ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, slew_ctl_del[0]);
    $setuphold (posedge HLD_H_N, negedge SLEW_CTL[0],   tsetup, thold,  notifier_slew_ctl,  	ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, slew_ctl_del[0]);
    $setuphold (posedge HLD_H_N, posedge IB_MODE_SEL[1], tsetup, thold,  notifier_ib_mode_sel,  ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, ib_mode_sel_del[1]);
    $setuphold (posedge HLD_H_N, negedge IB_MODE_SEL[1], tsetup, thold,  notifier_ib_mode_sel,  ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, ib_mode_sel_del[1]);
    $setuphold (posedge HLD_H_N, posedge IB_MODE_SEL[0], tsetup, thold,  notifier_ib_mode_sel,  ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, ib_mode_sel_del[0]);
    $setuphold (posedge HLD_H_N, negedge IB_MODE_SEL[0], tsetup, thold,  notifier_ib_mode_sel,  ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, ib_mode_sel_del[0]);
    $setuphold (posedge HLD_OVR,    	negedge HLD_H_N, tsetup, thold,  notifier_hld_ovr,	ENABLE_H==1'b1, ENABLE_H==1'b1, hld_ovr_del, hld_h_n_del);
    $setuphold (posedge DM[2],      	negedge HLD_H_N, tsetup, thold,  notifier_dm,		ENABLE_H==1'b1, ENABLE_H==1'b1, dm_del[2], hld_h_n_del);
    $setuphold (posedge DM[1],      	negedge HLD_H_N, tsetup, thold,  notifier_dm,		ENABLE_H==1'b1, ENABLE_H==1'b1, dm_del[1], hld_h_n_del);
    $setuphold (posedge DM[0],      	negedge HLD_H_N, tsetup, thold,  notifier_dm,		ENABLE_H==1'b1, ENABLE_H==1'b1, dm_del[0], hld_h_n_del);
    $setuphold (posedge INP_DIS,    	negedge HLD_H_N, tsetup, thold,  notifier_inp_dis,	ENABLE_H==1'b1, ENABLE_H==1'b1, inp_dis_del, hld_h_n_del);
    $setuphold (posedge VTRIP_SEL,  	negedge HLD_H_N, tsetup, thold,  notifier_vtrip_sel, 	ENABLE_H==1'b1, ENABLE_H==1'b1, vtrip_sel_del, hld_h_n_del);
    $setuphold (posedge HYS_TRIM,   	negedge HLD_H_N, tsetup, thold,  notifier_hys_trim,  	ENABLE_H==1'b1, ENABLE_H==1'b1, hys_trim_del, hld_h_n_del);
    $setuphold (posedge SLOW,	    	negedge HLD_H_N, tsetup, thold,  notifier_slow,		ENABLE_H==1'b1, ENABLE_H==1'b1, slow_del, hld_h_n_del);
    $setuphold (posedge OE_N,	    	negedge HLD_H_N, tsetup, thold,  notifier_oe_n,		ENABLE_H==1'b1, ENABLE_H==1'b1, oe_n_del, hld_h_n_del);
    $setuphold (posedge OUT,	    	negedge HLD_H_N, tsetup, thold,  notifier_out,		ENABLE_H==1'b1, ENABLE_H==1'b1, out_del, hld_h_n_del);
    $setuphold (posedge SLEW_CTL[1],   	negedge HLD_H_N, tsetup, thold,  notifier_slew_ctl,     ENABLE_H==1'b1, ENABLE_H==1'b1, slew_ctl_del[1], hld_h_n_del);
    $setuphold (posedge SLEW_CTL[0],   	negedge HLD_H_N, tsetup, thold,  notifier_slew_ctl,     ENABLE_H==1'b1, ENABLE_H==1'b1, slew_ctl_del[0], hld_h_n_del);
    $setuphold (posedge IB_MODE_SEL[1], negedge HLD_H_N, tsetup, thold,  notifier_ib_mode_sel,  ENABLE_H==1'b1, ENABLE_H==1'b1, ib_mode_sel_del[1], hld_h_n_del);
    $setuphold (posedge IB_MODE_SEL[0], negedge HLD_H_N, tsetup, thold,  notifier_ib_mode_sel,  ENABLE_H==1'b1, ENABLE_H==1'b1, ib_mode_sel_del[0], hld_h_n_del);
endspecify
wire  pwr_good_amux	         = ((hld_h_n_buf===0 || ENABLE_H===0) ? 1:(VCCD===1))  && (VSSD===0) && (VSSA===0) && (VSSIO_Q===0);
wire  pwr_good_output_driver     = (VDDIO===1)   && (VDDIO_Q===1)&& (VSSIO===0)   && (VSSD===0)  && (VSSA===0) ;
wire  pwr_good_hold_ovr_mode     = (VDDIO_Q===1) && (VDDIO===1)  && (VSSD===0)    && (VCCHIB===1);
wire  pwr_good_active_mode       = (VDDIO_Q===1) && (VDDIO===1)  && (VSSD===0)    && (VCCD===1);
wire  pwr_good_hold_mode         = (VDDIO_Q===1) && (VDDIO===1)  && (VSSD===0);
wire  pwr_good_active_mode_vdda  = (VDDA===1)  && (VSSD===0)   && (VCCD===1);
wire  pwr_good_hold_mode_vdda    = (VDDA===1)    && (VSSD===0);
wire  pwr_good_inpbuff_hv        = (VDDIO_Q===1) && (inp_dis_final===0 && dm_final!==3'b000 && ib_mode_sel_final===2'b01 ? VCCHIB===1 : 1) && (VSSD===0);
wire  pwr_good_inpbuff_lv        = (VDDIO_Q===1) && (VSSD===0)   && (VCCHIB===1);
wire  pwr_good_analog_en_vdda    = (VDDA===1)  && (VSSD===0) && (VSSA===0) ;
wire  pwr_good_analog_en_vddio_q = (VDDIO_Q ===1)  && (VSSD===0) && (VSSA===0) ;
wire  pwr_good_analog_en_vswitch = (VSWITCH ===1)  && (VSSD===0) && (VSSA===0) ;
wire  pwr_good_amux_vccd   	 = ((hld_h_n_buf===0 || ENABLE_H===0) ? 1:(VCCD===1));
parameter MAX_WARNING_COUNT = 100;
wire pad_tristate = oe_n_final === 1 || dm_final === 3'b000 || dm_final === 3'b001;
wire x_on_pad  =  !pwr_good_output_driver
     || (dm_final !== 3'b000 	&& dm_final !== 3'b001 		&& oe_n_final===1'bx)
     || (^dm_final[2:0] === 1'bx 	&& oe_n_final===1'b0)
     || (slow_final===1'bx 	&& dm_final !== 3'b000		&& dm_final !== 3'b001 && oe_n_final===1'b0)
     || (slow_final===1'b1 	&& ^slew_ctl_final[1:0] ===1'bx 	&& dm_final === 3'b100 && oe_n_final===1'b0);
`ifdef SKY130_FD_IO_TOP_GPIO_OVTV2_SLOW_BEHV
parameter SLOW_1_DELAY= 70 ;
parameter SLOW_0_DELAY= 40;
`else
parameter SLOW_1_DELAY= 0;
parameter SLOW_0_DELAY= 0;
`endif
`ifdef SKY130_FD_IO_TOP_GPIO_OVTV2_SLEW_BEHV
parameter SLEW_00_DELAY= 127 ;
parameter SLEW_01_DELAY= 109;
parameter SLEW_10_DELAY= 193;
parameter SLEW_11_DELAY= 136;
`else
parameter SLEW_00_DELAY= 0 ;
parameter SLEW_01_DELAY= 0;
parameter SLEW_10_DELAY= 0;
parameter SLEW_11_DELAY= 0;
`endif
integer slow_1_delay,slow_0_delay,slow_delay,slew_00_delay,slew_01_delay,slew_10_delay,slew_11_delay;
initial slow_1_delay = SLOW_1_DELAY;
initial slow_0_delay = SLOW_0_DELAY;
initial slew_00_delay = SLEW_00_DELAY;
initial slew_01_delay = SLEW_01_DELAY;
initial slew_10_delay = SLEW_10_DELAY;
initial slew_11_delay = SLEW_11_DELAY;
always @(*)
begin
    if (SLOW===1)
    begin
        if (DM[2]===1 && DM[1]===0 && DM[0]===0)
        begin
`ifdef SKY130_FD_IO_TOP_GPIO_OVTV2_SLEW_BEHV
            if (SLEW_CTL[1] ===0 && SLEW_CTL[0] ===0)
                slow_delay = 	slew_00_delay;
            else if (SLEW_CTL[1] ===0 && SLEW_CTL[0] ===1)
                slow_delay = 	slew_01_delay;
            else if (SLEW_CTL[1] ===1 && SLEW_CTL[0] ===0)
                slow_delay = 	slew_10_delay;
            else if (SLEW_CTL[1] ===1 && SLEW_CTL[0] ===1)
                slow_delay = 	slew_11_delay;
`else
            slow_delay = slow_1_delay;
`endif
        end
        else
            slow_delay = slow_1_delay;
    end
    else
        slow_delay = slow_0_delay;
end
bufif1 (pull1, strong0) #slow_delay dm2 (PAD, out_final, x_on_pad===1 ? 1'bx : (pad_tristate===0 && dm_final===3'b010));
bufif1 (strong1, pull0) #slow_delay dm3 (PAD, out_final, x_on_pad===1 ? 1'bx : (pad_tristate===0 && dm_final===3'b011));
bufif1 (highz1, strong0) #slow_delay dm4 (PAD, out_final, x_on_pad===1 ? 1'bx : (pad_tristate===0 && dm_final===3'b100));
bufif1 (strong1, highz0) #slow_delay dm5 (PAD, out_final, x_on_pad===1 ? 1'bx : (pad_tristate===0 && dm_final===3'b101));
bufif1 (strong1, strong0) #slow_delay dm6 (PAD, out_final, x_on_pad===1 ? 1'bx : (pad_tristate===0 && dm_final===3'b110));
bufif1 (pull1, pull0)  #slow_delay dm7 (PAD, out_final, x_on_pad===1 ? 1'bx : (pad_tristate===0 && dm_final===3'b111));
tran pad_esd_1 (PAD,PAD_A_NOESD_H);
tran pad_esd_2 (PAD,PAD_A_ESD_0_H);
tran pad_esd_3 (PAD,PAD_A_ESD_1_H);
wire x_on_in_hv  =  (ENABLE_H===0  && ^ENABLE_INP_H===1'bx)
     || (inp_dis_final===1'bx  && ^dm_final[2:0]!==1'bx && dm_final !== 3'b000)
     || (^ENABLE_H===1'bx)
     || (inp_dis_final===0 	       		&& ^dm_final[2:0] === 1'bx)
     || (^ib_mode_sel_final===1'bx  	&& inp_dis_final===0  		&& dm_final !== 3'b000)
     || (vtrip_sel_final===1'bx    		&& inp_dis_final===0        	&& dm_final !== 3'b000		&& ib_mode_sel_final===2'b00)
     || (^ENABLE_VDDIO===1'bx    		&& inp_dis_final===0        	&& dm_final !== 3'b000		&& ib_mode_sel_final===2'b01)
     || (ib_mode_sel_final[1]===1'b1	&& VINREF !== 1'b1    		&& inp_dis_final===0      	&& dm_final !== 3'b000)
     || (ib_mode_sel_final[1]===1'b1	&& hys_trim_final===1'bx	&& inp_dis_final===0      	&& dm_final !== 3'b000);
wire x_on_in_lv  =  (ENABLE_H===0  && ^ENABLE_VDDIO===1'bx)
     || (ENABLE_H===0  && ^ENABLE_INP_H===1'bx)
     || (inp_dis_final===1'bx  && ^dm_final[2:0]!==1'bx && dm_final !== 3'b000)
     || (^ENABLE_H===1'bx)
     || (inp_dis_final===0 	       		&& ^dm_final[2:0] === 1'bx)
     || (^ib_mode_sel_final===1'bx  	&& inp_dis_final===0  		&& dm_final !== 3'b000)
     || (vtrip_sel_final===1'bx    		&& inp_dis_final===0        	&& dm_final !== 3'b000		&& ib_mode_sel_final===2'b00)
     || (^ENABLE_VDDIO===1'bx    		&& inp_dis_final===0        	&& dm_final !== 3'b000	)
     || (ib_mode_sel_final[1]===1'b1	&& VINREF !== 1'b1    		&& inp_dis_final===0      	&& dm_final !== 3'b000)
     || (ib_mode_sel_final[1]===1'b1	&& hys_trim_final===1'bx	&& inp_dis_final===0      	&& dm_final !== 3'b000);
wire disable_inp_buff = ENABLE_H===1 ? (dm_final===3'b000 || inp_dis_final===1) : ENABLE_INP_H===0;
assign IN_H = (x_on_in_hv===1 || pwr_good_inpbuff_hv===0) ? 1'bx : (disable_inp_buff===1 ? 0 : (^PAD===1'bx ? 1'bx : PAD));
wire disable_inp_buff_lv = ENABLE_H===1 ? (dm_final===3'b000 || inp_dis_final===1) : ENABLE_VDDIO===0;
assign IN   = (x_on_in_lv ===1 || pwr_good_inpbuff_lv===0) ? 1'bx : (disable_inp_buff_lv===1 ? 0 : (^PAD===1'bx ? 1'bx : PAD));
assign TIE_HI_ESD = VDDIO===1'b1 ? 1'b1 : 1'bx;
assign TIE_LO_ESD = VSSIO===1'b0 ? 1'b0 : 1'bx;
wire timing_mode_amux = (pwr_good_analog_en_vdda ===1 && pwr_good_analog_en_vddio_q ===1 && pwr_good_analog_en_vswitch ===1 );
wire x_on_analog_en_vdda = (pwr_good_analog_en_vdda !==1
                            || (timing_mode_amux ==1 && (ENABLE_H !==0 && ^hld_h_n_buf === 1'bx) || (hld_h_n_buf!== 0 && ^ENABLE_H=== 1'bx) || pwr_good_amux_vccd !==1 )
                            || (timing_mode_amux ==1 && (hld_h_n_buf ===1 && ENABLE_H===1 && ^ANALOG_EN === 1'bx && ENABLE_VDDA_H ===1 && ENABLE_VSWITCH_H===1 ) || (hld_h_n_buf ===1 && ENABLE_H===1 && ANALOG_EN ===0 && ^ENABLE_VDDA_H ===1'bx) ));
wire zero_on_analog_en_vdda = ( (pwr_good_analog_en_vdda ===1 && ENABLE_VDDA_H ===0)
                                || (pwr_good_analog_en_vdda ===1 && pwr_good_analog_en_vddio_q ===1 && hld_h_n_buf===0)
                                || (pwr_good_analog_en_vdda ===1 && pwr_good_analog_en_vddio_q ===1 && ENABLE_H===0)
                                ||  (pwr_good_analog_en_vdda ===1 && pwr_good_analog_en_vddio_q ===1 && pwr_good_amux_vccd && ANALOG_EN===0) );
wire x_on_analog_en_vddio_q =  ( pwr_good_analog_en_vddio_q !==1
                                 || (timing_mode_amux ==1 && (ENABLE_H !==0 && ^hld_h_n_buf === 1'bx) || (hld_h_n_buf!== 0 && ^ENABLE_H=== 1'bx) || pwr_good_amux_vccd !==1 )
                                 || (timing_mode_amux ==1 && (hld_h_n_buf ===1 && ENABLE_H===1 && ^ANALOG_EN === 1'bx && ENABLE_VDDA_H ===1 && ENABLE_VSWITCH_H===1 ) ));
wire zero_on_analog_en_vddio_q =  ( (pwr_good_analog_en_vddio_q ===1 && hld_h_n_buf===0)
                                    || (pwr_good_analog_en_vddio_q ===1 && ENABLE_H===0)
                                    ||  (pwr_good_analog_en_vddio_q ===1 && pwr_good_amux_vccd && ANALOG_EN===0) );
wire x_on_analog_en_vswitch = (pwr_good_analog_en_vswitch !==1
                               || (timing_mode_amux ==1 && (ENABLE_H !==0 && ^hld_h_n_buf === 1'bx) || (hld_h_n_buf!== 0 && ^ENABLE_H=== 1'bx) || pwr_good_amux_vccd !==1 )
                               || (timing_mode_amux ==1 && (hld_h_n_buf ===1 && ENABLE_H===1 && ^ANALOG_EN === 1'bx && ENABLE_VDDA_H ===1 && ENABLE_VSWITCH_H===1 ) || (hld_h_n_buf ===1 && ENABLE_H===1 && ANALOG_EN ===0 && ^ENABLE_VSWITCH_H ===1'bx) ));
wire  zero_on_analog_en_vswitch =   ( (pwr_good_analog_en_vswitch ===1 && ENABLE_VSWITCH_H ===0)
                                      || (pwr_good_analog_en_vswitch ===1 && pwr_good_analog_en_vddio_q ===1 && hld_h_n_buf===0)
                                      || (pwr_good_analog_en_vswitch ===1 && pwr_good_analog_en_vddio_q ===1 && ENABLE_H===0)
                                      ||  (pwr_good_analog_en_vswitch ===1 && pwr_good_analog_en_vddio_q ===1 && pwr_good_amux_vccd && ANALOG_EN===0) );
always @(*)
begin : LATCH_dm
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode || (ENABLE_H===1 && ^hld_h_n_buf===1'bx))
    begin
        dm_final 	<= 3'bxxx;
    end
    else if (ENABLE_H===0)
    begin
        dm_final 	<= 3'b000;
    end
    else if (hld_h_n_buf===1)
    begin
        dm_final 	<= (^dm_buf[2:0]	=== 1'bx	|| !pwr_good_active_mode) ? 3'bxxx : dm_buf;
    end
end
always @(notifier_enable_h or notifier_dm)
begin
    disable LATCH_dm; dm_final <= 3'bxxx;
end
always @(*)
begin : LATCH_inp_dis
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode || (ENABLE_H===1 && ^hld_h_n_buf===1'bx))
    begin
        inp_dis_final 	<= 1'bx;
    end
    else if (ENABLE_H===0)
    begin
        inp_dis_final 	<= 1'b1;
    end
    else if (hld_h_n_buf===1)
    begin
        inp_dis_final 	<= (^inp_dis_buf === 1'bx	|| !pwr_good_active_mode) ? 1'bx : inp_dis_buf;
    end
end
always @(notifier_enable_h or notifier_inp_dis)
begin
    disable LATCH_inp_dis; inp_dis_final <= 1'bx;
end
always @(*)
begin : LATCH_ib_mode_sel
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode || (ENABLE_H===1 && ^hld_h_n_buf===1'bx))
    begin
        ib_mode_sel_final 	<= 2'bxx;
    end
    else if (ENABLE_H===0)
    begin
        ib_mode_sel_final 	<= 2'b00;
    end
    else if (hld_h_n_buf===1)
    begin
        ib_mode_sel_final 	<= (^ib_mode_sel_buf[1:0]	=== 1'bx	|| !pwr_good_active_mode) ? 2'bxx : ib_mode_sel_buf;
    end
end
always @(notifier_enable_h or notifier_ib_mode_sel)
begin
    disable LATCH_ib_mode_sel; ib_mode_sel_final <= 2'bxx;
end
always @(*)
begin : LATCH_slew_ctl_final
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode || (ENABLE_H===1 && ^hld_h_n_buf===1'bx))
    begin
        slew_ctl_final 	<= 2'bxx;
    end
    else if (ENABLE_H===0)
    begin
        slew_ctl_final 	<= 2'b00;
    end
    else if (hld_h_n_buf===1)
    begin
        slew_ctl_final 	<= (^slew_ctl_buf[1:0] === 1'bx || !pwr_good_active_mode) ? 2'bxx : slew_ctl_buf;
    end
end
always @(notifier_enable_h or notifier_slew_ctl)
begin
    disable LATCH_slew_ctl_final; slew_ctl_final <= 2'bxx;
end
always @(*)
begin : LATCH_vtrip_sel
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode || (ENABLE_H===1 && ^hld_h_n_buf===1'bx))
    begin
        vtrip_sel_final 	<= 1'bx;
    end
    else if (ENABLE_H===0)
    begin
        vtrip_sel_final 	<= 1'b0;
    end
    else if (hld_h_n_buf===1)
    begin
        vtrip_sel_final 	<= (^vtrip_sel_buf === 1'bx	|| !pwr_good_active_mode) ? 1'bx : vtrip_sel_buf;
    end
end
always @(notifier_enable_h or notifier_vtrip_sel)
begin
    disable LATCH_vtrip_sel; vtrip_sel_final <= 1'bx;
end
always @(*)
begin : LATCH_hys_trim
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode || (ENABLE_H===1 && ^hld_h_n_buf===1'bx))
    begin
        hys_trim_final 	<= 1'bx;
    end
    else if (ENABLE_H===0)
    begin
        hys_trim_final 	<= 1'b0;
    end
    else if (hld_h_n_buf===1)
    begin
        hys_trim_final 	<= (^hys_trim_buf === 1'bx	|| !pwr_good_active_mode) ? 1'bx : hys_trim_buf;
    end
end
always @(notifier_enable_h or notifier_hys_trim)
begin
    disable LATCH_hys_trim; hys_trim_final <= 1'bx;
end
always @(*)
begin : LATCH_slow
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode || (ENABLE_H===1 && ^hld_h_n_buf===1'bx))
    begin
        slow_final 	<= 1'bx;
    end
    else if (ENABLE_H===0)
    begin
        slow_final 	<= 1'b0;
    end
    else if (hld_h_n_buf===1)
    begin
        slow_final 	<= (^slow_buf === 1'bx	|| !pwr_good_active_mode) ? 1'bx : slow_buf;
    end
end
always @(notifier_enable_h or notifier_slow)
begin
    disable LATCH_slow; slow_final <= 1'bx;
end
always @(*)
begin : LATCH_hld_ovr
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode || (ENABLE_H===1 && ^hld_h_n_buf===1'bx))
    begin
        hld_ovr_final 	<= 1'bx;
    end
    else if (ENABLE_H===0)
    begin
        hld_ovr_final 	<= 1'b0;
    end
    else if (hld_h_n_buf===1)
    begin
        hld_ovr_final 	<= (^hld_ovr_buf === 1'bx	|| !pwr_good_active_mode) ? 1'bx : hld_ovr_buf;
    end
end
always @(notifier_enable_h or notifier_hld_ovr)
begin
    disable LATCH_hld_ovr; hld_ovr_final <= 1'bx;
end
always @(*)
begin : LATCH_oe_n
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode || (ENABLE_H===1 && (^hld_h_n_buf===1'bx || (hld_h_n_buf===0 && hld_ovr_final===1'bx)|| (hld_h_n_buf===1 && hld_ovr_final===1'bx))))
    begin
        oe_n_final 	<= 1'bx;
    end
    else if (ENABLE_H===0)
    begin
        oe_n_final 	<= 1'b1;
    end
    else if (hld_h_n_buf===1 || hld_ovr_final===1)
    begin
        oe_n_final  	<= (^oe_n_buf  === 1'bx  || !pwr_good_hold_ovr_mode) ? 1'bx   : oe_n_buf;
    end
end
always @(notifier_enable_h or notifier_oe_n)
begin
    disable LATCH_oe_n; oe_n_final <= 1'bx;
end
always @(*)
begin : LATCH_out
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode || (ENABLE_H===1 && (^hld_h_n_buf===1'bx ||(hld_h_n_buf===0 &&  hld_ovr_final===1'bx)||(hld_h_n_buf===1 &&  hld_ovr_final===1'bx))))
    begin
        out_final 	<= 1'bx;
    end
    else if (ENABLE_H===0)
    begin
        out_final 	<= 1'b1;
    end
    else if (hld_h_n_buf===1 || hld_ovr_final===1)
    begin
        out_final  	<= (^out_buf  === 1'bx  || !pwr_good_hold_ovr_mode) ? 1'bx   : out_buf;
    end
end
always @(notifier_enable_h or notifier_out)
begin
    disable LATCH_out; out_final <= 1'bx;
end
always @(*)
begin
    if (x_on_analog_en_vdda ===1 )
    begin
        analog_en_vdda <= 1'bx;
    end
    else if ( zero_on_analog_en_vdda ===1 )
    begin
        analog_en_vdda <= 1'b0;
    end
    else if (x_on_analog_en_vdda !==1 && zero_on_analog_en_vdda !==1)
    begin
        analog_en_vdda <= ANALOG_EN;
    end
    if (x_on_analog_en_vddio_q  ===1 )
    begin
        analog_en_vddio_q  <= 1'bx;
    end
    else if ( zero_on_analog_en_vddio_q ===1 )
    begin
        analog_en_vddio_q  <= 1'b0;
    end
    else if ( x_on_analog_en_vddio_q !==1 && zero_on_analog_en_vddio_q !==1)
    begin
        analog_en_vddio_q  <= ANALOG_EN;
    end
    if (x_on_analog_en_vswitch  ===1 )
    begin
        analog_en_vswitch  <= 1'bx;
    end
    else if ( zero_on_analog_en_vswitch ===1 )
    begin
        analog_en_vswitch  <= 1'b0;
    end
    else if (x_on_analog_en_vswitch !==1 && zero_on_analog_en_vswitch !==1)
    begin
        analog_en_vswitch  <= ANALOG_EN;
    end
    if ( (analog_en_vswitch ===1'bx && analog_en_vdda ===1'bx) || (analog_en_vswitch ===1'bx && analog_en_vddio_q ===1'bx) || (analog_en_vddio_q ===1'bx && analog_en_vdda ===1'bx ) )
    begin
        analog_en_final  <= 1'bx;
    end
    else if (analog_en_vdda ===1'bx && (analog_en_vddio_q ===1 ||analog_en_vswitch===1 ))
    begin
        analog_en_final  <= 1'bx;
    end
    else if (analog_en_vddio_q ===1'bx && (analog_en_vdda ===1 ||analog_en_vswitch===1 ))
    begin
        analog_en_final  <= 1'bx;
    end
    else if (analog_en_vswitch===1'bx && (analog_en_vdda ===1 || analog_en_vddio_q ===1 ))
    begin
        analog_en_final  <= 1'bx;
    end
    else if ((analog_en_vdda ===0 && analog_en_vddio_q ===0 )|| (analog_en_vdda ===0 && analog_en_vswitch===0 ) ||  (analog_en_vddio_q ===0 && analog_en_vswitch===0 ))
    begin
        analog_en_final  <=0;
    end
    else if (analog_en_vdda ===1 && analog_en_vddio_q ===1 &&  analog_en_vswitch ===1)
    begin
        analog_en_final  <=1;
    end
end
wire [2:0] amux_select = {ANALOG_SEL, ANALOG_POL, out_buf};
wire invalid_controls_amux = 	(analog_en_final===1'bx && inp_dis_final===1)
     || !pwr_good_amux
     || (analog_en_final===1 && ^amux_select[2:0] === 1'bx && inp_dis_final===1);
wire enable_pad_amuxbus_a = invalid_controls_amux  ? 1'bx : (amux_select===3'b001 || amux_select===3'b010) && (analog_en_final===1);
wire enable_pad_amuxbus_b = invalid_controls_amux  ? 1'bx : (amux_select===3'b101 || amux_select===3'b110) && (analog_en_final===1);
wire enable_pad_vssio_q   = invalid_controls_amux  ? 1'bx : (amux_select===3'b100 || amux_select===3'b000) && (analog_en_final===1);
wire enable_pad_vddio_q   = invalid_controls_amux  ? 1'bx : (amux_select===3'b011 || amux_select===3'b111) && (analog_en_final===1);
tranif1 pad_amuxbus_a 	(PAD, AMUXBUS_A, enable_pad_amuxbus_a);
tranif1 pad_amuxbus_b 	(PAD, AMUXBUS_B, enable_pad_amuxbus_b);
bufif1 pad_vddio_q	(PAD, VDDIO_Q,   enable_pad_vddio_q);
bufif1 pad_vssio_q   	(PAD, VSSIO_Q,   enable_pad_vssio_q);
reg dis_err_msgs;
integer msg_count_pad,msg_count_pad1,msg_count_pad2,msg_count_pad3,msg_count_pad4,msg_count_pad5,msg_count_pad6,msg_count_pad7,msg_count_pad8,msg_count_pad9,msg_count_pad10,msg_count_pad11,msg_count_pad12;
initial
begin
    dis_err_msgs = 1'b1;
    msg_count_pad  = 0;
    msg_count_pad1 = 0;
    msg_count_pad2 = 0;
    msg_count_pad3 = 0;
    msg_count_pad4 = 0;
    msg_count_pad5 = 0;
    msg_count_pad6 = 0;
    msg_count_pad7 = 0;
    msg_count_pad8 = 0;
    msg_count_pad9 = 0;
    msg_count_pad10 = 0;
    msg_count_pad11 = 0;
    msg_count_pad12  = 0;
`ifdef SKY130_FD_IO_TOP_GPIO_OVTV2_DIS_ERR_MSGS
`else
    #1;
    dis_err_msgs = 1'b0;
`endif
end
wire #100 error_enable_vddio = (ENABLE_VDDIO===0 && ENABLE_H===1);
event event_error_enable_vddio;
always @(error_enable_vddio)
begin
    if (!dis_err_msgs)
    begin
        if (error_enable_vddio===1)
        begin
            msg_count_pad = msg_count_pad + 1;
            ->event_error_enable_vddio;
            if (msg_count_pad <= MAX_WARNING_COUNT)
            begin
                $display(" ===ERROR=== sky130_fd_io__top_gpio_ovtv2 :  Enable_h (= %b) and ENABLE_VDDIO (= %b) are complement of each other. This is an illegal combination as ENABLE_VDDIO and ENABLE_H are the same input signals IN different power domains %m", ENABLE_H, ENABLE_VDDIO, $stime);
            end
            else
                if (msg_count_pad == MAX_WARNING_COUNT+1)
                begin
                    $display(" ===WARNING=== sky130_fd_io__top_gpio_ovtv2 :  Further WARNING messages will be suppressed as the message count has exceeded 100 %m",$stime);
                end
        end
    end
end
wire #100 error_vdda = ( VDDA===1 && VDDIO_Q !==1 && ENABLE_VDDA_H===1 );
event event_error_vdda;
always @(error_vdda)
begin
    if (!dis_err_msgs)
    begin
        if (error_vdda===1)
        begin
            msg_count_pad1 = msg_count_pad1 + 1;
            ->event_error_vdda;
            if (msg_count_pad1 <= MAX_WARNING_COUNT)
            begin
                $display(" ===ERROR=== sky130_fd_io__top_gpio_ovtv2 : ENABLE_VDDA_H (= %b) cannot be 1 when VDDA (= %b) and VDDIO_Q (= %b) %m",ENABLE_VDDA_H, VDDA,VDDIO_Q,$stime);
            end
            else
                if (msg_count_pad1 == MAX_WARNING_COUNT+1)
                begin
                    $display(" ===WARNING=== sky130_fd_io__top_gpio_ovtv2 :  Further WARNING messages will be suppressed as the message count has exceeded 100 %m",$stime);
                end
        end
    end
end
wire #100 error_vdda2 = ( VDDA===1 && VDDIO_Q ===1 && VSWITCH !==1 && ENABLE_H===1 && hld_h_n_buf ===1  &&  VCCD===1 && ANALOG_EN ===1 );
event event_error_vdda2;
always @(error_vdda2)
begin
    if (!dis_err_msgs)
    begin
        if (error_vdda2===1)
        begin
            msg_count_pad2 = msg_count_pad2 + 1;
            ->event_error_vdda2;
            if (msg_count_pad2 <= MAX_WARNING_COUNT)
            begin
                $display(" ===ERROR=== sky130_fd_io__top_gpio_ovtv2 : ANALOG_EN (= %b) cannot be 1 when VDDA (= %b) , VDDIO_Q (= %b) , VSWITCH(= %b), ENABLE_H (= %b),hld_h_n_buf (= %b) and VCCD (= %b)   %m",ANALOG_EN,VDDA,VDDIO_Q,VSWITCH,ENABLE_H,hld_h_n_buf,VCCD,$stime);
            end
            else
                if (msg_count_pad2 == MAX_WARNING_COUNT+1)
                begin
                    $display(" ===WARNING=== sky130_fd_io__top_gpio_ovtv2 :  Further WARNING messages will be suppressed as the message count has exceeded 100 %m",$stime);
                end
        end
    end
end
wire #100 error_vdda3 =  ( VDDA===1 && VDDIO_Q ===1 && VSWITCH !==1 && ENABLE_H===1 && hld_h_n_buf ===1  && VCCD !==1 );
event event_error_vdda3;
always @(error_vdda3)
begin
    if (!dis_err_msgs)
    begin
        if (error_vdda3===1)
        begin
            msg_count_pad3 = msg_count_pad3 + 1;
            ->event_error_vdda3;
            if (msg_count_pad3 <= MAX_WARNING_COUNT)
            begin
                $display(" ===ERROR=== sky130_fd_io__top_gpio_ovtv2 : VCCD (= %b) cannot be any value other than 1 when VDDA (= %b) , VDDIO_Q (= %b) , VSWITCH(= %b), ENABLE_H (= %b) and hld_h_n_buf (= %b) %m",VCCD,VDDA,VDDIO_Q,VSWITCH,ENABLE_H,hld_h_n_buf,$stime);
            end
            else
                if (msg_count_pad3 == MAX_WARNING_COUNT+1)
                begin
                    $display(" ===WARNING=== sky130_fd_io__top_gpio_ovtv2 :  Further WARNING messages will be suppressed as the message count has exceeded 100 %m",$stime);
                end
        end
    end
end
wire #100 error_vswitch1 =  (VDDA !==1 && VDDIO_Q !==1 && VSWITCH ===1 && (ENABLE_VSWITCH_H===1)) ;
event event_error_vswitch1;
always @(error_vswitch1)
begin
    if (!dis_err_msgs)
    begin
        if (error_vswitch1===1)
        begin
            msg_count_pad4 = msg_count_pad4 + 1;
            ->event_error_vswitch1;
            if (msg_count_pad4 <= MAX_WARNING_COUNT)
            begin
                $display(" ===ERROR=== sky130_fd_io__top_gpio_ovtv2 : ENABLE_VSWITCH_H (= %b) cannot be 1 when VDDA (= %b) , VDDIO_Q (= %b) & VSWITCH(= %b) %m",ENABLE_VSWITCH_H,VDDA,VDDIO_Q,VSWITCH,$stime);
            end
            else
                if (msg_count_pad4 == MAX_WARNING_COUNT+1)
                begin
                    $display(" ===WARNING=== sky130_fd_io__top_gpio_ovtv2 :  Further WARNING messages will be suppressed as the message count has exceeded 100 %m",$stime);
                end
        end
    end
end
wire #100 error_vswitch2 =   (VDDA !==1 && VDDIO_Q !==1 && VSWITCH ===1 && VCCD===1 && ANALOG_EN===1);
event event_error_vswitch2;
always @(error_vswitch2)
begin
    if (!dis_err_msgs)
    begin
        if (error_vswitch2===1)
        begin
            msg_count_pad5 = msg_count_pad5 + 1;
            ->event_error_vswitch2;
            if (msg_count_pad5 <= MAX_WARNING_COUNT)
            begin
                $display(" ===ERROR=== sky130_fd_io__top_gpio_ovtv2 : ANALOG_EN (= %b) cannot be 1 when VDDA (= %b) , VDDIO_Q (= %b) , VSWITCH(= %b)  & VCCD(= %b) %m",ANALOG_EN,VDDA,VDDIO_Q,VSWITCH,VCCD,$stime);
            end
            else
                if (msg_count_pad5 == MAX_WARNING_COUNT+1)
                begin
                    $display(" ===WARNING=== sky130_fd_io__top_gpio_ovtv2 :  Further WARNING messages will be suppressed as the message count has exceeded 100 %m",$stime);
                end
        end
    end
end
wire #100 error_vswitch3 =   (VDDA ===1 && VDDIO_Q !==1 && VSWITCH ===1 && ENABLE_VSWITCH_H===1);
event event_error_vswitch3;
always @(error_vswitch3)
begin
    if (!dis_err_msgs)
    begin
        if (error_vswitch3===1)
        begin
            msg_count_pad6 = msg_count_pad6 + 1;
            ->event_error_vswitch3;
            if (msg_count_pad6 <= MAX_WARNING_COUNT)
            begin
                $display(" ===ERROR=== sky130_fd_io__top_gpio_ovtv2 : ENABLE_VSWITCH_H(= %b) cannot be 1 when VDDA (= %b) , VDDIO_Q (= %b) & VSWITCH(= %b) %m",ENABLE_VSWITCH_H,VDDA,VDDIO_Q,VSWITCH,$stime);
            end
            else
                if (msg_count_pad6 == MAX_WARNING_COUNT+1)
                begin
                    $display(" ===WARNING=== sky130_fd_io__top_gpio_ovtv2 :  Further WARNING messages will be suppressed as the message count has exceeded 100 %m",$stime);
                end
        end
    end
end
wire #100 error_vswitch4 =  (VDDA !==1 && VDDIO_Q ===1 && VSWITCH ===1 && ENABLE_VSWITCH_H===1);
event event_error_vswitch4;
always @(error_vswitch4)
begin
    if (!dis_err_msgs)
    begin
        if (error_vswitch4===1)
        begin
            msg_count_pad7 = msg_count_pad7 + 1;
            ->event_error_vswitch4;
            if (msg_count_pad7 <= MAX_WARNING_COUNT)
            begin
                $display(" ===ERROR=== sky130_fd_io__top_gpio_ovtv2 : ENABLE_VSWITCH_H(= %b) cannot be 1 when VDDA (= %b) , VDDIO_Q (= %b) & VSWITCH(= %b) %m",ENABLE_VSWITCH_H,VDDA,VDDIO_Q,VSWITCH,$stime);
            end
            else
                if (msg_count_pad7 == MAX_WARNING_COUNT+1)
                begin
                    $display(" ===WARNING=== sky130_fd_io__top_gpio_ovtv2 :  Further WARNING messages will be suppressed as the message count has exceeded 100 %m",$stime);
                end
        end
    end
end
wire #100 error_vswitch5 =  (VDDA !==1 && VDDIO_Q ===1 && VSWITCH ===1 && ENABLE_H ===1 && hld_h_n_buf ===1 && VCCD ===1 && ANALOG_EN===1);
event event_error_vswitch5;
always @(error_vswitch5)
begin
    if (!dis_err_msgs)
    begin
        if (error_vswitch5===1)
        begin
            msg_count_pad8 = msg_count_pad8 + 1;
            ->event_error_vswitch5;
            if (msg_count_pad8 <= MAX_WARNING_COUNT)
            begin
                $display(" ===ERROR=== sky130_fd_io__top_gpio_ovtv2 : ANALOG_EN(= %b) cannot be 1 when VDDA (= %b) , VDDIO_Q (= %b) , VSWITCH(= %b),ENABLE_H (= %b),hld_h_n_buf (= %b) and VCCD (= %b) %m",ANALOG_EN,VDDA,VDDIO_Q,VSWITCH,ENABLE_H,hld_h_n_buf,VCCD,$stime);
            end
            else
                if (msg_count_pad8 == MAX_WARNING_COUNT+1)
                begin
                    $display(" ===WARNING=== sky130_fd_io__top_gpio_ovtv2 :  Further WARNING messages will be suppressed as the message count has exceeded 100 %m",$stime);
                end
        end
    end
end
wire #100 error_vddio_q1 =  (VDDA !==1 && VDDIO_Q ===1 && VSWITCH !==1 && ENABLE_H ===1 && hld_h_n_buf ===1 && VCCD!==1);
event event_error_vddio_q1;
always @(error_vddio_q1)
begin
    if (!dis_err_msgs)
    begin
        if (error_vddio_q1===1)
        begin
            msg_count_pad9 = msg_count_pad9 + 1;
            ->event_error_vddio_q1;
            if (msg_count_pad9 <= MAX_WARNING_COUNT)
            begin
                $display(" ===ERROR=== sky130_fd_io__top_gpio_ovtv2 : VCCD(= %b) cannot be any value other than 1 when VDDA (= %b) , VDDIO_Q (= %b) , VSWITCH(= %b),ENABLE_H (= %b) and hld_h_n_buf (= %b)  %m",VCCD,VDDA,VDDIO_Q,VSWITCH,ENABLE_H,hld_h_n_buf,$stime);
            end
            else
                if (msg_count_pad9 == MAX_WARNING_COUNT+1)
                begin
                    $display(" ===WARNING=== sky130_fd_io__top_gpio_ovtv2 :  Further WARNING messages will be suppressed as the message count has exceeded 100 %m",$stime);
                end
        end
    end
end
wire #100 error_vddio_q2 =  (VDDA !==1 && VDDIO_Q ===1 && VSWITCH !==1 && ENABLE_H ===1 && hld_h_n_buf ===1 && VCCD ===1 && ANALOG_EN===1);
event event_error_vddio_q2;
always @(error_vddio_q2)
begin
    if (!dis_err_msgs)
    begin
        if (error_vddio_q2===1)
        begin
            msg_count_pad10 = msg_count_pad10 + 1;
            ->event_error_vddio_q2;
            if (msg_count_pad10 <= MAX_WARNING_COUNT)
            begin
                $display(" ===ERROR=== sky130_fd_io__top_gpio_ovtv2 : ANALOG_EN(= %b) cannot be 1 when VDDA (= %b) , VDDIO_Q (= %b) , VSWITCH(= %b),ENABLE_H (= %b) , hld_h_n_buf (= %b) && VCCD (= %b) %m",ANALOG_EN, VDDA,VDDIO_Q,VSWITCH,ENABLE_H,hld_h_n_buf,VCCD,$stime);
            end
            else
                if (msg_count_pad10 == MAX_WARNING_COUNT+1)
                begin
                    $display(" ===WARNING=== sky130_fd_io__top_gpio_ovtv2 :  Further WARNING messages will be suppressed as the message count has exceeded 100 %m",$stime);
                end
        end
    end
end
wire #100 error_supply_good = ( VDDA ===1 && VDDIO_Q ===1 && VSWITCH ===1  && ENABLE_H ===1 && hld_h_n_buf ===1 && VCCD ===1 &&  ANALOG_EN===1 && ENABLE_VSWITCH_H !==1 && ENABLE_VSWITCH_H !==0 );
event event_error_supply_good;
always @(error_supply_good)
begin
    if (!dis_err_msgs)
    begin
        if (error_supply_good===1)
        begin
            msg_count_pad11 = msg_count_pad11 + 1;
            ->event_error_supply_good;
            if (msg_count_pad11 <= MAX_WARNING_COUNT)
            begin
                $display(" ===ERROR=== sky130_fd_io__top_gpio_ovtv2 : ENABLE_VSWITCH_H(= %b) should be either 1 or 0 when VDDA (= %b) , VDDIO_Q (= %b) , VSWITCH(= %b), ENABLE_H (= %b), hld_h_n_buf (= %b) ,VCCD (= %b) and ANALOG_EN(= %b)  %m",ENABLE_VSWITCH_H, VDDA,VDDIO_Q,VSWITCH,ENABLE_H,hld_h_n_buf,VCCD,ANALOG_EN,$stime);
            end
            else
                if (msg_count_pad11 == MAX_WARNING_COUNT+1)
                begin
                    $display(" ===WARNING=== sky130_fd_io__top_gpio_ovtv2 :  Further WARNING messages will be suppressed as the message count has exceeded 100 %m",$stime);
                end
        end
    end
end
wire #100 error_vdda_vddioq_vswitch2 = ( VDDA ===1 && VDDIO_Q ===1 && VSWITCH ===1 && ENABLE_H ===1 && hld_h_n_buf ===1 && VCCD ===1 &&  ANALOG_EN===1 && ENABLE_VDDA_H !==1 && ENABLE_VDDA_H !==0 );
event event_error_vdda_vddioq_vswitch2;
always @(error_vdda_vddioq_vswitch2)
begin
    if (!dis_err_msgs)
    begin
        if (error_vdda_vddioq_vswitch2===1)
        begin
            msg_count_pad12 = msg_count_pad12 + 1;
            ->event_error_vdda_vddioq_vswitch2;
            if (msg_count_pad12 <= MAX_WARNING_COUNT)
            begin
                $display(" ===ERROR=== sky130_fd_io__top_gpio_ovtv2 : ENABLE_VDDA_H(= %b) should be either 1 or 0 when VDDA (= %b) , VDDIO_Q (= %b) , VSWITCH(= %b), ENABLE_H (= %b), hld_h_n_buf (= %b) ,VCCD (= %b) and ANALOG_EN(= %b)  %m",ENABLE_VDDA_H, VDDA,VDDIO_Q,VSWITCH,ENABLE_H,hld_h_n_buf,VCCD,ANALOG_EN,$stime);
            end
            else
                if (msg_count_pad12 == MAX_WARNING_COUNT+1)
                begin
                    $display(" ===WARNING=== sky130_fd_io__top_gpio_ovtv2 :  Further WARNING messages will be suppressed as the message count has exceeded 100 %m",$stime);
                end
        end
    end
end
endmodule
`endif // FUNCTIONAL

`else  // USE_POWER_PINS

`ifdef FUNCTIONAL
/*
 * Copyright 2020 The SkyWater PDK Authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 * SPDX-License-Identifier: Apache-2.0
*/

module sky130_fd_io__top_gpio_ovtv2 ( IN, IN_H, TIE_HI_ESD, TIE_LO_ESD, AMUXBUS_A,
                                      AMUXBUS_B, PAD, PAD_A_ESD_0_H, PAD_A_ESD_1_H, PAD_A_NOESD_H,
                                      ANALOG_EN, ANALOG_POL, ANALOG_SEL, DM, ENABLE_H, ENABLE_INP_H, ENABLE_VDDA_H, ENABLE_VDDIO, ENABLE_VSWITCH_H, HLD_H_N,
                                      HLD_OVR, IB_MODE_SEL, INP_DIS, OE_N, OUT, SLOW, SLEW_CTL, VTRIP_SEL, HYS_TRIM, VINREF );
input OUT;
input OE_N;
input HLD_H_N;
input ENABLE_H;
input ENABLE_INP_H;
input ENABLE_VDDA_H;
input ENABLE_VDDIO;
input ENABLE_VSWITCH_H;
input INP_DIS;
input VTRIP_SEL;
input HYS_TRIM;
input SLOW;
input [1:0] SLEW_CTL;
input HLD_OVR;
input ANALOG_EN;
input ANALOG_SEL;
input ANALOG_POL;
input [2:0] DM;
input [1:0] IB_MODE_SEL;
input VINREF;
supply1 vddio;
supply1 vddio_q;
supply1 vdda;
supply1 vccd;
supply1 vswitch;
supply1 vcchib;
supply1 vpb;
supply1 vpbhib;
supply0 vssd;
supply0 vssio;
supply0 vssio_q;
supply0 vssa;
inout PAD;
inout PAD_A_NOESD_H,PAD_A_ESD_0_H,PAD_A_ESD_1_H;
inout AMUXBUS_A;
inout AMUXBUS_B;
output IN;
output IN_H;
output TIE_HI_ESD, TIE_LO_ESD;
wire hld_h_n_del;
wire hld_h_n_buf;
reg [2:0] dm_final;
reg [1:0] slew_ctl_final;
reg slow_final, vtrip_sel_final, inp_dis_final, out_final, oe_n_final, hld_ovr_final, hys_trim_final, analog_en_final,analog_en_vdda, analog_en_vswitch,analog_en_vddio_q;
reg [1:0] ib_mode_sel_final;
wire [2:0] dm_del;
wire [1:0] slew_ctl_del;
wire [1:0] ib_mode_sel_del;
wire slow_del, vtrip_sel_del, inp_dis_del, out_del, oe_n_del, hld_ovr_del, hys_trim_del;
wire [2:0] dm_buf;
wire [1:0] slew_ctl_buf;
wire [1:0] ib_mode_sel_buf;
wire slow_buf, vtrip_sel_buf, inp_dis_buf, out_buf, oe_n_buf, hld_ovr_buf, hys_trim_buf;
reg notifier_dm, notifier_slow, notifier_oe_n, notifier_out, notifier_vtrip_sel, notifier_hld_ovr, notifier_inp_dis;
reg notifier_slew_ctl, notifier_ib_mode_sel, notifier_hys_trim;
reg notifier_enable_h, notifier, dummy_notifier1;
assign hld_h_n_buf 	= HLD_H_N;
assign hld_ovr_buf 	= HLD_OVR;
assign dm_buf 		= DM;
assign inp_dis_buf 	= INP_DIS;
assign vtrip_sel_buf 	= VTRIP_SEL;
assign slow_buf 	= SLOW;
assign oe_n_buf 	= OE_N;
assign out_buf 		= OUT;
assign ib_mode_sel_buf 	= IB_MODE_SEL;
assign slew_ctl_buf	= SLEW_CTL;
assign hys_trim_buf 	= HYS_TRIM;
wire  pwr_good_amux	      	 = 1;
wire  pwr_good_inpbuff_hv      	 = 1;
wire  pwr_good_inpbuff_lv        = 1;
wire  pwr_good_output_driver   	 = 1;
wire  pwr_good_hold_mode	 = 1;
wire  pwr_good_hold_ovr_mode	 = 1;
wire  pwr_good_active_mode       = 1;
wire  pwr_good_hold_mode_vdda	 = 1;
wire  pwr_good_active_mode_vdda	 = 1;
wire pwr_good_amux_vccd          = 1;
wire  pwr_good_analog_en_vdda    = 1;
wire  pwr_good_analog_en_vddio_q = 1;
wire  pwr_good_analog_en_vswitch = 1;
parameter MAX_WARNING_COUNT = 100;
wire pad_tristate = oe_n_final === 1 || dm_final === 3'b000 || dm_final === 3'b001;
wire x_on_pad  =  !pwr_good_output_driver
     || (dm_final !== 3'b000 	&& dm_final !== 3'b001 		&& oe_n_final===1'bx)
     || (^dm_final[2:0] === 1'bx 	&& oe_n_final===1'b0)
     || (slow_final===1'bx 	&& dm_final !== 3'b000		&& dm_final !== 3'b001 && oe_n_final===1'b0)
     || (slow_final===1'b1 	&& ^slew_ctl_final[1:0] ===1'bx 	&& dm_final === 3'b100 && oe_n_final===1'b0);
`ifdef SKY130_FD_IO_TOP_GPIO_OVTV2_SLOW_BEHV
parameter SLOW_1_DELAY= 70 ;
parameter SLOW_0_DELAY= 40;
`else
parameter SLOW_1_DELAY= 0;
parameter SLOW_0_DELAY= 0;
`endif
`ifdef SKY130_FD_IO_TOP_GPIO_OVTV2_SLEW_BEHV
parameter SLEW_00_DELAY= 127 ;
parameter SLEW_01_DELAY= 109;
parameter SLEW_10_DELAY= 193;
parameter SLEW_11_DELAY= 136;
`else
parameter SLEW_00_DELAY= 0 ;
parameter SLEW_01_DELAY= 0;
parameter SLEW_10_DELAY= 0;
parameter SLEW_11_DELAY= 0;
`endif
integer slow_1_delay,slow_0_delay,slow_delay,slew_00_delay,slew_01_delay,slew_10_delay,slew_11_delay;
initial slow_1_delay = SLOW_1_DELAY;
initial slow_0_delay = SLOW_0_DELAY;
initial slew_00_delay = SLEW_00_DELAY;
initial slew_01_delay = SLEW_01_DELAY;
initial slew_10_delay = SLEW_10_DELAY;
initial slew_11_delay = SLEW_11_DELAY;
always @(*)
begin
    if (SLOW===1)
    begin
        if (DM[2]===1 && DM[1]===0 && DM[0]===0)
        begin
`ifdef SKY130_FD_IO_TOP_GPIO_OVTV2_SLEW_BEHV
            if (SLEW_CTL[1] ===0 && SLEW_CTL[0] ===0)
                slow_delay = 	slew_00_delay;
            else if (SLEW_CTL[1] ===0 && SLEW_CTL[0] ===1)
                slow_delay = 	slew_01_delay;
            else if (SLEW_CTL[1] ===1 && SLEW_CTL[0] ===0)
                slow_delay = 	slew_10_delay;
            else if (SLEW_CTL[1] ===1 && SLEW_CTL[0] ===1)
                slow_delay = 	slew_11_delay;
`else
            slow_delay = slow_1_delay;
`endif
        end
        else
            slow_delay = slow_1_delay;
    end
    else
        slow_delay = slow_0_delay;
end
bufif1 (pull1, strong0) #slow_delay dm2 (PAD, out_final, x_on_pad===1 ? 1'bx : (pad_tristate===0 && dm_final===3'b010));
bufif1 (strong1, pull0) #slow_delay dm3 (PAD, out_final, x_on_pad===1 ? 1'bx : (pad_tristate===0 && dm_final===3'b011));
bufif1 (highz1, strong0) #slow_delay dm4 (PAD, out_final, x_on_pad===1 ? 1'bx : (pad_tristate===0 && dm_final===3'b100));
bufif1 (strong1, highz0) #slow_delay dm5 (PAD, out_final, x_on_pad===1 ? 1'bx : (pad_tristate===0 && dm_final===3'b101));
bufif1 (strong1, strong0) #slow_delay dm6 (PAD, out_final, x_on_pad===1 ? 1'bx : (pad_tristate===0 && dm_final===3'b110));
bufif1 (pull1, pull0)  #slow_delay dm7 (PAD, out_final, x_on_pad===1 ? 1'bx : (pad_tristate===0 && dm_final===3'b111));
tran pad_esd_1 (PAD,PAD_A_NOESD_H);
tran pad_esd_2 (PAD,PAD_A_ESD_0_H);
tran pad_esd_3 (PAD,PAD_A_ESD_1_H);
wire x_on_in_hv  =  (ENABLE_H===0  && ^ENABLE_INP_H===1'bx)
     || (inp_dis_final===1'bx  && ^dm_final[2:0]!==1'bx && dm_final !== 3'b000)
     || (^ENABLE_H===1'bx)
     || (inp_dis_final===0 	       		&& ^dm_final[2:0] === 1'bx)
     || (^ib_mode_sel_final===1'bx  	&& inp_dis_final===0  		&& dm_final !== 3'b000)
     || (vtrip_sel_final===1'bx    		&& inp_dis_final===0        	&& dm_final !== 3'b000		&& ib_mode_sel_final===2'b00)
     || (^ENABLE_VDDIO===1'bx    		&& inp_dis_final===0        	&& dm_final !== 3'b000		&& ib_mode_sel_final===2'b01)
     || (ib_mode_sel_final[1]===1'b1	&& VINREF !== 1'b1    		&& inp_dis_final===0      	&& dm_final !== 3'b000)
     || (ib_mode_sel_final[1]===1'b1	&& hys_trim_final===1'bx	&& inp_dis_final===0      	&& dm_final !== 3'b000);
wire x_on_in_lv  =  (ENABLE_H===0  && ^ENABLE_VDDIO===1'bx)
     || (ENABLE_H===0  && ^ENABLE_INP_H===1'bx)
     || (inp_dis_final===1'bx  && ^dm_final[2:0]!==1'bx && dm_final !== 3'b000)
     || (^ENABLE_H===1'bx)
     || (inp_dis_final===0 	       		&& ^dm_final[2:0] === 1'bx)
     || (^ib_mode_sel_final===1'bx  	&& inp_dis_final===0  		&& dm_final !== 3'b000)
     || (vtrip_sel_final===1'bx    		&& inp_dis_final===0        	&& dm_final !== 3'b000		&& ib_mode_sel_final===2'b00)
     || (^ENABLE_VDDIO===1'bx    		&& inp_dis_final===0        	&& dm_final !== 3'b000	)
     || (ib_mode_sel_final[1]===1'b1	&& VINREF !== 1'b1    		&& inp_dis_final===0      	&& dm_final !== 3'b000)
     || (ib_mode_sel_final[1]===1'b1	&& hys_trim_final===1'bx	&& inp_dis_final===0      	&& dm_final !== 3'b000);
wire disable_inp_buff = ENABLE_H===1 ? (dm_final===3'b000 || inp_dis_final===1) : ENABLE_INP_H===0;
assign IN_H = (x_on_in_hv===1 || pwr_good_inpbuff_hv===0) ? 1'bx : (disable_inp_buff===1 ? 0 : (^PAD===1'bx ? 1'bx : PAD));
wire disable_inp_buff_lv = ENABLE_H===1 ? (dm_final===3'b000 || inp_dis_final===1) : ENABLE_VDDIO===0;
assign IN   = (x_on_in_lv ===1 || pwr_good_inpbuff_lv===0) ? 1'bx : (disable_inp_buff_lv===1 ? 0 : (^PAD===1'bx ? 1'bx : PAD));
assign TIE_HI_ESD = vddio===1'b1 ? 1'b1 : 1'bx;
assign TIE_LO_ESD = vssio===1'b0 ? 1'b0 : 1'bx;
wire functional_mode_amux = (pwr_good_analog_en_vdda ===1 && pwr_good_analog_en_vddio_q ===1 && pwr_good_analog_en_vswitch ===1 );
wire x_on_analog_en_vdda = (pwr_good_analog_en_vdda !==1
                            || (functional_mode_amux ==1 && (ENABLE_H !==0 && ^hld_h_n_buf === 1'bx) || (hld_h_n_buf!== 0 && ^ENABLE_H=== 1'bx) || pwr_good_amux_vccd !==1 )
                            || (functional_mode_amux ==1 && (hld_h_n_buf ===1 && ENABLE_H===1 && ^ANALOG_EN === 1'bx && ENABLE_VDDA_H ===1 && ENABLE_VSWITCH_H===1 ) || (hld_h_n_buf ===1 && ENABLE_H===1 && ANALOG_EN ===0 && ^ENABLE_VDDA_H ===1'bx) ));
wire zero_on_analog_en_vdda = ( (pwr_good_analog_en_vdda ===1 && ENABLE_VDDA_H ===0)
                                || (pwr_good_analog_en_vdda ===1 && pwr_good_analog_en_vddio_q ===1 && hld_h_n_buf===0)
                                || (pwr_good_analog_en_vdda ===1 && pwr_good_analog_en_vddio_q ===1 && ENABLE_H===0)
                                ||  (pwr_good_analog_en_vdda ===1 && pwr_good_analog_en_vddio_q ===1 && pwr_good_amux_vccd && ANALOG_EN===0) );
wire x_on_analog_en_vddio_q =  ( pwr_good_analog_en_vddio_q !==1
                                 || (functional_mode_amux ==1 && (ENABLE_H !==0 && ^hld_h_n_buf === 1'bx) || (hld_h_n_buf!== 0 && ^ENABLE_H=== 1'bx) || pwr_good_amux_vccd !==1 )
                                 || (functional_mode_amux ==1 && (hld_h_n_buf ===1 && ENABLE_H===1 && ^ANALOG_EN === 1'bx && ENABLE_VDDA_H ===1 && ENABLE_VSWITCH_H===1 ) ));
wire zero_on_analog_en_vddio_q =  ( (pwr_good_analog_en_vddio_q ===1 && hld_h_n_buf===0)
                                    || (pwr_good_analog_en_vddio_q ===1 && ENABLE_H===0)
                                    ||  (pwr_good_analog_en_vddio_q ===1 && pwr_good_amux_vccd && ANALOG_EN===0) );
wire x_on_analog_en_vswitch = (pwr_good_analog_en_vswitch !==1
                               || (functional_mode_amux ==1 && (ENABLE_H !==0 && ^hld_h_n_buf === 1'bx) || (hld_h_n_buf!== 0 && ^ENABLE_H=== 1'bx) || pwr_good_amux_vccd !==1 )
                               || (functional_mode_amux ==1 && (hld_h_n_buf ===1 && ENABLE_H===1 && ^ANALOG_EN === 1'bx && ENABLE_VDDA_H ===1 && ENABLE_VSWITCH_H===1 ) || (hld_h_n_buf ===1 && ENABLE_H===1 && ANALOG_EN ===0 && ^ENABLE_VSWITCH_H ===1'bx) ));
wire  zero_on_analog_en_vswitch =   ( (pwr_good_analog_en_vswitch ===1 && ENABLE_VSWITCH_H ===0)
                                      || (pwr_good_analog_en_vswitch ===1 && pwr_good_analog_en_vddio_q ===1 && hld_h_n_buf===0)
                                      || (pwr_good_analog_en_vswitch ===1 && pwr_good_analog_en_vddio_q ===1 && ENABLE_H===0)
                                      ||  (pwr_good_analog_en_vswitch ===1 && pwr_good_analog_en_vddio_q ===1 && pwr_good_amux_vccd && ANALOG_EN===0) );
always @(*)
begin : LATCH_dm
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode || (ENABLE_H===1 && ^hld_h_n_buf===1'bx))
    begin
        dm_final 	<= 3'bxxx;
    end
    else if (ENABLE_H===0)
    begin
        dm_final 	<= 3'b000;
    end
    else if (hld_h_n_buf===1)
    begin
        dm_final 	<= (^dm_buf[2:0]	=== 1'bx	|| !pwr_good_active_mode) ? 3'bxxx : dm_buf;
    end
end
always @(notifier_enable_h or notifier_dm)
begin
    disable LATCH_dm; dm_final <= 3'bxxx;
end
always @(*)
begin : LATCH_inp_dis
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode || (ENABLE_H===1 && ^hld_h_n_buf===1'bx))
    begin
        inp_dis_final 	<= 1'bx;
    end
    else if (ENABLE_H===0)
    begin
        inp_dis_final 	<= 1'b1;
    end
    else if (hld_h_n_buf===1)
    begin
        inp_dis_final 	<= (^inp_dis_buf === 1'bx	|| !pwr_good_active_mode) ? 1'bx : inp_dis_buf;
    end
end
always @(notifier_enable_h or notifier_inp_dis)
begin
    disable LATCH_inp_dis; inp_dis_final <= 1'bx;
end
always @(*)
begin : LATCH_ib_mode_sel
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode || (ENABLE_H===1 && ^hld_h_n_buf===1'bx))
    begin
        ib_mode_sel_final 	<= 2'bxx;
    end
    else if (ENABLE_H===0)
    begin
        ib_mode_sel_final 	<= 2'b00;
    end
    else if (hld_h_n_buf===1)
    begin
        ib_mode_sel_final 	<= (^ib_mode_sel_buf[1:0]	=== 1'bx	|| !pwr_good_active_mode) ? 2'bxx : ib_mode_sel_buf;
    end
end
always @(notifier_enable_h or notifier_ib_mode_sel)
begin
    disable LATCH_ib_mode_sel; ib_mode_sel_final <= 2'bxx;
end
always @(*)
begin : LATCH_slew_ctl_final
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode || (ENABLE_H===1 && ^hld_h_n_buf===1'bx))
    begin
        slew_ctl_final 	<= 2'bxx;
    end
    else if (ENABLE_H===0)
    begin
        slew_ctl_final 	<= 2'b00;
    end
    else if (hld_h_n_buf===1)
    begin
        slew_ctl_final 	<= (^slew_ctl_buf[1:0] === 1'bx || !pwr_good_active_mode) ? 2'bxx : slew_ctl_buf;
    end
end
always @(notifier_enable_h or notifier_slew_ctl)
begin
    disable LATCH_slew_ctl_final; slew_ctl_final <= 2'bxx;
end
always @(*)
begin : LATCH_vtrip_sel
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode || (ENABLE_H===1 && ^hld_h_n_buf===1'bx))
    begin
        vtrip_sel_final 	<= 1'bx;
    end
    else if (ENABLE_H===0)
    begin
        vtrip_sel_final 	<= 1'b0;
    end
    else if (hld_h_n_buf===1)
    begin
        vtrip_sel_final 	<= (^vtrip_sel_buf === 1'bx	|| !pwr_good_active_mode) ? 1'bx : vtrip_sel_buf;
    end
end
always @(notifier_enable_h or notifier_vtrip_sel)
begin
    disable LATCH_vtrip_sel; vtrip_sel_final <= 1'bx;
end
always @(*)
begin : LATCH_hys_trim
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode || (ENABLE_H===1 && ^hld_h_n_buf===1'bx))
    begin
        hys_trim_final 	<= 1'bx;
    end
    else if (ENABLE_H===0)
    begin
        hys_trim_final 	<= 1'b0;
    end
    else if (hld_h_n_buf===1)
    begin
        hys_trim_final 	<= (^hys_trim_buf === 1'bx	|| !pwr_good_active_mode) ? 1'bx : hys_trim_buf;
    end
end
always @(notifier_enable_h or notifier_hys_trim)
begin
    disable LATCH_hys_trim; hys_trim_final <= 1'bx;
end
always @(*)
begin : LATCH_slow
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode || (ENABLE_H===1 && ^hld_h_n_buf===1'bx))
    begin
        slow_final 	<= 1'bx;
    end
    else if (ENABLE_H===0)
    begin
        slow_final 	<= 1'b0;
    end
    else if (hld_h_n_buf===1)
    begin
        slow_final 	<= (^slow_buf === 1'bx	|| !pwr_good_active_mode) ? 1'bx : slow_buf;
    end
end
always @(notifier_enable_h or notifier_slow)
begin
    disable LATCH_slow; slow_final <= 1'bx;
end
always @(*)
begin : LATCH_hld_ovr
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode || (ENABLE_H===1 && ^hld_h_n_buf===1'bx))
    begin
        hld_ovr_final 	<= 1'bx;
    end
    else if (ENABLE_H===0)
    begin
        hld_ovr_final 	<= 1'b0;
    end
    else if (hld_h_n_buf===1)
    begin
        hld_ovr_final 	<= (^hld_ovr_buf === 1'bx	|| !pwr_good_active_mode) ? 1'bx : hld_ovr_buf;
    end
end
always @(notifier_enable_h or notifier_hld_ovr)
begin
    disable LATCH_hld_ovr; hld_ovr_final <= 1'bx;
end
always @(*)
begin : LATCH_oe_n
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode || (ENABLE_H===1 && (^hld_h_n_buf===1'bx || (hld_h_n_buf===0 && hld_ovr_final===1'bx)|| (hld_h_n_buf===1 && hld_ovr_final===1'bx))))
    begin
        oe_n_final 	<= 1'bx;
    end
    else if (ENABLE_H===0)
    begin
        oe_n_final 	<= 1'b1;
    end
    else if (hld_h_n_buf===1 || hld_ovr_final===1)
    begin
        oe_n_final  	<= (^oe_n_buf  === 1'bx  || !pwr_good_hold_ovr_mode) ? 1'bx   : oe_n_buf;
    end
end
always @(notifier_enable_h or notifier_oe_n)
begin
    disable LATCH_oe_n; oe_n_final <= 1'bx;
end
always @(*)
begin : LATCH_out
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode || (ENABLE_H===1 && (^hld_h_n_buf===1'bx ||(hld_h_n_buf===0 &&  hld_ovr_final===1'bx)||(hld_h_n_buf===1 &&  hld_ovr_final===1'bx))))
    begin
        out_final 	<= 1'bx;
    end
    else if (ENABLE_H===0)
    begin
        out_final 	<= 1'b1;
    end
    else if (hld_h_n_buf===1 || hld_ovr_final===1)
    begin
        out_final  	<= (^out_buf  === 1'bx  || !pwr_good_hold_ovr_mode) ? 1'bx   : out_buf;
    end
end
always @(notifier_enable_h or notifier_out)
begin
    disable LATCH_out; out_final <= 1'bx;
end
always @(*)
begin
    if (x_on_analog_en_vdda ===1 )
    begin
        analog_en_vdda <= 1'bx;
    end
    else if ( zero_on_analog_en_vdda ===1 )
    begin
        analog_en_vdda <= 1'b0;
    end
    else if (x_on_analog_en_vdda !==1 && zero_on_analog_en_vdda !==1)
    begin
        analog_en_vdda <= ANALOG_EN;
    end
    if (x_on_analog_en_vddio_q  ===1 )
    begin
        analog_en_vddio_q  <= 1'bx;
    end
    else if ( zero_on_analog_en_vddio_q ===1 )
    begin
        analog_en_vddio_q  <= 1'b0;
    end
    else if ( x_on_analog_en_vddio_q !==1 && zero_on_analog_en_vddio_q !==1)
    begin
        analog_en_vddio_q  <= ANALOG_EN;
    end
    if (x_on_analog_en_vswitch  ===1 )
    begin
        analog_en_vswitch  <= 1'bx;
    end
    else if ( zero_on_analog_en_vswitch ===1 )
    begin
        analog_en_vswitch  <= 1'b0;
    end
    else if (x_on_analog_en_vswitch !==1 && zero_on_analog_en_vswitch !==1)
    begin
        analog_en_vswitch  <= ANALOG_EN;
    end
    if ( (analog_en_vswitch ===1'bx && analog_en_vdda ===1'bx) || (analog_en_vswitch ===1'bx && analog_en_vddio_q ===1'bx) || (analog_en_vddio_q ===1'bx && analog_en_vdda ===1'bx ) )
    begin
        analog_en_final  <= 1'bx;
    end
    else if (analog_en_vdda ===1'bx && (analog_en_vddio_q ===1 ||analog_en_vswitch===1 ))
    begin
        analog_en_final  <= 1'bx;
    end
    else if (analog_en_vddio_q ===1'bx && (analog_en_vdda ===1 ||analog_en_vswitch===1 ))
    begin
        analog_en_final  <= 1'bx;
    end
    else if (analog_en_vswitch===1'bx && (analog_en_vdda ===1 || analog_en_vddio_q ===1 ))
    begin
        analog_en_final  <= 1'bx;
    end
    else if ((analog_en_vdda ===0 && analog_en_vddio_q ===0 )|| (analog_en_vdda ===0 && analog_en_vswitch===0 ) ||  (analog_en_vddio_q ===0 && analog_en_vswitch===0 ))
    begin
        analog_en_final  <=0;
    end
    else if (analog_en_vdda ===1 && analog_en_vddio_q ===1 &&  analog_en_vswitch ===1)
    begin
        analog_en_final  <=1;
    end
end
wire [2:0] amux_select = {ANALOG_SEL, ANALOG_POL, out_buf};
wire invalid_controls_amux = 	(analog_en_final===1'bx && inp_dis_final===1)
     || !pwr_good_amux
     || (analog_en_final===1 && ^amux_select[2:0] === 1'bx && inp_dis_final===1);
wire enable_pad_amuxbus_a = invalid_controls_amux  ? 1'bx : (amux_select===3'b001 || amux_select===3'b010) && (analog_en_final===1);
wire enable_pad_amuxbus_b = invalid_controls_amux  ? 1'bx : (amux_select===3'b101 || amux_select===3'b110) && (analog_en_final===1);
wire enable_pad_vssio_q   = invalid_controls_amux  ? 1'bx : (amux_select===3'b100 || amux_select===3'b000) && (analog_en_final===1);
wire enable_pad_vddio_q   = invalid_controls_amux  ? 1'bx : (amux_select===3'b011 || amux_select===3'b111) && (analog_en_final===1);
tranif1 pad_amuxbus_a 	(PAD, AMUXBUS_A, enable_pad_amuxbus_a);
tranif1 pad_amuxbus_b 	(PAD, AMUXBUS_B, enable_pad_amuxbus_b);
bufif1 pad_vddio_q	(PAD, vddio_q,   enable_pad_vddio_q);
bufif1 pad_vssio_q   	(PAD, vssio_q,   enable_pad_vssio_q);
reg dis_err_msgs;
integer msg_count_pad,msg_count_pad1,msg_count_pad2,msg_count_pad3,msg_count_pad4,msg_count_pad5,msg_count_pad6,msg_count_pad7,msg_count_pad8,msg_count_pad9,msg_count_pad10,msg_count_pad11,msg_count_pad12;
initial
begin
    dis_err_msgs = 1'b1;
    msg_count_pad  = 0;
    msg_count_pad1 = 0;
    msg_count_pad2 = 0;
    msg_count_pad3 = 0;
    msg_count_pad4 = 0;
    msg_count_pad5 = 0;
    msg_count_pad6 = 0;
    msg_count_pad7 = 0;
    msg_count_pad8 = 0;
    msg_count_pad9 = 0;
    msg_count_pad10 = 0;
    msg_count_pad11 = 0;
    msg_count_pad12  = 0;
`ifdef SKY130_FD_IO_TOP_GPIO_OVTV2_DIS_ERR_MSGS
`else
    #1;
    dis_err_msgs = 1'b0;
`endif
end
wire #100 error_enable_vddio = (ENABLE_VDDIO===0 && ENABLE_H===1);
event event_error_enable_vddio;
always @(error_enable_vddio)
begin
    if (!dis_err_msgs)
    begin
        if (error_enable_vddio===1)
        begin
            msg_count_pad = msg_count_pad + 1;
            ->event_error_enable_vddio;
            if (msg_count_pad <= MAX_WARNING_COUNT)
            begin
                $display(" ===ERROR=== sky130_fd_io__top_gpio_ovtv2 :  Enable_h (= %b) and ENABLE_VDDIO (= %b) are complement of each other. This is an illegal combination as ENABLE_VDDIO and ENABLE_H are the same input signals IN different power domains %m", ENABLE_H, ENABLE_VDDIO, $stime);
            end
            else
                if (msg_count_pad == MAX_WARNING_COUNT+1)
                begin
                    $display(" ===WARNING=== sky130_fd_io__top_gpio_ovtv2 :  Further WARNING messages will be suppressed as the message count has exceeded 100 %m",$stime);
                end
        end
    end
end
wire #100 error_vdda = ( vdda===1 && vddio_q !==1 && ENABLE_VDDA_H===1 );
event event_error_vdda;
always @(error_vdda)
begin
    if (!dis_err_msgs)
    begin
        if (error_vdda===1)
        begin
            msg_count_pad1 = msg_count_pad1 + 1;
            ->event_error_vdda;
            if (msg_count_pad1 <= MAX_WARNING_COUNT)
            begin
                $display(" ===ERROR=== sky130_fd_io__top_gpio_ovtv2 : ENABLE_VDDA_H (= %b) cannot be 1 when vdda (= %b) and vddio_q (= %b) %m",ENABLE_VDDA_H, vdda,vddio_q,$stime);
            end
            else
                if (msg_count_pad1 == MAX_WARNING_COUNT+1)
                begin
                    $display(" ===WARNING=== sky130_fd_io__top_gpio_ovtv2 :  Further WARNING messages will be suppressed as the message count has exceeded 100 %m",$stime);
                end
        end
    end
end
wire #100 error_vdda2 = ( vdda===1 && vddio_q ===1 && vswitch !==1 && ENABLE_H===1 && hld_h_n_buf ===1  &&  vccd===1 && ANALOG_EN ===1 );
event event_error_vdda2;
always @(error_vdda2)
begin
    if (!dis_err_msgs)
    begin
        if (error_vdda2===1)
        begin
            msg_count_pad2 = msg_count_pad2 + 1;
            ->event_error_vdda2;
            if (msg_count_pad2 <= MAX_WARNING_COUNT)
            begin
                $display(" ===ERROR=== sky130_fd_io__top_gpio_ovtv2 : ANALOG_EN (= %b) cannot be 1 when vdda (= %b) , vddio_q (= %b) , vswitch(= %b), ENABLE_H (= %b),hld_h_n_buf (= %b) and vccd (= %b)   %m",ANALOG_EN,vdda,vddio_q,vswitch,ENABLE_H,hld_h_n_buf,vccd,$stime);
            end
            else
                if (msg_count_pad2 == MAX_WARNING_COUNT+1)
                begin
                    $display(" ===WARNING=== sky130_fd_io__top_gpio_ovtv2 :  Further WARNING messages will be suppressed as the message count has exceeded 100 %m",$stime);
                end
        end
    end
end
wire #100 error_vdda3 =  ( vdda===1 && vddio_q ===1 && vswitch !==1 && ENABLE_H===1 && hld_h_n_buf ===1  && vccd !==1 );
event event_error_vdda3;
always @(error_vdda3)
begin
    if (!dis_err_msgs)
    begin
        if (error_vdda3===1)
        begin
            msg_count_pad3 = msg_count_pad3 + 1;
            ->event_error_vdda3;
            if (msg_count_pad3 <= MAX_WARNING_COUNT)
            begin
                $display(" ===ERROR=== sky130_fd_io__top_gpio_ovtv2 : vccd (= %b) cannot be any value other than 1 when vdda (= %b) , vddio_q (= %b) , vswitch(= %b), ENABLE_H (= %b) and hld_h_n_buf (= %b) %m",vccd,vdda,vddio_q,vswitch,ENABLE_H,hld_h_n_buf,$stime);
            end
            else
                if (msg_count_pad3 == MAX_WARNING_COUNT+1)
                begin
                    $display(" ===WARNING=== sky130_fd_io__top_gpio_ovtv2 :  Further WARNING messages will be suppressed as the message count has exceeded 100 %m",$stime);
                end
        end
    end
end
wire #100 error_vswitch1 =  (vdda !==1 && vddio_q !==1 && vswitch ===1 && (ENABLE_VSWITCH_H===1)) ;
event event_error_vswitch1;
always @(error_vswitch1)
begin
    if (!dis_err_msgs)
    begin
        if (error_vswitch1===1)
        begin
            msg_count_pad4 = msg_count_pad4 + 1;
            ->event_error_vswitch1;
            if (msg_count_pad4 <= MAX_WARNING_COUNT)
            begin
                $display(" ===ERROR=== sky130_fd_io__top_gpio_ovtv2 : ENABLE_VSWITCH_H (= %b) cannot be 1 when vdda (= %b) , vddio_q (= %b) & vswitch(= %b) %m",ENABLE_VSWITCH_H,vdda,vddio_q,vswitch,$stime);
            end
            else
                if (msg_count_pad4 == MAX_WARNING_COUNT+1)
                begin
                    $display(" ===WARNING=== sky130_fd_io__top_gpio_ovtv2 :  Further WARNING messages will be suppressed as the message count has exceeded 100 %m",$stime);
                end
        end
    end
end
wire #100 error_vswitch2 =   (vdda !==1 && vddio_q !==1 && vswitch ===1 && vccd===1 && ANALOG_EN===1);
event event_error_vswitch2;
always @(error_vswitch2)
begin
    if (!dis_err_msgs)
    begin
        if (error_vswitch2===1)
        begin
            msg_count_pad5 = msg_count_pad5 + 1;
            ->event_error_vswitch2;
            if (msg_count_pad5 <= MAX_WARNING_COUNT)
            begin
                $display(" ===ERROR=== sky130_fd_io__top_gpio_ovtv2 : ANALOG_EN (= %b) cannot be 1 when vdda (= %b) , vddio_q (= %b) , vswitch(= %b)  & vccd(= %b) %m",ANALOG_EN,vdda,vddio_q,vswitch,vccd,$stime);
            end
            else
                if (msg_count_pad5 == MAX_WARNING_COUNT+1)
                begin
                    $display(" ===WARNING=== sky130_fd_io__top_gpio_ovtv2 :  Further WARNING messages will be suppressed as the message count has exceeded 100 %m",$stime);
                end
        end
    end
end
wire #100 error_vswitch3 =   (vdda ===1 && vddio_q !==1 && vswitch ===1 && ENABLE_VSWITCH_H===1);
event event_error_vswitch3;
always @(error_vswitch3)
begin
    if (!dis_err_msgs)
    begin
        if (error_vswitch3===1)
        begin
            msg_count_pad6 = msg_count_pad6 + 1;
            ->event_error_vswitch3;
            if (msg_count_pad6 <= MAX_WARNING_COUNT)
            begin
                $display(" ===ERROR=== sky130_fd_io__top_gpio_ovtv2 : ENABLE_VSWITCH_H(= %b) cannot be 1 when vdda (= %b) , vddio_q (= %b) & vswitch(= %b) %m",ENABLE_VSWITCH_H,vdda,vddio_q,vswitch,$stime);
            end
            else
                if (msg_count_pad6 == MAX_WARNING_COUNT+1)
                begin
                    $display(" ===WARNING=== sky130_fd_io__top_gpio_ovtv2 :  Further WARNING messages will be suppressed as the message count has exceeded 100 %m",$stime);
                end
        end
    end
end
wire #100 error_vswitch4 =  (vdda !==1 && vddio_q ===1 && vswitch ===1 && ENABLE_VSWITCH_H===1);
event event_error_vswitch4;
always @(error_vswitch4)
begin
    if (!dis_err_msgs)
    begin
        if (error_vswitch4===1)
        begin
            msg_count_pad7 = msg_count_pad7 + 1;
            ->event_error_vswitch4;
            if (msg_count_pad7 <= MAX_WARNING_COUNT)
            begin
                $display(" ===ERROR=== sky130_fd_io__top_gpio_ovtv2 : ENABLE_VSWITCH_H(= %b) cannot be 1 when vdda (= %b) , vddio_q (= %b) & vswitch(= %b) %m",ENABLE_VSWITCH_H,vdda,vddio_q,vswitch,$stime);
            end
            else
                if (msg_count_pad7 == MAX_WARNING_COUNT+1)
                begin
                    $display(" ===WARNING=== sky130_fd_io__top_gpio_ovtv2 :  Further WARNING messages will be suppressed as the message count has exceeded 100 %m",$stime);
                end
        end
    end
end
wire #100 error_vswitch5 =  (vdda !==1 && vddio_q ===1 && vswitch ===1 && ENABLE_H ===1 && hld_h_n_buf ===1 && vccd ===1 && ANALOG_EN===1);
event event_error_vswitch5;
always @(error_vswitch5)
begin
    if (!dis_err_msgs)
    begin
        if (error_vswitch5===1)
        begin
            msg_count_pad8 = msg_count_pad8 + 1;
            ->event_error_vswitch5;
            if (msg_count_pad8 <= MAX_WARNING_COUNT)
            begin
                $display(" ===ERROR=== sky130_fd_io__top_gpio_ovtv2 : ANALOG_EN(= %b) cannot be 1 when vdda (= %b) , vddio_q (= %b) , vswitch(= %b),ENABLE_H (= %b),hld_h_n_buf (= %b) and vccd (= %b) %m",ANALOG_EN,vdda,vddio_q,vswitch,ENABLE_H,hld_h_n_buf,vccd,$stime);
            end
            else
                if (msg_count_pad8 == MAX_WARNING_COUNT+1)
                begin
                    $display(" ===WARNING=== sky130_fd_io__top_gpio_ovtv2 :  Further WARNING messages will be suppressed as the message count has exceeded 100 %m",$stime);
                end
        end
    end
end
wire #100 error_vddio_q1 =  (vdda !==1 && vddio_q ===1 && vswitch !==1 && ENABLE_H ===1 && hld_h_n_buf ===1 && vccd!==1);
event event_error_vddio_q1;
always @(error_vddio_q1)
begin
    if (!dis_err_msgs)
    begin
        if (error_vddio_q1===1)
        begin
            msg_count_pad9 = msg_count_pad9 + 1;
            ->event_error_vddio_q1;
            if (msg_count_pad9 <= MAX_WARNING_COUNT)
            begin
                $display(" ===ERROR=== sky130_fd_io__top_gpio_ovtv2 : vccd(= %b) cannot be any value other than 1 when vdda (= %b) , vddio_q (= %b) , vswitch(= %b),ENABLE_H (= %b) and hld_h_n_buf (= %b)  %m",vccd,vdda,vddio_q,vswitch,ENABLE_H,hld_h_n_buf,$stime);
            end
            else
                if (msg_count_pad9 == MAX_WARNING_COUNT+1)
                begin
                    $display(" ===WARNING=== sky130_fd_io__top_gpio_ovtv2 :  Further WARNING messages will be suppressed as the message count has exceeded 100 %m",$stime);
                end
        end
    end
end
wire #100 error_vddio_q2 =  (vdda !==1 && vddio_q ===1 && vswitch !==1 && ENABLE_H ===1 && hld_h_n_buf ===1 && vccd ===1 && ANALOG_EN===1);
event event_error_vddio_q2;
always @(error_vddio_q2)
begin
    if (!dis_err_msgs)
    begin
        if (error_vddio_q2===1)
        begin
            msg_count_pad10 = msg_count_pad10 + 1;
            ->event_error_vddio_q2;
            if (msg_count_pad10 <= MAX_WARNING_COUNT)
            begin
                $display(" ===ERROR=== sky130_fd_io__top_gpio_ovtv2 : ANALOG_EN(= %b) cannot be 1 when vdda (= %b) , vddio_q (= %b) , vswitch(= %b),ENABLE_H (= %b) , hld_h_n_buf (= %b) && vccd (= %b) %m",ANALOG_EN, vdda,vddio_q,vswitch,ENABLE_H,hld_h_n_buf,vccd,$stime);
            end
            else
                if (msg_count_pad10 == MAX_WARNING_COUNT+1)
                begin
                    $display(" ===WARNING=== sky130_fd_io__top_gpio_ovtv2 :  Further WARNING messages will be suppressed as the message count has exceeded 100 %m",$stime);
                end
        end
    end
end
wire #100 error_supply_good = ( vdda ===1 && vddio_q ===1 && vswitch ===1  && ENABLE_H ===1 && hld_h_n_buf ===1 && vccd ===1 &&  ANALOG_EN===1 && ENABLE_VSWITCH_H !==1 && ENABLE_VSWITCH_H !==0 );
event event_error_supply_good;
always @(error_supply_good)
begin
    if (!dis_err_msgs)
    begin
        if (error_supply_good===1)
        begin
            msg_count_pad11 = msg_count_pad11 + 1;
            ->event_error_supply_good;
            if (msg_count_pad11 <= MAX_WARNING_COUNT)
            begin
                $display(" ===ERROR=== sky130_fd_io__top_gpio_ovtv2 : ENABLE_VSWITCH_H(= %b) should be either 1 or 0 when vdda (= %b) , vddio_q (= %b) , vswitch(= %b), ENABLE_H (= %b), hld_h_n_buf (= %b) ,vccd (= %b) and ANALOG_EN(= %b)  %m",ENABLE_VSWITCH_H, vdda,vddio_q,vswitch,ENABLE_H,hld_h_n_buf,vccd,ANALOG_EN,$stime);
            end
            else
                if (msg_count_pad11 == MAX_WARNING_COUNT+1)
                begin
                    $display(" ===WARNING=== sky130_fd_io__top_gpio_ovtv2 :  Further WARNING messages will be suppressed as the message count has exceeded 100 %m",$stime);
                end
        end
    end
end
wire #100 error_vdda_vddioq_vswitch2 = ( vdda ===1 && vddio_q ===1 && vswitch ===1 && ENABLE_H ===1 && hld_h_n_buf ===1 && vccd ===1 &&  ANALOG_EN===1 && ENABLE_VDDA_H !==1 && ENABLE_VDDA_H !==0 );
event event_error_vdda_vddioq_vswitch2;
always @(error_vdda_vddioq_vswitch2)
begin
    if (!dis_err_msgs)
    begin
        if (error_vdda_vddioq_vswitch2===1)
        begin
            msg_count_pad12 = msg_count_pad12 + 1;
            ->event_error_vdda_vddioq_vswitch2;
            if (msg_count_pad12 <= MAX_WARNING_COUNT)
            begin
                $display(" ===ERROR=== sky130_fd_io__top_gpio_ovtv2 : ENABLE_VDDA_H(= %b) should be either 1 or 0 when vdda (= %b) , vddio_q (= %b) , vswitch(= %b), ENABLE_H (= %b), hld_h_n_buf (= %b) ,vccd (= %b) and ANALOG_EN(= %b)  %m",ENABLE_VDDA_H, vdda,vddio_q,vswitch,ENABLE_H,hld_h_n_buf,vccd,ANALOG_EN,$stime);
            end
            else
                if (msg_count_pad12 == MAX_WARNING_COUNT+1)
                begin
                    $display(" ===WARNING=== sky130_fd_io__top_gpio_ovtv2 :  Further WARNING messages will be suppressed as the message count has exceeded 100 %m",$stime);
                end
        end
    end
end
endmodule
`else  // FUNCTIONAL
/*
 * Copyright 2020 The SkyWater PDK Authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 * SPDX-License-Identifier: Apache-2.0
*/

module sky130_fd_io__top_gpio_ovtv2 ( IN, IN_H, TIE_HI_ESD, TIE_LO_ESD, AMUXBUS_A,
                                      AMUXBUS_B, PAD, PAD_A_ESD_0_H, PAD_A_ESD_1_H, PAD_A_NOESD_H,
                                      ANALOG_EN, ANALOG_POL, ANALOG_SEL, DM, ENABLE_H, ENABLE_INP_H, ENABLE_VDDA_H, ENABLE_VDDIO, ENABLE_VSWITCH_H, HLD_H_N,
                                      HLD_OVR, IB_MODE_SEL, INP_DIS, OE_N, OUT, SLOW, SLEW_CTL, VTRIP_SEL, HYS_TRIM, VINREF );
input OUT;
input OE_N;
input HLD_H_N;
input ENABLE_H;
input ENABLE_INP_H;
input ENABLE_VDDA_H;
input ENABLE_VDDIO;
input ENABLE_VSWITCH_H;
input INP_DIS;
input VTRIP_SEL;
input HYS_TRIM;
input SLOW;
input [1:0] SLEW_CTL;
input HLD_OVR;
input ANALOG_EN;
input ANALOG_SEL;
input ANALOG_POL;
input [2:0] DM;
input [1:0] IB_MODE_SEL;
input VINREF;
supply1 vddio;
supply1 vddio_q;
supply1 vdda;
supply1 vccd;
supply1 vswitch;
supply1 vcchib;
supply1 vpb;
supply1 vpbhib;
supply0 vssd;
supply0 vssio;
supply0 vssio_q;
supply0 vssa;
inout PAD;
inout PAD_A_NOESD_H,PAD_A_ESD_0_H,PAD_A_ESD_1_H;
inout AMUXBUS_A;
inout AMUXBUS_B;
output IN;
output IN_H;
output TIE_HI_ESD, TIE_LO_ESD;
wire hld_h_n_del;
wire hld_h_n_buf;
reg [2:0] dm_final;
reg [1:0] slew_ctl_final;
reg slow_final, vtrip_sel_final, inp_dis_final, out_final, oe_n_final, hld_ovr_final, hys_trim_final, analog_en_final,analog_en_vdda, analog_en_vswitch,analog_en_vddio_q;
reg [1:0] ib_mode_sel_final;
wire [2:0] dm_del;
wire [1:0] slew_ctl_del;
wire [1:0] ib_mode_sel_del;
wire slow_del, vtrip_sel_del, inp_dis_del, out_del, oe_n_del, hld_ovr_del, hys_trim_del;
wire [2:0] dm_buf;
wire [1:0] slew_ctl_buf;
wire [1:0] ib_mode_sel_buf;
wire slow_buf, vtrip_sel_buf, inp_dis_buf, out_buf, oe_n_buf, hld_ovr_buf, hys_trim_buf;
reg notifier_dm, notifier_slow, notifier_oe_n, notifier_out, notifier_vtrip_sel, notifier_hld_ovr, notifier_inp_dis;
reg notifier_slew_ctl, notifier_ib_mode_sel, notifier_hys_trim;
reg notifier_enable_h, notifier, dummy_notifier1;
assign hld_h_n_buf 	= hld_h_n_del;
assign hld_ovr_buf 	= hld_ovr_del;
assign dm_buf 		= dm_del;
assign inp_dis_buf 	= inp_dis_del;
assign vtrip_sel_buf 	= vtrip_sel_del;
assign slow_buf 	= slow_del;
assign oe_n_buf 	= oe_n_del;
assign out_buf 		= out_del;
assign ib_mode_sel_buf 	= ib_mode_sel_del;
assign slew_ctl_buf	= slew_ctl_del;
assign hys_trim_buf 	= hys_trim_del;
specify
    ( INP_DIS => IN) = (0:0:0 , 0:0:0);
    ( INP_DIS => IN_H) = (0:0:0 , 0:0:0);
    if (  IB_MODE_SEL[1]==1'b0 & IB_MODE_SEL[0]==1'b1  ) ( PAD => IN) = (0:0:0 , 0:0:0);
    if (  IB_MODE_SEL[1]==1'b0 & IB_MODE_SEL[0]==1'b1  ) ( PAD => IN_H) = (0:0:0 , 0:0:0);
    if (  OE_N==1'b0 & DM[2]==1'b1 & DM[1]==1'b1 & DM[0]==1'b0 & SLOW==1'b0 ) ( OUT => PAD) = (0:0:0 , 0:0:0);
    if (  OE_N==1'b0 & DM[2]==1'b1 & DM[1]==1'b1 & DM[0]==1'b0 & SLOW==1'b1 ) ( OUT => PAD) = (0:0:0 , 0:0:0);
    if (  OE_N==1'b0 & DM[2]==1'b1 & DM[1]==1'b0 & DM[0]==1'b0 & SLOW==1'b0 ) ( OUT => PAD) = (0:0:0 , 0:0:0, 0:0:0, 0:0:0, 0:0:0, 0:0:0);
    if (  DM[2]==1'b1 & DM[1]==1'b0 & DM[0]==1'b0 & SLOW==1'b1 & SLEW_CTL[1]==1'b0 & SLEW_CTL[0]==1'b0 ) ( OE_N => PAD) = (0:0:0 , 0:0:0, 0:0:0, 0:0:0, 0:0:0, 0:0:0);
    if (  OE_N==1'b0 & DM[2]==1'b1 & DM[1]==1'b1 & DM[0]==1'b1 & SLOW==1'b0 ) ( OUT => PAD ) = (0:0:0 , 0:0:0);
    if (  DM[2]==1'b1 & DM[1]==1'b0 & DM[0]==1'b0 & SLOW==1'b1 & SLEW_CTL[1]==1'b0 & SLEW_CTL[0]==1'b1 ) ( OE_N => PAD) = (0:0:0 , 0:0:0, 0:0:0, 0:0:0, 0:0:0, 0:0:0);
    if (  OE_N==1'b0 & DM[2]==1'b1 & DM[1]==1'b1 & DM[0]==1'b1 & SLOW==1'b1 ) ( OUT => PAD) = (0:0:0 , 0:0:0);
    if (  OE_N==1'b0 & DM[2]==1'b1 & DM[1]==1'b0 & DM[0]==1'b1 & SLOW==1'b0 ) ( OUT => PAD) = (0:0:0 , 0:0:0, 0:0:0, 0:0:0, 0:0:0, 0:0:0);
    if (  DM[2]==1'b1 & DM[1]==1'b1 & DM[0]==1'b0 & SLOW==1'b0 ) ( OE_N => PAD) = (0:0:0 , 0:0:0, 0:0:0, 0:0:0, 0:0:0, 0:0:0);
    if (  OE_N==1'b0 & DM[2]==1'b1 & DM[1]==1'b0 & DM[0]==1'b1 & SLOW==1'b1 ) ( OUT => PAD ) = (0:0:0 , 0:0:0, 0:0:0, 0:0:0, 0:0:0, 0:0:0);
    if (  DM[2]==1'b1 & DM[1]==1'b1 & DM[0]==1'b0 & SLOW==1'b1 ) ( OE_N => PAD) = (0:0:0 , 0:0:0, 0:0:0, 0:0:0, 0:0:0, 0:0:0);
    if (  DM[2]==1'b1 & DM[1]==1'b0 & DM[0]==1'b0 & SLOW==1'b1 & SLEW_CTL[1]==1'b1 & SLEW_CTL[0]==1'b0 ) ( OE_N => PAD) = (0:0:0 , 0:0:0, 0:0:0, 0:0:0, 0:0:0, 0:0:0);
    if (  DM[2]==1'b1 & DM[1]==1'b0 & DM[0]==1'b0 & SLOW==1'b0 ) ( OE_N => PAD) = (0:0:0 , 0:0:0, 0:0:0, 0:0:0, 0:0:0, 0:0:0);
    if (  IB_MODE_SEL[1]==1'b1 & HYS_TRIM==1'b0  ) ( PAD => IN) = (0:0:0 , 0:0:0);
    if (  IB_MODE_SEL[1]==1'b1 & HYS_TRIM==1'b0  ) ( PAD => IN_H) = (0:0:0 , 0:0:0);
    if (  DM[2]==1'b1 & DM[1]==1'b0 & DM[0]==1'b0 & SLOW==1'b1 & SLEW_CTL[1]==1'b1 & SLEW_CTL[0]==1'b1 ) ( OE_N => PAD) = (0:0:0 , 0:0:0, 0:0:0, 0:0:0, 0:0:0, 0:0:0);
    if (  DM[2]==1'b1 & DM[1]==1'b1 & DM[0]==1'b1 & SLOW==1'b0 ) ( OE_N => PAD) = (0:0:0 , 0:0:0, 0:0:0, 0:0:0, 0:0:0, 0:0:0);
    if (  IB_MODE_SEL[1]==1'b1 & HYS_TRIM==1'b1  ) ( PAD => IN) = (0:0:0 , 0:0:0);
    if (  IB_MODE_SEL[1]==1'b1 & HYS_TRIM==1'b1  ) ( PAD => IN_H) = (0:0:0 , 0:0:0);
    if (  DM[2]==1'b1 & DM[1]==1'b1 & DM[0]==1'b1 & SLOW==1'b1 ) ( OE_N => PAD) = (0:0:0 , 0:0:0, 0:0:0, 0:0:0, 0:0:0, 0:0:0);
    if (  OE_N==1'b0 & DM[2]==1'b1 & DM[1]==1'b0 & DM[0]==1'b0 & SLOW==1'b1 & SLEW_CTL[1]==1'b1 & SLEW_CTL[0]==1'b0 ) ( OUT=>  PAD) = (0:0:0 , 0:0:0, 0:0:0, 0:0:0, 0:0:0, 0:0:0);
    if (  DM[2]==1'b1 & DM[1]==1'b0 & DM[0]==1'b1 & SLOW==1'b0 ) ( OE_N => PAD) = (0:0:0 , 0:0:0, 0:0:0, 0:0:0, 0:0:0, 0:0:0);
    if (  OE_N==1'b0 & DM[2]==1'b1 & DM[1]==1'b0 & DM[0]==1'b0 & SLOW==1'b1 & SLEW_CTL[1]==1'b1 & SLEW_CTL[0]==1'b1 ) ( OUT => PAD) = (0:0:0 , 0:0:0, 0:0:0, 0:0:0, 0:0:0, 0:0:0);
    if (  DM[2]==1'b1 & DM[1]==1'b0 & DM[0]==1'b1 & SLOW==1'b1 ) ( OE_N => PAD) = (0:0:0 , 0:0:0, 0:0:0, 0:0:0, 0:0:0, 0:0:0);
    if (  DM[2]==1'b0 & DM[1]==1'b1 & DM[0]==1'b0 & SLOW==1'b0 ) ( OE_N => PAD ) = (0:0:0 , 0:0:0, 0:0:0, 0:0:0, 0:0:0, 0:0:0);
    if (  DM[2]==1'b0 & DM[1]==1'b1 & DM[0]==1'b0 & SLOW==1'b1 ) ( OE_N => PAD) = (0:0:0 , 0:0:0, 0:0:0, 0:0:0, 0:0:0, 0:0:0);
    if (  DM[2]==1'b0 & DM[1]==1'b1 & DM[0]==1'b1 & SLOW==1'b0 ) ( OE_N => PAD) = (0:0:0 , 0:0:0, 0:0:0, 0:0:0, 0:0:0, 0:0:0);
    if (  DM[2]==1'b0 & DM[1]==1'b1 & DM[0]==1'b1 & SLOW==1'b1 ) ( OE_N => PAD) = (0:0:0 , 0:0:0, 0:0:0, 0:0:0, 0:0:0, 0:0:0);
    if (  OE_N==1'b0 & DM[2]==1'b0 & DM[1]==1'b1 & DM[0]==1'b0 & SLOW==1'b0 ) ( OUT => PAD) = (0:0:0 , 0:0:0);
    if (  OE_N==1'b0 & DM[2]==1'b1 & DM[1]==1'b0 & DM[0]==1'b0 & SLOW==1'b1 & SLEW_CTL[1]==1'b0 & SLEW_CTL[0]==1'b0 ) ( OUT => PAD) = (0:0:0 , 0:0:0, 0:0:0, 0:0:0, 0:0:0, 0:0:0);
    if (  OE_N==1'b0 & DM[2]==1'b0 & DM[1]==1'b1 & DM[0]==1'b0 & SLOW==1'b1 ) ( OUT => PAD) = (0:0:0 , 0:0:0);
    if (  OE_N==1'b0 & DM[2]==1'b1 & DM[1]==1'b0 & DM[0]==1'b0 & SLOW==1'b1 & SLEW_CTL[1]==1'b0 & SLEW_CTL[0]==1'b1 ) ( OUT => PAD) = (0:0:0 , 0:0:0, 0:0:0, 0:0:0, 0:0:0, 0:0:0);
    if (  IB_MODE_SEL[1]==1'b0 & IB_MODE_SEL[0]==1'b0 & VTRIP_SEL==1'b0  ) ( PAD => IN) = (0:0:0 , 0:0:0);
    if (  IB_MODE_SEL[1]==1'b0 & IB_MODE_SEL[0]==1'b0 & VTRIP_SEL==1'b0  ) ( PAD => IN_H) = (0:0:0 , 0:0:0);
    if (  OE_N==1'b0 & DM[2]==1'b0 & DM[1]==1'b1 & DM[0]==1'b1 & SLOW==1'b0 ) ( OUT => PAD) = (0:0:0 , 0:0:0);
    if (  IB_MODE_SEL[1]==1'b0 & IB_MODE_SEL[0]==1'b0 & VTRIP_SEL==1'b1  ) ( PAD => IN) = (0:0:0 , 0:0:0);
    if (  IB_MODE_SEL[1]==1'b0 & IB_MODE_SEL[0]==1'b0 & VTRIP_SEL==1'b1  ) ( PAD => IN_H) = (0:0:0 , 0:0:0);
    if (  OE_N==1'b0 & DM[2]==1'b0 & DM[1]==1'b1 & DM[0]==1'b1 & SLOW==1'b1 ) ( OUT => PAD) = (0:0:0 , 0:0:0);
    $width  (negedge HLD_H_N,	      (15.500:0:15.500));
    $width  (posedge HLD_H_N,	      (15.500:0:15.500));
    $width  (negedge HLD_OVR,	      (15.500:0:15.500));
    $width  (posedge HLD_OVR,	      (15.500:0:15.500));
    specparam tsetup = 5;
    specparam tsetup1 = 0;
    specparam thold = 5;
    $setuphold (posedge ENABLE_H,     negedge HLD_H_N,      tsetup, thold,  notifier_enable_h);
    $setuphold (posedge ENABLE_VDDIO, posedge ENABLE_H,     tsetup1, thold,  notifier_enable_h);
    $setuphold (negedge ENABLE_H,     negedge ENABLE_VDDIO, tsetup1, thold,  notifier_enable_h);
    $setuphold (negedge HLD_H_N, posedge HLD_OVR,    tsetup, thold,  notifier_hld_ovr,   ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, hld_ovr_del);
    $setuphold (negedge HLD_H_N, negedge HLD_OVR,    tsetup, thold,  notifier_hld_ovr,   ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, hld_ovr_del);
    $setuphold (negedge HLD_H_N, posedge DM[2],      tsetup, thold,  notifier_dm,	 ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, dm_del[2]);
    $setuphold (negedge HLD_H_N, negedge DM[2],      tsetup, thold,  notifier_dm,	 ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, dm_del[2]);
    $setuphold (negedge HLD_H_N, posedge DM[1],      tsetup, thold,  notifier_dm,	 ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, dm_del[1]);
    $setuphold (negedge HLD_H_N, negedge DM[1],      tsetup, thold,  notifier_dm,	 ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, dm_del[1]);
    $setuphold (negedge HLD_H_N, posedge DM[0],      tsetup, thold,  notifier_dm,	 ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, dm_del[0]);
    $setuphold (negedge HLD_H_N, negedge DM[0],      tsetup, thold,  notifier_dm,	 ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, dm_del[0]);
    $setuphold (negedge HLD_H_N, posedge INP_DIS,    tsetup, thold,  notifier_inp_dis,   ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, inp_dis_del);
    $setuphold (negedge HLD_H_N, negedge INP_DIS,    tsetup, thold,  notifier_inp_dis,   ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, inp_dis_del);
    $setuphold (negedge HLD_H_N, posedge VTRIP_SEL,  tsetup, thold,  notifier_vtrip_sel, ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, vtrip_sel_del);
    $setuphold (negedge HLD_H_N, negedge VTRIP_SEL,  tsetup, thold,  notifier_vtrip_sel, ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, vtrip_sel_del);
    $setuphold (negedge HLD_H_N, posedge HYS_TRIM,   tsetup, thold,  notifier_hys_trim,  ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, hys_trim_del);
    $setuphold (negedge HLD_H_N, negedge HYS_TRIM,   tsetup, thold,  notifier_hys_trim,  ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, hys_trim_del);
    $setuphold (negedge HLD_H_N, posedge SLOW,       tsetup, thold,  notifier_slow,	 ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, slow_del);
    $setuphold (negedge HLD_H_N, negedge SLOW,       tsetup, thold,  notifier_slow,	 ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, slow_del);
    $setuphold (negedge HLD_H_N, posedge OE_N,       tsetup, thold,  notifier_oe_n,	 ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, oe_n_del);
    $setuphold (negedge HLD_H_N, negedge OE_N,       tsetup, thold,  notifier_oe_n,	 ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, oe_n_del);
    $setuphold (negedge HLD_H_N, posedge OUT,        tsetup, thold,  notifier_out,	 ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, out_del);
    $setuphold (negedge HLD_H_N, negedge OUT,        tsetup, thold,  notifier_out,	 ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, out_del);
    $setuphold (negedge HLD_H_N, posedge SLEW_CTL[1],   tsetup, thold,  notifier_slew_ctl,  	ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, slew_ctl_del[1]);
    $setuphold (negedge HLD_H_N, negedge SLEW_CTL[1],   tsetup, thold,  notifier_slew_ctl,  	ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, slew_ctl_del[1]);
    $setuphold (negedge HLD_H_N, posedge SLEW_CTL[0],   tsetup, thold,  notifier_slew_ctl,  	ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, slew_ctl_del[0]);
    $setuphold (negedge HLD_H_N, negedge SLEW_CTL[0],   tsetup, thold,  notifier_slew_ctl,  	ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, slew_ctl_del[0]);
    $setuphold (negedge HLD_H_N, posedge IB_MODE_SEL[1], tsetup, thold,  notifier_ib_mode_sel,  ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, ib_mode_sel_del[1]);
    $setuphold (negedge HLD_H_N, negedge IB_MODE_SEL[1], tsetup, thold,  notifier_ib_mode_sel,  ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, ib_mode_sel_del[1]);
    $setuphold (negedge HLD_H_N, posedge IB_MODE_SEL[0], tsetup, thold,  notifier_ib_mode_sel,  ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, ib_mode_sel_del[0]);
    $setuphold (negedge HLD_H_N, negedge IB_MODE_SEL[0], tsetup, thold,  notifier_ib_mode_sel,  ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, ib_mode_sel_del[0]);
    $setuphold (posedge HLD_H_N, posedge HLD_OVR,    tsetup, thold,  notifier_hld_ovr,   ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, hld_ovr_del);
    $setuphold (posedge HLD_H_N, negedge HLD_OVR,    tsetup, thold,  notifier_hld_ovr,   ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, hld_ovr_del);
    $setuphold (posedge HLD_H_N, posedge DM[2],      tsetup, thold,  notifier_dm,	 ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, dm_del[2]);
    $setuphold (posedge HLD_H_N, negedge DM[2],      tsetup, thold,  notifier_dm,	 ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, dm_del[2]);
    $setuphold (posedge HLD_H_N, posedge DM[1],      tsetup, thold,  notifier_dm,	 ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, dm_del[1]);
    $setuphold (posedge HLD_H_N, negedge DM[1],      tsetup, thold,  notifier_dm,	 ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, dm_del[1]);
    $setuphold (posedge HLD_H_N, posedge DM[0],      tsetup, thold,  notifier_dm,	 ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, dm_del[0]);
    $setuphold (posedge HLD_H_N, negedge DM[0],      tsetup, thold,  notifier_dm,	 ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, dm_del[0]);
    $setuphold (posedge HLD_H_N, posedge INP_DIS,    tsetup, thold,  notifier_inp_dis,   ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, inp_dis_del);
    $setuphold (posedge HLD_H_N, negedge INP_DIS,    tsetup, thold,  notifier_inp_dis,   ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, inp_dis_del);
    $setuphold (posedge HLD_H_N, posedge VTRIP_SEL,  tsetup, thold,  notifier_vtrip_sel, ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, vtrip_sel_del);
    $setuphold (posedge HLD_H_N, negedge VTRIP_SEL,  tsetup, thold,  notifier_vtrip_sel, ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, vtrip_sel_del);
    $setuphold (posedge HLD_H_N, posedge HYS_TRIM,   tsetup, thold,  notifier_hys_trim,  ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, hys_trim_del);
    $setuphold (posedge HLD_H_N, negedge HYS_TRIM,   tsetup, thold,  notifier_hys_trim,  ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, hys_trim_del);
    $setuphold (posedge HLD_H_N, posedge SLOW,       tsetup, thold,  notifier_slow,	 ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, slow_del);
    $setuphold (posedge HLD_H_N, negedge SLOW,       tsetup, thold,  notifier_slow,	 ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, slow_del);
    $setuphold (posedge HLD_H_N, posedge OE_N,       tsetup, thold,  notifier_oe_n,	 ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, oe_n_del);
    $setuphold (posedge HLD_H_N, negedge OE_N,       tsetup, thold,  notifier_oe_n,	 ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, oe_n_del);
    $setuphold (posedge HLD_H_N, posedge OUT,        tsetup, thold,  notifier_out,	 ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, out_del);
    $setuphold (posedge HLD_H_N, negedge OUT,        tsetup, thold,  notifier_out,	 ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, out_del);
    $setuphold (posedge HLD_H_N, posedge SLEW_CTL[1],   tsetup, thold,  notifier_slew_ctl,  	ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, slew_ctl_del[1]);
    $setuphold (posedge HLD_H_N, negedge SLEW_CTL[1],   tsetup, thold,  notifier_slew_ctl,  	ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, slew_ctl_del[1]);
    $setuphold (posedge HLD_H_N, posedge SLEW_CTL[0],   tsetup, thold,  notifier_slew_ctl,  	ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, slew_ctl_del[0]);
    $setuphold (posedge HLD_H_N, negedge SLEW_CTL[0],   tsetup, thold,  notifier_slew_ctl,  	ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, slew_ctl_del[0]);
    $setuphold (posedge HLD_H_N, posedge IB_MODE_SEL[1], tsetup, thold,  notifier_ib_mode_sel,  ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, ib_mode_sel_del[1]);
    $setuphold (posedge HLD_H_N, negedge IB_MODE_SEL[1], tsetup, thold,  notifier_ib_mode_sel,  ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, ib_mode_sel_del[1]);
    $setuphold (posedge HLD_H_N, posedge IB_MODE_SEL[0], tsetup, thold,  notifier_ib_mode_sel,  ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, ib_mode_sel_del[0]);
    $setuphold (posedge HLD_H_N, negedge IB_MODE_SEL[0], tsetup, thold,  notifier_ib_mode_sel,  ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, ib_mode_sel_del[0]);
    $setuphold (posedge HLD_OVR,    	negedge HLD_H_N, tsetup, thold,  notifier_hld_ovr,	ENABLE_H==1'b1, ENABLE_H==1'b1, hld_ovr_del, hld_h_n_del);
    $setuphold (posedge DM[2],      	negedge HLD_H_N, tsetup, thold,  notifier_dm,		ENABLE_H==1'b1, ENABLE_H==1'b1, dm_del[2], hld_h_n_del);
    $setuphold (posedge DM[1],      	negedge HLD_H_N, tsetup, thold,  notifier_dm,		ENABLE_H==1'b1, ENABLE_H==1'b1, dm_del[1], hld_h_n_del);
    $setuphold (posedge DM[0],      	negedge HLD_H_N, tsetup, thold,  notifier_dm,		ENABLE_H==1'b1, ENABLE_H==1'b1, dm_del[0], hld_h_n_del);
    $setuphold (posedge INP_DIS,    	negedge HLD_H_N, tsetup, thold,  notifier_inp_dis,	ENABLE_H==1'b1, ENABLE_H==1'b1, inp_dis_del, hld_h_n_del);
    $setuphold (posedge VTRIP_SEL,  	negedge HLD_H_N, tsetup, thold,  notifier_vtrip_sel, 	ENABLE_H==1'b1, ENABLE_H==1'b1, vtrip_sel_del, hld_h_n_del);
    $setuphold (posedge HYS_TRIM,   	negedge HLD_H_N, tsetup, thold,  notifier_hys_trim,  	ENABLE_H==1'b1, ENABLE_H==1'b1, hys_trim_del, hld_h_n_del);
    $setuphold (posedge SLOW,	    	negedge HLD_H_N, tsetup, thold,  notifier_slow,		ENABLE_H==1'b1, ENABLE_H==1'b1, slow_del, hld_h_n_del);
    $setuphold (posedge OE_N,	    	negedge HLD_H_N, tsetup, thold,  notifier_oe_n,		ENABLE_H==1'b1, ENABLE_H==1'b1, oe_n_del, hld_h_n_del);
    $setuphold (posedge OUT,	    	negedge HLD_H_N, tsetup, thold,  notifier_out,		ENABLE_H==1'b1, ENABLE_H==1'b1, out_del, hld_h_n_del);
    $setuphold (posedge SLEW_CTL[1],   	negedge HLD_H_N, tsetup, thold,  notifier_slew_ctl,     ENABLE_H==1'b1, ENABLE_H==1'b1, slew_ctl_del[1], hld_h_n_del);
    $setuphold (posedge SLEW_CTL[0],   	negedge HLD_H_N, tsetup, thold,  notifier_slew_ctl,     ENABLE_H==1'b1, ENABLE_H==1'b1, slew_ctl_del[0], hld_h_n_del);
    $setuphold (posedge IB_MODE_SEL[1], negedge HLD_H_N, tsetup, thold,  notifier_ib_mode_sel,  ENABLE_H==1'b1, ENABLE_H==1'b1, ib_mode_sel_del[1], hld_h_n_del);
    $setuphold (posedge IB_MODE_SEL[0], negedge HLD_H_N, tsetup, thold,  notifier_ib_mode_sel,  ENABLE_H==1'b1, ENABLE_H==1'b1, ib_mode_sel_del[0], hld_h_n_del);
endspecify
wire  pwr_good_amux	      	 = 1;
wire  pwr_good_inpbuff_hv      	 = 1;
wire  pwr_good_inpbuff_lv        = 1;
wire  pwr_good_output_driver   	 = 1;
wire  pwr_good_hold_mode	 = 1;
wire  pwr_good_hold_ovr_mode	 = 1;
wire  pwr_good_active_mode       = 1;
wire  pwr_good_hold_mode_vdda	 = 1;
wire  pwr_good_active_mode_vdda	 = 1;
wire pwr_good_amux_vccd          = 1;
wire  pwr_good_analog_en_vdda    = 1;
wire  pwr_good_analog_en_vddio_q = 1;
wire  pwr_good_analog_en_vswitch = 1;
parameter MAX_WARNING_COUNT = 100;
wire pad_tristate = oe_n_final === 1 || dm_final === 3'b000 || dm_final === 3'b001;
wire x_on_pad  =  !pwr_good_output_driver
     || (dm_final !== 3'b000 	&& dm_final !== 3'b001 		&& oe_n_final===1'bx)
     || (^dm_final[2:0] === 1'bx 	&& oe_n_final===1'b0)
     || (slow_final===1'bx 	&& dm_final !== 3'b000		&& dm_final !== 3'b001 && oe_n_final===1'b0)
     || (slow_final===1'b1 	&& ^slew_ctl_final[1:0] ===1'bx 	&& dm_final === 3'b100 && oe_n_final===1'b0);
`ifdef SKY130_FD_IO_TOP_GPIO_OVTV2_SLOW_BEHV
parameter SLOW_1_DELAY= 70 ;
parameter SLOW_0_DELAY= 40;
`else
parameter SLOW_1_DELAY= 0;
parameter SLOW_0_DELAY= 0;
`endif
`ifdef SKY130_FD_IO_TOP_GPIO_OVTV2_SLEW_BEHV
parameter SLEW_00_DELAY= 127 ;
parameter SLEW_01_DELAY= 109;
parameter SLEW_10_DELAY= 193;
parameter SLEW_11_DELAY= 136;
`else
parameter SLEW_00_DELAY= 0 ;
parameter SLEW_01_DELAY= 0;
parameter SLEW_10_DELAY= 0;
parameter SLEW_11_DELAY= 0;
`endif
integer slow_1_delay,slow_0_delay,slow_delay,slew_00_delay,slew_01_delay,slew_10_delay,slew_11_delay;
initial slow_1_delay = SLOW_1_DELAY;
initial slow_0_delay = SLOW_0_DELAY;
initial slew_00_delay = SLEW_00_DELAY;
initial slew_01_delay = SLEW_01_DELAY;
initial slew_10_delay = SLEW_10_DELAY;
initial slew_11_delay = SLEW_11_DELAY;
always @(*)
begin
    if (SLOW===1)
    begin
        if (DM[2]===1 && DM[1]===0 && DM[0]===0)
        begin
`ifdef SKY130_FD_IO_TOP_GPIO_OVTV2_SLEW_BEHV
            if (SLEW_CTL[1] ===0 && SLEW_CTL[0] ===0)
                slow_delay = 	slew_00_delay;
            else if (SLEW_CTL[1] ===0 && SLEW_CTL[0] ===1)
                slow_delay = 	slew_01_delay;
            else if (SLEW_CTL[1] ===1 && SLEW_CTL[0] ===0)
                slow_delay = 	slew_10_delay;
            else if (SLEW_CTL[1] ===1 && SLEW_CTL[0] ===1)
                slow_delay = 	slew_11_delay;
`else
            slow_delay = slow_1_delay;
`endif
        end
        else
            slow_delay = slow_1_delay;
    end
    else
        slow_delay = slow_0_delay;
end
bufif1 (pull1, strong0) #slow_delay dm2 (PAD, out_final, x_on_pad===1 ? 1'bx : (pad_tristate===0 && dm_final===3'b010));
bufif1 (strong1, pull0) #slow_delay dm3 (PAD, out_final, x_on_pad===1 ? 1'bx : (pad_tristate===0 && dm_final===3'b011));
bufif1 (highz1, strong0) #slow_delay dm4 (PAD, out_final, x_on_pad===1 ? 1'bx : (pad_tristate===0 && dm_final===3'b100));
bufif1 (strong1, highz0) #slow_delay dm5 (PAD, out_final, x_on_pad===1 ? 1'bx : (pad_tristate===0 && dm_final===3'b101));
bufif1 (strong1, strong0) #slow_delay dm6 (PAD, out_final, x_on_pad===1 ? 1'bx : (pad_tristate===0 && dm_final===3'b110));
bufif1 (pull1, pull0)  #slow_delay dm7 (PAD, out_final, x_on_pad===1 ? 1'bx : (pad_tristate===0 && dm_final===3'b111));
tran pad_esd_1 (PAD,PAD_A_NOESD_H);
tran pad_esd_2 (PAD,PAD_A_ESD_0_H);
tran pad_esd_3 (PAD,PAD_A_ESD_1_H);
wire x_on_in_hv  =  (ENABLE_H===0  && ^ENABLE_INP_H===1'bx)
     || (inp_dis_final===1'bx  && ^dm_final[2:0]!==1'bx && dm_final !== 3'b000)
     || (^ENABLE_H===1'bx)
     || (inp_dis_final===0 	       		&& ^dm_final[2:0] === 1'bx)
     || (^ib_mode_sel_final===1'bx  	&& inp_dis_final===0  		&& dm_final !== 3'b000)
     || (vtrip_sel_final===1'bx    		&& inp_dis_final===0        	&& dm_final !== 3'b000		&& ib_mode_sel_final===2'b00)
     || (^ENABLE_VDDIO===1'bx    		&& inp_dis_final===0        	&& dm_final !== 3'b000		&& ib_mode_sel_final===2'b01)
     || (ib_mode_sel_final[1]===1'b1	&& VINREF !== 1'b1    		&& inp_dis_final===0      	&& dm_final !== 3'b000)
     || (ib_mode_sel_final[1]===1'b1	&& hys_trim_final===1'bx	&& inp_dis_final===0      	&& dm_final !== 3'b000);
wire x_on_in_lv  =  (ENABLE_H===0  && ^ENABLE_VDDIO===1'bx)
     || (ENABLE_H===0  && ^ENABLE_INP_H===1'bx)
     || (inp_dis_final===1'bx  && ^dm_final[2:0]!==1'bx && dm_final !== 3'b000)
     || (^ENABLE_H===1'bx)
     || (inp_dis_final===0 	       		&& ^dm_final[2:0] === 1'bx)
     || (^ib_mode_sel_final===1'bx  	&& inp_dis_final===0  		&& dm_final !== 3'b000)
     || (vtrip_sel_final===1'bx    		&& inp_dis_final===0        	&& dm_final !== 3'b000		&& ib_mode_sel_final===2'b00)
     || (^ENABLE_VDDIO===1'bx    		&& inp_dis_final===0        	&& dm_final !== 3'b000	)
     || (ib_mode_sel_final[1]===1'b1	&& VINREF !== 1'b1    		&& inp_dis_final===0      	&& dm_final !== 3'b000)
     || (ib_mode_sel_final[1]===1'b1	&& hys_trim_final===1'bx	&& inp_dis_final===0      	&& dm_final !== 3'b000);
wire disable_inp_buff = ENABLE_H===1 ? (dm_final===3'b000 || inp_dis_final===1) : ENABLE_INP_H===0;
assign IN_H = (x_on_in_hv===1 || pwr_good_inpbuff_hv===0) ? 1'bx : (disable_inp_buff===1 ? 0 : (^PAD===1'bx ? 1'bx : PAD));
wire disable_inp_buff_lv = ENABLE_H===1 ? (dm_final===3'b000 || inp_dis_final===1) : ENABLE_VDDIO===0;
assign IN   = (x_on_in_lv ===1 || pwr_good_inpbuff_lv===0) ? 1'bx : (disable_inp_buff_lv===1 ? 0 : (^PAD===1'bx ? 1'bx : PAD));
assign TIE_HI_ESD = vddio===1'b1 ? 1'b1 : 1'bx;
assign TIE_LO_ESD = vssio===1'b0 ? 1'b0 : 1'bx;
wire timing_mode_amux = (pwr_good_analog_en_vdda ===1 && pwr_good_analog_en_vddio_q ===1 && pwr_good_analog_en_vswitch ===1 );
wire x_on_analog_en_vdda = (pwr_good_analog_en_vdda !==1
                            || (timing_mode_amux ==1 && (ENABLE_H !==0 && ^hld_h_n_buf === 1'bx) || (hld_h_n_buf!== 0 && ^ENABLE_H=== 1'bx) || pwr_good_amux_vccd !==1 )
                            || (timing_mode_amux ==1 && (hld_h_n_buf ===1 && ENABLE_H===1 && ^ANALOG_EN === 1'bx && ENABLE_VDDA_H ===1 && ENABLE_VSWITCH_H===1 ) || (hld_h_n_buf ===1 && ENABLE_H===1 && ANALOG_EN ===0 && ^ENABLE_VDDA_H ===1'bx) ));
wire zero_on_analog_en_vdda = ( (pwr_good_analog_en_vdda ===1 && ENABLE_VDDA_H ===0)
                                || (pwr_good_analog_en_vdda ===1 && pwr_good_analog_en_vddio_q ===1 && hld_h_n_buf===0)
                                || (pwr_good_analog_en_vdda ===1 && pwr_good_analog_en_vddio_q ===1 && ENABLE_H===0)
                                ||  (pwr_good_analog_en_vdda ===1 && pwr_good_analog_en_vddio_q ===1 && pwr_good_amux_vccd && ANALOG_EN===0) );
wire x_on_analog_en_vddio_q =  ( pwr_good_analog_en_vddio_q !==1
                                 || (timing_mode_amux ==1 && (ENABLE_H !==0 && ^hld_h_n_buf === 1'bx) || (hld_h_n_buf!== 0 && ^ENABLE_H=== 1'bx) || pwr_good_amux_vccd !==1 )
                                 || (timing_mode_amux ==1 && (hld_h_n_buf ===1 && ENABLE_H===1 && ^ANALOG_EN === 1'bx && ENABLE_VDDA_H ===1 && ENABLE_VSWITCH_H===1 ) ));
wire zero_on_analog_en_vddio_q =  ( (pwr_good_analog_en_vddio_q ===1 && hld_h_n_buf===0)
                                    || (pwr_good_analog_en_vddio_q ===1 && ENABLE_H===0)
                                    ||  (pwr_good_analog_en_vddio_q ===1 && pwr_good_amux_vccd && ANALOG_EN===0) );
wire x_on_analog_en_vswitch = (pwr_good_analog_en_vswitch !==1
                               || (timing_mode_amux ==1 && (ENABLE_H !==0 && ^hld_h_n_buf === 1'bx) || (hld_h_n_buf!== 0 && ^ENABLE_H=== 1'bx) || pwr_good_amux_vccd !==1 )
                               || (timing_mode_amux ==1 && (hld_h_n_buf ===1 && ENABLE_H===1 && ^ANALOG_EN === 1'bx && ENABLE_VDDA_H ===1 && ENABLE_VSWITCH_H===1 ) || (hld_h_n_buf ===1 && ENABLE_H===1 && ANALOG_EN ===0 && ^ENABLE_VSWITCH_H ===1'bx) ));
wire  zero_on_analog_en_vswitch =   ( (pwr_good_analog_en_vswitch ===1 && ENABLE_VSWITCH_H ===0)
                                      || (pwr_good_analog_en_vswitch ===1 && pwr_good_analog_en_vddio_q ===1 && hld_h_n_buf===0)
                                      || (pwr_good_analog_en_vswitch ===1 && pwr_good_analog_en_vddio_q ===1 && ENABLE_H===0)
                                      ||  (pwr_good_analog_en_vswitch ===1 && pwr_good_analog_en_vddio_q ===1 && pwr_good_amux_vccd && ANALOG_EN===0) );
always @(*)
begin : LATCH_dm
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode || (ENABLE_H===1 && ^hld_h_n_buf===1'bx))
    begin
        dm_final 	<= 3'bxxx;
    end
    else if (ENABLE_H===0)
    begin
        dm_final 	<= 3'b000;
    end
    else if (hld_h_n_buf===1)
    begin
        dm_final 	<= (^dm_buf[2:0]	=== 1'bx	|| !pwr_good_active_mode) ? 3'bxxx : dm_buf;
    end
end
always @(notifier_enable_h or notifier_dm)
begin
    disable LATCH_dm; dm_final <= 3'bxxx;
end
always @(*)
begin : LATCH_inp_dis
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode || (ENABLE_H===1 && ^hld_h_n_buf===1'bx))
    begin
        inp_dis_final 	<= 1'bx;
    end
    else if (ENABLE_H===0)
    begin
        inp_dis_final 	<= 1'b1;
    end
    else if (hld_h_n_buf===1)
    begin
        inp_dis_final 	<= (^inp_dis_buf === 1'bx	|| !pwr_good_active_mode) ? 1'bx : inp_dis_buf;
    end
end
always @(notifier_enable_h or notifier_inp_dis)
begin
    disable LATCH_inp_dis; inp_dis_final <= 1'bx;
end
always @(*)
begin : LATCH_ib_mode_sel
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode || (ENABLE_H===1 && ^hld_h_n_buf===1'bx))
    begin
        ib_mode_sel_final 	<= 2'bxx;
    end
    else if (ENABLE_H===0)
    begin
        ib_mode_sel_final 	<= 2'b00;
    end
    else if (hld_h_n_buf===1)
    begin
        ib_mode_sel_final 	<= (^ib_mode_sel_buf[1:0]	=== 1'bx	|| !pwr_good_active_mode) ? 2'bxx : ib_mode_sel_buf;
    end
end
always @(notifier_enable_h or notifier_ib_mode_sel)
begin
    disable LATCH_ib_mode_sel; ib_mode_sel_final <= 2'bxx;
end
always @(*)
begin : LATCH_slew_ctl_final
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode || (ENABLE_H===1 && ^hld_h_n_buf===1'bx))
    begin
        slew_ctl_final 	<= 2'bxx;
    end
    else if (ENABLE_H===0)
    begin
        slew_ctl_final 	<= 2'b00;
    end
    else if (hld_h_n_buf===1)
    begin
        slew_ctl_final 	<= (^slew_ctl_buf[1:0] === 1'bx || !pwr_good_active_mode) ? 2'bxx : slew_ctl_buf;
    end
end
always @(notifier_enable_h or notifier_slew_ctl)
begin
    disable LATCH_slew_ctl_final; slew_ctl_final <= 2'bxx;
end
always @(*)
begin : LATCH_vtrip_sel
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode || (ENABLE_H===1 && ^hld_h_n_buf===1'bx))
    begin
        vtrip_sel_final 	<= 1'bx;
    end
    else if (ENABLE_H===0)
    begin
        vtrip_sel_final 	<= 1'b0;
    end
    else if (hld_h_n_buf===1)
    begin
        vtrip_sel_final 	<= (^vtrip_sel_buf === 1'bx	|| !pwr_good_active_mode) ? 1'bx : vtrip_sel_buf;
    end
end
always @(notifier_enable_h or notifier_vtrip_sel)
begin
    disable LATCH_vtrip_sel; vtrip_sel_final <= 1'bx;
end
always @(*)
begin : LATCH_hys_trim
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode || (ENABLE_H===1 && ^hld_h_n_buf===1'bx))
    begin
        hys_trim_final 	<= 1'bx;
    end
    else if (ENABLE_H===0)
    begin
        hys_trim_final 	<= 1'b0;
    end
    else if (hld_h_n_buf===1)
    begin
        hys_trim_final 	<= (^hys_trim_buf === 1'bx	|| !pwr_good_active_mode) ? 1'bx : hys_trim_buf;
    end
end
always @(notifier_enable_h or notifier_hys_trim)
begin
    disable LATCH_hys_trim; hys_trim_final <= 1'bx;
end
always @(*)
begin : LATCH_slow
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode || (ENABLE_H===1 && ^hld_h_n_buf===1'bx))
    begin
        slow_final 	<= 1'bx;
    end
    else if (ENABLE_H===0)
    begin
        slow_final 	<= 1'b0;
    end
    else if (hld_h_n_buf===1)
    begin
        slow_final 	<= (^slow_buf === 1'bx	|| !pwr_good_active_mode) ? 1'bx : slow_buf;
    end
end
always @(notifier_enable_h or notifier_slow)
begin
    disable LATCH_slow; slow_final <= 1'bx;
end
always @(*)
begin : LATCH_hld_ovr
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode || (ENABLE_H===1 && ^hld_h_n_buf===1'bx))
    begin
        hld_ovr_final 	<= 1'bx;
    end
    else if (ENABLE_H===0)
    begin
        hld_ovr_final 	<= 1'b0;
    end
    else if (hld_h_n_buf===1)
    begin
        hld_ovr_final 	<= (^hld_ovr_buf === 1'bx	|| !pwr_good_active_mode) ? 1'bx : hld_ovr_buf;
    end
end
always @(notifier_enable_h or notifier_hld_ovr)
begin
    disable LATCH_hld_ovr; hld_ovr_final <= 1'bx;
end
always @(*)
begin : LATCH_oe_n
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode || (ENABLE_H===1 && (^hld_h_n_buf===1'bx || (hld_h_n_buf===0 && hld_ovr_final===1'bx)|| (hld_h_n_buf===1 && hld_ovr_final===1'bx))))
    begin
        oe_n_final 	<= 1'bx;
    end
    else if (ENABLE_H===0)
    begin
        oe_n_final 	<= 1'b1;
    end
    else if (hld_h_n_buf===1 || hld_ovr_final===1)
    begin
        oe_n_final  	<= (^oe_n_buf  === 1'bx  || !pwr_good_hold_ovr_mode) ? 1'bx   : oe_n_buf;
    end
end
always @(notifier_enable_h or notifier_oe_n)
begin
    disable LATCH_oe_n; oe_n_final <= 1'bx;
end
always @(*)
begin : LATCH_out
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode || (ENABLE_H===1 && (^hld_h_n_buf===1'bx ||(hld_h_n_buf===0 &&  hld_ovr_final===1'bx)||(hld_h_n_buf===1 &&  hld_ovr_final===1'bx))))
    begin
        out_final 	<= 1'bx;
    end
    else if (ENABLE_H===0)
    begin
        out_final 	<= 1'b1;
    end
    else if (hld_h_n_buf===1 || hld_ovr_final===1)
    begin
        out_final  	<= (^out_buf  === 1'bx  || !pwr_good_hold_ovr_mode) ? 1'bx   : out_buf;
    end
end
always @(notifier_enable_h or notifier_out)
begin
    disable LATCH_out; out_final <= 1'bx;
end
always @(*)
begin
    if (x_on_analog_en_vdda ===1 )
    begin
        analog_en_vdda <= 1'bx;
    end
    else if ( zero_on_analog_en_vdda ===1 )
    begin
        analog_en_vdda <= 1'b0;
    end
    else if (x_on_analog_en_vdda !==1 && zero_on_analog_en_vdda !==1)
    begin
        analog_en_vdda <= ANALOG_EN;
    end
    if (x_on_analog_en_vddio_q  ===1 )
    begin
        analog_en_vddio_q  <= 1'bx;
    end
    else if ( zero_on_analog_en_vddio_q ===1 )
    begin
        analog_en_vddio_q  <= 1'b0;
    end
    else if ( x_on_analog_en_vddio_q !==1 && zero_on_analog_en_vddio_q !==1)
    begin
        analog_en_vddio_q  <= ANALOG_EN;
    end
    if (x_on_analog_en_vswitch  ===1 )
    begin
        analog_en_vswitch  <= 1'bx;
    end
    else if ( zero_on_analog_en_vswitch ===1 )
    begin
        analog_en_vswitch  <= 1'b0;
    end
    else if (x_on_analog_en_vswitch !==1 && zero_on_analog_en_vswitch !==1)
    begin
        analog_en_vswitch  <= ANALOG_EN;
    end
    if ( (analog_en_vswitch ===1'bx && analog_en_vdda ===1'bx) || (analog_en_vswitch ===1'bx && analog_en_vddio_q ===1'bx) || (analog_en_vddio_q ===1'bx && analog_en_vdda ===1'bx ) )
    begin
        analog_en_final  <= 1'bx;
    end
    else if (analog_en_vdda ===1'bx && (analog_en_vddio_q ===1 ||analog_en_vswitch===1 ))
    begin
        analog_en_final  <= 1'bx;
    end
    else if (analog_en_vddio_q ===1'bx && (analog_en_vdda ===1 ||analog_en_vswitch===1 ))
    begin
        analog_en_final  <= 1'bx;
    end
    else if (analog_en_vswitch===1'bx && (analog_en_vdda ===1 || analog_en_vddio_q ===1 ))
    begin
        analog_en_final  <= 1'bx;
    end
    else if ((analog_en_vdda ===0 && analog_en_vddio_q ===0 )|| (analog_en_vdda ===0 && analog_en_vswitch===0 ) ||  (analog_en_vddio_q ===0 && analog_en_vswitch===0 ))
    begin
        analog_en_final  <=0;
    end
    else if (analog_en_vdda ===1 && analog_en_vddio_q ===1 &&  analog_en_vswitch ===1)
    begin
        analog_en_final  <=1;
    end
end
wire [2:0] amux_select = {ANALOG_SEL, ANALOG_POL, out_buf};
wire invalid_controls_amux = 	(analog_en_final===1'bx && inp_dis_final===1)
     || !pwr_good_amux
     || (analog_en_final===1 && ^amux_select[2:0] === 1'bx && inp_dis_final===1);
wire enable_pad_amuxbus_a = invalid_controls_amux  ? 1'bx : (amux_select===3'b001 || amux_select===3'b010) && (analog_en_final===1);
wire enable_pad_amuxbus_b = invalid_controls_amux  ? 1'bx : (amux_select===3'b101 || amux_select===3'b110) && (analog_en_final===1);
wire enable_pad_vssio_q   = invalid_controls_amux  ? 1'bx : (amux_select===3'b100 || amux_select===3'b000) && (analog_en_final===1);
wire enable_pad_vddio_q   = invalid_controls_amux  ? 1'bx : (amux_select===3'b011 || amux_select===3'b111) && (analog_en_final===1);
tranif1 pad_amuxbus_a 	(PAD, AMUXBUS_A, enable_pad_amuxbus_a);
tranif1 pad_amuxbus_b 	(PAD, AMUXBUS_B, enable_pad_amuxbus_b);
bufif1 pad_vddio_q	(PAD, vddio_q,   enable_pad_vddio_q);
bufif1 pad_vssio_q   	(PAD, vssio_q,   enable_pad_vssio_q);
reg dis_err_msgs;
integer msg_count_pad,msg_count_pad1,msg_count_pad2,msg_count_pad3,msg_count_pad4,msg_count_pad5,msg_count_pad6,msg_count_pad7,msg_count_pad8,msg_count_pad9,msg_count_pad10,msg_count_pad11,msg_count_pad12;
initial
begin
    dis_err_msgs = 1'b1;
    msg_count_pad  = 0;
    msg_count_pad1 = 0;
    msg_count_pad2 = 0;
    msg_count_pad3 = 0;
    msg_count_pad4 = 0;
    msg_count_pad5 = 0;
    msg_count_pad6 = 0;
    msg_count_pad7 = 0;
    msg_count_pad8 = 0;
    msg_count_pad9 = 0;
    msg_count_pad10 = 0;
    msg_count_pad11 = 0;
    msg_count_pad12  = 0;
`ifdef SKY130_FD_IO_TOP_GPIO_OVTV2_DIS_ERR_MSGS
`else
    #1;
    dis_err_msgs = 1'b0;
`endif
end
wire #100 error_enable_vddio = (ENABLE_VDDIO===0 && ENABLE_H===1);
event event_error_enable_vddio;
always @(error_enable_vddio)
begin
    if (!dis_err_msgs)
    begin
        if (error_enable_vddio===1)
        begin
            msg_count_pad = msg_count_pad + 1;
            ->event_error_enable_vddio;
            if (msg_count_pad <= MAX_WARNING_COUNT)
            begin
                $display(" ===ERROR=== sky130_fd_io__top_gpio_ovtv2 :  Enable_h (= %b) and ENABLE_VDDIO (= %b) are complement of each other. This is an illegal combination as ENABLE_VDDIO and ENABLE_H are the same input signals IN different power domains %m", ENABLE_H, ENABLE_VDDIO, $stime);
            end
            else
                if (msg_count_pad == MAX_WARNING_COUNT+1)
                begin
                    $display(" ===WARNING=== sky130_fd_io__top_gpio_ovtv2 :  Further WARNING messages will be suppressed as the message count has exceeded 100 %m",$stime);
                end
        end
    end
end
wire #100 error_vdda = ( vdda===1 && vddio_q !==1 && ENABLE_VDDA_H===1 );
event event_error_vdda;
always @(error_vdda)
begin
    if (!dis_err_msgs)
    begin
        if (error_vdda===1)
        begin
            msg_count_pad1 = msg_count_pad1 + 1;
            ->event_error_vdda;
            if (msg_count_pad1 <= MAX_WARNING_COUNT)
            begin
                $display(" ===ERROR=== sky130_fd_io__top_gpio_ovtv2 : ENABLE_VDDA_H (= %b) cannot be 1 when vdda (= %b) and vddio_q (= %b) %m",ENABLE_VDDA_H, vdda,vddio_q,$stime);
            end
            else
                if (msg_count_pad1 == MAX_WARNING_COUNT+1)
                begin
                    $display(" ===WARNING=== sky130_fd_io__top_gpio_ovtv2 :  Further WARNING messages will be suppressed as the message count has exceeded 100 %m",$stime);
                end
        end
    end
end
wire #100 error_vdda2 = ( vdda===1 && vddio_q ===1 && vswitch !==1 && ENABLE_H===1 && hld_h_n_buf ===1  &&  vccd===1 && ANALOG_EN ===1 );
event event_error_vdda2;
always @(error_vdda2)
begin
    if (!dis_err_msgs)
    begin
        if (error_vdda2===1)
        begin
            msg_count_pad2 = msg_count_pad2 + 1;
            ->event_error_vdda2;
            if (msg_count_pad2 <= MAX_WARNING_COUNT)
            begin
                $display(" ===ERROR=== sky130_fd_io__top_gpio_ovtv2 : ANALOG_EN (= %b) cannot be 1 when vdda (= %b) , vddio_q (= %b) , vswitch(= %b), ENABLE_H (= %b),hld_h_n_buf (= %b) and vccd (= %b)   %m",ANALOG_EN,vdda,vddio_q,vswitch,ENABLE_H,hld_h_n_buf,vccd,$stime);
            end
            else
                if (msg_count_pad2 == MAX_WARNING_COUNT+1)
                begin
                    $display(" ===WARNING=== sky130_fd_io__top_gpio_ovtv2 :  Further WARNING messages will be suppressed as the message count has exceeded 100 %m",$stime);
                end
        end
    end
end
wire #100 error_vdda3 =  ( vdda===1 && vddio_q ===1 && vswitch !==1 && ENABLE_H===1 && hld_h_n_buf ===1  && vccd !==1 );
event event_error_vdda3;
always @(error_vdda3)
begin
    if (!dis_err_msgs)
    begin
        if (error_vdda3===1)
        begin
            msg_count_pad3 = msg_count_pad3 + 1;
            ->event_error_vdda3;
            if (msg_count_pad3 <= MAX_WARNING_COUNT)
            begin
                $display(" ===ERROR=== sky130_fd_io__top_gpio_ovtv2 : vccd (= %b) cannot be any value other than 1 when vdda (= %b) , vddio_q (= %b) , vswitch(= %b), ENABLE_H (= %b) and hld_h_n_buf (= %b) %m",vccd,vdda,vddio_q,vswitch,ENABLE_H,hld_h_n_buf,$stime);
            end
            else
                if (msg_count_pad3 == MAX_WARNING_COUNT+1)
                begin
                    $display(" ===WARNING=== sky130_fd_io__top_gpio_ovtv2 :  Further WARNING messages will be suppressed as the message count has exceeded 100 %m",$stime);
                end
        end
    end
end
wire #100 error_vswitch1 =  (vdda !==1 && vddio_q !==1 && vswitch ===1 && (ENABLE_VSWITCH_H===1)) ;
event event_error_vswitch1;
always @(error_vswitch1)
begin
    if (!dis_err_msgs)
    begin
        if (error_vswitch1===1)
        begin
            msg_count_pad4 = msg_count_pad4 + 1;
            ->event_error_vswitch1;
            if (msg_count_pad4 <= MAX_WARNING_COUNT)
            begin
                $display(" ===ERROR=== sky130_fd_io__top_gpio_ovtv2 : ENABLE_VSWITCH_H (= %b) cannot be 1 when vdda (= %b) , vddio_q (= %b) & vswitch(= %b) %m",ENABLE_VSWITCH_H,vdda,vddio_q,vswitch,$stime);
            end
            else
                if (msg_count_pad4 == MAX_WARNING_COUNT+1)
                begin
                    $display(" ===WARNING=== sky130_fd_io__top_gpio_ovtv2 :  Further WARNING messages will be suppressed as the message count has exceeded 100 %m",$stime);
                end
        end
    end
end
wire #100 error_vswitch2 =   (vdda !==1 && vddio_q !==1 && vswitch ===1 && vccd===1 && ANALOG_EN===1);
event event_error_vswitch2;
always @(error_vswitch2)
begin
    if (!dis_err_msgs)
    begin
        if (error_vswitch2===1)
        begin
            msg_count_pad5 = msg_count_pad5 + 1;
            ->event_error_vswitch2;
            if (msg_count_pad5 <= MAX_WARNING_COUNT)
            begin
                $display(" ===ERROR=== sky130_fd_io__top_gpio_ovtv2 : ANALOG_EN (= %b) cannot be 1 when vdda (= %b) , vddio_q (= %b) , vswitch(= %b)  & vccd(= %b) %m",ANALOG_EN,vdda,vddio_q,vswitch,vccd,$stime);
            end
            else
                if (msg_count_pad5 == MAX_WARNING_COUNT+1)
                begin
                    $display(" ===WARNING=== sky130_fd_io__top_gpio_ovtv2 :  Further WARNING messages will be suppressed as the message count has exceeded 100 %m",$stime);
                end
        end
    end
end
wire #100 error_vswitch3 =   (vdda ===1 && vddio_q !==1 && vswitch ===1 && ENABLE_VSWITCH_H===1);
event event_error_vswitch3;
always @(error_vswitch3)
begin
    if (!dis_err_msgs)
    begin
        if (error_vswitch3===1)
        begin
            msg_count_pad6 = msg_count_pad6 + 1;
            ->event_error_vswitch3;
            if (msg_count_pad6 <= MAX_WARNING_COUNT)
            begin
                $display(" ===ERROR=== sky130_fd_io__top_gpio_ovtv2 : ENABLE_VSWITCH_H(= %b) cannot be 1 when vdda (= %b) , vddio_q (= %b) & vswitch(= %b) %m",ENABLE_VSWITCH_H,vdda,vddio_q,vswitch,$stime);
            end
            else
                if (msg_count_pad6 == MAX_WARNING_COUNT+1)
                begin
                    $display(" ===WARNING=== sky130_fd_io__top_gpio_ovtv2 :  Further WARNING messages will be suppressed as the message count has exceeded 100 %m",$stime);
                end
        end
    end
end
wire #100 error_vswitch4 =  (vdda !==1 && vddio_q ===1 && vswitch ===1 && ENABLE_VSWITCH_H===1);
event event_error_vswitch4;
always @(error_vswitch4)
begin
    if (!dis_err_msgs)
    begin
        if (error_vswitch4===1)
        begin
            msg_count_pad7 = msg_count_pad7 + 1;
            ->event_error_vswitch4;
            if (msg_count_pad7 <= MAX_WARNING_COUNT)
            begin
                $display(" ===ERROR=== sky130_fd_io__top_gpio_ovtv2 : ENABLE_VSWITCH_H(= %b) cannot be 1 when vdda (= %b) , vddio_q (= %b) & vswitch(= %b) %m",ENABLE_VSWITCH_H,vdda,vddio_q,vswitch,$stime);
            end
            else
                if (msg_count_pad7 == MAX_WARNING_COUNT+1)
                begin
                    $display(" ===WARNING=== sky130_fd_io__top_gpio_ovtv2 :  Further WARNING messages will be suppressed as the message count has exceeded 100 %m",$stime);
                end
        end
    end
end
wire #100 error_vswitch5 =  (vdda !==1 && vddio_q ===1 && vswitch ===1 && ENABLE_H ===1 && hld_h_n_buf ===1 && vccd ===1 && ANALOG_EN===1);
event event_error_vswitch5;
always @(error_vswitch5)
begin
    if (!dis_err_msgs)
    begin
        if (error_vswitch5===1)
        begin
            msg_count_pad8 = msg_count_pad8 + 1;
            ->event_error_vswitch5;
            if (msg_count_pad8 <= MAX_WARNING_COUNT)
            begin
                $display(" ===ERROR=== sky130_fd_io__top_gpio_ovtv2 : ANALOG_EN(= %b) cannot be 1 when vdda (= %b) , vddio_q (= %b) , vswitch(= %b),ENABLE_H (= %b),hld_h_n_buf (= %b) and vccd (= %b) %m",ANALOG_EN,vdda,vddio_q,vswitch,ENABLE_H,hld_h_n_buf,vccd,$stime);
            end
            else
                if (msg_count_pad8 == MAX_WARNING_COUNT+1)
                begin
                    $display(" ===WARNING=== sky130_fd_io__top_gpio_ovtv2 :  Further WARNING messages will be suppressed as the message count has exceeded 100 %m",$stime);
                end
        end
    end
end
wire #100 error_vddio_q1 =  (vdda !==1 && vddio_q ===1 && vswitch !==1 && ENABLE_H ===1 && hld_h_n_buf ===1 && vccd!==1);
event event_error_vddio_q1;
always @(error_vddio_q1)
begin
    if (!dis_err_msgs)
    begin
        if (error_vddio_q1===1)
        begin
            msg_count_pad9 = msg_count_pad9 + 1;
            ->event_error_vddio_q1;
            if (msg_count_pad9 <= MAX_WARNING_COUNT)
            begin
                $display(" ===ERROR=== sky130_fd_io__top_gpio_ovtv2 : vccd(= %b) cannot be any value other than 1 when vdda (= %b) , vddio_q (= %b) , vswitch(= %b),ENABLE_H (= %b) and hld_h_n_buf (= %b)  %m",vccd,vdda,vddio_q,vswitch,ENABLE_H,hld_h_n_buf,$stime);
            end
            else
                if (msg_count_pad9 == MAX_WARNING_COUNT+1)
                begin
                    $display(" ===WARNING=== sky130_fd_io__top_gpio_ovtv2 :  Further WARNING messages will be suppressed as the message count has exceeded 100 %m",$stime);
                end
        end
    end
end
wire #100 error_vddio_q2 =  (vdda !==1 && vddio_q ===1 && vswitch !==1 && ENABLE_H ===1 && hld_h_n_buf ===1 && vccd ===1 && ANALOG_EN===1);
event event_error_vddio_q2;
always @(error_vddio_q2)
begin
    if (!dis_err_msgs)
    begin
        if (error_vddio_q2===1)
        begin
            msg_count_pad10 = msg_count_pad10 + 1;
            ->event_error_vddio_q2;
            if (msg_count_pad10 <= MAX_WARNING_COUNT)
            begin
                $display(" ===ERROR=== sky130_fd_io__top_gpio_ovtv2 : ANALOG_EN(= %b) cannot be 1 when vdda (= %b) , vddio_q (= %b) , vswitch(= %b),ENABLE_H (= %b) , hld_h_n_buf (= %b) && vccd (= %b) %m",ANALOG_EN, vdda,vddio_q,vswitch,ENABLE_H,hld_h_n_buf,vccd,$stime);
            end
            else
                if (msg_count_pad10 == MAX_WARNING_COUNT+1)
                begin
                    $display(" ===WARNING=== sky130_fd_io__top_gpio_ovtv2 :  Further WARNING messages will be suppressed as the message count has exceeded 100 %m",$stime);
                end
        end
    end
end
wire #100 error_supply_good = ( vdda ===1 && vddio_q ===1 && vswitch ===1  && ENABLE_H ===1 && hld_h_n_buf ===1 && vccd ===1 &&  ANALOG_EN===1 && ENABLE_VSWITCH_H !==1 && ENABLE_VSWITCH_H !==0 );
event event_error_supply_good;
always @(error_supply_good)
begin
    if (!dis_err_msgs)
    begin
        if (error_supply_good===1)
        begin
            msg_count_pad11 = msg_count_pad11 + 1;
            ->event_error_supply_good;
            if (msg_count_pad11 <= MAX_WARNING_COUNT)
            begin
                $display(" ===ERROR=== sky130_fd_io__top_gpio_ovtv2 : ENABLE_VSWITCH_H(= %b) should be either 1 or 0 when vdda (= %b) , vddio_q (= %b) , vswitch(= %b), ENABLE_H (= %b), hld_h_n_buf (= %b) ,vccd (= %b) and ANALOG_EN(= %b)  %m",ENABLE_VSWITCH_H, vdda,vddio_q,vswitch,ENABLE_H,hld_h_n_buf,vccd,ANALOG_EN,$stime);
            end
            else
                if (msg_count_pad11 == MAX_WARNING_COUNT+1)
                begin
                    $display(" ===WARNING=== sky130_fd_io__top_gpio_ovtv2 :  Further WARNING messages will be suppressed as the message count has exceeded 100 %m",$stime);
                end
        end
    end
end
wire #100 error_vdda_vddioq_vswitch2 = ( vdda ===1 && vddio_q ===1 && vswitch ===1 && ENABLE_H ===1 && hld_h_n_buf ===1 && vccd ===1 &&  ANALOG_EN===1 && ENABLE_VDDA_H !==1 && ENABLE_VDDA_H !==0 );
event event_error_vdda_vddioq_vswitch2;
always @(error_vdda_vddioq_vswitch2)
begin
    if (!dis_err_msgs)
    begin
        if (error_vdda_vddioq_vswitch2===1)
        begin
            msg_count_pad12 = msg_count_pad12 + 1;
            ->event_error_vdda_vddioq_vswitch2;
            if (msg_count_pad12 <= MAX_WARNING_COUNT)
            begin
                $display(" ===ERROR=== sky130_fd_io__top_gpio_ovtv2 : ENABLE_VDDA_H(= %b) should be either 1 or 0 when vdda (= %b) , vddio_q (= %b) , vswitch(= %b), ENABLE_H (= %b), hld_h_n_buf (= %b) ,vccd (= %b) and ANALOG_EN(= %b)  %m",ENABLE_VDDA_H, vdda,vddio_q,vswitch,ENABLE_H,hld_h_n_buf,vccd,ANALOG_EN,$stime);
            end
            else
                if (msg_count_pad12 == MAX_WARNING_COUNT+1)
                begin
                    $display(" ===WARNING=== sky130_fd_io__top_gpio_ovtv2 :  Further WARNING messages will be suppressed as the message count has exceeded 100 %m",$stime);
                end
        end
    end
end
endmodule
`endif // FUNCTIONAL

`endif // USE_POWER_PINS

`default_nettype wire
`endif  // SKY130_FD_IO__TOP_GPIO_OVTV2_V


//--------EOF---------

/**
 * Copyright 2020 The SkyWater PDK Authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 * SPDX-License-Identifier: Apache-2.0
 */

`ifndef SKY130_FD_IO__TOP_GPIOV2_V
`define SKY130_FD_IO__TOP_GPIOV2_V

/**
 * top_gpiov2: General Purpose I/0.
 *
 * Verilog top module.
 *
 * WARNING: This file is autogenerated, do not modify directly!
 */

`timescale 1ns / 1ps
`default_nettype none

`ifdef USE_POWER_PINS

`ifdef FUNCTIONAL
/*
 * Copyright 2020 The SkyWater PDK Authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 * SPDX-License-Identifier: Apache-2.0
*/

module sky130_fd_io__top_gpiov2 (IN_H, PAD_A_NOESD_H,PAD_A_ESD_0_H,PAD_A_ESD_1_H,
                                 PAD, DM, HLD_H_N, IN, INP_DIS, IB_MODE_SEL, ENABLE_H, ENABLE_VDDA_H, ENABLE_INP_H, OE_N,
                                 TIE_HI_ESD, TIE_LO_ESD, SLOW, VTRIP_SEL, HLD_OVR, ANALOG_EN, ANALOG_SEL, ENABLE_VDDIO, ENABLE_VSWITCH_H,
                                 ANALOG_POL, OUT, AMUXBUS_A, AMUXBUS_B
                                 ,VSSA, VDDA, VSWITCH, VDDIO_Q, VCCHIB, VDDIO, VCCD, VSSIO,
                                 VSSD, VSSIO_Q
                                );
input OUT;
input OE_N;
input HLD_H_N;
input ENABLE_H;
input ENABLE_INP_H;
input ENABLE_VDDA_H;
input ENABLE_VSWITCH_H;
input ENABLE_VDDIO;
input INP_DIS;
input IB_MODE_SEL;
input VTRIP_SEL;
input SLOW;
input HLD_OVR;
input ANALOG_EN;
input ANALOG_SEL;
input ANALOG_POL;
input [2:0] DM;
inout VDDIO;
inout VDDIO_Q;
inout VDDA;
inout VCCD;
inout VSWITCH;
inout VCCHIB;
inout VSSA;
inout VSSD;
inout VSSIO_Q;
inout VSSIO;
inout PAD;
inout PAD_A_NOESD_H,PAD_A_ESD_0_H,PAD_A_ESD_1_H;
inout AMUXBUS_A;
inout AMUXBUS_B;
output IN;
output IN_H;
output TIE_HI_ESD, TIE_LO_ESD;
reg [2:0] dm_final;
reg slow_final, vtrip_sel_final, inp_dis_final, out_final, oe_n_final, hld_ovr_final, analog_en_final, ib_mode_sel_final, analog_en_vdda, analog_en_vswitch,analog_en_vddio_q;
wire [2:0] dm_buf;
wire slow_buf, vtrip_sel_buf, inp_dis_buf, out_buf, oe_n_buf, hld_ovr_buf,ib_mode_sel_buf;
wire [2:0] dm_del;
wire slow_del, vtrip_sel_del, inp_dis_del, out_del, oe_n_del, hld_ovr_del,ib_mode_sel_del;
wire hld_h_n_del;
wire hld_h_n_buf;
reg notifier_dm, notifier_slow, notifier_oe_n, notifier_out, notifier_vtrip_sel, notifier_hld_ovr, notifier_inp_dis, notifier_ib_mode_sel;
reg notifier_enable_h, notifier;
assign hld_h_n_buf 	= HLD_H_N;
assign hld_ovr_buf 	= HLD_OVR;
assign dm_buf 		= DM;
assign inp_dis_buf 	= INP_DIS;
assign vtrip_sel_buf 	= VTRIP_SEL;
assign slow_buf 	= SLOW;
assign oe_n_buf 	= OE_N;
assign out_buf 		= OUT;
assign ib_mode_sel_buf 	= IB_MODE_SEL;
wire  pwr_good_amux	       = ((hld_h_n_buf===0 || ENABLE_H===0) ? 1:(VCCD===1))  && (VSSD===0) && (VSSA===0) && (VSSIO_Q===0);
wire  pwr_good_hold_ovr_mode   = (VDDIO_Q===1) && (VDDIO===1)  && (VSSD===0)    && (VCCHIB===1);
wire  pwr_good_active_mode     = (VDDIO_Q===1) && (VDDIO===1)  && (VSSD===0)    && (VCCD===1);
wire  pwr_good_hold_mode       = (VDDIO_Q===1) && (VDDIO===1)  && (VSSD===0);
wire  pwr_good_active_mode_vdda = (VDDA===1)  && (VSSD===0)   && (VCCD===1);
wire  pwr_good_hold_mode_vdda   = (VDDA===1)    && (VSSD===0);
wire  pwr_good_inpbuff_hv       = (VDDIO_Q===1) && (VSSD===0)   && (inp_dis_final===0 && dm_final!==3'b000 && ib_mode_sel_final===1 ? VCCHIB===1 : 1);
wire  pwr_good_inpbuff_lv       = (VDDIO_Q===1) && (VSSD===0)   && (VCCHIB===1);
wire  pwr_good_output_driver    = (VDDIO===1)   && (VDDIO_Q===1)&& (VSSIO===0)   && (VSSD===0)  && (VSSA===0) ;
wire  pwr_good_analog_en_vdda   = (VDDA===1)  && (VSSD===0) && (VSSA===0) ;
wire  pwr_good_analog_en_vddio_q = (VDDIO_Q ===1)  && (VSSD===0) && (VSSA===0) ;
wire  pwr_good_analog_en_vswitch = (VSWITCH ===1)  && (VSSD===0) && (VSSA===0) ;
wire  pwr_good_amux_vccd   = ((hld_h_n_buf===0 || ENABLE_H===0) ? 1:(VCCD===1));
parameter MAX_WARNING_COUNT = 100;
wire pad_tristate = oe_n_final === 1 || dm_final === 3'b000 || dm_final === 3'b001;
wire x_on_pad  =  !pwr_good_output_driver
     || (dm_final !== 3'b000 && dm_final !== 3'b001 && oe_n_final===1'bx)
     || (^dm_final[2:0] === 1'bx && oe_n_final===1'b0)
     || (slow_final===1'bx && dm_final !== 3'b000 && dm_final !== 3'b001 && oe_n_final===1'b0);
`ifdef SKY130_FD_IO_TOP_GPIOV2_SLOW_BEHV
parameter SLOW_1_DELAY= 70;
parameter SLOW_0_DELAY= 40;
`else
parameter SLOW_1_DELAY= 0;
parameter SLOW_0_DELAY= 0;
`endif
integer slow_1_delay,slow_0_delay,slow_delay;
initial slow_1_delay = SLOW_1_DELAY;
initial slow_0_delay = SLOW_0_DELAY;
always @(*)
begin
    if (SLOW===1)
        slow_delay = slow_1_delay;
    else
        slow_delay = slow_0_delay;
end
bufif1 (pull1, strong0) #slow_delay dm2 (PAD, out_final, x_on_pad===1 ? 1'bx : (pad_tristate===0 && dm_final===3'b010));
bufif1 (strong1, pull0) #slow_delay dm3 (PAD, out_final, x_on_pad===1 ? 1'bx : (pad_tristate===0 && dm_final===3'b011));
bufif1 (highz1, strong0) #slow_delay dm4 (PAD, out_final, x_on_pad===1 ? 1'bx : (pad_tristate===0 && dm_final===3'b100));
bufif1 (strong1, highz0) #slow_delay dm5 (PAD, out_final, x_on_pad===1 ? 1'bx : (pad_tristate===0 && dm_final===3'b101));
bufif1 (strong1, strong0) #slow_delay dm6 (PAD, out_final, x_on_pad===1 ? 1'bx : (pad_tristate===0 && dm_final===3'b110));
bufif1 (pull1, pull0)  #slow_delay dm7 (PAD, out_final, x_on_pad===1 ? 1'bx : (pad_tristate===0 && dm_final===3'b111));
tran pad_esd_1 (PAD,PAD_A_NOESD_H);
tran pad_esd_2 (PAD,PAD_A_ESD_0_H);
tran pad_esd_3 (PAD,PAD_A_ESD_1_H);
wire x_on_in_hv  =  (ENABLE_H===0  && ^ENABLE_INP_H===1'bx)
     || (inp_dis_final===1'bx  && ^dm_final[2:0]!==1'bx && dm_final !== 3'b000)
     || (^ENABLE_H===1'bx)
     || (inp_dis_final===0 	       	&& ^dm_final[2:0] === 1'bx)
     || (ib_mode_sel_final===1'bx  	&& inp_dis_final===0        && dm_final !== 3'b000)
     || (^ENABLE_VDDIO===1'bx    	&& inp_dis_final===0        && dm_final !== 3'b000	&& ib_mode_sel_final===1'b1)
     || (vtrip_sel_final===1'bx    	&& inp_dis_final===0        && dm_final !== 3'b000	&& ib_mode_sel_final===1'b0);
wire x_on_in_lv  =  (ENABLE_H===0  && ^ENABLE_INP_H===1'bx)
     || (inp_dis_final===1'bx  && ^dm_final[2:0]!==1'bx && dm_final !== 3'b000)
     || (ENABLE_H===0  && ^ENABLE_VDDIO===1'bx)
     || (^ENABLE_H===1'bx)
     || (inp_dis_final===0 	       	&& ^dm_final[2:0] === 1'bx)
     || (ib_mode_sel_final===1'bx  	&& inp_dis_final===0        && dm_final !== 3'b000)
     || (^ENABLE_VDDIO===1'bx    	&& inp_dis_final===0        && dm_final !== 3'b000)
     || (vtrip_sel_final===1'bx    	&& inp_dis_final===0        && dm_final !== 3'b000	&& ib_mode_sel_final===1'b0);
wire disable_inp_buff = ENABLE_H===1 ? (dm_final===3'b000 || inp_dis_final===1) : ENABLE_INP_H===0;
assign IN_H = (x_on_in_hv===1 || pwr_good_inpbuff_hv===0) ? 1'bx : (disable_inp_buff===1 ? 0 : (^PAD===1'bx ? 1'bx : PAD));
wire disable_inp_buff_lv = ENABLE_H===1 ? (dm_final===3'b000 || inp_dis_final===1) : ENABLE_VDDIO===0;
assign IN =   (x_on_in_lv===1 || pwr_good_inpbuff_lv===0 ) ? 1'bx : (disable_inp_buff_lv===1 ? 0 : (^PAD===1'bx ? 1'bx : PAD));
assign TIE_HI_ESD = VDDIO===1'b1 ? 1'b1 : 1'bx;
assign TIE_LO_ESD = VSSIO===1'b0 ? 1'b0 : 1'bx;
wire functional_mode_amux = (pwr_good_analog_en_vdda ===1 && pwr_good_analog_en_vddio_q ===1 && pwr_good_analog_en_vswitch ===1 );
wire x_on_analog_en_vdda = (pwr_good_analog_en_vdda !==1
                            || (functional_mode_amux ==1 && (ENABLE_H !==0 && ^hld_h_n_buf === 1'bx) || (hld_h_n_buf!== 0 && ^ENABLE_H=== 1'bx) || pwr_good_amux_vccd !==1 )
                            || (functional_mode_amux ==1 && (hld_h_n_buf ===1 && ENABLE_H===1 && ^ANALOG_EN === 1'bx && ENABLE_VDDA_H ===1 && ENABLE_VSWITCH_H===1 ) || (hld_h_n_buf ===1 && ENABLE_H===1 && ANALOG_EN ===0 && ^ENABLE_VDDA_H ===1'bx) ));
wire zero_on_analog_en_vdda = ( (pwr_good_analog_en_vdda ===1 && ENABLE_VDDA_H ===0)
                                || (pwr_good_analog_en_vdda ===1 && pwr_good_analog_en_vddio_q ===1 && hld_h_n_buf===0)
                                || (pwr_good_analog_en_vdda ===1 && pwr_good_analog_en_vddio_q ===1 && ENABLE_H===0)
                                ||  (pwr_good_analog_en_vdda ===1 && pwr_good_analog_en_vddio_q ===1 && pwr_good_amux_vccd && ANALOG_EN===0) );
wire x_on_analog_en_vddio_q =  ( pwr_good_analog_en_vddio_q !==1
                                 || (functional_mode_amux ==1 && (ENABLE_H !==0 && ^hld_h_n_buf === 1'bx) || (hld_h_n_buf!== 0 && ^ENABLE_H=== 1'bx) || pwr_good_amux_vccd !==1 )
                                 || (functional_mode_amux ==1 && (hld_h_n_buf ===1 && ENABLE_H===1 && ^ANALOG_EN === 1'bx && ENABLE_VDDA_H ===1 && ENABLE_VSWITCH_H===1 ) ));
wire zero_on_analog_en_vddio_q =  ( (pwr_good_analog_en_vddio_q ===1 && hld_h_n_buf===0)
                                    || (pwr_good_analog_en_vddio_q ===1 && ENABLE_H===0)
                                    ||  (pwr_good_analog_en_vddio_q ===1 && pwr_good_amux_vccd && ANALOG_EN===0) );
wire x_on_analog_en_vswitch = (pwr_good_analog_en_vswitch !==1
                               || (functional_mode_amux ==1 && (ENABLE_H !==0 && ^hld_h_n_buf === 1'bx) || (hld_h_n_buf!== 0 && ^ENABLE_H=== 1'bx) || pwr_good_amux_vccd !==1 )
                               || (functional_mode_amux ==1 && (hld_h_n_buf ===1 && ENABLE_H===1 && ^ANALOG_EN === 1'bx && ENABLE_VDDA_H ===1 && ENABLE_VSWITCH_H===1 ) || (hld_h_n_buf ===1 && ENABLE_H===1 && ANALOG_EN ===0 && ^ENABLE_VSWITCH_H ===1'bx) ));
wire  zero_on_analog_en_vswitch =   ( (pwr_good_analog_en_vswitch ===1 && ENABLE_VSWITCH_H ===0)
                                      || (pwr_good_analog_en_vswitch ===1 && pwr_good_analog_en_vddio_q ===1 && hld_h_n_buf===0)
                                      || (pwr_good_analog_en_vswitch ===1 && pwr_good_analog_en_vddio_q ===1 && ENABLE_H===0)
                                      ||  (pwr_good_analog_en_vswitch ===1 && pwr_good_analog_en_vddio_q ===1 && pwr_good_amux_vccd && ANALOG_EN===0) );
always @(*)
begin : LATCH_dm
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode || (ENABLE_H===1 && ^hld_h_n_buf===1'bx))
    begin
        dm_final 	<= 3'bxxx;
    end
    else if (ENABLE_H===0)
    begin
        dm_final 	<= 3'b000;
    end
    else if (hld_h_n_buf===1)
    begin
        dm_final 	<= (^dm_buf[2:0]	=== 1'bx	|| !pwr_good_active_mode) ? 3'bxxx : dm_buf;
    end
end
always @(notifier_enable_h or notifier_dm)
begin
    disable LATCH_dm; dm_final <= 3'bxxx;
end
always @(*)
begin : LATCH_inp_dis
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode || (ENABLE_H===1 && ^hld_h_n_buf===1'bx))
    begin
        inp_dis_final 	<= 1'bx;
    end
    else if (ENABLE_H===0)
    begin
        inp_dis_final 	<= 1'b1;
    end
    else if (hld_h_n_buf===1)
    begin
        inp_dis_final 	<= (^inp_dis_buf === 1'bx	|| !pwr_good_active_mode) ? 1'bx : inp_dis_buf;
    end
end
always @(notifier_enable_h or notifier_inp_dis)
begin
    disable LATCH_inp_dis; inp_dis_final <= 1'bx;
end
always @(*)
begin : LATCH_vtrip_sel
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode || (ENABLE_H===1 && ^hld_h_n_buf===1'bx))
    begin
        vtrip_sel_final 	<= 1'bx;
    end
    else if (ENABLE_H===0)
    begin
        vtrip_sel_final 	<= 1'b0;
    end
    else if (hld_h_n_buf===1)
    begin
        vtrip_sel_final 	<= (^vtrip_sel_buf === 1'bx	|| !pwr_good_active_mode) ? 1'bx : vtrip_sel_buf;
    end
end
always @(notifier_enable_h or notifier_vtrip_sel)
begin
    disable LATCH_vtrip_sel; vtrip_sel_final <= 1'bx;
end
always @(*)
begin : LATCH_ib_mode_sel
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode || (ENABLE_H===1 && ^hld_h_n_buf===1'bx))
    begin
        ib_mode_sel_final 	<= 1'bx;
    end
    else if (ENABLE_H===0)
    begin
        ib_mode_sel_final 	<= 1'b0;
    end
    else if (hld_h_n_buf===1)
    begin
        ib_mode_sel_final 	<= (^ib_mode_sel_buf === 1'bx	|| !pwr_good_active_mode) ? 1'bx : ib_mode_sel_buf;
    end
end
always @(notifier_enable_h or notifier_ib_mode_sel)
begin
    disable LATCH_ib_mode_sel; ib_mode_sel_final <= 1'bx;
end
always @(*)
begin : LATCH_slow
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode || (ENABLE_H===1 && ^hld_h_n_buf===1'bx))
    begin
        slow_final 	<= 1'bx;
    end
    else if (ENABLE_H===0)
    begin
        slow_final 	<= 1'b0;
    end
    else if (hld_h_n_buf===1)
    begin
        slow_final 	<= (^slow_buf === 1'bx	|| !pwr_good_active_mode) ? 1'bx : slow_buf;
    end
end
always @(notifier_enable_h or notifier_slow)
begin
    disable LATCH_slow; slow_final <= 1'bx;
end
always @(*)
begin : LATCH_hld_ovr
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode || (ENABLE_H===1 && ^hld_h_n_buf===1'bx))
    begin
        hld_ovr_final 	<= 1'bx;
    end
    else if (ENABLE_H===0)
    begin
        hld_ovr_final 	<= 1'b0;
    end
    else if (hld_h_n_buf===1)
    begin
        hld_ovr_final 	<= (^hld_ovr_buf === 1'bx	|| !pwr_good_active_mode) ? 1'bx : hld_ovr_buf;
    end
end
always @(notifier_enable_h or notifier_hld_ovr)
begin
    disable LATCH_hld_ovr; hld_ovr_final <= 1'bx;
end
always @(*)
begin : LATCH_oe_n
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode || (ENABLE_H===1 && (^hld_h_n_buf===1'bx || (hld_h_n_buf===0 && hld_ovr_final===1'bx) || (hld_h_n_buf===1 && hld_ovr_final===1'bx))))
    begin
        oe_n_final 	<= 1'bx;
    end
    else if (ENABLE_H===0)
    begin
        oe_n_final 	<= 1'b1;
    end
    else if (hld_h_n_buf===1 || hld_ovr_final===1)
    begin
        oe_n_final  	<= (^oe_n_buf  === 1'bx  || !pwr_good_hold_ovr_mode) ? 1'bx   : oe_n_buf;
    end
end
always @(notifier_enable_h or notifier_oe_n)
begin
    disable LATCH_oe_n; oe_n_final <= 1'bx;
end
always @(*)
begin : LATCH_out
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode || (ENABLE_H===1 && (^hld_h_n_buf===1'bx ||(hld_h_n_buf===0 &&  hld_ovr_final===1'bx || (hld_h_n_buf===1 && hld_ovr_final===1'bx)))))
    begin
        out_final 	<= 1'bx;
    end
    else if (ENABLE_H===0)
    begin
        out_final 	<= 1'b1;
    end
    else if (hld_h_n_buf===1 || hld_ovr_final===1)
    begin
        out_final  	<= (^out_buf  === 1'bx  || !pwr_good_hold_ovr_mode) ? 1'bx   : out_buf;
    end
end
always @(notifier_enable_h or notifier_out)
begin
    disable LATCH_out; out_final <= 1'bx;
end
always @(*)
begin
    if (x_on_analog_en_vdda ===1 )
    begin
        analog_en_vdda <= 1'bx;
    end
    else if ( zero_on_analog_en_vdda ===1 )
    begin
        analog_en_vdda <= 1'b0;
    end
    else if (x_on_analog_en_vdda !==1 && zero_on_analog_en_vdda !==1)
    begin
        analog_en_vdda <= ANALOG_EN;
    end
    if (x_on_analog_en_vddio_q  ===1 )
    begin
        analog_en_vddio_q  <= 1'bx;
    end
    else if ( zero_on_analog_en_vddio_q ===1 )
    begin
        analog_en_vddio_q  <= 1'b0;
    end
    else if ( x_on_analog_en_vddio_q !==1 && zero_on_analog_en_vddio_q !==1)
    begin
        analog_en_vddio_q  <= ANALOG_EN;
    end
    if (x_on_analog_en_vswitch  ===1 )
    begin
        analog_en_vswitch  <= 1'bx;
    end
    else if ( zero_on_analog_en_vswitch ===1 )
    begin
        analog_en_vswitch  <= 1'b0;
    end
    else if (x_on_analog_en_vswitch !==1 && zero_on_analog_en_vswitch !==1)
    begin
        analog_en_vswitch  <= ANALOG_EN;
    end
    if ( (analog_en_vswitch ===1'bx && analog_en_vdda ===1'bx) || (analog_en_vswitch ===1'bx && analog_en_vddio_q ===1'bx) || (analog_en_vddio_q ===1'bx && analog_en_vdda ===1'bx ) )
    begin
        analog_en_final  <= 1'bx;
    end
    else if (analog_en_vdda ===1'bx && (analog_en_vddio_q ===1 ||analog_en_vswitch===1 ))
    begin
        analog_en_final  <= 1'bx;
    end
    else if (analog_en_vddio_q ===1'bx && (analog_en_vdda ===1 ||analog_en_vswitch===1 ))
    begin
        analog_en_final  <= 1'bx;
    end
    else if (analog_en_vswitch===1'bx && (analog_en_vdda ===1 || analog_en_vddio_q ===1 ))
    begin
        analog_en_final  <= 1'bx;
    end
    else if ((analog_en_vdda ===0 && analog_en_vddio_q ===0 )|| (analog_en_vdda ===0 && analog_en_vswitch===0 ) ||  (analog_en_vddio_q ===0 && analog_en_vswitch===0 ))
    begin
        analog_en_final  <=0;
    end
    else if (analog_en_vdda ===1 && analog_en_vddio_q ===1 &&  analog_en_vswitch ===1)
    begin
        analog_en_final  <=1;
    end
end
wire [2:0] amux_select = {ANALOG_SEL, ANALOG_POL, out_buf};
wire invalid_controls_amux = 	(analog_en_final===1'bx && inp_dis_final===1)
     || !pwr_good_amux
     || (analog_en_final===1 && ^amux_select[2:0] === 1'bx && inp_dis_final===1);
wire enable_pad_amuxbus_a = invalid_controls_amux  ? 1'bx : (amux_select===3'b001 || amux_select===3'b010) && (analog_en_final===1);
wire enable_pad_amuxbus_b = invalid_controls_amux  ? 1'bx : (amux_select===3'b101 || amux_select===3'b110) && (analog_en_final===1);
wire enable_pad_vssio_q   = invalid_controls_amux  ? 1'bx : (amux_select===3'b100 || amux_select===3'b000) && (analog_en_final===1);
wire enable_pad_vddio_q   = invalid_controls_amux  ? 1'bx : (amux_select===3'b011 || amux_select===3'b111) && (analog_en_final===1);
tranif1 pad_amuxbus_a 	(PAD, AMUXBUS_A, enable_pad_amuxbus_a);
tranif1 pad_amuxbus_b 	(PAD, AMUXBUS_B, enable_pad_amuxbus_b);
bufif1 pad_vddio_q	(PAD, VDDIO_Q,   enable_pad_vddio_q);
bufif1 pad_vssio_q   	(PAD, VSSIO_Q,   enable_pad_vssio_q);
reg dis_err_msgs;
integer msg_count_pad,msg_count_pad1,msg_count_pad2,msg_count_pad3,msg_count_pad4,msg_count_pad5,msg_count_pad6,msg_count_pad7,msg_count_pad8,msg_count_pad9,msg_count_pad10,msg_count_pad11,msg_count_pad12;
initial
begin
    dis_err_msgs = 1'b1;
    msg_count_pad  = 0;
    msg_count_pad1 = 0;
    msg_count_pad2 = 0;
    msg_count_pad3 = 0;
    msg_count_pad4 = 0;
    msg_count_pad5 = 0;
    msg_count_pad6 = 0;
    msg_count_pad7 = 0;
    msg_count_pad8 = 0;
    msg_count_pad9 = 0;
    msg_count_pad10 = 0;
    msg_count_pad11 = 0;
    msg_count_pad12  = 0;
`ifdef SKY130_FD_IO_TOP_GPIOV2_DIS_ERR_MSGS
`else
    #1;
    dis_err_msgs = 1'b0;
`endif
end
wire #100 error_enable_vddio = (ENABLE_VDDIO===0 && ENABLE_H===1);
event event_error_enable_vddio;
always @(error_enable_vddio)
begin
    if (!dis_err_msgs)
    begin
        if (error_enable_vddio===1)
        begin
            msg_count_pad = msg_count_pad + 1;
            ->event_error_enable_vddio;
            if (msg_count_pad <= MAX_WARNING_COUNT)
            begin
                $display(" ===ERROR=== sky130_fd_io__top_gpiov2 :  Enable_h (= %b) and ENABLE_VDDIO (= %b) are complement of each other. This is an illegal combination as ENABLE_VDDIO and ENABLE_H are the same input signals IN different power domains %m", ENABLE_H, ENABLE_VDDIO, $stime);
            end
            else
                if (msg_count_pad == MAX_WARNING_COUNT+1)
                begin
                    $display(" ===WARNING=== sky130_fd_io__top_gpiov2 :  Further WARNING messages will be suppressed as the message count has exceeded 100 %m",$stime);
                end
        end
    end
end
wire #100 error_vdda = ( VDDA===1 && VDDIO_Q !==1 && ENABLE_VDDA_H===1 );
event event_error_vdda;
always @(error_vdda)
begin
    if (!dis_err_msgs)
    begin
        if (error_vdda===1)
        begin
            msg_count_pad1 = msg_count_pad1 + 1;
            ->event_error_vdda;
            if (msg_count_pad1 <= MAX_WARNING_COUNT)
            begin
                $display(" ===ERROR=== sky130_fd_io__top_gpiov2 : ENABLE_VDDA_H (= %b) cannot be 1 when VDDA (= %b) and VDDIO_Q (= %b) %m",ENABLE_VDDA_H, VDDA,VDDIO_Q,$stime);
            end
            else
                if (msg_count_pad1 == MAX_WARNING_COUNT+1)
                begin
                    $display(" ===WARNING=== sky130_fd_io__top_gpiov2 :  Further WARNING messages will be suppressed as the message count has exceeded 100 %m",$stime);
                end
        end
    end
end
wire #100 error_vdda2 = ( VDDA===1 && VDDIO_Q ===1 && VSWITCH !==1 && ENABLE_H===1 && hld_h_n_buf ===1  &&  VCCD===1 && ANALOG_EN ===1 );
event event_error_vdda2;
always @(error_vdda2)
begin
    if (!dis_err_msgs)
    begin
        if (error_vdda2===1)
        begin
            msg_count_pad2 = msg_count_pad2 + 1;
            ->event_error_vdda2;
            if (msg_count_pad2 <= MAX_WARNING_COUNT)
            begin
                $display(" ===ERROR=== sky130_fd_io__top_gpiov2 : ANALOG_EN (= %b) cannot be 1 when VDDA (= %b) , VDDIO_Q (= %b) , VSWITCH(= %b), ENABLE_H (= %b),hld_h_n_buf (= %b) and VCCD (= %b)   %m",ANALOG_EN,VDDA,VDDIO_Q,VSWITCH,ENABLE_H,hld_h_n_buf,VCCD,$stime);
            end
            else
                if (msg_count_pad2 == MAX_WARNING_COUNT+1)
                begin
                    $display(" ===WARNING=== sky130_fd_io__top_gpiov2 :  Further WARNING messages will be suppressed as the message count has exceeded 100 %m",$stime);
                end
        end
    end
end
wire #100 error_vdda3 =  ( VDDA===1 && VDDIO_Q ===1 && VSWITCH !==1 && ENABLE_H===1 && hld_h_n_buf ===1  && VCCD !==1 );
event event_error_vdda3;
always @(error_vdda3)
begin
    if (!dis_err_msgs)
    begin
        if (error_vdda3===1)
        begin
            msg_count_pad3 = msg_count_pad3 + 1;
            ->event_error_vdda3;
            if (msg_count_pad3 <= MAX_WARNING_COUNT)
            begin
                $display(" ===ERROR=== sky130_fd_io__top_gpiov2 : VCCD (= %b) cannot be any value other than 1 when VDDA (= %b) , VDDIO_Q (= %b) , VSWITCH(= %b), ENABLE_H (= %b) and hld_h_n_buf (= %b) %m",VCCD,VDDA,VDDIO_Q,VSWITCH,ENABLE_H,hld_h_n_buf,$stime);
            end
            else
                if (msg_count_pad3 == MAX_WARNING_COUNT+1)
                begin
                    $display(" ===WARNING=== sky130_fd_io__top_gpiov2 :  Further WARNING messages will be suppressed as the message count has exceeded 100 %m",$stime);
                end
        end
    end
end
wire #100 error_vswitch1 =  (VDDA !==1 && VDDIO_Q !==1 && VSWITCH ===1 && (ENABLE_VSWITCH_H===1)) ;
event event_error_vswitch1;
always @(error_vswitch1)
begin
    if (!dis_err_msgs)
    begin
        if (error_vswitch1===1)
        begin
            msg_count_pad4 = msg_count_pad4 + 1;
            ->event_error_vswitch1;
            if (msg_count_pad4 <= MAX_WARNING_COUNT)
            begin
                $display(" ===ERROR=== sky130_fd_io__top_gpiov2 : ENABLE_VSWITCH_H (= %b) cannot be 1 when VDDA (= %b) , VDDIO_Q (= %b) & VSWITCH(= %b) %m",ENABLE_VSWITCH_H,VDDA,VDDIO_Q,VSWITCH,$stime);
            end
            else
                if (msg_count_pad4 == MAX_WARNING_COUNT+1)
                begin
                    $display(" ===WARNING=== sky130_fd_io__top_gpiov2 :  Further WARNING messages will be suppressed as the message count has exceeded 100 %m",$stime);
                end
        end
    end
end
wire #100 error_vswitch2 =   (VDDA !==1 && VDDIO_Q !==1 && VSWITCH ===1 && VCCD===1 && ANALOG_EN===1);
event event_error_vswitch2;
always @(error_vswitch2)
begin
    if (!dis_err_msgs)
    begin
        if (error_vswitch2===1)
        begin
            msg_count_pad5 = msg_count_pad5 + 1;
            ->event_error_vswitch2;
            if (msg_count_pad5 <= MAX_WARNING_COUNT)
            begin
                $display(" ===ERROR=== sky130_fd_io__top_gpiov2 : ANALOG_EN (= %b) cannot be 1 when VDDA (= %b) , VDDIO_Q (= %b) , VSWITCH(= %b)  & VCCD(= %b) %m",ANALOG_EN,VDDA,VDDIO_Q,VSWITCH,VCCD,$stime);
            end
            else
                if (msg_count_pad5 == MAX_WARNING_COUNT+1)
                begin
                    $display(" ===WARNING=== sky130_fd_io__top_gpiov2 :  Further WARNING messages will be suppressed as the message count has exceeded 100 %m",$stime);
                end
        end
    end
end
wire #100 error_vswitch3 =   (VDDA ===1 && VDDIO_Q !==1 && VSWITCH ===1 && ENABLE_VSWITCH_H===1);
event event_error_vswitch3;
always @(error_vswitch3)
begin
    if (!dis_err_msgs)
    begin
        if (error_vswitch3===1)
        begin
            msg_count_pad6 = msg_count_pad6 + 1;
            ->event_error_vswitch3;
            if (msg_count_pad6 <= MAX_WARNING_COUNT)
            begin
                $display(" ===ERROR=== sky130_fd_io__top_gpiov2 : ENABLE_VSWITCH_H(= %b) cannot be 1 when VDDA (= %b) , VDDIO_Q (= %b) & VSWITCH(= %b) %m",ENABLE_VSWITCH_H,VDDA,VDDIO_Q,VSWITCH,$stime);
            end
            else
                if (msg_count_pad6 == MAX_WARNING_COUNT+1)
                begin
                    $display(" ===WARNING=== sky130_fd_io__top_gpiov2 :  Further WARNING messages will be suppressed as the message count has exceeded 100 %m",$stime);
                end
        end
    end
end
wire #100 error_vswitch4 =  (VDDA !==1 && VDDIO_Q ===1 && VSWITCH ===1 && ENABLE_VSWITCH_H===1);
event event_error_vswitch4;
always @(error_vswitch4)
begin
    if (!dis_err_msgs)
    begin
        if (error_vswitch4===1)
        begin
            msg_count_pad7 = msg_count_pad7 + 1;
            ->event_error_vswitch4;
            if (msg_count_pad7 <= MAX_WARNING_COUNT)
            begin
                $display(" ===ERROR=== sky130_fd_io__top_gpiov2 : ENABLE_VSWITCH_H(= %b) cannot be 1 when VDDA (= %b) , VDDIO_Q (= %b) & VSWITCH(= %b) %m",ENABLE_VSWITCH_H,VDDA,VDDIO_Q,VSWITCH,$stime);
            end
            else
                if (msg_count_pad7 == MAX_WARNING_COUNT+1)
                begin
                    $display(" ===WARNING=== sky130_fd_io__top_gpiov2 :  Further WARNING messages will be suppressed as the message count has exceeded 100 %m",$stime);
                end
        end
    end
end
wire #100 error_vswitch5 =  (VDDA !==1 && VDDIO_Q ===1 && VSWITCH ===1 && ENABLE_H ===1 && hld_h_n_buf ===1 && VCCD ===1 && ANALOG_EN===1);
event event_error_vswitch5;
always @(error_vswitch5)
begin
    if (!dis_err_msgs)
    begin
        if (error_vswitch5===1)
        begin
            msg_count_pad8 = msg_count_pad8 + 1;
            ->event_error_vswitch5;
            if (msg_count_pad8 <= MAX_WARNING_COUNT)
            begin
                $display(" ===ERROR=== sky130_fd_io__top_gpiov2 : ANALOG_EN(= %b) cannot be 1 when VDDA (= %b) , VDDIO_Q (= %b) , VSWITCH(= %b),ENABLE_H (= %b),hld_h_n_buf (= %b) and VCCD (= %b) %m",ANALOG_EN,VDDA,VDDIO_Q,VSWITCH,ENABLE_H,hld_h_n_buf,VCCD,$stime);
            end
            else
                if (msg_count_pad8 == MAX_WARNING_COUNT+1)
                begin
                    $display(" ===WARNING=== sky130_fd_io__top_gpiov2 :  Further WARNING messages will be suppressed as the message count has exceeded 100 %m",$stime);
                end
        end
    end
end
wire #100 error_vddio_q1 =  (VDDA !==1 && VDDIO_Q ===1 && VSWITCH !==1 && ENABLE_H ===1 && hld_h_n_buf ===1 && VCCD!==1);
event event_error_vddio_q1;
always @(error_vddio_q1)
begin
    if (!dis_err_msgs)
    begin
        if (error_vddio_q1===1)
        begin
            msg_count_pad9 = msg_count_pad9 + 1;
            ->event_error_vddio_q1;
            if (msg_count_pad9 <= MAX_WARNING_COUNT)
            begin
                $display(" ===ERROR=== sky130_fd_io__top_gpiov2 : VCCD(= %b) cannot be any value other than 1 when VDDA (= %b) , VDDIO_Q (= %b) , VSWITCH(= %b),ENABLE_H (= %b) and hld_h_n_buf (= %b)  %m",VCCD,VDDA,VDDIO_Q,VSWITCH,ENABLE_H,hld_h_n_buf,$stime);
            end
            else
                if (msg_count_pad9 == MAX_WARNING_COUNT+1)
                begin
                    $display(" ===WARNING=== sky130_fd_io__top_gpiov2 :  Further WARNING messages will be suppressed as the message count has exceeded 100 %m",$stime);
                end
        end
    end
end
wire #100 error_vddio_q2 =  (VDDA !==1 && VDDIO_Q ===1 && VSWITCH !==1 && ENABLE_H ===1 && hld_h_n_buf ===1 && VCCD ===1 && ANALOG_EN===1);
event event_error_vddio_q2;
always @(error_vddio_q2)
begin
    if (!dis_err_msgs)
    begin
        if (error_vddio_q2===1)
        begin
            msg_count_pad10 = msg_count_pad10 + 1;
            ->event_error_vddio_q2;
            if (msg_count_pad10 <= MAX_WARNING_COUNT)
            begin
                $display(" ===ERROR=== sky130_fd_io__top_gpiov2 : ANALOG_EN(= %b) cannot be 1 when VDDA (= %b) , VDDIO_Q (= %b) , VSWITCH(= %b),ENABLE_H (= %b) , hld_h_n_buf (= %b) && VCCD (= %b) %m",ANALOG_EN, VDDA,VDDIO_Q,VSWITCH,ENABLE_H,hld_h_n_buf,VCCD,$stime);
            end
            else
                if (msg_count_pad10 == MAX_WARNING_COUNT+1)
                begin
                    $display(" ===WARNING=== sky130_fd_io__top_gpiov2 :  Further WARNING messages will be suppressed as the message count has exceeded 100 %m",$stime);
                end
        end
    end
end
wire #100 error_supply_good = ( VDDA ===1 && VDDIO_Q ===1 && VSWITCH ===1  && ENABLE_H ===1 && hld_h_n_buf ===1 && VCCD ===1 &&  ANALOG_EN===1 && ENABLE_VSWITCH_H !==1 && ENABLE_VSWITCH_H !==0 );
event event_error_supply_good;
always @(error_supply_good)
begin
    if (!dis_err_msgs)
    begin
        if (error_supply_good===1)
        begin
            msg_count_pad11 = msg_count_pad11 + 1;
            ->event_error_supply_good;
            if (msg_count_pad11 <= MAX_WARNING_COUNT)
            begin
                $display(" ===ERROR=== sky130_fd_io__top_gpiov2 : ENABLE_VSWITCH_H(= %b) should be either 1 or 0 when VDDA (= %b) , VDDIO_Q (= %b) , VSWITCH(= %b), ENABLE_H (= %b), hld_h_n_buf (= %b) ,VCCD (= %b) and ANALOG_EN(= %b)  %m",ENABLE_VSWITCH_H, VDDA,VDDIO_Q,VSWITCH,ENABLE_H,hld_h_n_buf,VCCD,ANALOG_EN,$stime);
            end
            else
                if (msg_count_pad11 == MAX_WARNING_COUNT+1)
                begin
                    $display(" ===WARNING=== sky130_fd_io__top_gpiov2 :  Further WARNING messages will be suppressed as the message count has exceeded 100 %m",$stime);
                end
        end
    end
end
wire #100 error_vdda_vddioq_vswitch2 = ( VDDA ===1 && VDDIO_Q ===1 && VSWITCH ===1 && ENABLE_H ===1 && hld_h_n_buf ===1 && VCCD ===1 &&  ANALOG_EN===1 && ENABLE_VDDA_H !==1 && ENABLE_VDDA_H !==0 );
event event_error_vdda_vddioq_vswitch2;
always @(error_vdda_vddioq_vswitch2)
begin
    if (!dis_err_msgs)
    begin
        if (error_vdda_vddioq_vswitch2===1)
        begin
            msg_count_pad12 = msg_count_pad12 + 1;
            ->event_error_vdda_vddioq_vswitch2;
            if (msg_count_pad12 <= MAX_WARNING_COUNT)
            begin
                $display(" ===ERROR=== sky130_fd_io__top_gpiov2 : ENABLE_VDDA_H(= %b) should be either 1 or 0 when VDDA (= %b) , VDDIO_Q (= %b) , VSWITCH(= %b), ENABLE_H (= %b), hld_h_n_buf (= %b) ,VCCD (= %b) and ANALOG_EN(= %b)  %m",ENABLE_VDDA_H, VDDA,VDDIO_Q,VSWITCH,ENABLE_H,hld_h_n_buf,VCCD,ANALOG_EN,$stime);
            end
            else
                if (msg_count_pad12 == MAX_WARNING_COUNT+1)
                begin
                    $display(" ===WARNING=== sky130_fd_io__top_gpiov2 :  Further WARNING messages will be suppressed as the message count has exceeded 100 %m",$stime);
                end
        end
    end
end
endmodule
`else  // FUNCTIONAL
/*
 * Copyright 2020 The SkyWater PDK Authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 * SPDX-License-Identifier: Apache-2.0
*/

module sky130_fd_io__top_gpiov2 (IN_H, PAD_A_NOESD_H,PAD_A_ESD_0_H,PAD_A_ESD_1_H,
                                 PAD, DM, HLD_H_N, IN, INP_DIS, IB_MODE_SEL, ENABLE_H, ENABLE_VDDA_H, ENABLE_INP_H, OE_N,
                                 TIE_HI_ESD, TIE_LO_ESD, SLOW, VTRIP_SEL, HLD_OVR, ANALOG_EN, ANALOG_SEL, ENABLE_VDDIO, ENABLE_VSWITCH_H,
                                 ANALOG_POL, OUT, AMUXBUS_A, AMUXBUS_B
                                 ,VSSA, VDDA, VSWITCH, VDDIO_Q, VCCHIB, VDDIO, VCCD, VSSIO,
                                 VSSD, VSSIO_Q
                                );
input OUT;
input OE_N;
input HLD_H_N;
input ENABLE_H;
input ENABLE_INP_H;
input ENABLE_VDDA_H;
input ENABLE_VSWITCH_H;
input ENABLE_VDDIO;
input INP_DIS;
input IB_MODE_SEL;
input VTRIP_SEL;
input SLOW;
input HLD_OVR;
input ANALOG_EN;
input ANALOG_SEL;
input ANALOG_POL;
input [2:0] DM;
inout VDDIO;
inout VDDIO_Q;
inout VDDA;
inout VCCD;
inout VSWITCH;
inout VCCHIB;
inout VSSA;
inout VSSD;
inout VSSIO_Q;
inout VSSIO;
inout PAD;
inout PAD_A_NOESD_H,PAD_A_ESD_0_H,PAD_A_ESD_1_H;
inout AMUXBUS_A;
inout AMUXBUS_B;
output IN;
output IN_H;
output TIE_HI_ESD, TIE_LO_ESD;
reg [2:0] dm_final;
reg slow_final, vtrip_sel_final, inp_dis_final, out_final, oe_n_final, hld_ovr_final, analog_en_final, ib_mode_sel_final, analog_en_vdda, analog_en_vswitch,analog_en_vddio_q;
wire [2:0] dm_buf;
wire slow_buf, vtrip_sel_buf, inp_dis_buf, out_buf, oe_n_buf, hld_ovr_buf,ib_mode_sel_buf;
wire [2:0] dm_del;
wire slow_del, vtrip_sel_del, inp_dis_del, out_del, oe_n_del, hld_ovr_del,ib_mode_sel_del;
wire hld_h_n_del;
wire hld_h_n_buf;
reg notifier_dm, notifier_slow, notifier_oe_n, notifier_out, notifier_vtrip_sel, notifier_hld_ovr, notifier_inp_dis, notifier_ib_mode_sel;
reg notifier_enable_h, notifier;
assign hld_h_n_buf 	= hld_h_n_del;
assign hld_ovr_buf 	= hld_ovr_del;
assign dm_buf 		= dm_del;
assign inp_dis_buf 	= inp_dis_del;
assign vtrip_sel_buf 	= vtrip_sel_del;
assign slow_buf 	= slow_del;
assign oe_n_buf 	= oe_n_del;
assign out_buf 		= out_del;
assign ib_mode_sel_buf 	= ib_mode_sel_del;
specify
    (INP_DIS => IN) = (0:0:0 , 0:0:0);
    (INP_DIS => IN_H) = (0:0:0 , 0:0:0);
    if (  IB_MODE_SEL==1'b0 & VTRIP_SEL==1'b1  ) ( PAD => IN) = (0:0:0 , 0:0:0);
    if (  IB_MODE_SEL==1'b0 & VTRIP_SEL==1'b1  ) ( PAD => IN_H) = (0:0:0 , 0:0:0);
    if (  OE_N==1'b0 & DM[2]==1'b1 & DM[1]==1'b1 & DM[0]==1'b0 & SLOW==1'b0 ) ( OUT => PAD) = (0:0:0 , 0:0:0);
    if (  OE_N==1'b0 & DM[2]==1'b1 & DM[1]==1'b1 & DM[0]==1'b0 & SLOW==1'b1 ) ( OUT => PAD) = (0:0:0 , 0:0:0);
    if (  OE_N==1'b0 & DM[2]==1'b1 & DM[1]==1'b0 & DM[0]==1'b0 & SLOW==1'b0 ) ( OUT => PAD) = (0:0:0 , 0:0:0, 0:0:0, 0:0:0, 0:0:0, 0:0:0);
    if (  OE_N==1'b0 & DM[2]==1'b1 & DM[1]==1'b1 & DM[0]==1'b1 & SLOW==1'b0 ) ( OUT => PAD ) = (0:0:0 , 0:0:0);
    if (  OE_N==1'b0 & DM[2]==1'b1 & DM[1]==1'b0 & DM[0]==1'b0 & SLOW==1'b1 ) ( OUT => PAD) = (0:0:0 , 0:0:0, 0:0:0, 0:0:0, 0:0:0, 0:0:0);
    if (  OE_N==1'b0 & DM[2]==1'b1 & DM[1]==1'b1 & DM[0]==1'b1 & SLOW==1'b1 ) ( OUT => PAD) = (0:0:0 , 0:0:0);
    if (  OE_N==1'b0 & DM[2]==1'b1 & DM[1]==1'b0 & DM[0]==1'b1 & SLOW==1'b0 ) ( OUT => PAD) = (0:0:0 , 0:0:0, 0:0:0, 0:0:0, 0:0:0, 0:0:0);
    if (  DM[2]==1'b1 & DM[1]==1'b1 & DM[0]==1'b0 & SLOW==1'b0 ) ( OE_N => PAD) = (0:0:0 , 0:0:0, 0:0:0, 0:0:0, 0:0:0, 0:0:0);
    if (  OE_N==1'b0 & DM[2]==1'b1 & DM[1]==1'b0 & DM[0]==1'b1 & SLOW==1'b1 ) ( OUT => PAD) = (0:0:0 , 0:0:0, 0:0:0, 0:0:0, 0:0:0, 0:0:0);
    if (  DM[2]==1'b1 & DM[1]==1'b1 & DM[0]==1'b0 & SLOW==1'b1 ) ( OE_N => PAD) = (0:0:0 , 0:0:0, 0:0:0, 0:0:0, 0:0:0, 0:0:0);
    if (  DM[2]==1'b1 & DM[1]==1'b0 & DM[0]==1'b0 & SLOW==1'b0 ) ( OE_N => PAD) = (0:0:0 , 0:0:0, 0:0:0, 0:0:0, 0:0:0, 0:0:0);
    if (  DM[2]==1'b1 & DM[1]==1'b1 & DM[0]==1'b1 & SLOW==1'b0 ) ( OE_N => PAD) = (0:0:0 , 0:0:0, 0:0:0, 0:0:0, 0:0:0, 0:0:0);
    if (  DM[2]==1'b1 & DM[1]==1'b0 & DM[0]==1'b0 & SLOW==1'b1 ) ( OE_N => PAD) = (0:0:0 , 0:0:0, 0:0:0, 0:0:0, 0:0:0, 0:0:0);
    if (  DM[2]==1'b1 & DM[1]==1'b1 & DM[0]==1'b1 & SLOW==1'b1 ) ( OE_N => PAD) = (0:0:0 , 0:0:0, 0:0:0, 0:0:0, 0:0:0, 0:0:0);
    if (  DM[2]==1'b1 & DM[1]==1'b0 & DM[0]==1'b1 & SLOW==1'b0 ) ( OE_N => PAD) = (0:0:0 , 0:0:0, 0:0:0, 0:0:0, 0:0:0, 0:0:0);
    if (  DM[2]==1'b1 & DM[1]==1'b0 & DM[0]==1'b1 & SLOW==1'b1 ) ( OE_N => PAD) = (0:0:0 , 0:0:0, 0:0:0, 0:0:0, 0:0:0, 0:0:0);
    if (  DM[2]==1'b0 & DM[1]==1'b1 & DM[0]==1'b0 & SLOW==1'b0 ) ( OE_N => PAD) = (0:0:0 , 0:0:0, 0:0:0, 0:0:0, 0:0:0, 0:0:0);
    if (  DM[2]==1'b0 & DM[1]==1'b1 & DM[0]==1'b0 & SLOW==1'b1 ) ( OE_N => PAD) = (0:0:0 , 0:0:0, 0:0:0, 0:0:0, 0:0:0, 0:0:0);
    if (  IB_MODE_SEL==1'b1  ) ( PAD => IN) = (0:0:0 , 0:0:0);
    if (  IB_MODE_SEL==1'b1  ) ( PAD => IN_H) = (0:0:0 , 0:0:0);
    if (  DM[2]==1'b0 & DM[1]==1'b1 & DM[0]==1'b1 & SLOW==1'b0 ) ( OE_N => PAD) = (0:0:0 , 0:0:0, 0:0:0, 0:0:0, 0:0:0, 0:0:0);
    if (  DM[2]==1'b0 & DM[1]==1'b1 & DM[0]==1'b1 & SLOW==1'b1 ) ( OE_N => PAD) = (0:0:0 , 0:0:0, 0:0:0, 0:0:0, 0:0:0, 0:0:0);
    if (  OE_N==1'b0 & DM[2]==1'b0 & DM[1]==1'b1 & DM[0]==1'b0 & SLOW==1'b0 ) ( OUT => PAD) = (0:0:0 , 0:0:0);
    if (  OE_N==1'b0 & DM[2]==1'b0 & DM[1]==1'b1 & DM[0]==1'b0 & SLOW==1'b1 ) ( OUT=>  PAD) = (0:0:0 , 0:0:0);
    if (  OE_N==1'b0 & DM[2]==1'b0 & DM[1]==1'b1 & DM[0]==1'b1 & SLOW==1'b0 ) ( OUT => PAD) = (0:0:0 , 0:0:0);
    if (  IB_MODE_SEL==1'b0 & VTRIP_SEL==1'b0  ) ( PAD => IN) = (0:0:0 , 0:0:0);
    if (  IB_MODE_SEL==1'b0 & VTRIP_SEL==1'b0  ) ( PAD => IN_H) = (0:0:0 , 0:0:0);
    if (  OE_N==1'b0 & DM[2]==1'b0 & DM[1]==1'b1 & DM[0]==1'b1 & SLOW==1'b1 ) ( OUT => PAD) = (0:0:0 , 0:0:0);
    $width  (negedge HLD_H_N,	      (15.500:0:15.500));
    $width  (posedge HLD_H_N,	      (15.500:0:15.500));
    $width  (negedge HLD_OVR,	      (15.500:0:15.500));
    $width  (posedge HLD_OVR,	      (15.500:0:15.500));
    specparam tsetup = 5;
    specparam tsetup1 = 0;
    specparam thold = 5;
    $setuphold (posedge ENABLE_H,     negedge HLD_H_N,      tsetup, thold,  notifier_enable_h);
    $setuphold (posedge ENABLE_VDDIO, posedge ENABLE_H,     tsetup1, thold,  notifier_enable_h);
    $setuphold (negedge ENABLE_H,     negedge ENABLE_VDDIO, tsetup1, thold,  notifier_enable_h);
    $setuphold (negedge HLD_H_N, posedge HLD_OVR,    tsetup, thold,  notifier_hld_ovr,   ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, hld_ovr_del);
    $setuphold (negedge HLD_H_N, negedge HLD_OVR,    tsetup, thold,  notifier_hld_ovr,   ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, hld_ovr_del);
    $setuphold (negedge HLD_H_N, posedge DM[2],      tsetup, thold,  notifier_dm,	 ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, dm_del[2]);
    $setuphold (negedge HLD_H_N, negedge DM[2],      tsetup, thold,  notifier_dm,	 ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, dm_del[2]);
    $setuphold (negedge HLD_H_N, posedge DM[1],      tsetup, thold,  notifier_dm,	 ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, dm_del[1]);
    $setuphold (negedge HLD_H_N, negedge DM[1],      tsetup, thold,  notifier_dm,	 ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, dm_del[1]);
    $setuphold (negedge HLD_H_N, posedge DM[0],      tsetup, thold,  notifier_dm,	 ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, dm_del[0]);
    $setuphold (negedge HLD_H_N, negedge DM[0],      tsetup, thold,  notifier_dm,	 ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, dm_del[0]);
    $setuphold (negedge HLD_H_N, posedge INP_DIS,    tsetup, thold,  notifier_inp_dis,   ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, inp_dis_del);
    $setuphold (negedge HLD_H_N, negedge INP_DIS,    tsetup, thold,  notifier_inp_dis,   ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, inp_dis_del);
    $setuphold (negedge HLD_H_N, posedge VTRIP_SEL,  tsetup, thold,  notifier_vtrip_sel, ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, vtrip_sel_del);
    $setuphold (negedge HLD_H_N, negedge VTRIP_SEL,  tsetup, thold,  notifier_vtrip_sel, ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, vtrip_sel_del);
    $setuphold (negedge HLD_H_N, posedge SLOW,       tsetup, thold,  notifier_slow,	 ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, slow_del);
    $setuphold (negedge HLD_H_N, negedge SLOW,       tsetup, thold,  notifier_slow,	 ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, slow_del);
    $setuphold (negedge HLD_H_N, posedge OE_N,       tsetup, thold,  notifier_oe_n,	 ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, oe_n_del);
    $setuphold (negedge HLD_H_N, negedge OE_N,       tsetup, thold,  notifier_oe_n,	 ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, oe_n_del);
    $setuphold (negedge HLD_H_N, posedge OUT,        tsetup, thold,  notifier_out,	 ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, out_del);
    $setuphold (negedge HLD_H_N, negedge OUT,        tsetup, thold,  notifier_out,	 ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, out_del);
    $setuphold (negedge HLD_H_N, posedge IB_MODE_SEL,tsetup, thold,  notifier_ib_mode_sel,ENABLE_H==1'b1,ENABLE_H==1'b1, hld_h_n_del,ib_mode_sel_del);
    $setuphold (negedge HLD_H_N, negedge IB_MODE_SEL,tsetup, thold,  notifier_ib_mode_sel,ENABLE_H==1'b1,ENABLE_H==1'b1, hld_h_n_del,ib_mode_sel_del);
    $setuphold (posedge HLD_H_N, posedge HLD_OVR,    tsetup, thold,  notifier_hld_ovr,   ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, hld_ovr_del);
    $setuphold (posedge HLD_H_N, negedge HLD_OVR,    tsetup, thold,  notifier_hld_ovr,   ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, hld_ovr_del);
    $setuphold (posedge HLD_H_N, posedge DM[2],      tsetup, thold,  notifier_dm,	 ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, dm_del[2]);
    $setuphold (posedge HLD_H_N, negedge DM[2],      tsetup, thold,  notifier_dm,	 ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, dm_del[2]);
    $setuphold (posedge HLD_H_N, posedge DM[1],      tsetup, thold,  notifier_dm,	 ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, dm_del[1]);
    $setuphold (posedge HLD_H_N, negedge DM[1],      tsetup, thold,  notifier_dm,	 ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, dm_del[1]);
    $setuphold (posedge HLD_H_N, posedge DM[0],      tsetup, thold,  notifier_dm,	 ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, dm_del[0]);
    $setuphold (posedge HLD_H_N, negedge DM[0],      tsetup, thold,  notifier_dm,	 ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, dm_del[0]);
    $setuphold (posedge HLD_H_N, posedge INP_DIS,    tsetup, thold,  notifier_inp_dis,   ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, inp_dis_del);
    $setuphold (posedge HLD_H_N, negedge INP_DIS,    tsetup, thold,  notifier_inp_dis,   ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, inp_dis_del);
    $setuphold (posedge HLD_H_N, posedge VTRIP_SEL,  tsetup, thold,  notifier_vtrip_sel, ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, vtrip_sel_del);
    $setuphold (posedge HLD_H_N, negedge VTRIP_SEL,  tsetup, thold,  notifier_vtrip_sel, ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, vtrip_sel_del);
    $setuphold (posedge HLD_H_N, posedge SLOW,       tsetup, thold,  notifier_slow,	 ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, slow_del);
    $setuphold (posedge HLD_H_N, negedge SLOW,       tsetup, thold,  notifier_slow,	 ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, slow_del);
    $setuphold (posedge HLD_H_N, posedge OE_N,       tsetup, thold,  notifier_oe_n,	 ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, oe_n_del);
    $setuphold (posedge HLD_H_N, negedge OE_N,       tsetup, thold,  notifier_oe_n,	 ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, oe_n_del);
    $setuphold (posedge HLD_H_N, posedge OUT,        tsetup, thold,  notifier_out,	 ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, out_del);
    $setuphold (posedge HLD_H_N, negedge OUT,        tsetup, thold,  notifier_out,	 ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, out_del);
    $setuphold (posedge HLD_H_N, posedge IB_MODE_SEL,tsetup, thold,  notifier_ib_mode_sel,ENABLE_H==1'b1,ENABLE_H==1'b1,hld_h_n_del,ib_mode_sel_del);
    $setuphold (posedge HLD_H_N, negedge IB_MODE_SEL,tsetup, thold,  notifier_ib_mode_sel,ENABLE_H==1'b1,ENABLE_H==1'b1,hld_h_n_del,ib_mode_sel_del);
    $setuphold (posedge HLD_OVR,    negedge HLD_H_N, tsetup, thold,  notifier_hld_ovr,	ENABLE_H==1'b1, ENABLE_H==1'b1,  hld_ovr_del, 	hld_h_n_del);
    $setuphold (posedge DM[2],      negedge HLD_H_N, tsetup, thold,  notifier_dm,	ENABLE_H==1'b1, ENABLE_H==1'b1,  dm_del[2], 	hld_h_n_del);
    $setuphold (posedge DM[1],      negedge HLD_H_N, tsetup, thold,  notifier_dm,	ENABLE_H==1'b1, ENABLE_H==1'b1,  dm_del[1], 	hld_h_n_del);
    $setuphold (posedge DM[0],      negedge HLD_H_N, tsetup, thold,  notifier_dm,	ENABLE_H==1'b1, ENABLE_H==1'b1,  dm_del[0], 	hld_h_n_del);
    $setuphold (posedge INP_DIS,    negedge HLD_H_N, tsetup, thold,  notifier_inp_dis,	ENABLE_H==1'b1, ENABLE_H==1'b1,  inp_dis_del, 	hld_h_n_del);
    $setuphold (posedge VTRIP_SEL,  negedge HLD_H_N, tsetup, thold,  notifier_vtrip_sel, ENABLE_H==1'b1, ENABLE_H==1'b1, vtrip_sel_del, hld_h_n_del);
    $setuphold (posedge SLOW,	    negedge HLD_H_N, tsetup, thold,  notifier_slow,	ENABLE_H==1'b1, ENABLE_H==1'b1,  slow_del, 	hld_h_n_del);
    $setuphold (posedge OE_N,	    negedge HLD_H_N, tsetup, thold,  notifier_oe_n,	ENABLE_H==1'b1, ENABLE_H==1'b1,  oe_n_del, 	hld_h_n_del);
    $setuphold (posedge OUT,	    negedge HLD_H_N, tsetup, thold,  notifier_out,	ENABLE_H==1'b1, ENABLE_H==1'b1,  out_del, 	hld_h_n_del);
    $setuphold (posedge IB_MODE_SEL,negedge HLD_H_N, tsetup, thold,  notifier_ib_mode_sel,ENABLE_H==1'b1,ENABLE_H==1'b1, ib_mode_sel_del, hld_h_n_del);
endspecify
wire  pwr_good_amux	       = ((hld_h_n_buf===0 || ENABLE_H===0) ? 1:(VCCD===1))  && (VSSD===0) && (VSSA===0) && (VSSIO_Q===0);
wire  pwr_good_hold_ovr_mode   = (VDDIO_Q===1) && (VDDIO===1)  && (VSSD===0)    && (VCCHIB===1);
wire  pwr_good_active_mode     = (VDDIO_Q===1) && (VDDIO===1)  && (VSSD===0)    && (VCCD===1);
wire  pwr_good_hold_mode       = (VDDIO_Q===1) && (VDDIO===1)  && (VSSD===0);
wire  pwr_good_active_mode_vdda = (VDDA===1)  && (VSSD===0)   && (VCCD===1);
wire  pwr_good_hold_mode_vdda   = (VDDA===1)    && (VSSD===0);
wire  pwr_good_inpbuff_hv       = (VDDIO_Q===1) && (VSSD===0)   && (inp_dis_final===0 && dm_final!==3'b000 && ib_mode_sel_final===1 ? VCCHIB===1 : 1);
wire  pwr_good_inpbuff_lv       = (VDDIO_Q===1) && (VSSD===0)   && (VCCHIB===1);
wire  pwr_good_output_driver    = (VDDIO===1)   && (VDDIO_Q===1)&& (VSSIO===0)   && (VSSD===0)  && (VSSA===0) ;
wire  pwr_good_analog_en_vdda   = (VDDA===1)  && (VSSD===0) && (VSSA===0) ;
wire  pwr_good_analog_en_vddio_q = (VDDIO_Q ===1)  && (VSSD===0) && (VSSA===0) ;
wire  pwr_good_analog_en_vswitch = (VSWITCH ===1)  && (VSSD===0) && (VSSA===0) ;
wire  pwr_good_amux_vccd   = ((hld_h_n_buf===0 || ENABLE_H===0) ? 1:(VCCD===1));
parameter MAX_WARNING_COUNT = 100;
wire pad_tristate = oe_n_final === 1 || dm_final === 3'b000 || dm_final === 3'b001;
wire x_on_pad  =  !pwr_good_output_driver
     || (dm_final !== 3'b000 && dm_final !== 3'b001 && oe_n_final===1'bx)
     || (^dm_final[2:0] === 1'bx && oe_n_final===1'b0)
     || (slow_final===1'bx && dm_final !== 3'b000 && dm_final !== 3'b001 && oe_n_final===1'b0);
`ifdef SKY130_FD_IO_TOP_GPIOV2_SLOW_BEHV
parameter SLOW_1_DELAY= 70;
parameter SLOW_0_DELAY= 40;
`else
parameter SLOW_1_DELAY= 0;
parameter SLOW_0_DELAY= 0;
`endif
integer slow_1_delay,slow_0_delay,slow_delay;
initial slow_1_delay = SLOW_1_DELAY;
initial slow_0_delay = SLOW_0_DELAY;
always @(*)
begin
    if (SLOW===1)
        slow_delay = slow_1_delay;
    else
        slow_delay = slow_0_delay;
end
bufif1 (pull1, strong0) #slow_delay dm2 (PAD, out_final, x_on_pad===1 ? 1'bx : (pad_tristate===0 && dm_final===3'b010));
bufif1 (strong1, pull0) #slow_delay dm3 (PAD, out_final, x_on_pad===1 ? 1'bx : (pad_tristate===0 && dm_final===3'b011));
bufif1 (highz1, strong0) #slow_delay dm4 (PAD, out_final, x_on_pad===1 ? 1'bx : (pad_tristate===0 && dm_final===3'b100));
bufif1 (strong1, highz0) #slow_delay dm5 (PAD, out_final, x_on_pad===1 ? 1'bx : (pad_tristate===0 && dm_final===3'b101));
bufif1 (strong1, strong0) #slow_delay dm6 (PAD, out_final, x_on_pad===1 ? 1'bx : (pad_tristate===0 && dm_final===3'b110));
bufif1 (pull1, pull0)  #slow_delay dm7 (PAD, out_final, x_on_pad===1 ? 1'bx : (pad_tristate===0 && dm_final===3'b111));
tran pad_esd_1 (PAD,PAD_A_NOESD_H);
tran pad_esd_2 (PAD,PAD_A_ESD_0_H);
tran pad_esd_3 (PAD,PAD_A_ESD_1_H);
wire x_on_in_hv  =  (ENABLE_H===0  && ^ENABLE_INP_H===1'bx)
     || (inp_dis_final===1'bx  && ^dm_final[2:0]!==1'bx && dm_final !== 3'b000)
     || (^ENABLE_H===1'bx)
     || (inp_dis_final===0 	       	&& ^dm_final[2:0] === 1'bx)
     || (ib_mode_sel_final===1'bx  	&& inp_dis_final===0        && dm_final !== 3'b000)
     || (^ENABLE_VDDIO===1'bx    	&& inp_dis_final===0        && dm_final !== 3'b000	&& ib_mode_sel_final===1'b1)
     || (vtrip_sel_final===1'bx    	&& inp_dis_final===0        && dm_final !== 3'b000	&& ib_mode_sel_final===1'b0);
wire x_on_in_lv  =  (ENABLE_H===0  && ^ENABLE_INP_H===1'bx)
     || (inp_dis_final===1'bx  && ^dm_final[2:0]!==1'bx && dm_final !== 3'b000)
     || (ENABLE_H===0  && ^ENABLE_VDDIO===1'bx)
     || (^ENABLE_H===1'bx)
     || (inp_dis_final===0 	       	&& ^dm_final[2:0] === 1'bx)
     || (ib_mode_sel_final===1'bx  	&& inp_dis_final===0        && dm_final !== 3'b000)
     || (^ENABLE_VDDIO===1'bx    	&& inp_dis_final===0        && dm_final !== 3'b000)
     || (vtrip_sel_final===1'bx    	&& inp_dis_final===0        && dm_final !== 3'b000	&& ib_mode_sel_final===1'b0);
wire disable_inp_buff = ENABLE_H===1 ? (dm_final===3'b000 || inp_dis_final===1) : ENABLE_INP_H===0;
assign IN_H = (x_on_in_hv===1 || pwr_good_inpbuff_hv===0) ? 1'bx : (disable_inp_buff===1 ? 0 : (^PAD===1'bx ? 1'bx : PAD));
wire disable_inp_buff_lv = ENABLE_H===1 ? (dm_final===3'b000 || inp_dis_final===1) : ENABLE_VDDIO===0;
assign IN =   (x_on_in_lv===1 || pwr_good_inpbuff_lv===0 ) ? 1'bx : (disable_inp_buff_lv===1 ? 0 : (^PAD===1'bx ? 1'bx : PAD));
assign TIE_HI_ESD = VDDIO===1'b1 ? 1'b1 : 1'bx;
assign TIE_LO_ESD = VSSIO===1'b0 ? 1'b0 : 1'bx;
wire timing_mode_amux = (pwr_good_analog_en_vdda ===1 && pwr_good_analog_en_vddio_q ===1 && pwr_good_analog_en_vswitch ===1 );
wire x_on_analog_en_vdda = (pwr_good_analog_en_vdda !==1
                            || (timing_mode_amux ==1 && (ENABLE_H !==0 && ^hld_h_n_buf === 1'bx) || (hld_h_n_buf!== 0 && ^ENABLE_H=== 1'bx) || pwr_good_amux_vccd !==1 )
                            || (timing_mode_amux ==1 && (hld_h_n_buf ===1 && ENABLE_H===1 && ^ANALOG_EN === 1'bx && ENABLE_VDDA_H ===1 && ENABLE_VSWITCH_H===1 ) || (hld_h_n_buf ===1 && ENABLE_H===1 && ANALOG_EN ===0 && ^ENABLE_VDDA_H ===1'bx) ));
wire zero_on_analog_en_vdda = ( (pwr_good_analog_en_vdda ===1 && ENABLE_VDDA_H ===0)
                                || (pwr_good_analog_en_vdda ===1 && pwr_good_analog_en_vddio_q ===1 && hld_h_n_buf===0)
                                || (pwr_good_analog_en_vdda ===1 && pwr_good_analog_en_vddio_q ===1 && ENABLE_H===0)
                                ||  (pwr_good_analog_en_vdda ===1 && pwr_good_analog_en_vddio_q ===1 && pwr_good_amux_vccd && ANALOG_EN===0) );
wire x_on_analog_en_vddio_q =  ( pwr_good_analog_en_vddio_q !==1
                                 || (timing_mode_amux ==1 && (ENABLE_H !==0 && ^hld_h_n_buf === 1'bx) || (hld_h_n_buf!== 0 && ^ENABLE_H=== 1'bx) || pwr_good_amux_vccd !==1 )
                                 || (timing_mode_amux ==1 && (hld_h_n_buf ===1 && ENABLE_H===1 && ^ANALOG_EN === 1'bx && ENABLE_VDDA_H ===1 && ENABLE_VSWITCH_H===1 ) ));
wire zero_on_analog_en_vddio_q =  ( (pwr_good_analog_en_vddio_q ===1 && hld_h_n_buf===0)
                                    || (pwr_good_analog_en_vddio_q ===1 && ENABLE_H===0)
                                    ||  (pwr_good_analog_en_vddio_q ===1 && pwr_good_amux_vccd && ANALOG_EN===0) );
wire x_on_analog_en_vswitch = (pwr_good_analog_en_vswitch !==1
                               || (timing_mode_amux ==1 && (ENABLE_H !==0 && ^hld_h_n_buf === 1'bx) || (hld_h_n_buf!== 0 && ^ENABLE_H=== 1'bx) || pwr_good_amux_vccd !==1 )
                               || (timing_mode_amux ==1 && (hld_h_n_buf ===1 && ENABLE_H===1 && ^ANALOG_EN === 1'bx && ENABLE_VDDA_H ===1 && ENABLE_VSWITCH_H===1 ) || (hld_h_n_buf ===1 && ENABLE_H===1 && ANALOG_EN ===0 && ^ENABLE_VSWITCH_H ===1'bx) ));
wire  zero_on_analog_en_vswitch =   ( (pwr_good_analog_en_vswitch ===1 && ENABLE_VSWITCH_H ===0)
                                      || (pwr_good_analog_en_vswitch ===1 && pwr_good_analog_en_vddio_q ===1 && hld_h_n_buf===0)
                                      || (pwr_good_analog_en_vswitch ===1 && pwr_good_analog_en_vddio_q ===1 && ENABLE_H===0)
                                      ||  (pwr_good_analog_en_vswitch ===1 && pwr_good_analog_en_vddio_q ===1 && pwr_good_amux_vccd && ANALOG_EN===0) );
always @(*)
begin : LATCH_dm
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode || (ENABLE_H===1 && ^hld_h_n_buf===1'bx))
    begin
        dm_final 	<= 3'bxxx;
    end
    else if (ENABLE_H===0)
    begin
        dm_final 	<= 3'b000;
    end
    else if (hld_h_n_buf===1)
    begin
        dm_final 	<= (^dm_buf[2:0]	=== 1'bx	|| !pwr_good_active_mode) ? 3'bxxx : dm_buf;
    end
end
always @(notifier_enable_h or notifier_dm)
begin
    disable LATCH_dm; dm_final <= 3'bxxx;
end
always @(*)
begin : LATCH_inp_dis
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode || (ENABLE_H===1 && ^hld_h_n_buf===1'bx))
    begin
        inp_dis_final 	<= 1'bx;
    end
    else if (ENABLE_H===0)
    begin
        inp_dis_final 	<= 1'b1;
    end
    else if (hld_h_n_buf===1)
    begin
        inp_dis_final 	<= (^inp_dis_buf === 1'bx	|| !pwr_good_active_mode) ? 1'bx : inp_dis_buf;
    end
end
always @(notifier_enable_h or notifier_inp_dis)
begin
    disable LATCH_inp_dis; inp_dis_final <= 1'bx;
end
always @(*)
begin : LATCH_vtrip_sel
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode || (ENABLE_H===1 && ^hld_h_n_buf===1'bx))
    begin
        vtrip_sel_final 	<= 1'bx;
    end
    else if (ENABLE_H===0)
    begin
        vtrip_sel_final 	<= 1'b0;
    end
    else if (hld_h_n_buf===1)
    begin
        vtrip_sel_final 	<= (^vtrip_sel_buf === 1'bx	|| !pwr_good_active_mode) ? 1'bx : vtrip_sel_buf;
    end
end
always @(notifier_enable_h or notifier_vtrip_sel)
begin
    disable LATCH_vtrip_sel; vtrip_sel_final <= 1'bx;
end
always @(*)
begin : LATCH_ib_mode_sel
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode || (ENABLE_H===1 && ^hld_h_n_buf===1'bx))
    begin
        ib_mode_sel_final 	<= 1'bx;
    end
    else if (ENABLE_H===0)
    begin
        ib_mode_sel_final 	<= 1'b0;
    end
    else if (hld_h_n_buf===1)
    begin
        ib_mode_sel_final 	<= (^ib_mode_sel_buf === 1'bx	|| !pwr_good_active_mode) ? 1'bx : ib_mode_sel_buf;
    end
end
always @(notifier_enable_h or notifier_ib_mode_sel)
begin
    disable LATCH_ib_mode_sel; ib_mode_sel_final <= 1'bx;
end
always @(*)
begin : LATCH_slow
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode || (ENABLE_H===1 && ^hld_h_n_buf===1'bx))
    begin
        slow_final 	<= 1'bx;
    end
    else if (ENABLE_H===0)
    begin
        slow_final 	<= 1'b0;
    end
    else if (hld_h_n_buf===1)
    begin
        slow_final 	<= (^slow_buf === 1'bx	|| !pwr_good_active_mode) ? 1'bx : slow_buf;
    end
end
always @(notifier_enable_h or notifier_slow)
begin
    disable LATCH_slow; slow_final <= 1'bx;
end
always @(*)
begin : LATCH_hld_ovr
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode || (ENABLE_H===1 && ^hld_h_n_buf===1'bx))
    begin
        hld_ovr_final 	<= 1'bx;
    end
    else if (ENABLE_H===0)
    begin
        hld_ovr_final 	<= 1'b0;
    end
    else if (hld_h_n_buf===1)
    begin
        hld_ovr_final 	<= (^hld_ovr_buf === 1'bx	|| !pwr_good_active_mode) ? 1'bx : hld_ovr_buf;
    end
end
always @(notifier_enable_h or notifier_hld_ovr)
begin
    disable LATCH_hld_ovr; hld_ovr_final <= 1'bx;
end
always @(*)
begin : LATCH_oe_n
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode || (ENABLE_H===1 && (^hld_h_n_buf===1'bx || (hld_h_n_buf===0 && hld_ovr_final===1'bx) || (hld_h_n_buf===1 && hld_ovr_final===1'bx))))
    begin
        oe_n_final 	<= 1'bx;
    end
    else if (ENABLE_H===0)
    begin
        oe_n_final 	<= 1'b1;
    end
    else if (hld_h_n_buf===1 || hld_ovr_final===1)
    begin
        oe_n_final  	<= (^oe_n_buf  === 1'bx  || !pwr_good_hold_ovr_mode) ? 1'bx   : oe_n_buf;
    end
end
always @(notifier_enable_h or notifier_oe_n)
begin
    disable LATCH_oe_n; oe_n_final <= 1'bx;
end
always @(*)
begin : LATCH_out
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode || (ENABLE_H===1 && (^hld_h_n_buf===1'bx ||(hld_h_n_buf===0 &&  hld_ovr_final===1'bx || (hld_h_n_buf===1 && hld_ovr_final===1'bx)))))
    begin
        out_final 	<= 1'bx;
    end
    else if (ENABLE_H===0)
    begin
        out_final 	<= 1'b1;
    end
    else if (hld_h_n_buf===1 || hld_ovr_final===1)
    begin
        out_final  	<= (^out_buf  === 1'bx  || !pwr_good_hold_ovr_mode) ? 1'bx   : out_buf;
    end
end
always @(notifier_enable_h or notifier_out)
begin
    disable LATCH_out; out_final <= 1'bx;
end
always @(*)
begin
    if (x_on_analog_en_vdda ===1 )
    begin
        analog_en_vdda <= 1'bx;
    end
    else if ( zero_on_analog_en_vdda ===1 )
    begin
        analog_en_vdda <= 1'b0;
    end
    else if (x_on_analog_en_vdda !==1 && zero_on_analog_en_vdda !==1)
    begin
        analog_en_vdda <= ANALOG_EN;
    end
    if (x_on_analog_en_vddio_q  ===1 )
    begin
        analog_en_vddio_q  <= 1'bx;
    end
    else if ( zero_on_analog_en_vddio_q ===1 )
    begin
        analog_en_vddio_q  <= 1'b0;
    end
    else if ( x_on_analog_en_vddio_q !==1 && zero_on_analog_en_vddio_q !==1)
    begin
        analog_en_vddio_q  <= ANALOG_EN;
    end
    if (x_on_analog_en_vswitch  ===1 )
    begin
        analog_en_vswitch  <= 1'bx;
    end
    else if ( zero_on_analog_en_vswitch ===1 )
    begin
        analog_en_vswitch  <= 1'b0;
    end
    else if (x_on_analog_en_vswitch !==1 && zero_on_analog_en_vswitch !==1)
    begin
        analog_en_vswitch  <= ANALOG_EN;
    end
    if ( (analog_en_vswitch ===1'bx && analog_en_vdda ===1'bx) || (analog_en_vswitch ===1'bx && analog_en_vddio_q ===1'bx) || (analog_en_vddio_q ===1'bx && analog_en_vdda ===1'bx ) )
    begin
        analog_en_final  <= 1'bx;
    end
    else if (analog_en_vdda ===1'bx && (analog_en_vddio_q ===1 ||analog_en_vswitch===1 ))
    begin
        analog_en_final  <= 1'bx;
    end
    else if (analog_en_vddio_q ===1'bx && (analog_en_vdda ===1 ||analog_en_vswitch===1 ))
    begin
        analog_en_final  <= 1'bx;
    end
    else if (analog_en_vswitch===1'bx && (analog_en_vdda ===1 || analog_en_vddio_q ===1 ))
    begin
        analog_en_final  <= 1'bx;
    end
    else if ((analog_en_vdda ===0 && analog_en_vddio_q ===0 )|| (analog_en_vdda ===0 && analog_en_vswitch===0 ) ||  (analog_en_vddio_q ===0 && analog_en_vswitch===0 ))
    begin
        analog_en_final  <=0;
    end
    else if (analog_en_vdda ===1 && analog_en_vddio_q ===1 &&  analog_en_vswitch ===1)
    begin
        analog_en_final  <=1;
    end
end
wire [2:0] amux_select = {ANALOG_SEL, ANALOG_POL, out_buf};
wire invalid_controls_amux = 	(analog_en_final===1'bx && inp_dis_final===1)
     || !pwr_good_amux
     || (analog_en_final===1 && ^amux_select[2:0] === 1'bx && inp_dis_final===1);
wire enable_pad_amuxbus_a = invalid_controls_amux  ? 1'bx : (amux_select===3'b001 || amux_select===3'b010) && (analog_en_final===1);
wire enable_pad_amuxbus_b = invalid_controls_amux  ? 1'bx : (amux_select===3'b101 || amux_select===3'b110) && (analog_en_final===1);
wire enable_pad_vssio_q   = invalid_controls_amux  ? 1'bx : (amux_select===3'b100 || amux_select===3'b000) && (analog_en_final===1);
wire enable_pad_vddio_q   = invalid_controls_amux  ? 1'bx : (amux_select===3'b011 || amux_select===3'b111) && (analog_en_final===1);
tranif1 pad_amuxbus_a 	(PAD, AMUXBUS_A, enable_pad_amuxbus_a);
tranif1 pad_amuxbus_b 	(PAD, AMUXBUS_B, enable_pad_amuxbus_b);
bufif1 pad_vddio_q	(PAD, VDDIO_Q,   enable_pad_vddio_q);
bufif1 pad_vssio_q   	(PAD, VSSIO_Q,   enable_pad_vssio_q);
reg dis_err_msgs;
integer msg_count_pad,msg_count_pad1,msg_count_pad2,msg_count_pad3,msg_count_pad4,msg_count_pad5,msg_count_pad6,msg_count_pad7,msg_count_pad8,msg_count_pad9,msg_count_pad10,msg_count_pad11,msg_count_pad12;
initial
begin
    dis_err_msgs = 1'b1;
    msg_count_pad  = 0;
    msg_count_pad1 = 0;
    msg_count_pad2 = 0;
    msg_count_pad3 = 0;
    msg_count_pad4 = 0;
    msg_count_pad5 = 0;
    msg_count_pad6 = 0;
    msg_count_pad7 = 0;
    msg_count_pad8 = 0;
    msg_count_pad9 = 0;
    msg_count_pad10 = 0;
    msg_count_pad11 = 0;
    msg_count_pad12  = 0;
`ifdef SKY130_FD_IO_TOP_GPIOV2_DIS_ERR_MSGS
`else
    #1;
    dis_err_msgs = 1'b0;
`endif
end
wire #100 error_enable_vddio = (ENABLE_VDDIO===0 && ENABLE_H===1);
event event_error_enable_vddio;
always @(error_enable_vddio)
begin
    if (!dis_err_msgs)
    begin
        if (error_enable_vddio===1)
        begin
            msg_count_pad = msg_count_pad + 1;
            ->event_error_enable_vddio;
            if (msg_count_pad <= MAX_WARNING_COUNT)
            begin
                $display(" ===ERROR=== sky130_fd_io__top_gpiov2 :  Enable_h (= %b) and ENABLE_VDDIO (= %b) are complement of each other. This is an illegal combination as ENABLE_VDDIO and ENABLE_H are the same input signals IN different power domains %m", ENABLE_H, ENABLE_VDDIO, $stime);
            end
            else
                if (msg_count_pad == MAX_WARNING_COUNT+1)
                begin
                    $display(" ===WARNING=== sky130_fd_io__top_gpiov2 :  Further WARNING messages will be suppressed as the message count has exceeded 100 %m",$stime);
                end
        end
    end
end
wire #100 error_vdda = ( VDDA===1 && VDDIO_Q !==1 && ENABLE_VDDA_H===1 );
event event_error_vdda;
always @(error_vdda)
begin
    if (!dis_err_msgs)
    begin
        if (error_vdda===1)
        begin
            msg_count_pad1 = msg_count_pad1 + 1;
            ->event_error_vdda;
            if (msg_count_pad1 <= MAX_WARNING_COUNT)
            begin
                $display(" ===ERROR=== sky130_fd_io__top_gpiov2 : ENABLE_VDDA_H (= %b) cannot be 1 when VDDA (= %b) and VDDIO_Q (= %b) %m",ENABLE_VDDA_H, VDDA,VDDIO_Q,$stime);
            end
            else
                if (msg_count_pad1 == MAX_WARNING_COUNT+1)
                begin
                    $display(" ===WARNING=== sky130_fd_io__top_gpiov2 :  Further WARNING messages will be suppressed as the message count has exceeded 100 %m",$stime);
                end
        end
    end
end
wire #100 error_vdda2 = ( VDDA===1 && VDDIO_Q ===1 && VSWITCH !==1 && ENABLE_H===1 && hld_h_n_buf ===1  &&  VCCD===1 && ANALOG_EN ===1 );
event event_error_vdda2;
always @(error_vdda2)
begin
    if (!dis_err_msgs)
    begin
        if (error_vdda2===1)
        begin
            msg_count_pad2 = msg_count_pad2 + 1;
            ->event_error_vdda2;
            if (msg_count_pad2 <= MAX_WARNING_COUNT)
            begin
                $display(" ===ERROR=== sky130_fd_io__top_gpiov2 : ANALOG_EN (= %b) cannot be 1 when VDDA (= %b) , VDDIO_Q (= %b) , VSWITCH(= %b), ENABLE_H (= %b),hld_h_n_buf (= %b) and VCCD (= %b)   %m",ANALOG_EN,VDDA,VDDIO_Q,VSWITCH,ENABLE_H,hld_h_n_buf,VCCD,$stime);
            end
            else
                if (msg_count_pad2 == MAX_WARNING_COUNT+1)
                begin
                    $display(" ===WARNING=== sky130_fd_io__top_gpiov2 :  Further WARNING messages will be suppressed as the message count has exceeded 100 %m",$stime);
                end
        end
    end
end
wire #100 error_vdda3 =  ( VDDA===1 && VDDIO_Q ===1 && VSWITCH !==1 && ENABLE_H===1 && hld_h_n_buf ===1  && VCCD !==1 );
event event_error_vdda3;
always @(error_vdda3)
begin
    if (!dis_err_msgs)
    begin
        if (error_vdda3===1)
        begin
            msg_count_pad3 = msg_count_pad3 + 1;
            ->event_error_vdda3;
            if (msg_count_pad3 <= MAX_WARNING_COUNT)
            begin
                $display(" ===ERROR=== sky130_fd_io__top_gpiov2 : VCCD (= %b) cannot be any value other than 1 when VDDA (= %b) , VDDIO_Q (= %b) , VSWITCH(= %b), ENABLE_H (= %b) and hld_h_n_buf (= %b) %m",VCCD,VDDA,VDDIO_Q,VSWITCH,ENABLE_H,hld_h_n_buf,$stime);
            end
            else
                if (msg_count_pad3 == MAX_WARNING_COUNT+1)
                begin
                    $display(" ===WARNING=== sky130_fd_io__top_gpiov2 :  Further WARNING messages will be suppressed as the message count has exceeded 100 %m",$stime);
                end
        end
    end
end
wire #100 error_vswitch1 =  (VDDA !==1 && VDDIO_Q !==1 && VSWITCH ===1 && (ENABLE_VSWITCH_H===1)) ;
event event_error_vswitch1;
always @(error_vswitch1)
begin
    if (!dis_err_msgs)
    begin
        if (error_vswitch1===1)
        begin
            msg_count_pad4 = msg_count_pad4 + 1;
            ->event_error_vswitch1;
            if (msg_count_pad4 <= MAX_WARNING_COUNT)
            begin
                $display(" ===ERROR=== sky130_fd_io__top_gpiov2 : ENABLE_VSWITCH_H (= %b) cannot be 1 when VDDA (= %b) , VDDIO_Q (= %b) & VSWITCH(= %b) %m",ENABLE_VSWITCH_H,VDDA,VDDIO_Q,VSWITCH,$stime);
            end
            else
                if (msg_count_pad4 == MAX_WARNING_COUNT+1)
                begin
                    $display(" ===WARNING=== sky130_fd_io__top_gpiov2 :  Further WARNING messages will be suppressed as the message count has exceeded 100 %m",$stime);
                end
        end
    end
end
wire #100 error_vswitch2 =   (VDDA !==1 && VDDIO_Q !==1 && VSWITCH ===1 && VCCD===1 && ANALOG_EN===1);
event event_error_vswitch2;
always @(error_vswitch2)
begin
    if (!dis_err_msgs)
    begin
        if (error_vswitch2===1)
        begin
            msg_count_pad5 = msg_count_pad5 + 1;
            ->event_error_vswitch2;
            if (msg_count_pad5 <= MAX_WARNING_COUNT)
            begin
                $display(" ===ERROR=== sky130_fd_io__top_gpiov2 : ANALOG_EN (= %b) cannot be 1 when VDDA (= %b) , VDDIO_Q (= %b) , VSWITCH(= %b)  & VCCD(= %b) %m",ANALOG_EN,VDDA,VDDIO_Q,VSWITCH,VCCD,$stime);
            end
            else
                if (msg_count_pad5 == MAX_WARNING_COUNT+1)
                begin
                    $display(" ===WARNING=== sky130_fd_io__top_gpiov2 :  Further WARNING messages will be suppressed as the message count has exceeded 100 %m",$stime);
                end
        end
    end
end
wire #100 error_vswitch3 =   (VDDA ===1 && VDDIO_Q !==1 && VSWITCH ===1 && ENABLE_VSWITCH_H===1);
event event_error_vswitch3;
always @(error_vswitch3)
begin
    if (!dis_err_msgs)
    begin
        if (error_vswitch3===1)
        begin
            msg_count_pad6 = msg_count_pad6 + 1;
            ->event_error_vswitch3;
            if (msg_count_pad6 <= MAX_WARNING_COUNT)
            begin
                $display(" ===ERROR=== sky130_fd_io__top_gpiov2 : ENABLE_VSWITCH_H(= %b) cannot be 1 when VDDA (= %b) , VDDIO_Q (= %b) & VSWITCH(= %b) %m",ENABLE_VSWITCH_H,VDDA,VDDIO_Q,VSWITCH,$stime);
            end
            else
                if (msg_count_pad6 == MAX_WARNING_COUNT+1)
                begin
                    $display(" ===WARNING=== sky130_fd_io__top_gpiov2 :  Further WARNING messages will be suppressed as the message count has exceeded 100 %m",$stime);
                end
        end
    end
end
wire #100 error_vswitch4 =  (VDDA !==1 && VDDIO_Q ===1 && VSWITCH ===1 && ENABLE_VSWITCH_H===1);
event event_error_vswitch4;
always @(error_vswitch4)
begin
    if (!dis_err_msgs)
    begin
        if (error_vswitch4===1)
        begin
            msg_count_pad7 = msg_count_pad7 + 1;
            ->event_error_vswitch4;
            if (msg_count_pad7 <= MAX_WARNING_COUNT)
            begin
                $display(" ===ERROR=== sky130_fd_io__top_gpiov2 : ENABLE_VSWITCH_H(= %b) cannot be 1 when VDDA (= %b) , VDDIO_Q (= %b) & VSWITCH(= %b) %m",ENABLE_VSWITCH_H,VDDA,VDDIO_Q,VSWITCH,$stime);
            end
            else
                if (msg_count_pad7 == MAX_WARNING_COUNT+1)
                begin
                    $display(" ===WARNING=== sky130_fd_io__top_gpiov2 :  Further WARNING messages will be suppressed as the message count has exceeded 100 %m",$stime);
                end
        end
    end
end
wire #100 error_vswitch5 =  (VDDA !==1 && VDDIO_Q ===1 && VSWITCH ===1 && ENABLE_H ===1 && hld_h_n_buf ===1 && VCCD ===1 && ANALOG_EN===1);
event event_error_vswitch5;
always @(error_vswitch5)
begin
    if (!dis_err_msgs)
    begin
        if (error_vswitch5===1)
        begin
            msg_count_pad8 = msg_count_pad8 + 1;
            ->event_error_vswitch5;
            if (msg_count_pad8 <= MAX_WARNING_COUNT)
            begin
                $display(" ===ERROR=== sky130_fd_io__top_gpiov2 : ANALOG_EN(= %b) cannot be 1 when VDDA (= %b) , VDDIO_Q (= %b) , VSWITCH(= %b),ENABLE_H (= %b),hld_h_n_buf (= %b) and VCCD (= %b) %m",ANALOG_EN,VDDA,VDDIO_Q,VSWITCH,ENABLE_H,hld_h_n_buf,VCCD,$stime);
            end
            else
                if (msg_count_pad8 == MAX_WARNING_COUNT+1)
                begin
                    $display(" ===WARNING=== sky130_fd_io__top_gpiov2 :  Further WARNING messages will be suppressed as the message count has exceeded 100 %m",$stime);
                end
        end
    end
end
wire #100 error_vddio_q1 =  (VDDA !==1 && VDDIO_Q ===1 && VSWITCH !==1 && ENABLE_H ===1 && hld_h_n_buf ===1 && VCCD!==1);
event event_error_vddio_q1;
always @(error_vddio_q1)
begin
    if (!dis_err_msgs)
    begin
        if (error_vddio_q1===1)
        begin
            msg_count_pad9 = msg_count_pad9 + 1;
            ->event_error_vddio_q1;
            if (msg_count_pad9 <= MAX_WARNING_COUNT)
            begin
                $display(" ===ERROR=== sky130_fd_io__top_gpiov2 : VCCD(= %b) cannot be any value other than 1 when VDDA (= %b) , VDDIO_Q (= %b) , VSWITCH(= %b),ENABLE_H (= %b) and hld_h_n_buf (= %b)  %m",VCCD,VDDA,VDDIO_Q,VSWITCH,ENABLE_H,hld_h_n_buf,$stime);
            end
            else
                if (msg_count_pad9 == MAX_WARNING_COUNT+1)
                begin
                    $display(" ===WARNING=== sky130_fd_io__top_gpiov2 :  Further WARNING messages will be suppressed as the message count has exceeded 100 %m",$stime);
                end
        end
    end
end
wire #100 error_vddio_q2 =  (VDDA !==1 && VDDIO_Q ===1 && VSWITCH !==1 && ENABLE_H ===1 && hld_h_n_buf ===1 && VCCD ===1 && ANALOG_EN===1);
event event_error_vddio_q2;
always @(error_vddio_q2)
begin
    if (!dis_err_msgs)
    begin
        if (error_vddio_q2===1)
        begin
            msg_count_pad10 = msg_count_pad10 + 1;
            ->event_error_vddio_q2;
            if (msg_count_pad10 <= MAX_WARNING_COUNT)
            begin
                $display(" ===ERROR=== sky130_fd_io__top_gpiov2 : ANALOG_EN(= %b) cannot be 1 when VDDA (= %b) , VDDIO_Q (= %b) , VSWITCH(= %b),ENABLE_H (= %b) , hld_h_n_buf (= %b) && VCCD (= %b) %m",ANALOG_EN, VDDA,VDDIO_Q,VSWITCH,ENABLE_H,hld_h_n_buf,VCCD,$stime);
            end
            else
                if (msg_count_pad10 == MAX_WARNING_COUNT+1)
                begin
                    $display(" ===WARNING=== sky130_fd_io__top_gpiov2 :  Further WARNING messages will be suppressed as the message count has exceeded 100 %m",$stime);
                end
        end
    end
end
wire #100 error_supply_good = ( VDDA ===1 && VDDIO_Q ===1 && VSWITCH ===1  && ENABLE_H ===1 && hld_h_n_buf ===1 && VCCD ===1 &&  ANALOG_EN===1 && ENABLE_VSWITCH_H !==1 && ENABLE_VSWITCH_H !==0 );
event event_error_supply_good;
always @(error_supply_good)
begin
    if (!dis_err_msgs)
    begin
        if (error_supply_good===1)
        begin
            msg_count_pad11 = msg_count_pad11 + 1;
            ->event_error_supply_good;
            if (msg_count_pad11 <= MAX_WARNING_COUNT)
            begin
                $display(" ===ERROR=== sky130_fd_io__top_gpiov2 : ENABLE_VSWITCH_H(= %b) should be either 1 or 0 when VDDA (= %b) , VDDIO_Q (= %b) , VSWITCH(= %b), ENABLE_H (= %b), hld_h_n_buf (= %b) ,VCCD (= %b) and ANALOG_EN(= %b)  %m",ENABLE_VSWITCH_H, VDDA,VDDIO_Q,VSWITCH,ENABLE_H,hld_h_n_buf,VCCD,ANALOG_EN,$stime);
            end
            else
                if (msg_count_pad11 == MAX_WARNING_COUNT+1)
                begin
                    $display(" ===WARNING=== sky130_fd_io__top_gpiov2 :  Further WARNING messages will be suppressed as the message count has exceeded 100 %m",$stime);
                end
        end
    end
end
wire #100 error_vdda_vddioq_vswitch2 = ( VDDA ===1 && VDDIO_Q ===1 && VSWITCH ===1 && ENABLE_H ===1 && hld_h_n_buf ===1 && VCCD ===1 &&  ANALOG_EN===1 && ENABLE_VDDA_H !==1 && ENABLE_VDDA_H !==0 );
event event_error_vdda_vddioq_vswitch2;
always @(error_vdda_vddioq_vswitch2)
begin
    if (!dis_err_msgs)
    begin
        if (error_vdda_vddioq_vswitch2===1)
        begin
            msg_count_pad12 = msg_count_pad12 + 1;
            ->event_error_vdda_vddioq_vswitch2;
            if (msg_count_pad12 <= MAX_WARNING_COUNT)
            begin
                $display(" ===ERROR=== sky130_fd_io__top_gpiov2 : ENABLE_VDDA_H(= %b) should be either 1 or 0 when VDDA (= %b) , VDDIO_Q (= %b) , VSWITCH(= %b), ENABLE_H (= %b), hld_h_n_buf (= %b) ,VCCD (= %b) and ANALOG_EN(= %b)  %m",ENABLE_VDDA_H, VDDA,VDDIO_Q,VSWITCH,ENABLE_H,hld_h_n_buf,VCCD,ANALOG_EN,$stime);
            end
            else
                if (msg_count_pad12 == MAX_WARNING_COUNT+1)
                begin
                    $display(" ===WARNING=== sky130_fd_io__top_gpiov2 :  Further WARNING messages will be suppressed as the message count has exceeded 100 %m",$stime);
                end
        end
    end
end
endmodule
`endif // FUNCTIONAL

`else  // USE_POWER_PINS

`ifdef FUNCTIONAL
/*
 * Copyright 2020 The SkyWater PDK Authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 * SPDX-License-Identifier: Apache-2.0
*/

module sky130_fd_io__top_gpiov2 (IN_H, PAD_A_NOESD_H,PAD_A_ESD_0_H,PAD_A_ESD_1_H,
                                 PAD, DM, HLD_H_N, IN, INP_DIS, IB_MODE_SEL, ENABLE_H, ENABLE_VDDA_H, ENABLE_INP_H, OE_N,
                                 TIE_HI_ESD, TIE_LO_ESD, SLOW, VTRIP_SEL, HLD_OVR, ANALOG_EN, ANALOG_SEL, ENABLE_VDDIO, ENABLE_VSWITCH_H,
                                 ANALOG_POL, OUT, AMUXBUS_A, AMUXBUS_B
                                );
input OUT;
input OE_N;
input HLD_H_N;
input ENABLE_H;
input ENABLE_INP_H;
input ENABLE_VDDA_H;
input ENABLE_VSWITCH_H;
input ENABLE_VDDIO;
input INP_DIS;
input IB_MODE_SEL;
input VTRIP_SEL;
input SLOW;
input HLD_OVR;
input ANALOG_EN;
input ANALOG_SEL;
input ANALOG_POL;
input [2:0] DM;
supply1 vddio;
supply1 vddio_q;
supply1 vdda;
supply1 vccd;
supply1 vswitch;
supply1 vcchib;
supply1 vpb;
supply1 vpbhib;
supply0 vssd;
supply0 vssio;
supply0 vssio_q;
supply0 vssa;
inout PAD;
inout PAD_A_NOESD_H,PAD_A_ESD_0_H,PAD_A_ESD_1_H;
inout AMUXBUS_A;
inout AMUXBUS_B;
output IN;
output IN_H;
output TIE_HI_ESD, TIE_LO_ESD;
reg [2:0] dm_final;
reg slow_final, vtrip_sel_final, inp_dis_final, out_final, oe_n_final, hld_ovr_final, analog_en_final, ib_mode_sel_final, analog_en_vdda, analog_en_vswitch,analog_en_vddio_q;
wire [2:0] dm_buf;
wire slow_buf, vtrip_sel_buf, inp_dis_buf, out_buf, oe_n_buf, hld_ovr_buf,ib_mode_sel_buf;
wire [2:0] dm_del;
wire slow_del, vtrip_sel_del, inp_dis_del, out_del, oe_n_del, hld_ovr_del,ib_mode_sel_del;
wire hld_h_n_del;
wire hld_h_n_buf;
reg notifier_dm, notifier_slow, notifier_oe_n, notifier_out, notifier_vtrip_sel, notifier_hld_ovr, notifier_inp_dis, notifier_ib_mode_sel;
reg notifier_enable_h, notifier;
assign hld_h_n_buf 	= HLD_H_N;
assign hld_ovr_buf 	= HLD_OVR;
assign dm_buf 		= DM;
assign inp_dis_buf 	= INP_DIS;
assign vtrip_sel_buf 	= VTRIP_SEL;
assign slow_buf 	= SLOW;
assign oe_n_buf 	= OE_N;
assign out_buf 		= OUT;
assign ib_mode_sel_buf 	= IB_MODE_SEL;
wire  pwr_good_amux	      	= 1;
wire  pwr_good_inpbuff_hv      	= 1;
wire  pwr_good_inpbuff_lv       = 1;
wire  pwr_good_output_driver  	= 1;
wire  pwr_good_hold_mode	= 1;
wire  pwr_good_hold_ovr_mode	= 1;
wire  pwr_good_active_mode      = 1;
wire  pwr_good_hold_mode_vdda	= 1;
wire  pwr_good_active_mode_vdda	= 1;
wire pwr_good_amux_vccd         = 1;
wire  pwr_good_analog_en_vdda   = 1;
wire  pwr_good_analog_en_vddio_q = 1;
wire  pwr_good_analog_en_vswitch = 1;
parameter MAX_WARNING_COUNT = 100;
wire pad_tristate = oe_n_final === 1 || dm_final === 3'b000 || dm_final === 3'b001;
wire x_on_pad  =  !pwr_good_output_driver
     || (dm_final !== 3'b000 && dm_final !== 3'b001 && oe_n_final===1'bx)
     || (^dm_final[2:0] === 1'bx && oe_n_final===1'b0)
     || (slow_final===1'bx && dm_final !== 3'b000 && dm_final !== 3'b001 && oe_n_final===1'b0);
`ifdef SKY130_FD_IO_TOP_GPIOV2_SLOW_BEHV
parameter SLOW_1_DELAY= 70;
parameter SLOW_0_DELAY= 40;
`else
parameter SLOW_1_DELAY= 0;
parameter SLOW_0_DELAY= 0;
`endif
integer slow_1_delay,slow_0_delay,slow_delay;
initial slow_1_delay = SLOW_1_DELAY;
initial slow_0_delay = SLOW_0_DELAY;
always @(*)
begin
    if (SLOW===1)
        slow_delay = slow_1_delay;
    else
        slow_delay = slow_0_delay;
end
bufif1 (pull1, strong0) #slow_delay dm2 (PAD, out_final, x_on_pad===1 ? 1'bx : (pad_tristate===0 && dm_final===3'b010));
bufif1 (strong1, pull0) #slow_delay dm3 (PAD, out_final, x_on_pad===1 ? 1'bx : (pad_tristate===0 && dm_final===3'b011));
bufif1 (highz1, strong0) #slow_delay dm4 (PAD, out_final, x_on_pad===1 ? 1'bx : (pad_tristate===0 && dm_final===3'b100));
bufif1 (strong1, highz0) #slow_delay dm5 (PAD, out_final, x_on_pad===1 ? 1'bx : (pad_tristate===0 && dm_final===3'b101));
bufif1 (strong1, strong0) #slow_delay dm6 (PAD, out_final, x_on_pad===1 ? 1'bx : (pad_tristate===0 && dm_final===3'b110));
bufif1 (pull1, pull0)  #slow_delay dm7 (PAD, out_final, x_on_pad===1 ? 1'bx : (pad_tristate===0 && dm_final===3'b111));
tran pad_esd_1 (PAD,PAD_A_NOESD_H);
tran pad_esd_2 (PAD,PAD_A_ESD_0_H);
tran pad_esd_3 (PAD,PAD_A_ESD_1_H);
wire x_on_in_hv  =  (ENABLE_H===0  && ^ENABLE_INP_H===1'bx)
     || (inp_dis_final===1'bx  && ^dm_final[2:0]!==1'bx && dm_final !== 3'b000)
     || (^ENABLE_H===1'bx)
     || (inp_dis_final===0 	       	&& ^dm_final[2:0] === 1'bx)
     || (ib_mode_sel_final===1'bx  	&& inp_dis_final===0        && dm_final !== 3'b000)
     || (^ENABLE_VDDIO===1'bx    	&& inp_dis_final===0        && dm_final !== 3'b000	&& ib_mode_sel_final===1'b1)
     || (vtrip_sel_final===1'bx    	&& inp_dis_final===0        && dm_final !== 3'b000	&& ib_mode_sel_final===1'b0);
wire x_on_in_lv  =  (ENABLE_H===0  && ^ENABLE_INP_H===1'bx)
     || (inp_dis_final===1'bx  && ^dm_final[2:0]!==1'bx && dm_final !== 3'b000)
     || (ENABLE_H===0  && ^ENABLE_VDDIO===1'bx)
     || (^ENABLE_H===1'bx)
     || (inp_dis_final===0 	       	&& ^dm_final[2:0] === 1'bx)
     || (ib_mode_sel_final===1'bx  	&& inp_dis_final===0        && dm_final !== 3'b000)
     || (^ENABLE_VDDIO===1'bx    	&& inp_dis_final===0        && dm_final !== 3'b000)
     || (vtrip_sel_final===1'bx    	&& inp_dis_final===0        && dm_final !== 3'b000	&& ib_mode_sel_final===1'b0);
wire disable_inp_buff = ENABLE_H===1 ? (dm_final===3'b000 || inp_dis_final===1) : ENABLE_INP_H===0;
assign IN_H = (x_on_in_hv===1 || pwr_good_inpbuff_hv===0) ? 1'bx : (disable_inp_buff===1 ? 0 : (^PAD===1'bx ? 1'bx : PAD));
wire disable_inp_buff_lv = ENABLE_H===1 ? (dm_final===3'b000 || inp_dis_final===1) : ENABLE_VDDIO===0;
assign IN =   (x_on_in_lv===1 || pwr_good_inpbuff_lv===0 ) ? 1'bx : (disable_inp_buff_lv===1 ? 0 : (^PAD===1'bx ? 1'bx : PAD));
assign TIE_HI_ESD = vddio===1'b1 ? 1'b1 : 1'bx;
assign TIE_LO_ESD = vssio===1'b0 ? 1'b0 : 1'bx;
wire functional_mode_amux = (pwr_good_analog_en_vdda ===1 && pwr_good_analog_en_vddio_q ===1 && pwr_good_analog_en_vswitch ===1 );
wire x_on_analog_en_vdda = (pwr_good_analog_en_vdda !==1
                            || (functional_mode_amux ==1 && (ENABLE_H !==0 && ^hld_h_n_buf === 1'bx) || (hld_h_n_buf!== 0 && ^ENABLE_H=== 1'bx) || pwr_good_amux_vccd !==1 )
                            || (functional_mode_amux ==1 && (hld_h_n_buf ===1 && ENABLE_H===1 && ^ANALOG_EN === 1'bx && ENABLE_VDDA_H ===1 && ENABLE_VSWITCH_H===1 ) || (hld_h_n_buf ===1 && ENABLE_H===1 && ANALOG_EN ===0 && ^ENABLE_VDDA_H ===1'bx) ));
wire zero_on_analog_en_vdda = ( (pwr_good_analog_en_vdda ===1 && ENABLE_VDDA_H ===0)
                                || (pwr_good_analog_en_vdda ===1 && pwr_good_analog_en_vddio_q ===1 && hld_h_n_buf===0)
                                || (pwr_good_analog_en_vdda ===1 && pwr_good_analog_en_vddio_q ===1 && ENABLE_H===0)
                                ||  (pwr_good_analog_en_vdda ===1 && pwr_good_analog_en_vddio_q ===1 && pwr_good_amux_vccd && ANALOG_EN===0) );
wire x_on_analog_en_vddio_q =  ( pwr_good_analog_en_vddio_q !==1
                                 || (functional_mode_amux ==1 && (ENABLE_H !==0 && ^hld_h_n_buf === 1'bx) || (hld_h_n_buf!== 0 && ^ENABLE_H=== 1'bx) || pwr_good_amux_vccd !==1 )
                                 || (functional_mode_amux ==1 && (hld_h_n_buf ===1 && ENABLE_H===1 && ^ANALOG_EN === 1'bx && ENABLE_VDDA_H ===1 && ENABLE_VSWITCH_H===1 ) ));
wire zero_on_analog_en_vddio_q =  ( (pwr_good_analog_en_vddio_q ===1 && hld_h_n_buf===0)
                                    || (pwr_good_analog_en_vddio_q ===1 && ENABLE_H===0)
                                    ||  (pwr_good_analog_en_vddio_q ===1 && pwr_good_amux_vccd && ANALOG_EN===0) );
wire x_on_analog_en_vswitch = (pwr_good_analog_en_vswitch !==1
                               || (functional_mode_amux ==1 && (ENABLE_H !==0 && ^hld_h_n_buf === 1'bx) || (hld_h_n_buf!== 0 && ^ENABLE_H=== 1'bx) || pwr_good_amux_vccd !==1 )
                               || (functional_mode_amux ==1 && (hld_h_n_buf ===1 && ENABLE_H===1 && ^ANALOG_EN === 1'bx && ENABLE_VDDA_H ===1 && ENABLE_VSWITCH_H===1 ) || (hld_h_n_buf ===1 && ENABLE_H===1 && ANALOG_EN ===0 && ^ENABLE_VSWITCH_H ===1'bx) ));
wire  zero_on_analog_en_vswitch =   ( (pwr_good_analog_en_vswitch ===1 && ENABLE_VSWITCH_H ===0)
                                      || (pwr_good_analog_en_vswitch ===1 && pwr_good_analog_en_vddio_q ===1 && hld_h_n_buf===0)
                                      || (pwr_good_analog_en_vswitch ===1 && pwr_good_analog_en_vddio_q ===1 && ENABLE_H===0)
                                      ||  (pwr_good_analog_en_vswitch ===1 && pwr_good_analog_en_vddio_q ===1 && pwr_good_amux_vccd && ANALOG_EN===0) );
always @(*)
begin : LATCH_dm
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode || (ENABLE_H===1 && ^hld_h_n_buf===1'bx))
    begin
        dm_final 	<= 3'bxxx;
    end
    else if (ENABLE_H===0)
    begin
        dm_final 	<= 3'b000;
    end
    else if (hld_h_n_buf===1)
    begin
        dm_final 	<= (^dm_buf[2:0]	=== 1'bx	|| !pwr_good_active_mode) ? 3'bxxx : dm_buf;
    end
end
always @(notifier_enable_h or notifier_dm)
begin
    disable LATCH_dm; dm_final <= 3'bxxx;
end
always @(*)
begin : LATCH_inp_dis
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode || (ENABLE_H===1 && ^hld_h_n_buf===1'bx))
    begin
        inp_dis_final 	<= 1'bx;
    end
    else if (ENABLE_H===0)
    begin
        inp_dis_final 	<= 1'b1;
    end
    else if (hld_h_n_buf===1)
    begin
        inp_dis_final 	<= (^inp_dis_buf === 1'bx	|| !pwr_good_active_mode) ? 1'bx : inp_dis_buf;
    end
end
always @(notifier_enable_h or notifier_inp_dis)
begin
    disable LATCH_inp_dis; inp_dis_final <= 1'bx;
end
always @(*)
begin : LATCH_vtrip_sel
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode || (ENABLE_H===1 && ^hld_h_n_buf===1'bx))
    begin
        vtrip_sel_final 	<= 1'bx;
    end
    else if (ENABLE_H===0)
    begin
        vtrip_sel_final 	<= 1'b0;
    end
    else if (hld_h_n_buf===1)
    begin
        vtrip_sel_final 	<= (^vtrip_sel_buf === 1'bx	|| !pwr_good_active_mode) ? 1'bx : vtrip_sel_buf;
    end
end
always @(notifier_enable_h or notifier_vtrip_sel)
begin
    disable LATCH_vtrip_sel; vtrip_sel_final <= 1'bx;
end
always @(*)
begin : LATCH_ib_mode_sel
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode || (ENABLE_H===1 && ^hld_h_n_buf===1'bx))
    begin
        ib_mode_sel_final 	<= 1'bx;
    end
    else if (ENABLE_H===0)
    begin
        ib_mode_sel_final 	<= 1'b0;
    end
    else if (hld_h_n_buf===1)
    begin
        ib_mode_sel_final 	<= (^ib_mode_sel_buf === 1'bx	|| !pwr_good_active_mode) ? 1'bx : ib_mode_sel_buf;
    end
end
always @(notifier_enable_h or notifier_ib_mode_sel)
begin
    disable LATCH_ib_mode_sel; ib_mode_sel_final <= 1'bx;
end
always @(*)
begin : LATCH_slow
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode || (ENABLE_H===1 && ^hld_h_n_buf===1'bx))
    begin
        slow_final 	<= 1'bx;
    end
    else if (ENABLE_H===0)
    begin
        slow_final 	<= 1'b0;
    end
    else if (hld_h_n_buf===1)
    begin
        slow_final 	<= (^slow_buf === 1'bx	|| !pwr_good_active_mode) ? 1'bx : slow_buf;
    end
end
always @(notifier_enable_h or notifier_slow)
begin
    disable LATCH_slow; slow_final <= 1'bx;
end
always @(*)
begin : LATCH_hld_ovr
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode || (ENABLE_H===1 && ^hld_h_n_buf===1'bx))
    begin
        hld_ovr_final 	<= 1'bx;
    end
    else if (ENABLE_H===0)
    begin
        hld_ovr_final 	<= 1'b0;
    end
    else if (hld_h_n_buf===1)
    begin
        hld_ovr_final 	<= (^hld_ovr_buf === 1'bx	|| !pwr_good_active_mode) ? 1'bx : hld_ovr_buf;
    end
end
always @(notifier_enable_h or notifier_hld_ovr)
begin
    disable LATCH_hld_ovr; hld_ovr_final <= 1'bx;
end
always @(*)
begin : LATCH_oe_n
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode || (ENABLE_H===1 && (^hld_h_n_buf===1'bx || (hld_h_n_buf===0 && hld_ovr_final===1'bx) || (hld_h_n_buf===1 && hld_ovr_final===1'bx))))
    begin
        oe_n_final 	<= 1'bx;
    end
    else if (ENABLE_H===0)
    begin
        oe_n_final 	<= 1'b1;
    end
    else if (hld_h_n_buf===1 || hld_ovr_final===1)
    begin
        oe_n_final  	<= (^oe_n_buf  === 1'bx  || !pwr_good_hold_ovr_mode) ? 1'bx   : oe_n_buf;
    end
end
always @(notifier_enable_h or notifier_oe_n)
begin
    disable LATCH_oe_n; oe_n_final <= 1'bx;
end
always @(*)
begin : LATCH_out
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode || (ENABLE_H===1 && (^hld_h_n_buf===1'bx ||(hld_h_n_buf===0 &&  hld_ovr_final===1'bx || (hld_h_n_buf===1 && hld_ovr_final===1'bx)))))
    begin
        out_final 	<= 1'bx;
    end
    else if (ENABLE_H===0)
    begin
        out_final 	<= 1'b1;
    end
    else if (hld_h_n_buf===1 || hld_ovr_final===1)
    begin
        out_final  	<= (^out_buf  === 1'bx  || !pwr_good_hold_ovr_mode) ? 1'bx   : out_buf;
    end
end
always @(notifier_enable_h or notifier_out)
begin
    disable LATCH_out; out_final <= 1'bx;
end
always @(*)
begin
    if (x_on_analog_en_vdda ===1 )
    begin
        analog_en_vdda <= 1'bx;
    end
    else if ( zero_on_analog_en_vdda ===1 )
    begin
        analog_en_vdda <= 1'b0;
    end
    else if (x_on_analog_en_vdda !==1 && zero_on_analog_en_vdda !==1)
    begin
        analog_en_vdda <= ANALOG_EN;
    end
    if (x_on_analog_en_vddio_q  ===1 )
    begin
        analog_en_vddio_q  <= 1'bx;
    end
    else if ( zero_on_analog_en_vddio_q ===1 )
    begin
        analog_en_vddio_q  <= 1'b0;
    end
    else if ( x_on_analog_en_vddio_q !==1 && zero_on_analog_en_vddio_q !==1)
    begin
        analog_en_vddio_q  <= ANALOG_EN;
    end
    if (x_on_analog_en_vswitch  ===1 )
    begin
        analog_en_vswitch  <= 1'bx;
    end
    else if ( zero_on_analog_en_vswitch ===1 )
    begin
        analog_en_vswitch  <= 1'b0;
    end
    else if (x_on_analog_en_vswitch !==1 && zero_on_analog_en_vswitch !==1)
    begin
        analog_en_vswitch  <= ANALOG_EN;
    end
    if ( (analog_en_vswitch ===1'bx && analog_en_vdda ===1'bx) || (analog_en_vswitch ===1'bx && analog_en_vddio_q ===1'bx) || (analog_en_vddio_q ===1'bx && analog_en_vdda ===1'bx ) )
    begin
        analog_en_final  <= 1'bx;
    end
    else if (analog_en_vdda ===1'bx && (analog_en_vddio_q ===1 ||analog_en_vswitch===1 ))
    begin
        analog_en_final  <= 1'bx;
    end
    else if (analog_en_vddio_q ===1'bx && (analog_en_vdda ===1 ||analog_en_vswitch===1 ))
    begin
        analog_en_final  <= 1'bx;
    end
    else if (analog_en_vswitch===1'bx && (analog_en_vdda ===1 || analog_en_vddio_q ===1 ))
    begin
        analog_en_final  <= 1'bx;
    end
    else if ((analog_en_vdda ===0 && analog_en_vddio_q ===0 )|| (analog_en_vdda ===0 && analog_en_vswitch===0 ) ||  (analog_en_vddio_q ===0 && analog_en_vswitch===0 ))
    begin
        analog_en_final  <=0;
    end
    else if (analog_en_vdda ===1 && analog_en_vddio_q ===1 &&  analog_en_vswitch ===1)
    begin
        analog_en_final  <=1;
    end
end
wire [2:0] amux_select = {ANALOG_SEL, ANALOG_POL, out_buf};
wire invalid_controls_amux = 	(analog_en_final===1'bx && inp_dis_final===1)
     || !pwr_good_amux
     || (analog_en_final===1 && ^amux_select[2:0] === 1'bx && inp_dis_final===1);
wire enable_pad_amuxbus_a = invalid_controls_amux  ? 1'bx : (amux_select===3'b001 || amux_select===3'b010) && (analog_en_final===1);
wire enable_pad_amuxbus_b = invalid_controls_amux  ? 1'bx : (amux_select===3'b101 || amux_select===3'b110) && (analog_en_final===1);
wire enable_pad_vssio_q   = invalid_controls_amux  ? 1'bx : (amux_select===3'b100 || amux_select===3'b000) && (analog_en_final===1);
wire enable_pad_vddio_q   = invalid_controls_amux  ? 1'bx : (amux_select===3'b011 || amux_select===3'b111) && (analog_en_final===1);
tranif1 pad_amuxbus_a 	(PAD, AMUXBUS_A, enable_pad_amuxbus_a);
tranif1 pad_amuxbus_b 	(PAD, AMUXBUS_B, enable_pad_amuxbus_b);
bufif1 pad_vddio_q	(PAD, vddio_q,   enable_pad_vddio_q);
bufif1 pad_vssio_q   	(PAD, vssio_q,   enable_pad_vssio_q);
reg dis_err_msgs;
integer msg_count_pad,msg_count_pad1,msg_count_pad2,msg_count_pad3,msg_count_pad4,msg_count_pad5,msg_count_pad6,msg_count_pad7,msg_count_pad8,msg_count_pad9,msg_count_pad10,msg_count_pad11,msg_count_pad12;
initial
begin
    dis_err_msgs = 1'b1;
    msg_count_pad  = 0;
    msg_count_pad1 = 0;
    msg_count_pad2 = 0;
    msg_count_pad3 = 0;
    msg_count_pad4 = 0;
    msg_count_pad5 = 0;
    msg_count_pad6 = 0;
    msg_count_pad7 = 0;
    msg_count_pad8 = 0;
    msg_count_pad9 = 0;
    msg_count_pad10 = 0;
    msg_count_pad11 = 0;
    msg_count_pad12  = 0;
`ifdef SKY130_FD_IO_TOP_GPIOV2_DIS_ERR_MSGS
`else
    #1;
    dis_err_msgs = 1'b0;
`endif
end
wire #100 error_enable_vddio = (ENABLE_VDDIO===0 && ENABLE_H===1);
event event_error_enable_vddio;
always @(error_enable_vddio)
begin
    if (!dis_err_msgs)
    begin
        if (error_enable_vddio===1)
        begin
            msg_count_pad = msg_count_pad + 1;
            ->event_error_enable_vddio;
            if (msg_count_pad <= MAX_WARNING_COUNT)
            begin
                $display(" ===ERROR=== sky130_fd_io__top_gpiov2 :  Enable_h (= %b) and ENABLE_VDDIO (= %b) are complement of each other. This is an illegal combination as ENABLE_VDDIO and ENABLE_H are the same input signals IN different power domains %m", ENABLE_H, ENABLE_VDDIO, $stime);
            end
            else
                if (msg_count_pad == MAX_WARNING_COUNT+1)
                begin
                    $display(" ===WARNING=== sky130_fd_io__top_gpiov2 :  Further WARNING messages will be suppressed as the message count has exceeded 100 %m",$stime);
                end
        end
    end
end
wire #100 error_vdda = ( vdda===1 && vddio_q !==1 && ENABLE_VDDA_H===1 );
event event_error_vdda;
always @(error_vdda)
begin
    if (!dis_err_msgs)
    begin
        if (error_vdda===1)
        begin
            msg_count_pad1 = msg_count_pad1 + 1;
            ->event_error_vdda;
            if (msg_count_pad1 <= MAX_WARNING_COUNT)
            begin
                $display(" ===ERROR=== sky130_fd_io__top_gpiov2 : ENABLE_VDDA_H (= %b) cannot be 1 when vdda (= %b) and vddio_q (= %b) %m",ENABLE_VDDA_H, vdda,vddio_q,$stime);
            end
            else
                if (msg_count_pad1 == MAX_WARNING_COUNT+1)
                begin
                    $display(" ===WARNING=== sky130_fd_io__top_gpiov2 :  Further WARNING messages will be suppressed as the message count has exceeded 100 %m",$stime);
                end
        end
    end
end
wire #100 error_vdda2 = ( vdda===1 && vddio_q ===1 && vswitch !==1 && ENABLE_H===1 && hld_h_n_buf ===1  &&  vccd===1 && ANALOG_EN ===1 );
event event_error_vdda2;
always @(error_vdda2)
begin
    if (!dis_err_msgs)
    begin
        if (error_vdda2===1)
        begin
            msg_count_pad2 = msg_count_pad2 + 1;
            ->event_error_vdda2;
            if (msg_count_pad2 <= MAX_WARNING_COUNT)
            begin
                $display(" ===ERROR=== sky130_fd_io__top_gpiov2 : ANALOG_EN (= %b) cannot be 1 when vdda (= %b) , vddio_q (= %b) , vswitch(= %b), ENABLE_H (= %b),hld_h_n_buf (= %b) and vccd (= %b)   %m",ANALOG_EN,vdda,vddio_q,vswitch,ENABLE_H,hld_h_n_buf,vccd,$stime);
            end
            else
                if (msg_count_pad2 == MAX_WARNING_COUNT+1)
                begin
                    $display(" ===WARNING=== sky130_fd_io__top_gpiov2 :  Further WARNING messages will be suppressed as the message count has exceeded 100 %m",$stime);
                end
        end
    end
end
wire #100 error_vdda3 =  ( vdda===1 && vddio_q ===1 && vswitch !==1 && ENABLE_H===1 && hld_h_n_buf ===1  && vccd !==1 );
event event_error_vdda3;
always @(error_vdda3)
begin
    if (!dis_err_msgs)
    begin
        if (error_vdda3===1)
        begin
            msg_count_pad3 = msg_count_pad3 + 1;
            ->event_error_vdda3;
            if (msg_count_pad3 <= MAX_WARNING_COUNT)
            begin
                $display(" ===ERROR=== sky130_fd_io__top_gpiov2 : vccd (= %b) cannot be any value other than 1 when vdda (= %b) , vddio_q (= %b) , vswitch(= %b), ENABLE_H (= %b) and hld_h_n_buf (= %b) %m",vccd,vdda,vddio_q,vswitch,ENABLE_H,hld_h_n_buf,$stime);
            end
            else
                if (msg_count_pad3 == MAX_WARNING_COUNT+1)
                begin
                    $display(" ===WARNING=== sky130_fd_io__top_gpiov2 :  Further WARNING messages will be suppressed as the message count has exceeded 100 %m",$stime);
                end
        end
    end
end
wire #100 error_vswitch1 =  (vdda !==1 && vddio_q !==1 && vswitch ===1 && (ENABLE_VSWITCH_H===1)) ;
event event_error_vswitch1;
always @(error_vswitch1)
begin
    if (!dis_err_msgs)
    begin
        if (error_vswitch1===1)
        begin
            msg_count_pad4 = msg_count_pad4 + 1;
            ->event_error_vswitch1;
            if (msg_count_pad4 <= MAX_WARNING_COUNT)
            begin
                $display(" ===ERROR=== sky130_fd_io__top_gpiov2 : ENABLE_VSWITCH_H (= %b) cannot be 1 when vdda (= %b) , vddio_q (= %b) & vswitch(= %b) %m",ENABLE_VSWITCH_H,vdda,vddio_q,vswitch,$stime);
            end
            else
                if (msg_count_pad4 == MAX_WARNING_COUNT+1)
                begin
                    $display(" ===WARNING=== sky130_fd_io__top_gpiov2 :  Further WARNING messages will be suppressed as the message count has exceeded 100 %m",$stime);
                end
        end
    end
end
wire #100 error_vswitch2 =   (vdda !==1 && vddio_q !==1 && vswitch ===1 && vccd===1 && ANALOG_EN===1);
event event_error_vswitch2;
always @(error_vswitch2)
begin
    if (!dis_err_msgs)
    begin
        if (error_vswitch2===1)
        begin
            msg_count_pad5 = msg_count_pad5 + 1;
            ->event_error_vswitch2;
            if (msg_count_pad5 <= MAX_WARNING_COUNT)
            begin
                $display(" ===ERROR=== sky130_fd_io__top_gpiov2 : ANALOG_EN (= %b) cannot be 1 when vdda (= %b) , vddio_q (= %b) , vswitch(= %b)  & vccd(= %b) %m",ANALOG_EN,vdda,vddio_q,vswitch,vccd,$stime);
            end
            else
                if (msg_count_pad5 == MAX_WARNING_COUNT+1)
                begin
                    $display(" ===WARNING=== sky130_fd_io__top_gpiov2 :  Further WARNING messages will be suppressed as the message count has exceeded 100 %m",$stime);
                end
        end
    end
end
wire #100 error_vswitch3 =   (vdda ===1 && vddio_q !==1 && vswitch ===1 && ENABLE_VSWITCH_H===1);
event event_error_vswitch3;
always @(error_vswitch3)
begin
    if (!dis_err_msgs)
    begin
        if (error_vswitch3===1)
        begin
            msg_count_pad6 = msg_count_pad6 + 1;
            ->event_error_vswitch3;
            if (msg_count_pad6 <= MAX_WARNING_COUNT)
            begin
                $display(" ===ERROR=== sky130_fd_io__top_gpiov2 : ENABLE_VSWITCH_H(= %b) cannot be 1 when vdda (= %b) , vddio_q (= %b) & vswitch(= %b) %m",ENABLE_VSWITCH_H,vdda,vddio_q,vswitch,$stime);
            end
            else
                if (msg_count_pad6 == MAX_WARNING_COUNT+1)
                begin
                    $display(" ===WARNING=== sky130_fd_io__top_gpiov2 :  Further WARNING messages will be suppressed as the message count has exceeded 100 %m",$stime);
                end
        end
    end
end
wire #100 error_vswitch4 =  (vdda !==1 && vddio_q ===1 && vswitch ===1 && ENABLE_VSWITCH_H===1);
event event_error_vswitch4;
always @(error_vswitch4)
begin
    if (!dis_err_msgs)
    begin
        if (error_vswitch4===1)
        begin
            msg_count_pad7 = msg_count_pad7 + 1;
            ->event_error_vswitch4;
            if (msg_count_pad7 <= MAX_WARNING_COUNT)
            begin
                $display(" ===ERROR=== sky130_fd_io__top_gpiov2 : ENABLE_VSWITCH_H(= %b) cannot be 1 when vdda (= %b) , vddio_q (= %b) & vswitch(= %b) %m",ENABLE_VSWITCH_H,vdda,vddio_q,vswitch,$stime);
            end
            else
                if (msg_count_pad7 == MAX_WARNING_COUNT+1)
                begin
                    $display(" ===WARNING=== sky130_fd_io__top_gpiov2 :  Further WARNING messages will be suppressed as the message count has exceeded 100 %m",$stime);
                end
        end
    end
end
wire #100 error_vswitch5 =  (vdda !==1 && vddio_q ===1 && vswitch ===1 && ENABLE_H ===1 && hld_h_n_buf ===1 && vccd ===1 && ANALOG_EN===1);
event event_error_vswitch5;
always @(error_vswitch5)
begin
    if (!dis_err_msgs)
    begin
        if (error_vswitch5===1)
        begin
            msg_count_pad8 = msg_count_pad8 + 1;
            ->event_error_vswitch5;
            if (msg_count_pad8 <= MAX_WARNING_COUNT)
            begin
                $display(" ===ERROR=== sky130_fd_io__top_gpiov2 : ANALOG_EN(= %b) cannot be 1 when vdda (= %b) , vddio_q (= %b) , vswitch(= %b),ENABLE_H (= %b),hld_h_n_buf (= %b) and vccd (= %b) %m",ANALOG_EN,vdda,vddio_q,vswitch,ENABLE_H,hld_h_n_buf,vccd,$stime);
            end
            else
                if (msg_count_pad8 == MAX_WARNING_COUNT+1)
                begin
                    $display(" ===WARNING=== sky130_fd_io__top_gpiov2 :  Further WARNING messages will be suppressed as the message count has exceeded 100 %m",$stime);
                end
        end
    end
end
wire #100 error_vddio_q1 =  (vdda !==1 && vddio_q ===1 && vswitch !==1 && ENABLE_H ===1 && hld_h_n_buf ===1 && vccd!==1);
event event_error_vddio_q1;
always @(error_vddio_q1)
begin
    if (!dis_err_msgs)
    begin
        if (error_vddio_q1===1)
        begin
            msg_count_pad9 = msg_count_pad9 + 1;
            ->event_error_vddio_q1;
            if (msg_count_pad9 <= MAX_WARNING_COUNT)
            begin
                $display(" ===ERROR=== sky130_fd_io__top_gpiov2 : vccd(= %b) cannot be any value other than 1 when vdda (= %b) , vddio_q (= %b) , vswitch(= %b),ENABLE_H (= %b) and hld_h_n_buf (= %b)  %m",vccd,vdda,vddio_q,vswitch,ENABLE_H,hld_h_n_buf,$stime);
            end
            else
                if (msg_count_pad9 == MAX_WARNING_COUNT+1)
                begin
                    $display(" ===WARNING=== sky130_fd_io__top_gpiov2 :  Further WARNING messages will be suppressed as the message count has exceeded 100 %m",$stime);
                end
        end
    end
end
wire #100 error_vddio_q2 =  (vdda !==1 && vddio_q ===1 && vswitch !==1 && ENABLE_H ===1 && hld_h_n_buf ===1 && vccd ===1 && ANALOG_EN===1);
event event_error_vddio_q2;
always @(error_vddio_q2)
begin
    if (!dis_err_msgs)
    begin
        if (error_vddio_q2===1)
        begin
            msg_count_pad10 = msg_count_pad10 + 1;
            ->event_error_vddio_q2;
            if (msg_count_pad10 <= MAX_WARNING_COUNT)
            begin
                $display(" ===ERROR=== sky130_fd_io__top_gpiov2 : ANALOG_EN(= %b) cannot be 1 when vdda (= %b) , vddio_q (= %b) , vswitch(= %b),ENABLE_H (= %b) , hld_h_n_buf (= %b) && vccd (= %b) %m",ANALOG_EN, vdda,vddio_q,vswitch,ENABLE_H,hld_h_n_buf,vccd,$stime);
            end
            else
                if (msg_count_pad10 == MAX_WARNING_COUNT+1)
                begin
                    $display(" ===WARNING=== sky130_fd_io__top_gpiov2 :  Further WARNING messages will be suppressed as the message count has exceeded 100 %m",$stime);
                end
        end
    end
end
wire #100 error_supply_good = ( vdda ===1 && vddio_q ===1 && vswitch ===1  && ENABLE_H ===1 && hld_h_n_buf ===1 && vccd ===1 &&  ANALOG_EN===1 && ENABLE_VSWITCH_H !==1 && ENABLE_VSWITCH_H !==0 );
event event_error_supply_good;
always @(error_supply_good)
begin
    if (!dis_err_msgs)
    begin
        if (error_supply_good===1)
        begin
            msg_count_pad11 = msg_count_pad11 + 1;
            ->event_error_supply_good;
            if (msg_count_pad11 <= MAX_WARNING_COUNT)
            begin
                $display(" ===ERROR=== sky130_fd_io__top_gpiov2 : ENABLE_VSWITCH_H(= %b) should be either 1 or 0 when vdda (= %b) , vddio_q (= %b) , vswitch(= %b), ENABLE_H (= %b), hld_h_n_buf (= %b) ,vccd (= %b) and ANALOG_EN(= %b)  %m",ENABLE_VSWITCH_H, vdda,vddio_q,vswitch,ENABLE_H,hld_h_n_buf,vccd,ANALOG_EN,$stime);
            end
            else
                if (msg_count_pad11 == MAX_WARNING_COUNT+1)
                begin
                    $display(" ===WARNING=== sky130_fd_io__top_gpiov2 :  Further WARNING messages will be suppressed as the message count has exceeded 100 %m",$stime);
                end
        end
    end
end
wire #100 error_vdda_vddioq_vswitch2 = ( vdda ===1 && vddio_q ===1 && vswitch ===1 && ENABLE_H ===1 && hld_h_n_buf ===1 && vccd ===1 &&  ANALOG_EN===1 && ENABLE_VDDA_H !==1 && ENABLE_VDDA_H !==0 );
event event_error_vdda_vddioq_vswitch2;
always @(error_vdda_vddioq_vswitch2)
begin
    if (!dis_err_msgs)
    begin
        if (error_vdda_vddioq_vswitch2===1)
        begin
            msg_count_pad12 = msg_count_pad12 + 1;
            ->event_error_vdda_vddioq_vswitch2;
            if (msg_count_pad12 <= MAX_WARNING_COUNT)
            begin
                $display(" ===ERROR=== sky130_fd_io__top_gpiov2 : ENABLE_VDDA_H(= %b) should be either 1 or 0 when vdda (= %b) , vddio_q (= %b) , vswitch(= %b), ENABLE_H (= %b), hld_h_n_buf (= %b) ,vccd (= %b) and ANALOG_EN(= %b)  %m",ENABLE_VDDA_H, vdda,vddio_q,vswitch,ENABLE_H,hld_h_n_buf,vccd,ANALOG_EN,$stime);
            end
            else
                if (msg_count_pad12 == MAX_WARNING_COUNT+1)
                begin
                    $display(" ===WARNING=== sky130_fd_io__top_gpiov2 :  Further WARNING messages will be suppressed as the message count has exceeded 100 %m",$stime);
                end
        end
    end
end
endmodule
`else  // FUNCTIONAL
/*
 * Copyright 2020 The SkyWater PDK Authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 * SPDX-License-Identifier: Apache-2.0
*/

module sky130_fd_io__top_gpiov2 (IN_H, PAD_A_NOESD_H,PAD_A_ESD_0_H,PAD_A_ESD_1_H,
                                 PAD, DM, HLD_H_N, IN, INP_DIS, IB_MODE_SEL, ENABLE_H, ENABLE_VDDA_H, ENABLE_INP_H, OE_N,
                                 TIE_HI_ESD, TIE_LO_ESD, SLOW, VTRIP_SEL, HLD_OVR, ANALOG_EN, ANALOG_SEL, ENABLE_VDDIO, ENABLE_VSWITCH_H,
                                 ANALOG_POL, OUT, AMUXBUS_A, AMUXBUS_B
                                );
input OUT;
input OE_N;
input HLD_H_N;
input ENABLE_H;
input ENABLE_INP_H;
input ENABLE_VDDA_H;
input ENABLE_VSWITCH_H;
input ENABLE_VDDIO;
input INP_DIS;
input IB_MODE_SEL;
input VTRIP_SEL;
input SLOW;
input HLD_OVR;
input ANALOG_EN;
input ANALOG_SEL;
input ANALOG_POL;
input [2:0] DM;
supply1 vddio;
supply1 vddio_q;
supply1 vdda;
supply1 vccd;
supply1 vswitch;
supply1 vcchib;
supply1 vpb;
supply1 vpbhib;
supply0 vssd;
supply0 vssio;
supply0 vssio_q;
supply0 vssa;
inout PAD;
inout PAD_A_NOESD_H,PAD_A_ESD_0_H,PAD_A_ESD_1_H;
inout AMUXBUS_A;
inout AMUXBUS_B;
output IN;
output IN_H;
output TIE_HI_ESD, TIE_LO_ESD;
reg [2:0] dm_final;
reg slow_final, vtrip_sel_final, inp_dis_final, out_final, oe_n_final, hld_ovr_final, analog_en_final, ib_mode_sel_final, analog_en_vdda, analog_en_vswitch,analog_en_vddio_q;
wire [2:0] dm_buf;
wire slow_buf, vtrip_sel_buf, inp_dis_buf, out_buf, oe_n_buf, hld_ovr_buf,ib_mode_sel_buf;
wire [2:0] dm_del;
wire slow_del, vtrip_sel_del, inp_dis_del, out_del, oe_n_del, hld_ovr_del,ib_mode_sel_del;
wire hld_h_n_del;
wire hld_h_n_buf;
reg notifier_dm, notifier_slow, notifier_oe_n, notifier_out, notifier_vtrip_sel, notifier_hld_ovr, notifier_inp_dis, notifier_ib_mode_sel;
reg notifier_enable_h, notifier;
assign hld_h_n_buf 	= hld_h_n_del;
assign hld_ovr_buf 	= hld_ovr_del;
assign dm_buf 		= dm_del;
assign inp_dis_buf 	= inp_dis_del;
assign vtrip_sel_buf 	= vtrip_sel_del;
assign slow_buf 	= slow_del;
assign oe_n_buf 	= oe_n_del;
assign out_buf 		= out_del;
assign ib_mode_sel_buf 	= ib_mode_sel_del;
specify
    (INP_DIS => IN) = (0:0:0 , 0:0:0);
    (INP_DIS => IN_H) = (0:0:0 , 0:0:0);
    if (  IB_MODE_SEL==1'b0 & VTRIP_SEL==1'b1  ) ( PAD => IN) = (0:0:0 , 0:0:0);
    if (  IB_MODE_SEL==1'b0 & VTRIP_SEL==1'b1  ) ( PAD => IN_H) = (0:0:0 , 0:0:0);
    if (  OE_N==1'b0 & DM[2]==1'b1 & DM[1]==1'b1 & DM[0]==1'b0 & SLOW==1'b0 ) ( OUT => PAD) = (0:0:0 , 0:0:0);
    if (  OE_N==1'b0 & DM[2]==1'b1 & DM[1]==1'b1 & DM[0]==1'b0 & SLOW==1'b1 ) ( OUT => PAD) = (0:0:0 , 0:0:0);
    if (  OE_N==1'b0 & DM[2]==1'b1 & DM[1]==1'b0 & DM[0]==1'b0 & SLOW==1'b0 ) ( OUT => PAD) = (0:0:0 , 0:0:0, 0:0:0, 0:0:0, 0:0:0, 0:0:0);
    if (  OE_N==1'b0 & DM[2]==1'b1 & DM[1]==1'b1 & DM[0]==1'b1 & SLOW==1'b0 ) ( OUT => PAD ) = (0:0:0 , 0:0:0);
    if (  OE_N==1'b0 & DM[2]==1'b1 & DM[1]==1'b0 & DM[0]==1'b0 & SLOW==1'b1 ) ( OUT => PAD) = (0:0:0 , 0:0:0, 0:0:0, 0:0:0, 0:0:0, 0:0:0);
    if (  OE_N==1'b0 & DM[2]==1'b1 & DM[1]==1'b1 & DM[0]==1'b1 & SLOW==1'b1 ) ( OUT => PAD) = (0:0:0 , 0:0:0);
    if (  OE_N==1'b0 & DM[2]==1'b1 & DM[1]==1'b0 & DM[0]==1'b1 & SLOW==1'b0 ) ( OUT => PAD) = (0:0:0 , 0:0:0, 0:0:0, 0:0:0, 0:0:0, 0:0:0);
    if (  DM[2]==1'b1 & DM[1]==1'b1 & DM[0]==1'b0 & SLOW==1'b0 ) ( OE_N => PAD) = (0:0:0 , 0:0:0, 0:0:0, 0:0:0, 0:0:0, 0:0:0);
    if (  OE_N==1'b0 & DM[2]==1'b1 & DM[1]==1'b0 & DM[0]==1'b1 & SLOW==1'b1 ) ( OUT => PAD) = (0:0:0 , 0:0:0, 0:0:0, 0:0:0, 0:0:0, 0:0:0);
    if (  DM[2]==1'b1 & DM[1]==1'b1 & DM[0]==1'b0 & SLOW==1'b1 ) ( OE_N => PAD) = (0:0:0 , 0:0:0, 0:0:0, 0:0:0, 0:0:0, 0:0:0);
    if (  DM[2]==1'b1 & DM[1]==1'b0 & DM[0]==1'b0 & SLOW==1'b0 ) ( OE_N => PAD) = (0:0:0 , 0:0:0, 0:0:0, 0:0:0, 0:0:0, 0:0:0);
    if (  DM[2]==1'b1 & DM[1]==1'b1 & DM[0]==1'b1 & SLOW==1'b0 ) ( OE_N => PAD) = (0:0:0 , 0:0:0, 0:0:0, 0:0:0, 0:0:0, 0:0:0);
    if (  DM[2]==1'b1 & DM[1]==1'b0 & DM[0]==1'b0 & SLOW==1'b1 ) ( OE_N => PAD) = (0:0:0 , 0:0:0, 0:0:0, 0:0:0, 0:0:0, 0:0:0);
    if (  DM[2]==1'b1 & DM[1]==1'b1 & DM[0]==1'b1 & SLOW==1'b1 ) ( OE_N => PAD) = (0:0:0 , 0:0:0, 0:0:0, 0:0:0, 0:0:0, 0:0:0);
    if (  DM[2]==1'b1 & DM[1]==1'b0 & DM[0]==1'b1 & SLOW==1'b0 ) ( OE_N => PAD) = (0:0:0 , 0:0:0, 0:0:0, 0:0:0, 0:0:0, 0:0:0);
    if (  DM[2]==1'b1 & DM[1]==1'b0 & DM[0]==1'b1 & SLOW==1'b1 ) ( OE_N => PAD) = (0:0:0 , 0:0:0, 0:0:0, 0:0:0, 0:0:0, 0:0:0);
    if (  DM[2]==1'b0 & DM[1]==1'b1 & DM[0]==1'b0 & SLOW==1'b0 ) ( OE_N => PAD) = (0:0:0 , 0:0:0, 0:0:0, 0:0:0, 0:0:0, 0:0:0);
    if (  DM[2]==1'b0 & DM[1]==1'b1 & DM[0]==1'b0 & SLOW==1'b1 ) ( OE_N => PAD) = (0:0:0 , 0:0:0, 0:0:0, 0:0:0, 0:0:0, 0:0:0);
    if (  IB_MODE_SEL==1'b1  ) ( PAD => IN) = (0:0:0 , 0:0:0);
    if (  IB_MODE_SEL==1'b1  ) ( PAD => IN_H) = (0:0:0 , 0:0:0);
    if (  DM[2]==1'b0 & DM[1]==1'b1 & DM[0]==1'b1 & SLOW==1'b0 ) ( OE_N => PAD) = (0:0:0 , 0:0:0, 0:0:0, 0:0:0, 0:0:0, 0:0:0);
    if (  DM[2]==1'b0 & DM[1]==1'b1 & DM[0]==1'b1 & SLOW==1'b1 ) ( OE_N => PAD) = (0:0:0 , 0:0:0, 0:0:0, 0:0:0, 0:0:0, 0:0:0);
    if (  OE_N==1'b0 & DM[2]==1'b0 & DM[1]==1'b1 & DM[0]==1'b0 & SLOW==1'b0 ) ( OUT => PAD) = (0:0:0 , 0:0:0);
    if (  OE_N==1'b0 & DM[2]==1'b0 & DM[1]==1'b1 & DM[0]==1'b0 & SLOW==1'b1 ) ( OUT=>  PAD) = (0:0:0 , 0:0:0);
    if (  OE_N==1'b0 & DM[2]==1'b0 & DM[1]==1'b1 & DM[0]==1'b1 & SLOW==1'b0 ) ( OUT => PAD) = (0:0:0 , 0:0:0);
    if (  IB_MODE_SEL==1'b0 & VTRIP_SEL==1'b0  ) ( PAD => IN) = (0:0:0 , 0:0:0);
    if (  IB_MODE_SEL==1'b0 & VTRIP_SEL==1'b0  ) ( PAD => IN_H) = (0:0:0 , 0:0:0);
    if (  OE_N==1'b0 & DM[2]==1'b0 & DM[1]==1'b1 & DM[0]==1'b1 & SLOW==1'b1 ) ( OUT => PAD) = (0:0:0 , 0:0:0);
    $width  (negedge HLD_H_N,	      (15.500:0:15.500));
    $width  (posedge HLD_H_N,	      (15.500:0:15.500));
    $width  (negedge HLD_OVR,	      (15.500:0:15.500));
    $width  (posedge HLD_OVR,	      (15.500:0:15.500));
    specparam tsetup = 5;
    specparam tsetup1 = 0;
    specparam thold = 5;
    $setuphold (posedge ENABLE_H,     negedge HLD_H_N,      tsetup, thold,  notifier_enable_h);
    $setuphold (posedge ENABLE_VDDIO, posedge ENABLE_H,     tsetup1, thold,  notifier_enable_h);
    $setuphold (negedge ENABLE_H,     negedge ENABLE_VDDIO, tsetup1, thold,  notifier_enable_h);
    $setuphold (negedge HLD_H_N, posedge HLD_OVR,    tsetup, thold,  notifier_hld_ovr,   ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, hld_ovr_del);
    $setuphold (negedge HLD_H_N, negedge HLD_OVR,    tsetup, thold,  notifier_hld_ovr,   ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, hld_ovr_del);
    $setuphold (negedge HLD_H_N, posedge DM[2],      tsetup, thold,  notifier_dm,	 ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, dm_del[2]);
    $setuphold (negedge HLD_H_N, negedge DM[2],      tsetup, thold,  notifier_dm,	 ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, dm_del[2]);
    $setuphold (negedge HLD_H_N, posedge DM[1],      tsetup, thold,  notifier_dm,	 ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, dm_del[1]);
    $setuphold (negedge HLD_H_N, negedge DM[1],      tsetup, thold,  notifier_dm,	 ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, dm_del[1]);
    $setuphold (negedge HLD_H_N, posedge DM[0],      tsetup, thold,  notifier_dm,	 ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, dm_del[0]);
    $setuphold (negedge HLD_H_N, negedge DM[0],      tsetup, thold,  notifier_dm,	 ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, dm_del[0]);
    $setuphold (negedge HLD_H_N, posedge INP_DIS,    tsetup, thold,  notifier_inp_dis,   ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, inp_dis_del);
    $setuphold (negedge HLD_H_N, negedge INP_DIS,    tsetup, thold,  notifier_inp_dis,   ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, inp_dis_del);
    $setuphold (negedge HLD_H_N, posedge VTRIP_SEL,  tsetup, thold,  notifier_vtrip_sel, ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, vtrip_sel_del);
    $setuphold (negedge HLD_H_N, negedge VTRIP_SEL,  tsetup, thold,  notifier_vtrip_sel, ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, vtrip_sel_del);
    $setuphold (negedge HLD_H_N, posedge SLOW,       tsetup, thold,  notifier_slow,	 ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, slow_del);
    $setuphold (negedge HLD_H_N, negedge SLOW,       tsetup, thold,  notifier_slow,	 ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, slow_del);
    $setuphold (negedge HLD_H_N, posedge OE_N,       tsetup, thold,  notifier_oe_n,	 ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, oe_n_del);
    $setuphold (negedge HLD_H_N, negedge OE_N,       tsetup, thold,  notifier_oe_n,	 ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, oe_n_del);
    $setuphold (negedge HLD_H_N, posedge OUT,        tsetup, thold,  notifier_out,	 ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, out_del);
    $setuphold (negedge HLD_H_N, negedge OUT,        tsetup, thold,  notifier_out,	 ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, out_del);
    $setuphold (negedge HLD_H_N, posedge IB_MODE_SEL,tsetup, thold,  notifier_ib_mode_sel,ENABLE_H==1'b1,ENABLE_H==1'b1, hld_h_n_del,ib_mode_sel_del);
    $setuphold (negedge HLD_H_N, negedge IB_MODE_SEL,tsetup, thold,  notifier_ib_mode_sel,ENABLE_H==1'b1,ENABLE_H==1'b1, hld_h_n_del,ib_mode_sel_del);
    $setuphold (posedge HLD_H_N, posedge HLD_OVR,    tsetup, thold,  notifier_hld_ovr,   ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, hld_ovr_del);
    $setuphold (posedge HLD_H_N, negedge HLD_OVR,    tsetup, thold,  notifier_hld_ovr,   ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, hld_ovr_del);
    $setuphold (posedge HLD_H_N, posedge DM[2],      tsetup, thold,  notifier_dm,	 ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, dm_del[2]);
    $setuphold (posedge HLD_H_N, negedge DM[2],      tsetup, thold,  notifier_dm,	 ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, dm_del[2]);
    $setuphold (posedge HLD_H_N, posedge DM[1],      tsetup, thold,  notifier_dm,	 ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, dm_del[1]);
    $setuphold (posedge HLD_H_N, negedge DM[1],      tsetup, thold,  notifier_dm,	 ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, dm_del[1]);
    $setuphold (posedge HLD_H_N, posedge DM[0],      tsetup, thold,  notifier_dm,	 ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, dm_del[0]);
    $setuphold (posedge HLD_H_N, negedge DM[0],      tsetup, thold,  notifier_dm,	 ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, dm_del[0]);
    $setuphold (posedge HLD_H_N, posedge INP_DIS,    tsetup, thold,  notifier_inp_dis,   ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, inp_dis_del);
    $setuphold (posedge HLD_H_N, negedge INP_DIS,    tsetup, thold,  notifier_inp_dis,   ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, inp_dis_del);
    $setuphold (posedge HLD_H_N, posedge VTRIP_SEL,  tsetup, thold,  notifier_vtrip_sel, ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, vtrip_sel_del);
    $setuphold (posedge HLD_H_N, negedge VTRIP_SEL,  tsetup, thold,  notifier_vtrip_sel, ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, vtrip_sel_del);
    $setuphold (posedge HLD_H_N, posedge SLOW,       tsetup, thold,  notifier_slow,	 ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, slow_del);
    $setuphold (posedge HLD_H_N, negedge SLOW,       tsetup, thold,  notifier_slow,	 ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, slow_del);
    $setuphold (posedge HLD_H_N, posedge OE_N,       tsetup, thold,  notifier_oe_n,	 ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, oe_n_del);
    $setuphold (posedge HLD_H_N, negedge OE_N,       tsetup, thold,  notifier_oe_n,	 ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, oe_n_del);
    $setuphold (posedge HLD_H_N, posedge OUT,        tsetup, thold,  notifier_out,	 ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, out_del);
    $setuphold (posedge HLD_H_N, negedge OUT,        tsetup, thold,  notifier_out,	 ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, out_del);
    $setuphold (posedge HLD_H_N, posedge IB_MODE_SEL,tsetup, thold,  notifier_ib_mode_sel,ENABLE_H==1'b1,ENABLE_H==1'b1,hld_h_n_del,ib_mode_sel_del);
    $setuphold (posedge HLD_H_N, negedge IB_MODE_SEL,tsetup, thold,  notifier_ib_mode_sel,ENABLE_H==1'b1,ENABLE_H==1'b1,hld_h_n_del,ib_mode_sel_del);
    $setuphold (posedge HLD_OVR,    negedge HLD_H_N, tsetup, thold,  notifier_hld_ovr,	ENABLE_H==1'b1, ENABLE_H==1'b1,  hld_ovr_del, 	hld_h_n_del);
    $setuphold (posedge DM[2],      negedge HLD_H_N, tsetup, thold,  notifier_dm,	ENABLE_H==1'b1, ENABLE_H==1'b1,  dm_del[2], 	hld_h_n_del);
    $setuphold (posedge DM[1],      negedge HLD_H_N, tsetup, thold,  notifier_dm,	ENABLE_H==1'b1, ENABLE_H==1'b1,  dm_del[1], 	hld_h_n_del);
    $setuphold (posedge DM[0],      negedge HLD_H_N, tsetup, thold,  notifier_dm,	ENABLE_H==1'b1, ENABLE_H==1'b1,  dm_del[0], 	hld_h_n_del);
    $setuphold (posedge INP_DIS,    negedge HLD_H_N, tsetup, thold,  notifier_inp_dis,	ENABLE_H==1'b1, ENABLE_H==1'b1,  inp_dis_del, 	hld_h_n_del);
    $setuphold (posedge VTRIP_SEL,  negedge HLD_H_N, tsetup, thold,  notifier_vtrip_sel, ENABLE_H==1'b1, ENABLE_H==1'b1, vtrip_sel_del, hld_h_n_del);
    $setuphold (posedge SLOW,	    negedge HLD_H_N, tsetup, thold,  notifier_slow,	ENABLE_H==1'b1, ENABLE_H==1'b1,  slow_del, 	hld_h_n_del);
    $setuphold (posedge OE_N,	    negedge HLD_H_N, tsetup, thold,  notifier_oe_n,	ENABLE_H==1'b1, ENABLE_H==1'b1,  oe_n_del, 	hld_h_n_del);
    $setuphold (posedge OUT,	    negedge HLD_H_N, tsetup, thold,  notifier_out,	ENABLE_H==1'b1, ENABLE_H==1'b1,  out_del, 	hld_h_n_del);
    $setuphold (posedge IB_MODE_SEL,negedge HLD_H_N, tsetup, thold,  notifier_ib_mode_sel,ENABLE_H==1'b1,ENABLE_H==1'b1, ib_mode_sel_del, hld_h_n_del);
endspecify
wire  pwr_good_amux	      	= 1;
wire  pwr_good_inpbuff_hv      	= 1;
wire  pwr_good_inpbuff_lv       = 1;
wire  pwr_good_output_driver  	= 1;
wire  pwr_good_hold_mode	= 1;
wire  pwr_good_hold_ovr_mode	= 1;
wire  pwr_good_active_mode      = 1;
wire  pwr_good_hold_mode_vdda	= 1;
wire  pwr_good_active_mode_vdda	= 1;
wire pwr_good_amux_vccd         = 1;
wire  pwr_good_analog_en_vdda   = 1;
wire  pwr_good_analog_en_vddio_q = 1;
wire  pwr_good_analog_en_vswitch = 1;
parameter MAX_WARNING_COUNT = 100;
wire pad_tristate = oe_n_final === 1 || dm_final === 3'b000 || dm_final === 3'b001;
wire x_on_pad  =  !pwr_good_output_driver
     || (dm_final !== 3'b000 && dm_final !== 3'b001 && oe_n_final===1'bx)
     || (^dm_final[2:0] === 1'bx && oe_n_final===1'b0)
     || (slow_final===1'bx && dm_final !== 3'b000 && dm_final !== 3'b001 && oe_n_final===1'b0);
`ifdef SKY130_FD_IO_TOP_GPIOV2_SLOW_BEHV
parameter SLOW_1_DELAY= 70;
parameter SLOW_0_DELAY= 40;
`else
parameter SLOW_1_DELAY= 0;
parameter SLOW_0_DELAY= 0;
`endif
integer slow_1_delay,slow_0_delay,slow_delay;
initial slow_1_delay = SLOW_1_DELAY;
initial slow_0_delay = SLOW_0_DELAY;
always @(*)
begin
    if (SLOW===1)
        slow_delay = slow_1_delay;
    else
        slow_delay = slow_0_delay;
end
bufif1 (pull1, strong0) #slow_delay dm2 (PAD, out_final, x_on_pad===1 ? 1'bx : (pad_tristate===0 && dm_final===3'b010));
bufif1 (strong1, pull0) #slow_delay dm3 (PAD, out_final, x_on_pad===1 ? 1'bx : (pad_tristate===0 && dm_final===3'b011));
bufif1 (highz1, strong0) #slow_delay dm4 (PAD, out_final, x_on_pad===1 ? 1'bx : (pad_tristate===0 && dm_final===3'b100));
bufif1 (strong1, highz0) #slow_delay dm5 (PAD, out_final, x_on_pad===1 ? 1'bx : (pad_tristate===0 && dm_final===3'b101));
bufif1 (strong1, strong0) #slow_delay dm6 (PAD, out_final, x_on_pad===1 ? 1'bx : (pad_tristate===0 && dm_final===3'b110));
bufif1 (pull1, pull0)  #slow_delay dm7 (PAD, out_final, x_on_pad===1 ? 1'bx : (pad_tristate===0 && dm_final===3'b111));
tran pad_esd_1 (PAD,PAD_A_NOESD_H);
tran pad_esd_2 (PAD,PAD_A_ESD_0_H);
tran pad_esd_3 (PAD,PAD_A_ESD_1_H);
wire x_on_in_hv  =  (ENABLE_H===0  && ^ENABLE_INP_H===1'bx)
     || (inp_dis_final===1'bx  && ^dm_final[2:0]!==1'bx && dm_final !== 3'b000)
     || (^ENABLE_H===1'bx)
     || (inp_dis_final===0 	       	&& ^dm_final[2:0] === 1'bx)
     || (ib_mode_sel_final===1'bx  	&& inp_dis_final===0        && dm_final !== 3'b000)
     || (^ENABLE_VDDIO===1'bx    	&& inp_dis_final===0        && dm_final !== 3'b000	&& ib_mode_sel_final===1'b1)
     || (vtrip_sel_final===1'bx    	&& inp_dis_final===0        && dm_final !== 3'b000	&& ib_mode_sel_final===1'b0);
wire x_on_in_lv  =  (ENABLE_H===0  && ^ENABLE_INP_H===1'bx)
     || (inp_dis_final===1'bx  && ^dm_final[2:0]!==1'bx && dm_final !== 3'b000)
     || (ENABLE_H===0  && ^ENABLE_VDDIO===1'bx)
     || (^ENABLE_H===1'bx)
     || (inp_dis_final===0 	       	&& ^dm_final[2:0] === 1'bx)
     || (ib_mode_sel_final===1'bx  	&& inp_dis_final===0        && dm_final !== 3'b000)
     || (^ENABLE_VDDIO===1'bx    	&& inp_dis_final===0        && dm_final !== 3'b000)
     || (vtrip_sel_final===1'bx    	&& inp_dis_final===0        && dm_final !== 3'b000	&& ib_mode_sel_final===1'b0);
wire disable_inp_buff = ENABLE_H===1 ? (dm_final===3'b000 || inp_dis_final===1) : ENABLE_INP_H===0;
assign IN_H = (x_on_in_hv===1 || pwr_good_inpbuff_hv===0) ? 1'bx : (disable_inp_buff===1 ? 0 : (^PAD===1'bx ? 1'bx : PAD));
wire disable_inp_buff_lv = ENABLE_H===1 ? (dm_final===3'b000 || inp_dis_final===1) : ENABLE_VDDIO===0;
assign IN =   (x_on_in_lv===1 || pwr_good_inpbuff_lv===0 ) ? 1'bx : (disable_inp_buff_lv===1 ? 0 : (^PAD===1'bx ? 1'bx : PAD));
assign TIE_HI_ESD = vddio===1'b1 ? 1'b1 : 1'bx;
assign TIE_LO_ESD = vssio===1'b0 ? 1'b0 : 1'bx;
wire timing_mode_amux = (pwr_good_analog_en_vdda ===1 && pwr_good_analog_en_vddio_q ===1 && pwr_good_analog_en_vswitch ===1 );
wire x_on_analog_en_vdda = (pwr_good_analog_en_vdda !==1
                            || (timing_mode_amux ==1 && (ENABLE_H !==0 && ^hld_h_n_buf === 1'bx) || (hld_h_n_buf!== 0 && ^ENABLE_H=== 1'bx) || pwr_good_amux_vccd !==1 )
                            || (timing_mode_amux ==1 && (hld_h_n_buf ===1 && ENABLE_H===1 && ^ANALOG_EN === 1'bx && ENABLE_VDDA_H ===1 && ENABLE_VSWITCH_H===1 ) || (hld_h_n_buf ===1 && ENABLE_H===1 && ANALOG_EN ===0 && ^ENABLE_VDDA_H ===1'bx) ));
wire zero_on_analog_en_vdda = ( (pwr_good_analog_en_vdda ===1 && ENABLE_VDDA_H ===0)
                                || (pwr_good_analog_en_vdda ===1 && pwr_good_analog_en_vddio_q ===1 && hld_h_n_buf===0)
                                || (pwr_good_analog_en_vdda ===1 && pwr_good_analog_en_vddio_q ===1 && ENABLE_H===0)
                                ||  (pwr_good_analog_en_vdda ===1 && pwr_good_analog_en_vddio_q ===1 && pwr_good_amux_vccd && ANALOG_EN===0) );
wire x_on_analog_en_vddio_q =  ( pwr_good_analog_en_vddio_q !==1
                                 || (timing_mode_amux ==1 && (ENABLE_H !==0 && ^hld_h_n_buf === 1'bx) || (hld_h_n_buf!== 0 && ^ENABLE_H=== 1'bx) || pwr_good_amux_vccd !==1 )
                                 || (timing_mode_amux ==1 && (hld_h_n_buf ===1 && ENABLE_H===1 && ^ANALOG_EN === 1'bx && ENABLE_VDDA_H ===1 && ENABLE_VSWITCH_H===1 ) ));
wire zero_on_analog_en_vddio_q =  ( (pwr_good_analog_en_vddio_q ===1 && hld_h_n_buf===0)
                                    || (pwr_good_analog_en_vddio_q ===1 && ENABLE_H===0)
                                    ||  (pwr_good_analog_en_vddio_q ===1 && pwr_good_amux_vccd && ANALOG_EN===0) );
wire x_on_analog_en_vswitch = (pwr_good_analog_en_vswitch !==1
                               || (timing_mode_amux ==1 && (ENABLE_H !==0 && ^hld_h_n_buf === 1'bx) || (hld_h_n_buf!== 0 && ^ENABLE_H=== 1'bx) || pwr_good_amux_vccd !==1 )
                               || (timing_mode_amux ==1 && (hld_h_n_buf ===1 && ENABLE_H===1 && ^ANALOG_EN === 1'bx && ENABLE_VDDA_H ===1 && ENABLE_VSWITCH_H===1 ) || (hld_h_n_buf ===1 && ENABLE_H===1 && ANALOG_EN ===0 && ^ENABLE_VSWITCH_H ===1'bx) ));
wire  zero_on_analog_en_vswitch =   ( (pwr_good_analog_en_vswitch ===1 && ENABLE_VSWITCH_H ===0)
                                      || (pwr_good_analog_en_vswitch ===1 && pwr_good_analog_en_vddio_q ===1 && hld_h_n_buf===0)
                                      || (pwr_good_analog_en_vswitch ===1 && pwr_good_analog_en_vddio_q ===1 && ENABLE_H===0)
                                      ||  (pwr_good_analog_en_vswitch ===1 && pwr_good_analog_en_vddio_q ===1 && pwr_good_amux_vccd && ANALOG_EN===0) );
always @(*)
begin : LATCH_dm
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode || (ENABLE_H===1 && ^hld_h_n_buf===1'bx))
    begin
        dm_final 	<= 3'bxxx;
    end
    else if (ENABLE_H===0)
    begin
        dm_final 	<= 3'b000;
    end
    else if (hld_h_n_buf===1)
    begin
        dm_final 	<= (^dm_buf[2:0]	=== 1'bx	|| !pwr_good_active_mode) ? 3'bxxx : dm_buf;
    end
end
always @(notifier_enable_h or notifier_dm)
begin
    disable LATCH_dm; dm_final <= 3'bxxx;
end
always @(*)
begin : LATCH_inp_dis
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode || (ENABLE_H===1 && ^hld_h_n_buf===1'bx))
    begin
        inp_dis_final 	<= 1'bx;
    end
    else if (ENABLE_H===0)
    begin
        inp_dis_final 	<= 1'b1;
    end
    else if (hld_h_n_buf===1)
    begin
        inp_dis_final 	<= (^inp_dis_buf === 1'bx	|| !pwr_good_active_mode) ? 1'bx : inp_dis_buf;
    end
end
always @(notifier_enable_h or notifier_inp_dis)
begin
    disable LATCH_inp_dis; inp_dis_final <= 1'bx;
end
always @(*)
begin : LATCH_vtrip_sel
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode || (ENABLE_H===1 && ^hld_h_n_buf===1'bx))
    begin
        vtrip_sel_final 	<= 1'bx;
    end
    else if (ENABLE_H===0)
    begin
        vtrip_sel_final 	<= 1'b0;
    end
    else if (hld_h_n_buf===1)
    begin
        vtrip_sel_final 	<= (^vtrip_sel_buf === 1'bx	|| !pwr_good_active_mode) ? 1'bx : vtrip_sel_buf;
    end
end
always @(notifier_enable_h or notifier_vtrip_sel)
begin
    disable LATCH_vtrip_sel; vtrip_sel_final <= 1'bx;
end
always @(*)
begin : LATCH_ib_mode_sel
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode || (ENABLE_H===1 && ^hld_h_n_buf===1'bx))
    begin
        ib_mode_sel_final 	<= 1'bx;
    end
    else if (ENABLE_H===0)
    begin
        ib_mode_sel_final 	<= 1'b0;
    end
    else if (hld_h_n_buf===1)
    begin
        ib_mode_sel_final 	<= (^ib_mode_sel_buf === 1'bx	|| !pwr_good_active_mode) ? 1'bx : ib_mode_sel_buf;
    end
end
always @(notifier_enable_h or notifier_ib_mode_sel)
begin
    disable LATCH_ib_mode_sel; ib_mode_sel_final <= 1'bx;
end
always @(*)
begin : LATCH_slow
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode || (ENABLE_H===1 && ^hld_h_n_buf===1'bx))
    begin
        slow_final 	<= 1'bx;
    end
    else if (ENABLE_H===0)
    begin
        slow_final 	<= 1'b0;
    end
    else if (hld_h_n_buf===1)
    begin
        slow_final 	<= (^slow_buf === 1'bx	|| !pwr_good_active_mode) ? 1'bx : slow_buf;
    end
end
always @(notifier_enable_h or notifier_slow)
begin
    disable LATCH_slow; slow_final <= 1'bx;
end
always @(*)
begin : LATCH_hld_ovr
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode || (ENABLE_H===1 && ^hld_h_n_buf===1'bx))
    begin
        hld_ovr_final 	<= 1'bx;
    end
    else if (ENABLE_H===0)
    begin
        hld_ovr_final 	<= 1'b0;
    end
    else if (hld_h_n_buf===1)
    begin
        hld_ovr_final 	<= (^hld_ovr_buf === 1'bx	|| !pwr_good_active_mode) ? 1'bx : hld_ovr_buf;
    end
end
always @(notifier_enable_h or notifier_hld_ovr)
begin
    disable LATCH_hld_ovr; hld_ovr_final <= 1'bx;
end
always @(*)
begin : LATCH_oe_n
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode || (ENABLE_H===1 && (^hld_h_n_buf===1'bx || (hld_h_n_buf===0 && hld_ovr_final===1'bx) || (hld_h_n_buf===1 && hld_ovr_final===1'bx))))
    begin
        oe_n_final 	<= 1'bx;
    end
    else if (ENABLE_H===0)
    begin
        oe_n_final 	<= 1'b1;
    end
    else if (hld_h_n_buf===1 || hld_ovr_final===1)
    begin
        oe_n_final  	<= (^oe_n_buf  === 1'bx  || !pwr_good_hold_ovr_mode) ? 1'bx   : oe_n_buf;
    end
end
always @(notifier_enable_h or notifier_oe_n)
begin
    disable LATCH_oe_n; oe_n_final <= 1'bx;
end
always @(*)
begin : LATCH_out
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode || (ENABLE_H===1 && (^hld_h_n_buf===1'bx ||(hld_h_n_buf===0 &&  hld_ovr_final===1'bx || (hld_h_n_buf===1 && hld_ovr_final===1'bx)))))
    begin
        out_final 	<= 1'bx;
    end
    else if (ENABLE_H===0)
    begin
        out_final 	<= 1'b1;
    end
    else if (hld_h_n_buf===1 || hld_ovr_final===1)
    begin
        out_final  	<= (^out_buf  === 1'bx  || !pwr_good_hold_ovr_mode) ? 1'bx   : out_buf;
    end
end
always @(notifier_enable_h or notifier_out)
begin
    disable LATCH_out; out_final <= 1'bx;
end
always @(*)
begin
    if (x_on_analog_en_vdda ===1 )
    begin
        analog_en_vdda <= 1'bx;
    end
    else if ( zero_on_analog_en_vdda ===1 )
    begin
        analog_en_vdda <= 1'b0;
    end
    else if (x_on_analog_en_vdda !==1 && zero_on_analog_en_vdda !==1)
    begin
        analog_en_vdda <= ANALOG_EN;
    end
    if (x_on_analog_en_vddio_q  ===1 )
    begin
        analog_en_vddio_q  <= 1'bx;
    end
    else if ( zero_on_analog_en_vddio_q ===1 )
    begin
        analog_en_vddio_q  <= 1'b0;
    end
    else if ( x_on_analog_en_vddio_q !==1 && zero_on_analog_en_vddio_q !==1)
    begin
        analog_en_vddio_q  <= ANALOG_EN;
    end
    if (x_on_analog_en_vswitch  ===1 )
    begin
        analog_en_vswitch  <= 1'bx;
    end
    else if ( zero_on_analog_en_vswitch ===1 )
    begin
        analog_en_vswitch  <= 1'b0;
    end
    else if (x_on_analog_en_vswitch !==1 && zero_on_analog_en_vswitch !==1)
    begin
        analog_en_vswitch  <= ANALOG_EN;
    end
    if ( (analog_en_vswitch ===1'bx && analog_en_vdda ===1'bx) || (analog_en_vswitch ===1'bx && analog_en_vddio_q ===1'bx) || (analog_en_vddio_q ===1'bx && analog_en_vdda ===1'bx ) )
    begin
        analog_en_final  <= 1'bx;
    end
    else if (analog_en_vdda ===1'bx && (analog_en_vddio_q ===1 ||analog_en_vswitch===1 ))
    begin
        analog_en_final  <= 1'bx;
    end
    else if (analog_en_vddio_q ===1'bx && (analog_en_vdda ===1 ||analog_en_vswitch===1 ))
    begin
        analog_en_final  <= 1'bx;
    end
    else if (analog_en_vswitch===1'bx && (analog_en_vdda ===1 || analog_en_vddio_q ===1 ))
    begin
        analog_en_final  <= 1'bx;
    end
    else if ((analog_en_vdda ===0 && analog_en_vddio_q ===0 )|| (analog_en_vdda ===0 && analog_en_vswitch===0 ) ||  (analog_en_vddio_q ===0 && analog_en_vswitch===0 ))
    begin
        analog_en_final  <=0;
    end
    else if (analog_en_vdda ===1 && analog_en_vddio_q ===1 &&  analog_en_vswitch ===1)
    begin
        analog_en_final  <=1;
    end
end
wire [2:0] amux_select = {ANALOG_SEL, ANALOG_POL, out_buf};
wire invalid_controls_amux = 	(analog_en_final===1'bx && inp_dis_final===1)
     || !pwr_good_amux
     || (analog_en_final===1 && ^amux_select[2:0] === 1'bx && inp_dis_final===1);
wire enable_pad_amuxbus_a = invalid_controls_amux  ? 1'bx : (amux_select===3'b001 || amux_select===3'b010) && (analog_en_final===1);
wire enable_pad_amuxbus_b = invalid_controls_amux  ? 1'bx : (amux_select===3'b101 || amux_select===3'b110) && (analog_en_final===1);
wire enable_pad_vssio_q   = invalid_controls_amux  ? 1'bx : (amux_select===3'b100 || amux_select===3'b000) && (analog_en_final===1);
wire enable_pad_vddio_q   = invalid_controls_amux  ? 1'bx : (amux_select===3'b011 || amux_select===3'b111) && (analog_en_final===1);
tranif1 pad_amuxbus_a 	(PAD, AMUXBUS_A, enable_pad_amuxbus_a);
tranif1 pad_amuxbus_b 	(PAD, AMUXBUS_B, enable_pad_amuxbus_b);
bufif1 pad_vddio_q	(PAD, vddio_q,   enable_pad_vddio_q);
bufif1 pad_vssio_q   	(PAD, vssio_q,   enable_pad_vssio_q);
reg dis_err_msgs;
integer msg_count_pad,msg_count_pad1,msg_count_pad2,msg_count_pad3,msg_count_pad4,msg_count_pad5,msg_count_pad6,msg_count_pad7,msg_count_pad8,msg_count_pad9,msg_count_pad10,msg_count_pad11,msg_count_pad12;
initial
begin
    dis_err_msgs = 1'b1;
    msg_count_pad  = 0;
    msg_count_pad1 = 0;
    msg_count_pad2 = 0;
    msg_count_pad3 = 0;
    msg_count_pad4 = 0;
    msg_count_pad5 = 0;
    msg_count_pad6 = 0;
    msg_count_pad7 = 0;
    msg_count_pad8 = 0;
    msg_count_pad9 = 0;
    msg_count_pad10 = 0;
    msg_count_pad11 = 0;
    msg_count_pad12  = 0;
`ifdef SKY130_FD_IO_TOP_GPIOV2_DIS_ERR_MSGS
`else
    #1;
    dis_err_msgs = 1'b0;
`endif
end
wire #100 error_enable_vddio = (ENABLE_VDDIO===0 && ENABLE_H===1);
event event_error_enable_vddio;
always @(error_enable_vddio)
begin
    if (!dis_err_msgs)
    begin
        if (error_enable_vddio===1)
        begin
            msg_count_pad = msg_count_pad + 1;
            ->event_error_enable_vddio;
            if (msg_count_pad <= MAX_WARNING_COUNT)
            begin
                $display(" ===ERROR=== sky130_fd_io__top_gpiov2 :  Enable_h (= %b) and ENABLE_VDDIO (= %b) are complement of each other. This is an illegal combination as ENABLE_VDDIO and ENABLE_H are the same input signals IN different power domains %m", ENABLE_H, ENABLE_VDDIO, $stime);
            end
            else
                if (msg_count_pad == MAX_WARNING_COUNT+1)
                begin
                    $display(" ===WARNING=== sky130_fd_io__top_gpiov2 :  Further WARNING messages will be suppressed as the message count has exceeded 100 %m",$stime);
                end
        end
    end
end
wire #100 error_vdda = ( vdda===1 && vddio_q !==1 && ENABLE_VDDA_H===1 );
event event_error_vdda;
always @(error_vdda)
begin
    if (!dis_err_msgs)
    begin
        if (error_vdda===1)
        begin
            msg_count_pad1 = msg_count_pad1 + 1;
            ->event_error_vdda;
            if (msg_count_pad1 <= MAX_WARNING_COUNT)
            begin
                $display(" ===ERROR=== sky130_fd_io__top_gpiov2 : ENABLE_VDDA_H (= %b) cannot be 1 when vdda (= %b) and vddio_q (= %b) %m",ENABLE_VDDA_H, vdda,vddio_q,$stime);
            end
            else
                if (msg_count_pad1 == MAX_WARNING_COUNT+1)
                begin
                    $display(" ===WARNING=== sky130_fd_io__top_gpiov2 :  Further WARNING messages will be suppressed as the message count has exceeded 100 %m",$stime);
                end
        end
    end
end
wire #100 error_vdda2 = ( vdda===1 && vddio_q ===1 && vswitch !==1 && ENABLE_H===1 && hld_h_n_buf ===1  &&  vccd===1 && ANALOG_EN ===1 );
event event_error_vdda2;
always @(error_vdda2)
begin
    if (!dis_err_msgs)
    begin
        if (error_vdda2===1)
        begin
            msg_count_pad2 = msg_count_pad2 + 1;
            ->event_error_vdda2;
            if (msg_count_pad2 <= MAX_WARNING_COUNT)
            begin
                $display(" ===ERROR=== sky130_fd_io__top_gpiov2 : ANALOG_EN (= %b) cannot be 1 when vdda (= %b) , vddio_q (= %b) , vswitch(= %b), ENABLE_H (= %b),hld_h_n_buf (= %b) and vccd (= %b)   %m",ANALOG_EN,vdda,vddio_q,vswitch,ENABLE_H,hld_h_n_buf,vccd,$stime);
            end
            else
                if (msg_count_pad2 == MAX_WARNING_COUNT+1)
                begin
                    $display(" ===WARNING=== sky130_fd_io__top_gpiov2 :  Further WARNING messages will be suppressed as the message count has exceeded 100 %m",$stime);
                end
        end
    end
end
wire #100 error_vdda3 =  ( vdda===1 && vddio_q ===1 && vswitch !==1 && ENABLE_H===1 && hld_h_n_buf ===1  && vccd !==1 );
event event_error_vdda3;
always @(error_vdda3)
begin
    if (!dis_err_msgs)
    begin
        if (error_vdda3===1)
        begin
            msg_count_pad3 = msg_count_pad3 + 1;
            ->event_error_vdda3;
            if (msg_count_pad3 <= MAX_WARNING_COUNT)
            begin
                $display(" ===ERROR=== sky130_fd_io__top_gpiov2 : vccd (= %b) cannot be any value other than 1 when vdda (= %b) , vddio_q (= %b) , vswitch(= %b), ENABLE_H (= %b) and hld_h_n_buf (= %b) %m",vccd,vdda,vddio_q,vswitch,ENABLE_H,hld_h_n_buf,$stime);
            end
            else
                if (msg_count_pad3 == MAX_WARNING_COUNT+1)
                begin
                    $display(" ===WARNING=== sky130_fd_io__top_gpiov2 :  Further WARNING messages will be suppressed as the message count has exceeded 100 %m",$stime);
                end
        end
    end
end
wire #100 error_vswitch1 =  (vdda !==1 && vddio_q !==1 && vswitch ===1 && (ENABLE_VSWITCH_H===1)) ;
event event_error_vswitch1;
always @(error_vswitch1)
begin
    if (!dis_err_msgs)
    begin
        if (error_vswitch1===1)
        begin
            msg_count_pad4 = msg_count_pad4 + 1;
            ->event_error_vswitch1;
            if (msg_count_pad4 <= MAX_WARNING_COUNT)
            begin
                $display(" ===ERROR=== sky130_fd_io__top_gpiov2 : ENABLE_VSWITCH_H (= %b) cannot be 1 when vdda (= %b) , vddio_q (= %b) & vswitch(= %b) %m",ENABLE_VSWITCH_H,vdda,vddio_q,vswitch,$stime);
            end
            else
                if (msg_count_pad4 == MAX_WARNING_COUNT+1)
                begin
                    $display(" ===WARNING=== sky130_fd_io__top_gpiov2 :  Further WARNING messages will be suppressed as the message count has exceeded 100 %m",$stime);
                end
        end
    end
end
wire #100 error_vswitch2 =   (vdda !==1 && vddio_q !==1 && vswitch ===1 && vccd===1 && ANALOG_EN===1);
event event_error_vswitch2;
always @(error_vswitch2)
begin
    if (!dis_err_msgs)
    begin
        if (error_vswitch2===1)
        begin
            msg_count_pad5 = msg_count_pad5 + 1;
            ->event_error_vswitch2;
            if (msg_count_pad5 <= MAX_WARNING_COUNT)
            begin
                $display(" ===ERROR=== sky130_fd_io__top_gpiov2 : ANALOG_EN (= %b) cannot be 1 when vdda (= %b) , vddio_q (= %b) , vswitch(= %b)  & vccd(= %b) %m",ANALOG_EN,vdda,vddio_q,vswitch,vccd,$stime);
            end
            else
                if (msg_count_pad5 == MAX_WARNING_COUNT+1)
                begin
                    $display(" ===WARNING=== sky130_fd_io__top_gpiov2 :  Further WARNING messages will be suppressed as the message count has exceeded 100 %m",$stime);
                end
        end
    end
end
wire #100 error_vswitch3 =   (vdda ===1 && vddio_q !==1 && vswitch ===1 && ENABLE_VSWITCH_H===1);
event event_error_vswitch3;
always @(error_vswitch3)
begin
    if (!dis_err_msgs)
    begin
        if (error_vswitch3===1)
        begin
            msg_count_pad6 = msg_count_pad6 + 1;
            ->event_error_vswitch3;
            if (msg_count_pad6 <= MAX_WARNING_COUNT)
            begin
                $display(" ===ERROR=== sky130_fd_io__top_gpiov2 : ENABLE_VSWITCH_H(= %b) cannot be 1 when vdda (= %b) , vddio_q (= %b) & vswitch(= %b) %m",ENABLE_VSWITCH_H,vdda,vddio_q,vswitch,$stime);
            end
            else
                if (msg_count_pad6 == MAX_WARNING_COUNT+1)
                begin
                    $display(" ===WARNING=== sky130_fd_io__top_gpiov2 :  Further WARNING messages will be suppressed as the message count has exceeded 100 %m",$stime);
                end
        end
    end
end
wire #100 error_vswitch4 =  (vdda !==1 && vddio_q ===1 && vswitch ===1 && ENABLE_VSWITCH_H===1);
event event_error_vswitch4;
always @(error_vswitch4)
begin
    if (!dis_err_msgs)
    begin
        if (error_vswitch4===1)
        begin
            msg_count_pad7 = msg_count_pad7 + 1;
            ->event_error_vswitch4;
            if (msg_count_pad7 <= MAX_WARNING_COUNT)
            begin
                $display(" ===ERROR=== sky130_fd_io__top_gpiov2 : ENABLE_VSWITCH_H(= %b) cannot be 1 when vdda (= %b) , vddio_q (= %b) & vswitch(= %b) %m",ENABLE_VSWITCH_H,vdda,vddio_q,vswitch,$stime);
            end
            else
                if (msg_count_pad7 == MAX_WARNING_COUNT+1)
                begin
                    $display(" ===WARNING=== sky130_fd_io__top_gpiov2 :  Further WARNING messages will be suppressed as the message count has exceeded 100 %m",$stime);
                end
        end
    end
end
wire #100 error_vswitch5 =  (vdda !==1 && vddio_q ===1 && vswitch ===1 && ENABLE_H ===1 && hld_h_n_buf ===1 && vccd ===1 && ANALOG_EN===1);
event event_error_vswitch5;
always @(error_vswitch5)
begin
    if (!dis_err_msgs)
    begin
        if (error_vswitch5===1)
        begin
            msg_count_pad8 = msg_count_pad8 + 1;
            ->event_error_vswitch5;
            if (msg_count_pad8 <= MAX_WARNING_COUNT)
            begin
                $display(" ===ERROR=== sky130_fd_io__top_gpiov2 : ANALOG_EN(= %b) cannot be 1 when vdda (= %b) , vddio_q (= %b) , vswitch(= %b),ENABLE_H (= %b),hld_h_n_buf (= %b) and vccd (= %b) %m",ANALOG_EN,vdda,vddio_q,vswitch,ENABLE_H,hld_h_n_buf,vccd,$stime);
            end
            else
                if (msg_count_pad8 == MAX_WARNING_COUNT+1)
                begin
                    $display(" ===WARNING=== sky130_fd_io__top_gpiov2 :  Further WARNING messages will be suppressed as the message count has exceeded 100 %m",$stime);
                end
        end
    end
end
wire #100 error_vddio_q1 =  (vdda !==1 && vddio_q ===1 && vswitch !==1 && ENABLE_H ===1 && hld_h_n_buf ===1 && vccd!==1);
event event_error_vddio_q1;
always @(error_vddio_q1)
begin
    if (!dis_err_msgs)
    begin
        if (error_vddio_q1===1)
        begin
            msg_count_pad9 = msg_count_pad9 + 1;
            ->event_error_vddio_q1;
            if (msg_count_pad9 <= MAX_WARNING_COUNT)
            begin
                $display(" ===ERROR=== sky130_fd_io__top_gpiov2 : vccd(= %b) cannot be any value other than 1 when vdda (= %b) , vddio_q (= %b) , vswitch(= %b),ENABLE_H (= %b) and hld_h_n_buf (= %b)  %m",vccd,vdda,vddio_q,vswitch,ENABLE_H,hld_h_n_buf,$stime);
            end
            else
                if (msg_count_pad9 == MAX_WARNING_COUNT+1)
                begin
                    $display(" ===WARNING=== sky130_fd_io__top_gpiov2 :  Further WARNING messages will be suppressed as the message count has exceeded 100 %m",$stime);
                end
        end
    end
end
wire #100 error_vddio_q2 =  (vdda !==1 && vddio_q ===1 && vswitch !==1 && ENABLE_H ===1 && hld_h_n_buf ===1 && vccd ===1 && ANALOG_EN===1);
event event_error_vddio_q2;
always @(error_vddio_q2)
begin
    if (!dis_err_msgs)
    begin
        if (error_vddio_q2===1)
        begin
            msg_count_pad10 = msg_count_pad10 + 1;
            ->event_error_vddio_q2;
            if (msg_count_pad10 <= MAX_WARNING_COUNT)
            begin
                $display(" ===ERROR=== sky130_fd_io__top_gpiov2 : ANALOG_EN(= %b) cannot be 1 when vdda (= %b) , vddio_q (= %b) , vswitch(= %b),ENABLE_H (= %b) , hld_h_n_buf (= %b) && vccd (= %b) %m",ANALOG_EN, vdda,vddio_q,vswitch,ENABLE_H,hld_h_n_buf,vccd,$stime);
            end
            else
                if (msg_count_pad10 == MAX_WARNING_COUNT+1)
                begin
                    $display(" ===WARNING=== sky130_fd_io__top_gpiov2 :  Further WARNING messages will be suppressed as the message count has exceeded 100 %m",$stime);
                end
        end
    end
end
wire #100 error_supply_good = ( vdda ===1 && vddio_q ===1 && vswitch ===1  && ENABLE_H ===1 && hld_h_n_buf ===1 && vccd ===1 &&  ANALOG_EN===1 && ENABLE_VSWITCH_H !==1 && ENABLE_VSWITCH_H !==0 );
event event_error_supply_good;
always @(error_supply_good)
begin
    if (!dis_err_msgs)
    begin
        if (error_supply_good===1)
        begin
            msg_count_pad11 = msg_count_pad11 + 1;
            ->event_error_supply_good;
            if (msg_count_pad11 <= MAX_WARNING_COUNT)
            begin
                $display(" ===ERROR=== sky130_fd_io__top_gpiov2 : ENABLE_VSWITCH_H(= %b) should be either 1 or 0 when vdda (= %b) , vddio_q (= %b) , vswitch(= %b), ENABLE_H (= %b), hld_h_n_buf (= %b) ,vccd (= %b) and ANALOG_EN(= %b)  %m",ENABLE_VSWITCH_H, vdda,vddio_q,vswitch,ENABLE_H,hld_h_n_buf,vccd,ANALOG_EN,$stime);
            end
            else
                if (msg_count_pad11 == MAX_WARNING_COUNT+1)
                begin
                    $display(" ===WARNING=== sky130_fd_io__top_gpiov2 :  Further WARNING messages will be suppressed as the message count has exceeded 100 %m",$stime);
                end
        end
    end
end
wire #100 error_vdda_vddioq_vswitch2 = ( vdda ===1 && vddio_q ===1 && vswitch ===1 && ENABLE_H ===1 && hld_h_n_buf ===1 && vccd ===1 &&  ANALOG_EN===1 && ENABLE_VDDA_H !==1 && ENABLE_VDDA_H !==0 );
event event_error_vdda_vddioq_vswitch2;
always @(error_vdda_vddioq_vswitch2)
begin
    if (!dis_err_msgs)
    begin
        if (error_vdda_vddioq_vswitch2===1)
        begin
            msg_count_pad12 = msg_count_pad12 + 1;
            ->event_error_vdda_vddioq_vswitch2;
            if (msg_count_pad12 <= MAX_WARNING_COUNT)
            begin
                $display(" ===ERROR=== sky130_fd_io__top_gpiov2 : ENABLE_VDDA_H(= %b) should be either 1 or 0 when vdda (= %b) , vddio_q (= %b) , vswitch(= %b), ENABLE_H (= %b), hld_h_n_buf (= %b) ,vccd (= %b) and ANALOG_EN(= %b)  %m",ENABLE_VDDA_H, vdda,vddio_q,vswitch,ENABLE_H,hld_h_n_buf,vccd,ANALOG_EN,$stime);
            end
            else
                if (msg_count_pad12 == MAX_WARNING_COUNT+1)
                begin
                    $display(" ===WARNING=== sky130_fd_io__top_gpiov2 :  Further WARNING messages will be suppressed as the message count has exceeded 100 %m",$stime);
                end
        end
    end
end
endmodule
`endif // FUNCTIONAL

`endif // USE_POWER_PINS

`default_nettype wire
`endif  // SKY130_FD_IO__TOP_GPIOV2_V


//--------EOF---------

/**
 * Copyright 2020 The SkyWater PDK Authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 * SPDX-License-Identifier: Apache-2.0
 */

`ifndef SKY130_FD_IO__TOP_GPIOVREFV2_V
`define SKY130_FD_IO__TOP_GPIOVREFV2_V

/**
 * top_gpiovrefv2: Voltage Reference generator for GPIO_OVTV2 block
 *
 * Verilog top module.
 */

`timescale 1ns/1ps
`default_nettype none

module sky130_fd_io__top_gpiovrefv2 ( amuxbus_a, amuxbus_b, 
`ifdef USE_POWER_PINS
    vccd, vcchib, vdda, vddio, vddio_q, vssa, vssd, vssio, vssio_q, vswitch, 
`endif    
    enable_h, hld_h_n, ref_sel, vrefgen_en, vinref );

`ifdef USE_POWER_PINS
  inout vssio_q;
  inout vcchib;
  inout vdda;
  inout vssa;
  inout vccd;
  inout vddio_q;
  inout vddio;
  inout vswitch;
  inout vssio;
  inout vssd;
  wire pwr_good_active_mode = (vddio_q===1) && (vssd===0) && (vcchib===1);
  wire pwr_good_hold_mode   = (vddio_q===1) && (vssd===0);

`else
  supply0 vssio_q;
  supply1 vcchib;
  supply1 vdda;
  supply0 vssa;
  supply1 vccd;
  supply1 vddio_q;
  supply1 vddio;
  supply1 vswitch;
  supply0 vssio;
  supply0 vssd;
  
  wire pwr_good_active_mode = 1;
  wire pwr_good_hold_mode   = 1;
  
`endif  
  
  inout amuxbus_a;
  inout amuxbus_b;
  input vrefgen_en;
  input  [4:0] ref_sel;
  input enable_h;
  input hld_h_n;
  inout vinref;


reg notifier_ref_sel,  notifier_vrefgen_en;
reg notifier_enable_h;

wire [4:0] ref_sel_buf;
wire vrefgen_en_buf, hld_h_n_buf;

wire [4:0] ref_sel_del;
wire vrefgen_en_del, hld_h_n_del;


`ifdef S8IOM0S8_TOP_GPIOVREFV2_DISABLE_STARTUP_DELAY
	parameter STARTUP_DELAY = 0;
`else
	parameter STARTUP_DELAY = 24000;
`endif
// AC_SPEC # FOR STARTUP_DELAY from BROS :  (in 001-70428_0N_HardIP_Tables -> HardIP_AC_Specs_ProdTest -> AC.VREFV2.1)


integer startup_delay;

initial startup_delay = STARTUP_DELAY;

//===================================================================================================================================

// Timing section

`ifdef FUNCTIONAL
	assign ref_sel_buf	= ref_sel;
	assign vrefgen_en_buf	= vrefgen_en;
	assign hld_h_n_buf	= hld_h_n;
`else
	assign ref_sel_buf	= ref_sel_del;
	assign vrefgen_en_buf	= vrefgen_en_del;	
	assign hld_h_n_buf	= hld_h_n_del;

specify
 
       
    $width  (negedge hld_h_n,	      (15.500:0:15.500));
    $width  (posedge hld_h_n,	      (15.500:0:15.500));
   
    specparam tsetup = 5;
    specparam thold = 5;

    $setuphold (posedge enable_h,    negedge hld_h_n,    tsetup, thold,  notifier_enable_h); 
      
    $setuphold (negedge hld_h_n, posedge ref_sel[4],   tsetup, thold,  notifier_ref_sel,   enable_h==1'b1, enable_h==1'b1, hld_h_n_del, ref_sel_del[4]); 
    $setuphold (negedge hld_h_n, negedge ref_sel[4],   tsetup, thold,  notifier_ref_sel,   enable_h==1'b1, enable_h==1'b1, hld_h_n_del, ref_sel_del[4]); 
    $setuphold (negedge hld_h_n, posedge ref_sel[3],   tsetup, thold,  notifier_ref_sel,   enable_h==1'b1, enable_h==1'b1, hld_h_n_del, ref_sel_del[3]); 
    $setuphold (negedge hld_h_n, negedge ref_sel[3],   tsetup, thold,  notifier_ref_sel,   enable_h==1'b1, enable_h==1'b1, hld_h_n_del, ref_sel_del[3]); 
    $setuphold (negedge hld_h_n, posedge ref_sel[2],   tsetup, thold,  notifier_ref_sel,   enable_h==1'b1, enable_h==1'b1, hld_h_n_del, ref_sel_del[2]); 
    $setuphold (negedge hld_h_n, negedge ref_sel[2],   tsetup, thold,  notifier_ref_sel,   enable_h==1'b1, enable_h==1'b1, hld_h_n_del, ref_sel_del[2]); 
    $setuphold (negedge hld_h_n, posedge ref_sel[1],   tsetup, thold,  notifier_ref_sel,   enable_h==1'b1, enable_h==1'b1, hld_h_n_del, ref_sel_del[1]); 
    $setuphold (negedge hld_h_n, negedge ref_sel[1],   tsetup, thold,  notifier_ref_sel,   enable_h==1'b1, enable_h==1'b1, hld_h_n_del, ref_sel_del[1]); 
    $setuphold (negedge hld_h_n, posedge ref_sel[0],   tsetup, thold,  notifier_ref_sel,   enable_h==1'b1, enable_h==1'b1, hld_h_n_del, ref_sel_del[0]); 
    $setuphold (negedge hld_h_n, negedge ref_sel[0],   tsetup, thold,  notifier_ref_sel,   enable_h==1'b1, enable_h==1'b1, hld_h_n_del, ref_sel_del[0]); 
    $setuphold (negedge hld_h_n, posedge vrefgen_en,   tsetup, thold,  notifier_vrefgen_en,enable_h==1'b1, enable_h==1'b1, hld_h_n_del, vrefgen_en_del); 
    $setuphold (negedge hld_h_n, negedge vrefgen_en,   tsetup, thold,  notifier_vrefgen_en,enable_h==1'b1, enable_h==1'b1, hld_h_n_del, vrefgen_en_del); 
 endspecify

`endif

//===================================================================================================================================

// Level-shifted latchin of ref_sel[4:0], vrefgen_en

  
reg [4:0] ref_sel_final; 
always @(*)
begin : LATCH_ref_sel
	
	
		
	if (^enable_h===1'bx || !pwr_good_hold_mode || (enable_h===1 && ^hld_h_n_buf===1'bx))
	begin	
		ref_sel_final 	<= 5'bxxxxx;
	end
	else if (enable_h===0)
	begin
		ref_sel_final 	<= 5'b00000;
	end
	else if (hld_h_n_buf===1)
	begin
		ref_sel_final 	<= (^ref_sel_buf[4:0]	=== 1'bx	|| !pwr_good_active_mode) ? 5'bxxxxx : ref_sel_buf;
	end
end

always @(notifier_enable_h or notifier_ref_sel)
begin
     disable LATCH_ref_sel; ref_sel_final <= 5'bxxxxx;
end


reg vrefgen_en_final;
always @(*)
begin : LATCH_vrefgen_en	
	
	
	
	if (^enable_h===1'bx || !pwr_good_hold_mode || (enable_h===1 && ^hld_h_n_buf===1'bx))
	begin
		vrefgen_en_final 	<= 1'bx;
	end
	else if (enable_h===0)
	begin
		vrefgen_en_final 	<= 1'b0;
	end
	else if (hld_h_n_buf===1)
	begin
		vrefgen_en_final 	<= (^vrefgen_en_buf === 1'bx	|| !pwr_good_active_mode) ? 1'bx : vrefgen_en_buf;
	end
end

always @(notifier_enable_h or notifier_vrefgen_en)
begin
     disable LATCH_vrefgen_en; vrefgen_en_final <= 1'bx;
end


//===================================================================================================================================

// Output functionality

// pwr_good check is already contained in *_final (latched) signals

wire x_on_vinref =   	 vrefgen_en_final === 1'bx
			
			 || (vrefgen_en_final === 1'b1 && ^ref_sel_final === 1'bx);
			
			 
assign #(startup_delay,0) vinref = x_on_vinref === 1'b1 ? 1'bx : vrefgen_en_final;


//===================================================================================================================================



endmodule

`default_nettype wire
`endif  // SKY130_FD_IO__TOP_GPIOVREFV2_V


//--------EOF---------

/**
 * Copyright 2020 The SkyWater PDK Authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 * SPDX-License-Identifier: Apache-2.0
 */

`ifndef SKY130_FD_IO__TOP_GROUND_HVC_WPAD_V
`define SKY130_FD_IO__TOP_GROUND_HVC_WPAD_V

/**
 * top_ground_hvc_wpad: Ground pad.
 *
 * Verilog top module.
 *
 * WARNING: This file is autogenerated, do not modify directly!
 */

`timescale 1ns / 1ps
`default_nettype none

`ifdef USE_POWER_PINS

`ifdef FUNCTIONAL
/*
 * Copyright 2020 The SkyWater PDK Authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 * SPDX-License-Identifier: Apache-2.0
*/

module sky130_fd_io__top_ground_hvc_wpad ( G_PAD, AMUXBUS_A, AMUXBUS_B
        , G_CORE, DRN_HVC, OGC_HVC, SRC_BDY_HVC,VSSA, VDDA, VSWITCH, VDDIO_Q, VCCHIB, VDDIO, VCCD, VSSIO, VSSD, VSSIO_Q
                                         );
inout G_PAD;
inout AMUXBUS_A;
inout AMUXBUS_B;
inout OGC_HVC;
inout DRN_HVC;
inout SRC_BDY_HVC;
inout G_CORE;
inout VDDIO;
inout VDDIO_Q;
inout VDDA;
inout VCCD;
inout VSWITCH;
inout VCCHIB;
inout VSSA;
inout VSSD;
inout VSSIO_Q;
inout VSSIO;
assign G_CORE = G_PAD;
endmodule
`else  // FUNCTIONAL
/*
 * Copyright 2020 The SkyWater PDK Authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 * SPDX-License-Identifier: Apache-2.0
*/

module sky130_fd_io__top_ground_hvc_wpad ( G_PAD, AMUXBUS_A, AMUXBUS_B
        , G_CORE, DRN_HVC, OGC_HVC, SRC_BDY_HVC,VSSA, VDDA, VSWITCH, VDDIO_Q, VCCHIB, VDDIO, VCCD, VSSIO, VSSD, VSSIO_Q
                                         );
inout G_PAD;
inout AMUXBUS_A;
inout AMUXBUS_B;
inout OGC_HVC;
inout DRN_HVC;
inout SRC_BDY_HVC;
inout G_CORE;
inout VDDIO;
inout VDDIO_Q;
inout VDDA;
inout VCCD;
inout VSWITCH;
inout VCCHIB;
inout VSSA;
inout VSSD;
inout VSSIO_Q;
inout VSSIO;
assign G_CORE = G_PAD;
endmodule
`endif // FUNCTIONAL

`else  // USE_POWER_PINS

`ifdef FUNCTIONAL
/*
 * Copyright 2020 The SkyWater PDK Authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 * SPDX-License-Identifier: Apache-2.0
*/

module sky130_fd_io__top_ground_hvc_wpad ( G_PAD, AMUXBUS_A, AMUXBUS_B
                                         );
inout G_PAD;
inout AMUXBUS_A;
inout AMUXBUS_B;
supply1 ogc_hvc;
supply1 drn_hvc;
supply0 src_bdy_hvc;
supply0 g_core;
supply1 vddio;
supply1 vddio_q;
supply1 vdda;
supply1 vccd;
supply1 vswitch;
supply1 vcchib;
supply1 vpb;
supply1 vpbhib;
supply0 vssd;
supply0 vssio;
supply0 vssio_q;
supply0 vssa;
assign g_core = G_PAD;
endmodule
`else  // FUNCTIONAL
/*
 * Copyright 2020 The SkyWater PDK Authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 * SPDX-License-Identifier: Apache-2.0
*/

module sky130_fd_io__top_ground_hvc_wpad ( G_PAD, AMUXBUS_A, AMUXBUS_B
                                         );
inout G_PAD;
inout AMUXBUS_A;
inout AMUXBUS_B;
supply1 ogc_hvc;
supply1 drn_hvc;
supply0 src_bdy_hvc;
supply0 g_core;
supply1 vddio;
supply1 vddio_q;
supply1 vdda;
supply1 vccd;
supply1 vswitch;
supply1 vcchib;
supply1 vpb;
supply1 vpbhib;
supply0 vssd;
supply0 vssio;
supply0 vssio_q;
supply0 vssa;
assign g_core = G_PAD;
endmodule
`endif // FUNCTIONAL

`endif // USE_POWER_PINS

`default_nettype wire
`endif  // SKY130_FD_IO__TOP_GROUND_HVC_WPAD_V


//--------EOF---------

/**
 * Copyright 2020 The SkyWater PDK Authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 * SPDX-License-Identifier: Apache-2.0
 */

`ifndef SKY130_FD_IO__TOP_GROUND_LVC_WPAD_V
`define SKY130_FD_IO__TOP_GROUND_LVC_WPAD_V

/**
 * top_ground_lvc_wpad: Base ground I/O pad with low voltage clamp.
 *
 * Verilog top module.
 *
 * WARNING: This file is autogenerated, do not modify directly!
 */

`timescale 1ns / 1ps
`default_nettype none

`ifdef USE_POWER_PINS

`ifdef FUNCTIONAL
/*
 * Copyright 2020 The SkyWater PDK Authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 * SPDX-License-Identifier: Apache-2.0
*/

module sky130_fd_io__top_ground_lvc_wpad ( G_PAD, AMUXBUS_A, AMUXBUS_B
        , G_CORE, BDY2_B2B, DRN_LVC1, DRN_LVC2, OGC_LVC, SRC_BDY_LVC1, SRC_BDY_LVC2, VSSA, VDDA, VSWITCH, VDDIO_Q, VCCHIB, VDDIO, VCCD, VSSIO, VSSD, VSSIO_Q
                                         );
inout G_PAD;
inout AMUXBUS_A;
inout AMUXBUS_B;
inout SRC_BDY_LVC1;
inout SRC_BDY_LVC2;
inout OGC_LVC;
inout DRN_LVC1;
inout BDY2_B2B;
inout DRN_LVC2;
inout G_CORE;
inout VDDIO;
inout VDDIO_Q;
inout VDDA;
inout VCCD;
inout VSWITCH;
inout VCCHIB;
inout VSSA;
inout VSSD;
inout VSSIO_Q;
inout VSSIO;
assign G_CORE = G_PAD;
endmodule
`else  // FUNCTIONAL
/*
 * Copyright 2020 The SkyWater PDK Authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 * SPDX-License-Identifier: Apache-2.0
*/

module sky130_fd_io__top_ground_lvc_wpad ( G_PAD, AMUXBUS_A, AMUXBUS_B
        , G_CORE, BDY2_B2B, DRN_LVC1, DRN_LVC2, OGC_LVC, SRC_BDY_LVC1, SRC_BDY_LVC2, VSSA, VDDA, VSWITCH, VDDIO_Q, VCCHIB, VDDIO, VCCD, VSSIO, VSSD, VSSIO_Q
                                         );
inout G_PAD;
inout AMUXBUS_A;
inout AMUXBUS_B;
inout SRC_BDY_LVC1;
inout SRC_BDY_LVC2;
inout OGC_LVC;
inout DRN_LVC1;
inout BDY2_B2B;
inout DRN_LVC2;
inout G_CORE;
inout VDDIO;
inout VDDIO_Q;
inout VDDA;
inout VCCD;
inout VSWITCH;
inout VCCHIB;
inout VSSA;
inout VSSD;
inout VSSIO_Q;
inout VSSIO;
assign G_CORE = G_PAD;
endmodule
`endif // FUNCTIONAL

`else  // USE_POWER_PINS

`ifdef FUNCTIONAL
/*
 * Copyright 2020 The SkyWater PDK Authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 * SPDX-License-Identifier: Apache-2.0
*/

module sky130_fd_io__top_ground_lvc_wpad ( G_PAD, AMUXBUS_A, AMUXBUS_B
                                         );
inout G_PAD;
inout AMUXBUS_A;
inout AMUXBUS_B;
supply0 src_bdy_lvc1;
supply0 src_bdy_lvc2;
supply1 ogc_lvc;
supply1 drn_lvc1;
supply1 bdy2_b2b;
supply0 drn_lvc2;
supply0 g_core;
supply1 vddio;
supply1 vddio_q;
supply1 vdda;
supply1 vccd;
supply1 vswitch;
supply1 vcchib;
supply1 vpb;
supply1 vpbhib;
supply0 vssd;
supply0 vssio;
supply0 vssio_q;
supply0 vssa;
assign g_core = G_PAD;
endmodule
`else  // FUNCTIONAL
/*
 * Copyright 2020 The SkyWater PDK Authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 * SPDX-License-Identifier: Apache-2.0
*/

module sky130_fd_io__top_ground_lvc_wpad ( G_PAD, AMUXBUS_A, AMUXBUS_B
                                         );
inout G_PAD;
inout AMUXBUS_A;
inout AMUXBUS_B;
supply0 src_bdy_lvc1;
supply0 src_bdy_lvc2;
supply1 ogc_lvc;
supply1 drn_lvc1;
supply1 bdy2_b2b;
supply0 drn_lvc2;
supply0 g_core;
supply1 vddio;
supply1 vddio_q;
supply1 vdda;
supply1 vccd;
supply1 vswitch;
supply1 vcchib;
supply1 vpb;
supply1 vpbhib;
supply0 vssd;
supply0 vssio;
supply0 vssio_q;
supply0 vssa;
assign g_core = G_PAD;
endmodule
`endif // FUNCTIONAL

`endif // USE_POWER_PINS

`default_nettype wire
`endif  // SKY130_FD_IO__TOP_GROUND_LVC_WPAD_V


//--------EOF---------

/**
 * Copyright 2020 The SkyWater PDK Authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 * SPDX-License-Identifier: Apache-2.0
 */

`ifndef SKY130_FD_IO__TOP_HVCLAMP_V
`define SKY130_FD_IO__TOP_HVCLAMP_V

/**
 * top_hvclamp: Standalone high voltage ESD clamp circuit.
 *
 * Verilog top module.
 */

`timescale 1ns / 1ps
`default_nettype none

module sky130_fd_io__top_hvclamp ( 
`ifdef USE_POWER_PINS
  drn_hvc, ogc_hvc, src_bdy_hvc
`endif
 );

`ifdef USE_POWER_PINS
  inout ogc_hvc;
  inout drn_hvc;
  inout src_bdy_hvc;
`else
  supply1 ogc_hvc;
  supply1 drn_hvc;
  supply0 src_bdy_hvc;
`endif

endmodule

`default_nettype wire
`endif  // SKY130_FD_IO__TOP_HVCLAMP_V


//--------EOF---------

/**
 * Copyright 2020 The SkyWater PDK Authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 * SPDX-License-Identifier: Apache-2.0
 */

`ifndef SKY130_FD_IO__TOP_HVCLAMPV2_V
`define SKY130_FD_IO__TOP_HVCLAMPV2_V

/**
 * top_hvclampv2: HV Clamp without pad (version 2).
 *
 * Verilog top module.
 */

`timescale 1ns / 1ps
`default_nettype none

module sky130_fd_io__hvclampv2 ( 
`ifdef USE_POWER_PINS
  drn_hvc, ogc_hvc, src_bdy_hvc, vssd
`endif
 );

`ifdef USE_POWER_PINS
  inout ogc_hvc;
  inout drn_hvc;
  inout src_bdy_hvc;
  inout vssd;
`else
  supply1 ogc_hvc;
  supply1 drn_hvc;
  supply0 src_bdy_hvc;
  supply0 vssd;
`endif

endmodule

`default_nettype wire
`endif  // SKY130_FD_IO__TOP_HVCLAMPV2_V


//--------EOF---------

/**
 * Copyright 2020 The SkyWater PDK Authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 * SPDX-License-Identifier: Apache-2.0
 */

`ifndef SKY130_FD_IO__TOP_LVC_B2B_V
`define SKY130_FD_IO__TOP_LVC_B2B_V

/**
 * top_lvc_b2b:  Back-to-back ground domain joining diodes, standalone
 *
 * Verilog top module.
 */

`timescale 1ns / 1ps
`default_nettype none

module sky130_fd_io__top_lvc_b2b ( 
`ifdef USE_POWER_PINS
bdy2_b2b, drn_lvc1, drn_lvc2, ogc_lvc, src_bdy_lvc1, src_bdy_lvc2, vssd
`endif	// USE_POWER_PINS
 );

`ifdef USE_POWER_PINS
  inout src_bdy_lvc1;
  inout src_bdy_lvc2;
  inout ogc_lvc;
  inout drn_lvc1;
  inout bdy2_b2b;
  inout drn_lvc2;
  inout vssd;
`else	// USE_POWER_PINS
  supply0 src_bdy_lvc1;
  supply0 src_bdy_lvc2;
  supply1 ogc_lvc;
  supply1 drn_lvc1;
  supply0 bdy2_b2b;
  supply0 vssd;
  supply1 drn_lvc2;
`endif	// USE_POWER_PINS


endmodule

`default_nettype wire
`endif  // SKY130_FD_IO__TOP_LVC_B2B_V


//--------EOF---------

/**
 * Copyright 2020 The SkyWater PDK Authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 * SPDX-License-Identifier: Apache-2.0
 */

`ifndef SKY130_FD_IO__TOP_LVCLAMP_V
`define SKY130_FD_IO__TOP_LVCLAMP_V

/**
 * top_lvclamp:  Standalone low-voltage ESD clamp circuit.
 *
 * Verilog top module.
 */

`timescale 1ns / 1ps
`default_nettype none


module sky130_fd_io__top_lvclamp (
`ifdef USE_POWER_PINS
 drn_lvc, ogc_lvc, src_bdy_lvc
`endif 
 );

`ifdef USE_POWER_PINS
    inout drn_lvc;
    inout ogc_lvc;
    inout src_bdy_lvc;
`else
  supply1 ogc_lvc;
  supply1 drn_lvc;
  supply0 src_bdy_lvc;
`endif

endmodule

`default_nettype wire
`endif  // SKY130_FD_IO__TOP_LVCLAMP_V


//--------EOF---------

/**
 * Copyright 2020 The SkyWater PDK Authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 * SPDX-License-Identifier: Apache-2.0
 */

`ifndef SKY130_FD_IO__TOP_POWER_HVC_WPAD_V
`define SKY130_FD_IO__TOP_POWER_HVC_WPAD_V

/**
 * top_power_hvc_wpad: A power pad with an ESD high-voltage clamp.
 *
 * Verilog top module.
 *
 * WARNING: This file is autogenerated, do not modify directly!
 */

`timescale 1ns / 1ps
`default_nettype none

`ifdef USE_POWER_PINS

`ifdef FUNCTIONAL
/*
 * Copyright 2020 The SkyWater PDK Authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 * SPDX-License-Identifier: Apache-2.0
*/

module sky130_fd_io__top_power_hvc_wpad ( P_PAD, AMUXBUS_A, AMUXBUS_B
        , P_CORE, DRN_HVC, OGC_HVC, SRC_BDY_HVC,VSSA, VDDA, VSWITCH, VDDIO_Q, VCCHIB, VDDIO, VCCD, VSSIO, VSSD, VSSIO_Q
                                        );
inout P_PAD;
inout AMUXBUS_A;
inout AMUXBUS_B;
inout OGC_HVC;
inout DRN_HVC;
inout SRC_BDY_HVC;
inout P_CORE;
inout VDDIO;
inout VDDIO_Q;
inout VDDA;
inout VCCD;
inout VSWITCH;
inout VCCHIB;
inout VSSA;
inout VSSD;
inout VSSIO_Q;
inout VSSIO;
assign P_CORE = P_PAD;
endmodule
`else  // FUNCTIONAL
/*
 * Copyright 2020 The SkyWater PDK Authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 * SPDX-License-Identifier: Apache-2.0
*/

module sky130_fd_io__top_power_hvc_wpad ( P_PAD, AMUXBUS_A, AMUXBUS_B
        , P_CORE, DRN_HVC, OGC_HVC, SRC_BDY_HVC,VSSA, VDDA, VSWITCH, VDDIO_Q, VCCHIB, VDDIO, VCCD, VSSIO, VSSD, VSSIO_Q
                                        );
inout P_PAD;
inout AMUXBUS_A;
inout AMUXBUS_B;
inout OGC_HVC;
inout DRN_HVC;
inout SRC_BDY_HVC;
inout P_CORE;
inout VDDIO;
inout VDDIO_Q;
inout VDDA;
inout VCCD;
inout VSWITCH;
inout VCCHIB;
inout VSSA;
inout VSSD;
inout VSSIO_Q;
inout VSSIO;
assign P_CORE = P_PAD;
endmodule
`endif // FUNCTIONAL

`else  // USE_POWER_PINS

`ifdef FUNCTIONAL
/*
 * Copyright 2020 The SkyWater PDK Authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 * SPDX-License-Identifier: Apache-2.0
*/

module sky130_fd_io__top_power_hvc_wpad ( P_PAD, AMUXBUS_A, AMUXBUS_B
                                        );
inout P_PAD;
inout AMUXBUS_A;
inout AMUXBUS_B;
supply1 ogc_hvc;
supply1 drn_hvc;
supply0 src_bdy_hvc;
supply1 p_core;
supply1 vddio;
supply1 vddio_q;
supply1 vdda;
supply1 vccd;
supply1 vswitch;
supply1 vcchib;
supply1 vpb;
supply1 vpbhib;
supply0 vssd;
supply0 vssio;
supply0 vssio_q;
supply0 vssa;
assign p_core = P_PAD;
endmodule
`else  // FUNCTIONAL
/*
 * Copyright 2020 The SkyWater PDK Authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 * SPDX-License-Identifier: Apache-2.0
*/

module sky130_fd_io__top_power_hvc_wpad ( P_PAD, AMUXBUS_A, AMUXBUS_B
                                        );
inout P_PAD;
inout AMUXBUS_A;
inout AMUXBUS_B;
supply1 ogc_hvc;
supply1 drn_hvc;
supply0 src_bdy_hvc;
supply1 p_core;
supply1 vddio;
supply1 vddio_q;
supply1 vdda;
supply1 vccd;
supply1 vswitch;
supply1 vcchib;
supply1 vpb;
supply1 vpbhib;
supply0 vssd;
supply0 vssio;
supply0 vssio_q;
supply0 vssa;
assign p_core = P_PAD;
endmodule
`endif // FUNCTIONAL

`endif // USE_POWER_PINS

`default_nettype wire
`endif  // SKY130_FD_IO__TOP_POWER_HVC_WPAD_V


//--------EOF---------

/**
 * Copyright 2020 The SkyWater PDK Authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 * SPDX-License-Identifier: Apache-2.0
 */

`ifndef SKY130_FD_IO__TOP_POWER_HVC_WPADV2_V
`define SKY130_FD_IO__TOP_POWER_HVC_WPADV2_V

/**
 * top_power_hvc_wpadv2: A power pad with an ESD high-voltage clamp.
 *
 * Verilog top module.
 *
 * WARNING: This file is autogenerated, do not modify directly!
 */

`timescale 1ns / 1ps
`default_nettype none

`ifdef USE_POWER_PINS

`ifdef FUNCTIONAL
/*
 * Copyright 2020 The SkyWater PDK Authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 * SPDX-License-Identifier: Apache-2.0
*/

module sky130_fd_io__top_power_hvc_wpadv2 ( P_PAD, AMUXBUS_A, AMUXBUS_B
        , P_CORE, DRN_HVC, OGC_HVC, SRC_BDY_HVC,VSSA, VDDA, VSWITCH, VDDIO_Q, VCCHIB, VDDIO, VCCD, VSSIO, VSSD, VSSIO_Q
                                          );
inout P_PAD;
inout AMUXBUS_A;
inout AMUXBUS_B;
inout OGC_HVC;
inout DRN_HVC;
inout SRC_BDY_HVC;
inout P_CORE;
inout VDDIO;
inout VDDIO_Q;
inout VDDA;
inout VCCD;
inout VSWITCH;
inout VCCHIB;
inout VSSA;
inout VSSD;
inout VSSIO_Q;
inout VSSIO;
tran p1 (P_CORE, P_PAD);
endmodule
`else  // FUNCTIONAL
/*
 * Copyright 2020 The SkyWater PDK Authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 * SPDX-License-Identifier: Apache-2.0
*/

module sky130_fd_io__top_power_hvc_wpadv2 ( P_PAD, AMUXBUS_A, AMUXBUS_B
        , P_CORE, DRN_HVC, OGC_HVC, SRC_BDY_HVC,VSSA, VDDA, VSWITCH, VDDIO_Q, VCCHIB, VDDIO, VCCD, VSSIO, VSSD, VSSIO_Q
                                          );
inout P_PAD;
inout AMUXBUS_A;
inout AMUXBUS_B;
inout OGC_HVC;
inout DRN_HVC;
inout SRC_BDY_HVC;
inout P_CORE;
inout VDDIO;
inout VDDIO_Q;
inout VDDA;
inout VCCD;
inout VSWITCH;
inout VCCHIB;
inout VSSA;
inout VSSD;
inout VSSIO_Q;
inout VSSIO;
tran p1 (P_CORE, P_PAD);
endmodule
`endif // FUNCTIONAL

`else  // USE_POWER_PINS

`ifdef FUNCTIONAL
/*
 * Copyright 2020 The SkyWater PDK Authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 * SPDX-License-Identifier: Apache-2.0
*/

module sky130_fd_io__top_power_hvc_wpadv2 ( P_PAD, AMUXBUS_A, AMUXBUS_B
                                          );
inout P_PAD;
inout AMUXBUS_A;
inout AMUXBUS_B;
supply1 ogc_hvc;
supply1 drn_hvc;
supply0 src_bdy_hvc;
supply1 p_core;
supply1 vddio;
supply1 vddio_q;
supply1 vdda;
supply1 vccd;
supply1 vswitch;
supply1 vcchib;
supply1 vpb;
supply1 vpbhib;
supply0 vssd;
supply0 vssio;
supply0 vssio_q;
supply0 vssa;
tran p1 (p_core, P_PAD);
endmodule
`else  // FUNCTIONAL
/*
 * Copyright 2020 The SkyWater PDK Authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 * SPDX-License-Identifier: Apache-2.0
*/

module sky130_fd_io__top_power_hvc_wpadv2 ( P_PAD, AMUXBUS_A, AMUXBUS_B
                                          );
inout P_PAD;
inout AMUXBUS_A;
inout AMUXBUS_B;
supply1 ogc_hvc;
supply1 drn_hvc;
supply0 src_bdy_hvc;
supply1 p_core;
supply1 vddio;
supply1 vddio_q;
supply1 vdda;
supply1 vccd;
supply1 vswitch;
supply1 vcchib;
supply1 vpb;
supply1 vpbhib;
supply0 vssd;
supply0 vssio;
supply0 vssio_q;
supply0 vssa;
tran p1 (p_core, P_PAD);
endmodule
`endif // FUNCTIONAL

`endif // USE_POWER_PINS

`default_nettype wire
`endif  // SKY130_FD_IO__TOP_POWER_HVC_WPADV2_V


//--------EOF---------

/**
 * Copyright 2020 The SkyWater PDK Authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 * SPDX-License-Identifier: Apache-2.0
 */

`ifndef SKY130_FD_IO__TOP_POWER_LVC_WPAD_V
`define SKY130_FD_IO__TOP_POWER_LVC_WPAD_V

/**
 * top_power_lvc_wpad: A power pad with an ESD low-voltage clamp.
 *
 * Verilog top module.
 *
 * WARNING: This file is autogenerated, do not modify directly!
 */

`timescale 1ns / 1ps
`default_nettype none

`ifdef USE_POWER_PINS

`ifdef FUNCTIONAL
/*
 * Copyright 2020 The SkyWater PDK Authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 * SPDX-License-Identifier: Apache-2.0
*/

module sky130_fd_io__top_power_lvc_wpad ( P_PAD, AMUXBUS_A, AMUXBUS_B
        , P_CORE, BDY2_B2B, DRN_LVC1, DRN_LVC2, OGC_LVC, SRC_BDY_LVC1, SRC_BDY_LVC2, VSSA, VDDA, VSWITCH, VDDIO_Q, VCCHIB, VDDIO, VCCD, VSSIO, VSSD, VSSIO_Q
                                        );
inout P_PAD;
inout AMUXBUS_A;
inout AMUXBUS_B;
inout SRC_BDY_LVC1;
inout SRC_BDY_LVC2;
inout OGC_LVC;
inout DRN_LVC1;
inout BDY2_B2B;
inout DRN_LVC2;
inout P_CORE;
inout VDDIO;
inout VDDIO_Q;
inout VDDA;
inout VCCD;
inout VSWITCH;
inout VCCHIB;
inout VSSA;
inout VSSD;
inout VSSIO_Q;
inout VSSIO;
assign P_CORE = P_PAD;
endmodule
`else  // FUNCTIONAL
/*
 * Copyright 2020 The SkyWater PDK Authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 * SPDX-License-Identifier: Apache-2.0
*/

module sky130_fd_io__top_power_lvc_wpad ( P_PAD, AMUXBUS_A, AMUXBUS_B
        , P_CORE, BDY2_B2B, DRN_LVC1, DRN_LVC2, OGC_LVC, SRC_BDY_LVC1, SRC_BDY_LVC2, VSSA, VDDA, VSWITCH, VDDIO_Q, VCCHIB, VDDIO, VCCD, VSSIO, VSSD, VSSIO_Q
                                        );
inout P_PAD;
inout AMUXBUS_A;
inout AMUXBUS_B;
inout SRC_BDY_LVC1;
inout SRC_BDY_LVC2;
inout OGC_LVC;
inout DRN_LVC1;
inout BDY2_B2B;
inout DRN_LVC2;
inout P_CORE;
inout VDDIO;
inout VDDIO_Q;
inout VDDA;
inout VCCD;
inout VSWITCH;
inout VCCHIB;
inout VSSA;
inout VSSD;
inout VSSIO_Q;
inout VSSIO;
assign P_CORE = P_PAD;
endmodule
`endif // FUNCTIONAL

`else  // USE_POWER_PINS

`ifdef FUNCTIONAL
/*
 * Copyright 2020 The SkyWater PDK Authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 * SPDX-License-Identifier: Apache-2.0
*/

module sky130_fd_io__top_power_lvc_wpad ( P_PAD, AMUXBUS_A, AMUXBUS_B
                                        );
inout P_PAD;
inout AMUXBUS_A;
inout AMUXBUS_B;
supply0 src_bdy_lvc1;
supply0 src_bdy_lvc2;
supply1 ogc_lvc;
supply1 drn_lvc1;
supply1 bdy2_b2b;
supply0 drn_lvc2;
supply1 p_core;
supply1 vddio;
supply1 vddio_q;
supply1 vdda;
supply1 vccd;
supply1 vswitch;
supply1 vcchib;
supply1 vpb;
supply1 vpbhib;
supply0 vssd;
supply0 vssio;
supply0 vssio_q;
supply0 vssa;
assign p_core = P_PAD;
endmodule
`else  // FUNCTIONAL
/*
 * Copyright 2020 The SkyWater PDK Authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 * SPDX-License-Identifier: Apache-2.0
*/

module sky130_fd_io__top_power_lvc_wpad ( P_PAD, AMUXBUS_A, AMUXBUS_B
                                        );
inout P_PAD;
inout AMUXBUS_A;
inout AMUXBUS_B;
supply0 src_bdy_lvc1;
supply0 src_bdy_lvc2;
supply1 ogc_lvc;
supply1 drn_lvc1;
supply1 bdy2_b2b;
supply0 drn_lvc2;
supply1 p_core;
supply1 vddio;
supply1 vddio_q;
supply1 vdda;
supply1 vccd;
supply1 vswitch;
supply1 vcchib;
supply1 vpb;
supply1 vpbhib;
supply0 vssd;
supply0 vssio;
supply0 vssio_q;
supply0 vssa;
assign p_core = P_PAD;
endmodule
`endif // FUNCTIONAL

`endif // USE_POWER_PINS

`default_nettype wire
`endif  // SKY130_FD_IO__TOP_POWER_LVC_WPAD_V


//--------EOF---------

/**
 * Copyright 2020 The SkyWater PDK Authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 * SPDX-License-Identifier: Apache-2.0
 */

`ifndef SKY130_FD_IO__TOP_PWRDETV2_V
`define SKY130_FD_IO__TOP_PWRDETV2_V

/**
 * top_pwrdetv2: vddd and vddio power detectors.
 *
 * Verilog top module.
 */

`timescale 1ns/1ps
`default_nettype none

module sky130_fd_io__top_pwrdetv2 (out1_vddd_hv, out1_vddio_hv, out2_vddd_hv, 
           out2_vddio_hv, out3_vddd_hv, out3_vddio_hv, tie_lo_esd, 
           vddd_present_vddio_hv, vddio_present_vddd_hv, 
`ifdef USE_POWER_PINS	   
	   vccd, vddd1, vddd2, vddio_q, vssa, vssd, vssio_q, 
`endif
           in1_vddd_hv, in1_vddio_hv, in2_vddd_hv, in2_vddio_hv, in3_vddd_hv, in3_vddio_hv ,rst_por_hv_n);
    output out1_vddd_hv;
    output out1_vddio_hv;
    output out2_vddd_hv;
    output out2_vddio_hv;
    output out3_vddd_hv;
    output out3_vddio_hv;
    output tie_lo_esd;
    output vddd_present_vddio_hv;
    output vddio_present_vddd_hv;
    
`ifdef USE_POWER_PINS
    inout vccd;
    inout vddd1;
    inout vddd2;
    inout vddio_q;
    inout vssa;
    inout vssd;
    inout vssio_q;
`else
    supply1 vccd;
    supply1 vddd1;
    supply1 vddd2;
    supply1 vddio_q;
    supply0 vssa;
    supply0 vssd;
    supply0 vssio_q;
`endif
    input in1_vddd_hv;
    input in1_vddio_hv;
    input in2_vddd_hv;
    input in2_vddio_hv;
    input in3_vddd_hv;
    input in3_vddio_hv;
    input rst_por_hv_n;



`ifdef S8IOM0S8_TOP_PWRDETV2_DISABLE_STARTUP_DELAY
	parameter STARTUP_DELAY = 0;
`else
	parameter STARTUP_DELAY = 2000;
`endif

// AC_SPEC # FOR DELAY from BROS : AC.DET.3 and AC.DET.4  (in 001-70428_0J_HardIP_Tables -> HardIP_AC_Specs_ProdTest)


integer startup_delay;

initial startup_delay = STARTUP_DELAY;

//===================================================================================================================================================================

// 1. VDDIO_PRESENT_VDDD_HV

`ifdef USE_POWER_PINS
	wire pwr_good_vddio_present_vddd_hv    	=  (vddd1===1) && (vssa===0) && (vssd===0);
						   
	wire x_on_vddio_present_vddd_hv	=  pwr_good_vddio_present_vddd_hv===0 || ^rst_por_hv_n===1'bx || ^vddio_q===1'bx; 
	
	assign vddio_present_vddd_hv 	= x_on_vddio_present_vddd_hv===1 ? 1'bx : ((rst_por_hv_n===0 && vccd===0 && vddio_q===0) ? 1'b0 : vddio_q); 

`else

	assign vddio_present_vddd_hv = ^rst_por_hv_n===1'bx ? 1'bx : 1'b1;

`endif


				
// 2. OUT1_VDDD_HV, OUT2_VDDD_HV, OUT3_VDDD_HV


assign  out1_vddd_hv	=   vddio_present_vddd_hv && in1_vddio_hv;


assign  out2_vddd_hv	=   vddio_present_vddd_hv && in2_vddio_hv;


assign  out3_vddd_hv	=   vddio_present_vddd_hv && in3_vddio_hv;


//===================================================================================================================================================================

// 3. VDDD_PRESENT_VDDIO_HV

`ifdef USE_POWER_PINS
	wire pwr_good_vddd_present_vddio_hv    	=  (vddio_q===1) && (vssa===0) && (vssio_q===0);
	
	wire x_on_vddd_present_vddio_hv 	=  (pwr_good_vddd_present_vddio_hv===0) || (^vddd2===1'bx);
	
	wire vddd_present_vddio_hv_buf		=   x_on_vddd_present_vddio_hv===1 ? 1'bx : vddd2;
	
	assign #(startup_delay,startup_delay,0) vddd_present_vddio_hv	=   vddd_present_vddio_hv_buf;

`else
	assign vddd_present_vddio_hv  	=  1;
`endif



// 4. OUT1_VDDIO_HV, OUT2_VDDIO_HV, OUT3_VDDIO_HV


assign  out1_vddio_hv	=    (vddd_present_vddio_hv && in1_vddd_hv);


assign  out2_vddio_hv	=    (vddd_present_vddio_hv && in2_vddd_hv);


assign  out3_vddio_hv	=    (vddd_present_vddio_hv && in3_vddd_hv);

//===================================================================================================================================================================

// 5. TIE_LO_ESD

assign tie_lo_esd = vssd;

//===================================================================================================================================================================
// WARNING CONDITIONS


reg dis_err_msgs;

initial
begin
  dis_err_msgs = 1'b1;
  `ifdef S8IOM0S8_TOP_PWRDETV2_DIS_ERR_MSGS
  `else
    #1;
    dis_err_msgs = 1'b0;
  `endif
end

event event_warning_unreliable_output;

wire #(100) warning_unreliable_output = rst_por_hv_n===1 && vccd!==1 && vddio_q===0;

always @(warning_unreliable_output) 
begin
  if (!dis_err_msgs) 
  begin
    	if (warning_unreliable_output===1)
	begin
		$display("\n ===WARNING=== sky130_fd_io__top_pwrdetv2 :  rst_por_hv_n===1 && vccd!==1 && vddio_q===0 : In this state, the vddio detector output may be unreliable: %m\n",$stime);
		->event_warning_unreliable_output;		
	end
  end
end

//=========================================================================================================================================

`ifdef FUNCTIONAL 

`else	// FUNCTIONAL

 specify
 	(in1_vddio_hv	=> out1_vddd_hv) =  (0:0:0 , 0:0:0);
 	(in2_vddio_hv	=> out2_vddd_hv) =  (0:0:0 , 0:0:0);
 	(in3_vddio_hv	=> out3_vddd_hv) =  (0:0:0 , 0:0:0);

	(in1_vddd_hv	=> out1_vddio_hv) =  (0:0:0 , 0:0:0);
 	(in2_vddd_hv	=> out2_vddio_hv) =  (0:0:0 , 0:0:0);
 	(in3_vddd_hv	=> out3_vddio_hv) =  (0:0:0 , 0:0:0);

	$width  (negedge rst_por_hv_n,	      (0:0:0));
 endspecify
 
`endif	// FUNCTIONAL

 
endmodule

`default_nettype wire
`endif  // SKY130_FD_IO__TOP_PWRDETV2_V


//--------EOF---------

/**
 * Copyright 2020 The SkyWater PDK Authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 * SPDX-License-Identifier: Apache-2.0
 */

`ifndef SKY130_FD_IO__TOP_REFGEN_V
`define SKY130_FD_IO__TOP_REFGEN_V

/**
 * top_refgen: The REFGEN block (sky130_fd_io__top_refgen) is used to
 *             provide the input trip point (VINREF) for the
 *             differential input buffer in SIO and also
 *             the output buffer regulated output level (VOUTREF).
 *             Verilog HDL for "sky130_fd_io",
 *             "sky130_fd_io_top_refgen" "timing_tmp".
 *
 * Verilog top module.
 *
 * WARNING: This file is autogenerated, do not modify directly!
 */

`timescale 1ns / 1ps
`default_nettype none

`ifdef USE_POWER_PINS

`ifdef FUNCTIONAL
/*
 * Copyright 2020 The SkyWater PDK Authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 * SPDX-License-Identifier: Apache-2.0
*/

module sky130_fd_io__top_refgen (VINREF, VOUTREF, REFLEAK_BIAS,
                                 VCCD, VCCHIB, VDDA, VDDIO, VDDIO_Q, VSSD, VSSIO, VSSIO_Q,
                                 HLD_H_N, IBUF_SEL, OD_H, VOHREF, VREF_SEL, VREG_EN, VTRIP_SEL);
wire error_vsel;
output VINREF;
output VOUTREF;
inout REFLEAK_BIAS;
inout VCCD;
inout VCCHIB;
inout VDDA;
inout VDDIO;
inout VDDIO_Q;
inout VSSD;
inout VSSIO;
inout VSSIO_Q;
input HLD_H_N;
input IBUF_SEL;
input OD_H;
input VOHREF;
input VREF_SEL;
input VREG_EN;
input VTRIP_SEL;
reg [2:0] dm_final;
reg       slow_final, vtrip_sel_final, inp_dis_final, hld_ovr_final;
reg [2:0] dm;
reg       slow, inp_dis, hld_ovr;
reg [1:0] vsel;
wire  pwr_good_active_mode    = (VDDIO_Q===1) && (VDDIO===1)  && (VSSD===0)    && (VCCD===1);
wire  pwr_good_hold_mode      = (VDDIO_Q===1) && (VDDIO===1)  && (VSSD===0);
always @(*)
begin
    if (^OD_H===1'bx || !pwr_good_hold_mode || (OD_H===0 && ^HLD_H_N===1'bx))
    begin
        dm_final 	= 3'bxxx;
        slow_final 	= 1'bx;
        vtrip_sel_final	= 1'bx;
        inp_dis_final 	= 1'bx;
        hld_ovr_final 	= 1'bx;
    end
    else if (OD_H===1)
    begin
        dm_final 	= 3'b000;
        slow_final 	= 1'b0;
        vtrip_sel_final	= 1'b0;
        inp_dis_final 	= 1'b0;
        hld_ovr_final 	= 1'b0;
    end
    else if (HLD_H_N===1)
    begin
        dm_final 	= (^dm[2:0] === 1'bx	|| !pwr_good_active_mode) ? 3'bxxx : dm;
        slow_final 	= (^slow 	=== 1'bx	|| !pwr_good_active_mode) ? 1'bx   : slow;
        vtrip_sel_final	= (^VTRIP_SEL 	=== 1'bx	|| !pwr_good_active_mode) ? 1'bx   : VTRIP_SEL;
        inp_dis_final 	= (^inp_dis	=== 1'bx	|| !pwr_good_active_mode) ? 1'bx   : inp_dis;
        hld_ovr_final 	= (^hld_ovr 	=== 1'bx	|| !pwr_good_active_mode) ? 1'bx   : hld_ovr;
    end
end
reg dis_err_msgs;
initial
begin
    dis_err_msgs = 1'b1;
`ifdef SKY130_FD_IO_TOP_REFGEN_DIS_ERR_MSGS
`else
    #1;
    dis_err_msgs = 1'b0;
`endif
end
assign error_vsel = (vsel[1]===1 && vsel[0]===1);
always @(*)
begin
    if (!dis_err_msgs)
    begin
        if (error_vsel==1) $display(" ===ERROR=== sky130_fd_io__top_refgen : %m : Incorrect inputs on vsel[1:0] = 11",$stime);
    end
end
endmodule
`else  // FUNCTIONAL
/*
 * Copyright 2020 The SkyWater PDK Authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 * SPDX-License-Identifier: Apache-2.0
*/

module sky130_fd_io__top_refgen (VINREF, VOUTREF, REFLEAK_BIAS,
                                 VCCD, VCCHIB, VDDA, VDDIO, VDDIO_Q, VSSD, VSSIO, VSSIO_Q,
                                 HLD_H_N, IBUF_SEL, OD_H, VOHREF, VREF_SEL, VREG_EN, VTRIP_SEL);
wire error_vsel;
output VINREF;
output VOUTREF;
inout REFLEAK_BIAS;
inout VCCD;
inout VCCHIB;
inout VDDA;
inout VDDIO;
inout VDDIO_Q;
inout VSSD;
inout VSSIO;
inout VSSIO_Q;
input HLD_H_N;
input IBUF_SEL;
input OD_H;
input VOHREF;
input VREF_SEL;
input VREG_EN;
input VTRIP_SEL;
reg [2:0] dm_final;
reg       slow_final, vtrip_sel_final, inp_dis_final, hld_ovr_final;
reg [2:0] dm;
reg       slow, inp_dis, hld_ovr;
reg [1:0] vsel;
wire  pwr_good_active_mode    = (VDDIO_Q===1) && (VDDIO===1)  && (VSSD===0)    && (VCCD===1);
wire  pwr_good_hold_mode      = (VDDIO_Q===1) && (VDDIO===1)  && (VSSD===0);
always @(*)
begin
    if (^OD_H===1'bx || !pwr_good_hold_mode || (OD_H===0 && ^HLD_H_N===1'bx))
    begin
        dm_final 	= 3'bxxx;
        slow_final 	= 1'bx;
        vtrip_sel_final	= 1'bx;
        inp_dis_final 	= 1'bx;
        hld_ovr_final 	= 1'bx;
    end
    else if (OD_H===1)
    begin
        dm_final 	= 3'b000;
        slow_final 	= 1'b0;
        vtrip_sel_final	= 1'b0;
        inp_dis_final 	= 1'b0;
        hld_ovr_final 	= 1'b0;
    end
    else if (HLD_H_N===1)
    begin
        dm_final 	= (^dm[2:0] === 1'bx	|| !pwr_good_active_mode) ? 3'bxxx : dm;
        slow_final 	= (^slow 	=== 1'bx	|| !pwr_good_active_mode) ? 1'bx   : slow;
        vtrip_sel_final	= (^VTRIP_SEL 	=== 1'bx	|| !pwr_good_active_mode) ? 1'bx   : VTRIP_SEL;
        inp_dis_final 	= (^inp_dis	=== 1'bx	|| !pwr_good_active_mode) ? 1'bx   : inp_dis;
        hld_ovr_final 	= (^hld_ovr 	=== 1'bx	|| !pwr_good_active_mode) ? 1'bx   : hld_ovr;
    end
end
reg dis_err_msgs;
initial
begin
    dis_err_msgs = 1'b1;
`ifdef SKY130_FD_IO_TOP_REFGEN_DIS_ERR_MSGS
`else
    #1;
    dis_err_msgs = 1'b0;
`endif
end
assign error_vsel = (vsel[1]===1 && vsel[0]===1);
always @(*)
begin
    if (!dis_err_msgs)
    begin
        if (error_vsel==1) $display(" ===ERROR=== sky130_fd_io__top_refgen : %m : Incorrect inputs on vsel[1:0] = 11",$stime);
    end
end
endmodule
`endif // FUNCTIONAL

`else  // USE_POWER_PINS

`ifdef FUNCTIONAL
/*
 * Copyright 2020 The SkyWater PDK Authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 * SPDX-License-Identifier: Apache-2.0
*/

module sky130_fd_io__top_refgen (VINREF, VOUTREF, REFLEAK_BIAS,
                                 HLD_H_N, IBUF_SEL, OD_H, VOHREF, VREF_SEL, VREG_EN, VTRIP_SEL);
wire error_vsel;
output VINREF;
output VOUTREF;
inout REFLEAK_BIAS;
wire vccd	=1;
wire vcchib	=1;
wire vdda	=1;
wire vddio	=1;
wire vddio_q=1;
wire vssd	=0;
wire vssio	=0;
wire vssio_q=0;
input HLD_H_N;
input IBUF_SEL;
input OD_H;
input VOHREF;
input VREF_SEL;
input VREG_EN;
input VTRIP_SEL;
reg [2:0] dm_final;
reg       slow_final, vtrip_sel_final, inp_dis_final, hld_ovr_final;
reg [2:0] dm;
reg       slow, inp_dis, hld_ovr;
reg [1:0] vsel;
wire  pwr_good_hold_mode	= 1;
wire  pwr_good_active_mode      = 1;
always @(*)
begin
    if (^OD_H===1'bx || !pwr_good_hold_mode || (OD_H===0 && ^HLD_H_N===1'bx))
    begin
        dm_final 	= 3'bxxx;
        slow_final 	= 1'bx;
        vtrip_sel_final	= 1'bx;
        inp_dis_final 	= 1'bx;
        hld_ovr_final 	= 1'bx;
    end
    else if (OD_H===1)
    begin
        dm_final 	= 3'b000;
        slow_final 	= 1'b0;
        vtrip_sel_final	= 1'b0;
        inp_dis_final 	= 1'b0;
        hld_ovr_final 	= 1'b0;
    end
    else if (HLD_H_N===1)
    begin
        dm_final 	= (^dm[2:0] === 1'bx	|| !pwr_good_active_mode) ? 3'bxxx : dm;
        slow_final 	= (^slow 	=== 1'bx	|| !pwr_good_active_mode) ? 1'bx   : slow;
        vtrip_sel_final	= (^VTRIP_SEL 	=== 1'bx	|| !pwr_good_active_mode) ? 1'bx   : VTRIP_SEL;
        inp_dis_final 	= (^inp_dis	=== 1'bx	|| !pwr_good_active_mode) ? 1'bx   : inp_dis;
        hld_ovr_final 	= (^hld_ovr 	=== 1'bx	|| !pwr_good_active_mode) ? 1'bx   : hld_ovr;
    end
end
reg dis_err_msgs;
initial
begin
    dis_err_msgs = 1'b1;
`ifdef SKY130_FD_IO_TOP_REFGEN_DIS_ERR_MSGS
`else
    #1;
    dis_err_msgs = 1'b0;
`endif
end
assign error_vsel = (vsel[1]===1 && vsel[0]===1);
always @(*)
begin
    if (!dis_err_msgs)
    begin
        if (error_vsel==1) $display(" ===ERROR=== sky130_fd_io__top_refgen : %m : Incorrect inputs on vsel[1:0] = 11",$stime);
    end
end
endmodule
`else  // FUNCTIONAL
/*
 * Copyright 2020 The SkyWater PDK Authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 * SPDX-License-Identifier: Apache-2.0
*/

module sky130_fd_io__top_refgen (VINREF, VOUTREF, REFLEAK_BIAS,
                                 HLD_H_N, IBUF_SEL, OD_H, VOHREF, VREF_SEL, VREG_EN, VTRIP_SEL);
wire error_vsel;
output VINREF;
output VOUTREF;
inout REFLEAK_BIAS;
wire vccd	=1;
wire vcchib	=1;
wire vdda	=1;
wire vddio	=1;
wire vddio_q=1;
wire vssd	=0;
wire vssio	=0;
wire vssio_q=0;
input HLD_H_N;
input IBUF_SEL;
input OD_H;
input VOHREF;
input VREF_SEL;
input VREG_EN;
input VTRIP_SEL;
reg [2:0] dm_final;
reg       slow_final, vtrip_sel_final, inp_dis_final, hld_ovr_final;
reg [2:0] dm;
reg       slow, inp_dis, hld_ovr;
reg [1:0] vsel;
wire  pwr_good_hold_mode	= 1;
wire  pwr_good_active_mode      = 1;
always @(*)
begin
    if (^OD_H===1'bx || !pwr_good_hold_mode || (OD_H===0 && ^HLD_H_N===1'bx))
    begin
        dm_final 	= 3'bxxx;
        slow_final 	= 1'bx;
        vtrip_sel_final	= 1'bx;
        inp_dis_final 	= 1'bx;
        hld_ovr_final 	= 1'bx;
    end
    else if (OD_H===1)
    begin
        dm_final 	= 3'b000;
        slow_final 	= 1'b0;
        vtrip_sel_final	= 1'b0;
        inp_dis_final 	= 1'b0;
        hld_ovr_final 	= 1'b0;
    end
    else if (HLD_H_N===1)
    begin
        dm_final 	= (^dm[2:0] === 1'bx	|| !pwr_good_active_mode) ? 3'bxxx : dm;
        slow_final 	= (^slow 	=== 1'bx	|| !pwr_good_active_mode) ? 1'bx   : slow;
        vtrip_sel_final	= (^VTRIP_SEL 	=== 1'bx	|| !pwr_good_active_mode) ? 1'bx   : VTRIP_SEL;
        inp_dis_final 	= (^inp_dis	=== 1'bx	|| !pwr_good_active_mode) ? 1'bx   : inp_dis;
        hld_ovr_final 	= (^hld_ovr 	=== 1'bx	|| !pwr_good_active_mode) ? 1'bx   : hld_ovr;
    end
end
reg dis_err_msgs;
initial
begin
    dis_err_msgs = 1'b1;
`ifdef SKY130_FD_IO_TOP_REFGEN_DIS_ERR_MSGS
`else
    #1;
    dis_err_msgs = 1'b0;
`endif
end
assign error_vsel = (vsel[1]===1 && vsel[0]===1);
always @(*)
begin
    if (!dis_err_msgs)
    begin
        if (error_vsel==1) $display(" ===ERROR=== sky130_fd_io__top_refgen : %m : Incorrect inputs on vsel[1:0] = 11",$stime);
    end
end
endmodule
`endif // FUNCTIONAL

`endif // USE_POWER_PINS

`default_nettype wire
`endif  // SKY130_FD_IO__TOP_REFGEN_V


//--------EOF---------

/**
 * Copyright 2020 The SkyWater PDK Authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 * SPDX-License-Identifier: Apache-2.0
 */

`ifndef SKY130_FD_IO__TOP_REFGEN_NEW_V
`define SKY130_FD_IO__TOP_REFGEN_NEW_V

/**
 * top_refgen_new: The REFGEN block (sky130_fd_io__top_refgen) is used
 *                 to provide the input trip point (VINREF) for the
 *                 differential input buffer in SIO and also
 *                 the output buffer regulated output level (VOUTREF).
 *
 * Verilog top module.
 *
 * WARNING: This file is autogenerated, do not modify directly!
 */

`timescale 1ns / 1ps
`default_nettype none

`ifdef USE_POWER_PINS

`ifdef FUNCTIONAL
/*
 * Copyright 2020 The SkyWater PDK Authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 * SPDX-License-Identifier: Apache-2.0
*/

module sky130_fd_io__top_refgen_new (VINREF, VOUTREF, REFLEAK_BIAS,
                                     VCCD, VCCHIB, VDDA, VDDIO, VDDIO_Q, VSSD, VSSIO, VSSIO_Q, VSWITCH, VSSA,
                                     AMUXBUS_A, AMUXBUS_B, DFT_REFGEN, HLD_H_N, IBUF_SEL, ENABLE_H, ENABLE_VDDA_H, VOH_SEL, VOHREF,
                                     VREF_SEL, VREG_EN, VTRIP_SEL, VOUTREF_DFT, VINREF_DFT);
output VINREF;
output VOUTREF;
inout REFLEAK_BIAS;
inout VCCD;
inout VCCHIB;
inout VDDA;
inout VDDIO;
inout VDDIO_Q;
inout VSSD;
inout VSSIO;
inout VSSIO_Q;
inout VSWITCH;
inout VSSA;
inout AMUXBUS_A;
inout AMUXBUS_B;
input DFT_REFGEN;
input HLD_H_N;
input IBUF_SEL;
input ENABLE_H;
input ENABLE_VDDA_H;
input [2:0] VOH_SEL;
input VOHREF;
input [1:0] VREF_SEL;
input VREG_EN;
input VTRIP_SEL;
inout VOUTREF_DFT;
inout VINREF_DFT;
reg ibuf_sel_final, vtrip_sel_final, vreg_en_final, dft_refgen_final, vref_sel_int_final;
reg [2:0] voh_sel_final;
reg [1:0] vref_sel_final;
reg vohref_int;
wire  pwr_good_active_mode_1    = (VDDIO_Q===1) && (VSSD===0) && (VCCD===1);
wire  pwr_good_hold_mode_1      = (VDDIO_Q===1) && (VSSD===0);
wire  pwr_good_hold_mode_2   	= (VDDA===1) && (VSWITCH===1) && (VSSA===0) && (VSSD===0);
wire  pwr_good_active_mode_2 	= (VDDA===1) && (VSWITCH===1) && (VSSA===0) && (VSSD===0) && (VCCD===1);
wire  pwr_good_hold_mode_3   	= (VSWITCH===1) && (VSSD===0) && (VSSA===0);
wire  pwr_good_active_mode_3 	= (VSWITCH===1) && (VSSD===0) && (VCCD===1) && (VSSA===0);
`ifdef SKY130_FD_IO_TOP_REFGEN_NEW_DISABLE_DELAY
parameter STARTUP_TIME_VOUTREF = 0;
parameter STARTUP_TIME_VINREF  = 0;
`else
parameter STARTUP_TIME_VOUTREF = 50000;
parameter STARTUP_TIME_VINREF  = 50000;
`endif
integer startup_time_vinref,startup_time_voutref;
initial begin
    startup_time_vinref 	= vref_sel_int_final===1 && vtrip_sel_final===0 ? STARTUP_TIME_VINREF : 0;
    startup_time_voutref 	= STARTUP_TIME_VOUTREF;
end
wire 	notifier_enable_h, notifier_vtrip_sel, notifier_ibuf_sel, notifier_vref_sel,
      notifier_voh_sel, notifier_vreg_en, notifier_dft_refgen, notifier_vref_sel_int;
always @(*)
begin : LATCH_ibuf_sel
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode_1 || (ENABLE_H===1 && ^HLD_H_N===1'bx))
        ibuf_sel_final 		<= 1'bx;
    else if (ENABLE_H===0)
        ibuf_sel_final 		<= 1'b0;
    else if (HLD_H_N===1)
        ibuf_sel_final 		<= (^IBUF_SEL 	  === 1'bx  || !pwr_good_active_mode_1) ? 1'bx 	: IBUF_SEL;
end
always @(notifier_enable_h or notifier_ibuf_sel)
begin
    disable LATCH_ibuf_sel; ibuf_sel_final <= 1'bx;
end
always @(*)
begin : LATCH_vtrip_sel
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode_1 || (ENABLE_H===1 && ^HLD_H_N===1'bx))
        vtrip_sel_final 		<= 1'bx;
    else if (ENABLE_H===0)
        vtrip_sel_final 		<= 1'b0;
    else if (HLD_H_N===1)
        vtrip_sel_final 		<= (^VTRIP_SEL 	  === 1'bx  || !pwr_good_active_mode_1) ? 1'bx 	: VTRIP_SEL;
end
always @(notifier_enable_h or notifier_vtrip_sel)
begin
    disable LATCH_vtrip_sel; vtrip_sel_final <= 1'bx;
end
always @(*)
begin : LATCH_vreg_en
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode_1 || (ENABLE_H===1 && ^HLD_H_N===1'bx))
        vreg_en_final 		<= 1'bx;
    else if (ENABLE_H===0)
        vreg_en_final 		<= 1'b0;
    else if (HLD_H_N===1)
        vreg_en_final 		<= (^VREG_EN 	  === 1'bx  || !pwr_good_active_mode_1) ? 1'bx 	: VREG_EN;
end
always @(notifier_enable_h or notifier_vreg_en)
begin
    disable LATCH_vreg_en; vreg_en_final <= 1'bx;
end
always @(*)
begin : LATCH_vref_sel_int
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode_1 || (ENABLE_H===1 && ^HLD_H_N===1'bx))
        vref_sel_int_final 		<= 1'bx;
    else if (ENABLE_H===0)
        vref_sel_int_final 		<= 1'b0;
    else if (HLD_H_N===1)
        vref_sel_int_final 		<= (^VREF_SEL[1:0]  === 1'bx  || !pwr_good_active_mode_1) ? 1'bx : (VREF_SEL[1] || VREF_SEL[0]);
end
always @(notifier_enable_h or notifier_vref_sel_int)
begin
    disable LATCH_vref_sel; vref_sel_int_final <= 1'bx;
end
always @(*)
begin : LATCH_vref_sel
    if (^ENABLE_VDDA_H===1'bx || ^ENABLE_H===1'bx ||!pwr_good_hold_mode_2 || (ENABLE_VDDA_H===1 && ENABLE_H===1 && ^HLD_H_N===1'bx))
        vref_sel_final 	= 2'bxx;
    else if (ENABLE_VDDA_H===0 || ENABLE_H===0)
        vref_sel_final	= 2'b00;
    else if (HLD_H_N===1)
        vref_sel_final 	= (^VREF_SEL[1:0]=== 1'bx || !pwr_good_active_mode_2) ? 2'bxx : VREF_SEL;
end
always @(notifier_enable_h or notifier_vref_sel)
begin
    disable LATCH_vref_sel; vref_sel_final <= 2'bxx;
end
always @(*)
begin : LATCH_dft_refgen
    if (^ENABLE_VDDA_H===1'bx || ^ENABLE_H===1'bx ||!pwr_good_hold_mode_2 || (ENABLE_VDDA_H===1 && ENABLE_H===1 &&^HLD_H_N===1'bx))
        dft_refgen_final 	= 2'bxx;
    else if (ENABLE_VDDA_H===0 || ENABLE_H===0)
        dft_refgen_final	= 2'b00;
    else if (HLD_H_N===1)
        dft_refgen_final 	= (^DFT_REFGEN=== 1'bx || !pwr_good_active_mode_2) ? 2'bxx : DFT_REFGEN;
end
always @(notifier_enable_h or notifier_dft_refgen)
begin
    disable LATCH_dft_refgen; dft_refgen_final <= 2'bxx;
end
always @(*)
begin : LATCH_voh_sel
    if (^ENABLE_VDDA_H===1'bx ||^ENABLE_H===1'bx || !pwr_good_hold_mode_3 || (ENABLE_VDDA_H===1 && ENABLE_H===1 && ^HLD_H_N===1'bx))
        voh_sel_final 	= 3'bxxx;
    else if (ENABLE_VDDA_H===0 || ENABLE_H===0)
        voh_sel_final	= 3'b000;
    else if (HLD_H_N===1)
        voh_sel_final 	= (^VOH_SEL[2:0]=== 1'bx || !pwr_good_active_mode_3) ? 3'bxxx : VOH_SEL;
end
always @(notifier_enable_h or notifier_voh_sel)
begin
    disable LATCH_voh_sel; voh_sel_final <= 2'bxx;
end
always @(*)
begin
    case (vref_sel_final[1:0])
        2'b00, 2'b01   : vohref_int = VOHREF!==1'b1 ? 1'bx : VOHREF;
        2'b10	       : vohref_int = ^AMUXBUS_A!==1'b1 ? 1'bx : AMUXBUS_A;
        2'b11	       : vohref_int = ^AMUXBUS_B!==1'b1 ? 1'bx : AMUXBUS_B;
        default	       : vohref_int = 1'bx;
    endcase
end
wire vohref_final = ENABLE_VDDA_H===1'b1 ? vohref_int : 1'bx;
assign #(startup_time_voutref,0) VOUTREF = (REFLEAK_BIAS===1'bx) ? 1'bx : (REFLEAK_BIAS===1 ? vohref_final:1'bz);
assign VOUTREF_DFT = dft_refgen_final===1 ? VOUTREF : (dft_refgen_final===0 ? 1'bz : 1'bx);
assign REFLEAK_BIAS = VCCHIB!==1 ? 1'bx : (vreg_en_final || (ibuf_sel_final && vref_sel_int_final));
reg vinref_tmp;
always @(*)
begin
    if (ibuf_sel_final===1'bx
            || (ibuf_sel_final===1 && (vref_sel_int_final===1'bx || vtrip_sel_final===1'bx))
            || (ibuf_sel_final===1 && vref_sel_int_final===1 && (VCCHIB!==1 || vohref_int!==1))
            || (ibuf_sel_final===1 && vref_sel_int_final===1 && vtrip_sel_final===0 && ^voh_sel_final[2:0]===1'bx))
        vinref_tmp = 1'bx;
    else
        vinref_tmp = ibuf_sel_final===0 ? 1'bz : 1'b1;
end
assign #(startup_time_vinref,0) VINREF = vinref_tmp;
assign VINREF_DFT = dft_refgen_final===1 ? VINREF : (dft_refgen_final===0 ? 1'bz : 1'bx);
endmodule
`else  // FUNCTIONAL
/*
 * Copyright 2020 The SkyWater PDK Authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 * SPDX-License-Identifier: Apache-2.0
*/

module sky130_fd_io__top_refgen_new (VINREF, VOUTREF, REFLEAK_BIAS,
                                     VCCD, VCCHIB, VDDA, VDDIO, VDDIO_Q, VSSD, VSSIO, VSSIO_Q, VSWITCH, VSSA,
                                     AMUXBUS_A, AMUXBUS_B, DFT_REFGEN, HLD_H_N, IBUF_SEL, ENABLE_H, ENABLE_VDDA_H, VOH_SEL, VOHREF,
                                     VREF_SEL, VREG_EN, VTRIP_SEL, VOUTREF_DFT, VINREF_DFT);
output VINREF;
output VOUTREF;
inout REFLEAK_BIAS;
inout VCCD;
inout VCCHIB;
inout VDDA;
inout VDDIO;
inout VDDIO_Q;
inout VSSD;
inout VSSIO;
inout VSSIO_Q;
inout VSWITCH;
inout VSSA;
inout AMUXBUS_A;
inout AMUXBUS_B;
input DFT_REFGEN;
input HLD_H_N;
input IBUF_SEL;
input ENABLE_H;
input ENABLE_VDDA_H;
input [2:0] VOH_SEL;
input VOHREF;
input [1:0] VREF_SEL;
input VREG_EN;
input VTRIP_SEL;
inout VOUTREF_DFT;
inout VINREF_DFT;
reg ibuf_sel_final, vtrip_sel_final, vreg_en_final, dft_refgen_final, vref_sel_int_final;
reg [2:0] voh_sel_final;
reg [1:0] vref_sel_final;
reg vohref_int;
wire  pwr_good_active_mode_1    = (VDDIO_Q===1) && (VSSD===0) && (VCCD===1);
wire  pwr_good_hold_mode_1      = (VDDIO_Q===1) && (VSSD===0);
wire  pwr_good_hold_mode_2   	= (VDDA===1) && (VSWITCH===1) && (VSSA===0) && (VSSD===0);
wire  pwr_good_active_mode_2 	= (VDDA===1) && (VSWITCH===1) && (VSSA===0) && (VSSD===0) && (VCCD===1);
wire  pwr_good_hold_mode_3   	= (VSWITCH===1) && (VSSD===0) && (VSSA===0);
wire  pwr_good_active_mode_3 	= (VSWITCH===1) && (VSSD===0) && (VCCD===1) && (VSSA===0);
`ifdef SKY130_FD_IO_TOP_REFGEN_NEW_DISABLE_DELAY
parameter STARTUP_TIME_VOUTREF = 0;
parameter STARTUP_TIME_VINREF  = 0;
`else
parameter STARTUP_TIME_VOUTREF = 50000;
parameter STARTUP_TIME_VINREF  = 50000;
`endif
integer startup_time_vinref,startup_time_voutref;
initial begin
    startup_time_vinref 	= vref_sel_int_final===1 && vtrip_sel_final===0 ? STARTUP_TIME_VINREF : 0;
    startup_time_voutref 	= STARTUP_TIME_VOUTREF;
end
wire 	notifier_enable_h, notifier_vtrip_sel, notifier_ibuf_sel, notifier_vref_sel,
      notifier_voh_sel, notifier_vreg_en, notifier_dft_refgen, notifier_vref_sel_int;
always @(*)
begin : LATCH_ibuf_sel
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode_1 || (ENABLE_H===1 && ^HLD_H_N===1'bx))
        ibuf_sel_final 		<= 1'bx;
    else if (ENABLE_H===0)
        ibuf_sel_final 		<= 1'b0;
    else if (HLD_H_N===1)
        ibuf_sel_final 		<= (^IBUF_SEL 	  === 1'bx  || !pwr_good_active_mode_1) ? 1'bx 	: IBUF_SEL;
end
always @(notifier_enable_h or notifier_ibuf_sel)
begin
    disable LATCH_ibuf_sel; ibuf_sel_final <= 1'bx;
end
always @(*)
begin : LATCH_vtrip_sel
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode_1 || (ENABLE_H===1 && ^HLD_H_N===1'bx))
        vtrip_sel_final 		<= 1'bx;
    else if (ENABLE_H===0)
        vtrip_sel_final 		<= 1'b0;
    else if (HLD_H_N===1)
        vtrip_sel_final 		<= (^VTRIP_SEL 	  === 1'bx  || !pwr_good_active_mode_1) ? 1'bx 	: VTRIP_SEL;
end
always @(notifier_enable_h or notifier_vtrip_sel)
begin
    disable LATCH_vtrip_sel; vtrip_sel_final <= 1'bx;
end
always @(*)
begin : LATCH_vreg_en
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode_1 || (ENABLE_H===1 && ^HLD_H_N===1'bx))
        vreg_en_final 		<= 1'bx;
    else if (ENABLE_H===0)
        vreg_en_final 		<= 1'b0;
    else if (HLD_H_N===1)
        vreg_en_final 		<= (^VREG_EN 	  === 1'bx  || !pwr_good_active_mode_1) ? 1'bx 	: VREG_EN;
end
always @(notifier_enable_h or notifier_vreg_en)
begin
    disable LATCH_vreg_en; vreg_en_final <= 1'bx;
end
always @(*)
begin : LATCH_vref_sel_int
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode_1 || (ENABLE_H===1 && ^HLD_H_N===1'bx))
        vref_sel_int_final 		<= 1'bx;
    else if (ENABLE_H===0)
        vref_sel_int_final 		<= 1'b0;
    else if (HLD_H_N===1)
        vref_sel_int_final 		<= (^VREF_SEL[1:0]  === 1'bx  || !pwr_good_active_mode_1) ? 1'bx : (VREF_SEL[1] || VREF_SEL[0]);
end
always @(notifier_enable_h or notifier_vref_sel_int)
begin
    disable LATCH_vref_sel; vref_sel_int_final <= 1'bx;
end
always @(*)
begin : LATCH_vref_sel
    if (^ENABLE_VDDA_H===1'bx || ^ENABLE_H===1'bx ||!pwr_good_hold_mode_2 || (ENABLE_VDDA_H===1 && ENABLE_H===1 && ^HLD_H_N===1'bx))
        vref_sel_final 	= 2'bxx;
    else if (ENABLE_VDDA_H===0 || ENABLE_H===0)
        vref_sel_final	= 2'b00;
    else if (HLD_H_N===1)
        vref_sel_final 	= (^VREF_SEL[1:0]=== 1'bx || !pwr_good_active_mode_2) ? 2'bxx : VREF_SEL;
end
always @(notifier_enable_h or notifier_vref_sel)
begin
    disable LATCH_vref_sel; vref_sel_final <= 2'bxx;
end
always @(*)
begin : LATCH_dft_refgen
    if (^ENABLE_VDDA_H===1'bx || ^ENABLE_H===1'bx ||!pwr_good_hold_mode_2 || (ENABLE_VDDA_H===1 && ENABLE_H===1 &&^HLD_H_N===1'bx))
        dft_refgen_final 	= 2'bxx;
    else if (ENABLE_VDDA_H===0 || ENABLE_H===0)
        dft_refgen_final	= 2'b00;
    else if (HLD_H_N===1)
        dft_refgen_final 	= (^DFT_REFGEN=== 1'bx || !pwr_good_active_mode_2) ? 2'bxx : DFT_REFGEN;
end
always @(notifier_enable_h or notifier_dft_refgen)
begin
    disable LATCH_dft_refgen; dft_refgen_final <= 2'bxx;
end
always @(*)
begin : LATCH_voh_sel
    if (^ENABLE_VDDA_H===1'bx ||^ENABLE_H===1'bx || !pwr_good_hold_mode_3 || (ENABLE_VDDA_H===1 && ENABLE_H===1 && ^HLD_H_N===1'bx))
        voh_sel_final 	= 3'bxxx;
    else if (ENABLE_VDDA_H===0 || ENABLE_H===0)
        voh_sel_final	= 3'b000;
    else if (HLD_H_N===1)
        voh_sel_final 	= (^VOH_SEL[2:0]=== 1'bx || !pwr_good_active_mode_3) ? 3'bxxx : VOH_SEL;
end
always @(notifier_enable_h or notifier_voh_sel)
begin
    disable LATCH_voh_sel; voh_sel_final <= 2'bxx;
end
always @(*)
begin
    case (vref_sel_final[1:0])
        2'b00, 2'b01   : vohref_int = VOHREF!==1'b1 ? 1'bx : VOHREF;
        2'b10	       : vohref_int = ^AMUXBUS_A!==1'b1 ? 1'bx : AMUXBUS_A;
        2'b11	       : vohref_int = ^AMUXBUS_B!==1'b1 ? 1'bx : AMUXBUS_B;
        default	       : vohref_int = 1'bx;
    endcase
end
wire vohref_final = ENABLE_VDDA_H===1'b1 ? vohref_int : 1'bx;
assign #(startup_time_voutref,0) VOUTREF = (REFLEAK_BIAS===1'bx) ? 1'bx : (REFLEAK_BIAS===1 ? vohref_final:1'bz);
assign VOUTREF_DFT = dft_refgen_final===1 ? VOUTREF : (dft_refgen_final===0 ? 1'bz : 1'bx);
assign REFLEAK_BIAS = VCCHIB!==1 ? 1'bx : (vreg_en_final || (ibuf_sel_final && vref_sel_int_final));
reg vinref_tmp;
always @(*)
begin
    if (ibuf_sel_final===1'bx
            || (ibuf_sel_final===1 && (vref_sel_int_final===1'bx || vtrip_sel_final===1'bx))
            || (ibuf_sel_final===1 && vref_sel_int_final===1 && (VCCHIB!==1 || vohref_int!==1))
            || (ibuf_sel_final===1 && vref_sel_int_final===1 && vtrip_sel_final===0 && ^voh_sel_final[2:0]===1'bx))
        vinref_tmp = 1'bx;
    else
        vinref_tmp = ibuf_sel_final===0 ? 1'bz : 1'b1;
end
assign #(startup_time_vinref,0) VINREF = vinref_tmp;
assign VINREF_DFT = dft_refgen_final===1 ? VINREF : (dft_refgen_final===0 ? 1'bz : 1'bx);
endmodule
`endif // FUNCTIONAL

`else  // USE_POWER_PINS

`ifdef FUNCTIONAL
/*
 * Copyright 2020 The SkyWater PDK Authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 * SPDX-License-Identifier: Apache-2.0
*/

module sky130_fd_io__top_refgen_new (VINREF, VOUTREF, REFLEAK_BIAS,
                                     AMUXBUS_A, AMUXBUS_B, DFT_REFGEN, HLD_H_N, IBUF_SEL, ENABLE_H, ENABLE_VDDA_H, VOH_SEL, VOHREF,
                                     VREF_SEL, VREG_EN, VTRIP_SEL, VOUTREF_DFT, VINREF_DFT);
output VINREF;
output VOUTREF;
inout REFLEAK_BIAS;
supply1 vccd;
supply1 vcchib;
supply1 vdda;
supply1 vddio;
supply1 vddio_q;
supply0 vssd;
supply0 vssio;
supply0 vssio_q;
supply1 vswitch;
supply0 vssa;
inout AMUXBUS_A;
inout AMUXBUS_B;
input DFT_REFGEN;
input HLD_H_N;
input IBUF_SEL;
input ENABLE_H;
input ENABLE_VDDA_H;
input [2:0] VOH_SEL;
input VOHREF;
input [1:0] VREF_SEL;
input VREG_EN;
input VTRIP_SEL;
inout VOUTREF_DFT;
inout VINREF_DFT;
reg ibuf_sel_final, vtrip_sel_final, vreg_en_final, dft_refgen_final, vref_sel_int_final;
reg [2:0] voh_sel_final;
reg [1:0] vref_sel_final;
reg vohref_int;
wire  pwr_good_active_mode_1    = 1;
wire  pwr_good_hold_mode_1	= 1;
wire  pwr_good_hold_mode_2   	= 1;
wire  pwr_good_active_mode_2 	= 1;
wire  pwr_good_hold_mode_3   	= 1;
wire  pwr_good_active_mode_3 	= 1;
`ifdef SKY130_FD_IO_TOP_REFGEN_NEW_DISABLE_DELAY
parameter STARTUP_TIME_VOUTREF = 0;
parameter STARTUP_TIME_VINREF  = 0;
`else
parameter STARTUP_TIME_VOUTREF = 50000;
parameter STARTUP_TIME_VINREF  = 50000;
`endif
integer startup_time_vinref,startup_time_voutref;
initial begin
    startup_time_vinref 	= vref_sel_int_final===1 && vtrip_sel_final===0 ? STARTUP_TIME_VINREF : 0;
    startup_time_voutref 	= STARTUP_TIME_VOUTREF;
end
wire 	notifier_enable_h, notifier_vtrip_sel, notifier_ibuf_sel, notifier_vref_sel,
      notifier_voh_sel, notifier_vreg_en, notifier_dft_refgen, notifier_vref_sel_int;
always @(*)
begin : LATCH_ibuf_sel
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode_1 || (ENABLE_H===1 && ^HLD_H_N===1'bx))
        ibuf_sel_final 		<= 1'bx;
    else if (ENABLE_H===0)
        ibuf_sel_final 		<= 1'b0;
    else if (HLD_H_N===1)
        ibuf_sel_final 		<= (^IBUF_SEL 	  === 1'bx  || !pwr_good_active_mode_1) ? 1'bx 	: IBUF_SEL;
end
always @(notifier_enable_h or notifier_ibuf_sel)
begin
    disable LATCH_ibuf_sel; ibuf_sel_final <= 1'bx;
end
always @(*)
begin : LATCH_vtrip_sel
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode_1 || (ENABLE_H===1 && ^HLD_H_N===1'bx))
        vtrip_sel_final 		<= 1'bx;
    else if (ENABLE_H===0)
        vtrip_sel_final 		<= 1'b0;
    else if (HLD_H_N===1)
        vtrip_sel_final 		<= (^VTRIP_SEL 	  === 1'bx  || !pwr_good_active_mode_1) ? 1'bx 	: VTRIP_SEL;
end
always @(notifier_enable_h or notifier_vtrip_sel)
begin
    disable LATCH_vtrip_sel; vtrip_sel_final <= 1'bx;
end
always @(*)
begin : LATCH_vreg_en
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode_1 || (ENABLE_H===1 && ^HLD_H_N===1'bx))
        vreg_en_final 		<= 1'bx;
    else if (ENABLE_H===0)
        vreg_en_final 		<= 1'b0;
    else if (HLD_H_N===1)
        vreg_en_final 		<= (^VREG_EN 	  === 1'bx  || !pwr_good_active_mode_1) ? 1'bx 	: VREG_EN;
end
always @(notifier_enable_h or notifier_vreg_en)
begin
    disable LATCH_vreg_en; vreg_en_final <= 1'bx;
end
always @(*)
begin : LATCH_vref_sel_int
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode_1 || (ENABLE_H===1 && ^HLD_H_N===1'bx))
        vref_sel_int_final 		<= 1'bx;
    else if (ENABLE_H===0)
        vref_sel_int_final 		<= 1'b0;
    else if (HLD_H_N===1)
        vref_sel_int_final 		<= (^VREF_SEL[1:0]  === 1'bx  || !pwr_good_active_mode_1) ? 1'bx : (VREF_SEL[1] || VREF_SEL[0]);
end
always @(notifier_enable_h or notifier_vref_sel_int)
begin
    disable LATCH_vref_sel; vref_sel_int_final <= 1'bx;
end
always @(*)
begin : LATCH_vref_sel
    if (^ENABLE_VDDA_H===1'bx || ^ENABLE_H===1'bx ||!pwr_good_hold_mode_2 || (ENABLE_VDDA_H===1 && ENABLE_H===1 && ^HLD_H_N===1'bx))
        vref_sel_final 	= 2'bxx;
    else if (ENABLE_VDDA_H===0 || ENABLE_H===0)
        vref_sel_final	= 2'b00;
    else if (HLD_H_N===1)
        vref_sel_final 	= (^VREF_SEL[1:0]=== 1'bx || !pwr_good_active_mode_2) ? 2'bxx : VREF_SEL;
end
always @(notifier_enable_h or notifier_vref_sel)
begin
    disable LATCH_vref_sel; vref_sel_final <= 2'bxx;
end
always @(*)
begin : LATCH_dft_refgen
    if (^ENABLE_VDDA_H===1'bx || ^ENABLE_H===1'bx ||!pwr_good_hold_mode_2 || (ENABLE_VDDA_H===1 && ENABLE_H===1 &&^HLD_H_N===1'bx))
        dft_refgen_final 	= 2'bxx;
    else if (ENABLE_VDDA_H===0 || ENABLE_H===0)
        dft_refgen_final	= 2'b00;
    else if (HLD_H_N===1)
        dft_refgen_final 	= (^DFT_REFGEN=== 1'bx || !pwr_good_active_mode_2) ? 2'bxx : DFT_REFGEN;
end
always @(notifier_enable_h or notifier_dft_refgen)
begin
    disable LATCH_dft_refgen; dft_refgen_final <= 2'bxx;
end
always @(*)
begin : LATCH_voh_sel
    if (^ENABLE_VDDA_H===1'bx ||^ENABLE_H===1'bx || !pwr_good_hold_mode_3 || (ENABLE_VDDA_H===1 && ENABLE_H===1 && ^HLD_H_N===1'bx))
        voh_sel_final 	= 3'bxxx;
    else if (ENABLE_VDDA_H===0 || ENABLE_H===0)
        voh_sel_final	= 3'b000;
    else if (HLD_H_N===1)
        voh_sel_final 	= (^VOH_SEL[2:0]=== 1'bx || !pwr_good_active_mode_3) ? 3'bxxx : VOH_SEL;
end
always @(notifier_enable_h or notifier_voh_sel)
begin
    disable LATCH_voh_sel; voh_sel_final <= 2'bxx;
end
always @(*)
begin
    case (vref_sel_final[1:0])
        2'b00, 2'b01   : vohref_int = VOHREF!==1'b1 ? 1'bx : VOHREF;
        2'b10	       : vohref_int = ^AMUXBUS_A!==1'b1 ? 1'bx : AMUXBUS_A;
        2'b11	       : vohref_int = ^AMUXBUS_B!==1'b1 ? 1'bx : AMUXBUS_B;
        default	       : vohref_int = 1'bx;
    endcase
end
wire vohref_final = ENABLE_VDDA_H===1'b1 ? vohref_int : 1'bx;
assign #(startup_time_voutref,0) VOUTREF = (REFLEAK_BIAS===1'bx) ? 1'bx : (REFLEAK_BIAS===1 ? vohref_final:1'bz);
assign VOUTREF_DFT = dft_refgen_final===1 ? VOUTREF : (dft_refgen_final===0 ? 1'bz : 1'bx);
assign REFLEAK_BIAS = vcchib!==1 ? 1'bx : (vreg_en_final || (ibuf_sel_final && vref_sel_int_final));
reg vinref_tmp;
always @(*)
begin
    if (ibuf_sel_final===1'bx
            || (ibuf_sel_final===1 && (vref_sel_int_final===1'bx || vtrip_sel_final===1'bx))
            || (ibuf_sel_final===1 && vref_sel_int_final===1 && (vcchib!==1 || vohref_int!==1))
            || (ibuf_sel_final===1 && vref_sel_int_final===1 && vtrip_sel_final===0 && ^voh_sel_final[2:0]===1'bx))
        vinref_tmp = 1'bx;
    else
        vinref_tmp = ibuf_sel_final===0 ? 1'bz : 1'b1;
end
assign #(startup_time_vinref,0) VINREF = vinref_tmp;
assign VINREF_DFT = dft_refgen_final===1 ? VINREF : (dft_refgen_final===0 ? 1'bz : 1'bx);
endmodule
`else  // FUNCTIONAL
/*
 * Copyright 2020 The SkyWater PDK Authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 * SPDX-License-Identifier: Apache-2.0
*/

module sky130_fd_io__top_refgen_new (VINREF, VOUTREF, REFLEAK_BIAS,
                                     AMUXBUS_A, AMUXBUS_B, DFT_REFGEN, HLD_H_N, IBUF_SEL, ENABLE_H, ENABLE_VDDA_H, VOH_SEL, VOHREF,
                                     VREF_SEL, VREG_EN, VTRIP_SEL, VOUTREF_DFT, VINREF_DFT);
output VINREF;
output VOUTREF;
inout REFLEAK_BIAS;
supply1 vccd;
supply1 vcchib;
supply1 vdda;
supply1 vddio;
supply1 vddio_q;
supply0 vssd;
supply0 vssio;
supply0 vssio_q;
supply1 vswitch;
supply0 vssa;
inout AMUXBUS_A;
inout AMUXBUS_B;
input DFT_REFGEN;
input HLD_H_N;
input IBUF_SEL;
input ENABLE_H;
input ENABLE_VDDA_H;
input [2:0] VOH_SEL;
input VOHREF;
input [1:0] VREF_SEL;
input VREG_EN;
input VTRIP_SEL;
inout VOUTREF_DFT;
inout VINREF_DFT;
reg ibuf_sel_final, vtrip_sel_final, vreg_en_final, dft_refgen_final, vref_sel_int_final;
reg [2:0] voh_sel_final;
reg [1:0] vref_sel_final;
reg vohref_int;
wire  pwr_good_active_mode_1    = 1;
wire  pwr_good_hold_mode_1	= 1;
wire  pwr_good_hold_mode_2   	= 1;
wire  pwr_good_active_mode_2 	= 1;
wire  pwr_good_hold_mode_3   	= 1;
wire  pwr_good_active_mode_3 	= 1;
`ifdef SKY130_FD_IO_TOP_REFGEN_NEW_DISABLE_DELAY
parameter STARTUP_TIME_VOUTREF = 0;
parameter STARTUP_TIME_VINREF  = 0;
`else
parameter STARTUP_TIME_VOUTREF = 50000;
parameter STARTUP_TIME_VINREF  = 50000;
`endif
integer startup_time_vinref,startup_time_voutref;
initial begin
    startup_time_vinref 	= vref_sel_int_final===1 && vtrip_sel_final===0 ? STARTUP_TIME_VINREF : 0;
    startup_time_voutref 	= STARTUP_TIME_VOUTREF;
end
wire 	notifier_enable_h, notifier_vtrip_sel, notifier_ibuf_sel, notifier_vref_sel,
      notifier_voh_sel, notifier_vreg_en, notifier_dft_refgen, notifier_vref_sel_int;
always @(*)
begin : LATCH_ibuf_sel
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode_1 || (ENABLE_H===1 && ^HLD_H_N===1'bx))
        ibuf_sel_final 		<= 1'bx;
    else if (ENABLE_H===0)
        ibuf_sel_final 		<= 1'b0;
    else if (HLD_H_N===1)
        ibuf_sel_final 		<= (^IBUF_SEL 	  === 1'bx  || !pwr_good_active_mode_1) ? 1'bx 	: IBUF_SEL;
end
always @(notifier_enable_h or notifier_ibuf_sel)
begin
    disable LATCH_ibuf_sel; ibuf_sel_final <= 1'bx;
end
always @(*)
begin : LATCH_vtrip_sel
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode_1 || (ENABLE_H===1 && ^HLD_H_N===1'bx))
        vtrip_sel_final 		<= 1'bx;
    else if (ENABLE_H===0)
        vtrip_sel_final 		<= 1'b0;
    else if (HLD_H_N===1)
        vtrip_sel_final 		<= (^VTRIP_SEL 	  === 1'bx  || !pwr_good_active_mode_1) ? 1'bx 	: VTRIP_SEL;
end
always @(notifier_enable_h or notifier_vtrip_sel)
begin
    disable LATCH_vtrip_sel; vtrip_sel_final <= 1'bx;
end
always @(*)
begin : LATCH_vreg_en
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode_1 || (ENABLE_H===1 && ^HLD_H_N===1'bx))
        vreg_en_final 		<= 1'bx;
    else if (ENABLE_H===0)
        vreg_en_final 		<= 1'b0;
    else if (HLD_H_N===1)
        vreg_en_final 		<= (^VREG_EN 	  === 1'bx  || !pwr_good_active_mode_1) ? 1'bx 	: VREG_EN;
end
always @(notifier_enable_h or notifier_vreg_en)
begin
    disable LATCH_vreg_en; vreg_en_final <= 1'bx;
end
always @(*)
begin : LATCH_vref_sel_int
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode_1 || (ENABLE_H===1 && ^HLD_H_N===1'bx))
        vref_sel_int_final 		<= 1'bx;
    else if (ENABLE_H===0)
        vref_sel_int_final 		<= 1'b0;
    else if (HLD_H_N===1)
        vref_sel_int_final 		<= (^VREF_SEL[1:0]  === 1'bx  || !pwr_good_active_mode_1) ? 1'bx : (VREF_SEL[1] || VREF_SEL[0]);
end
always @(notifier_enable_h or notifier_vref_sel_int)
begin
    disable LATCH_vref_sel; vref_sel_int_final <= 1'bx;
end
always @(*)
begin : LATCH_vref_sel
    if (^ENABLE_VDDA_H===1'bx || ^ENABLE_H===1'bx ||!pwr_good_hold_mode_2 || (ENABLE_VDDA_H===1 && ENABLE_H===1 && ^HLD_H_N===1'bx))
        vref_sel_final 	= 2'bxx;
    else if (ENABLE_VDDA_H===0 || ENABLE_H===0)
        vref_sel_final	= 2'b00;
    else if (HLD_H_N===1)
        vref_sel_final 	= (^VREF_SEL[1:0]=== 1'bx || !pwr_good_active_mode_2) ? 2'bxx : VREF_SEL;
end
always @(notifier_enable_h or notifier_vref_sel)
begin
    disable LATCH_vref_sel; vref_sel_final <= 2'bxx;
end
always @(*)
begin : LATCH_dft_refgen
    if (^ENABLE_VDDA_H===1'bx || ^ENABLE_H===1'bx ||!pwr_good_hold_mode_2 || (ENABLE_VDDA_H===1 && ENABLE_H===1 &&^HLD_H_N===1'bx))
        dft_refgen_final 	= 2'bxx;
    else if (ENABLE_VDDA_H===0 || ENABLE_H===0)
        dft_refgen_final	= 2'b00;
    else if (HLD_H_N===1)
        dft_refgen_final 	= (^DFT_REFGEN=== 1'bx || !pwr_good_active_mode_2) ? 2'bxx : DFT_REFGEN;
end
always @(notifier_enable_h or notifier_dft_refgen)
begin
    disable LATCH_dft_refgen; dft_refgen_final <= 2'bxx;
end
always @(*)
begin : LATCH_voh_sel
    if (^ENABLE_VDDA_H===1'bx ||^ENABLE_H===1'bx || !pwr_good_hold_mode_3 || (ENABLE_VDDA_H===1 && ENABLE_H===1 && ^HLD_H_N===1'bx))
        voh_sel_final 	= 3'bxxx;
    else if (ENABLE_VDDA_H===0 || ENABLE_H===0)
        voh_sel_final	= 3'b000;
    else if (HLD_H_N===1)
        voh_sel_final 	= (^VOH_SEL[2:0]=== 1'bx || !pwr_good_active_mode_3) ? 3'bxxx : VOH_SEL;
end
always @(notifier_enable_h or notifier_voh_sel)
begin
    disable LATCH_voh_sel; voh_sel_final <= 2'bxx;
end
always @(*)
begin
    case (vref_sel_final[1:0])
        2'b00, 2'b01   : vohref_int = VOHREF!==1'b1 ? 1'bx : VOHREF;
        2'b10	       : vohref_int = ^AMUXBUS_A!==1'b1 ? 1'bx : AMUXBUS_A;
        2'b11	       : vohref_int = ^AMUXBUS_B!==1'b1 ? 1'bx : AMUXBUS_B;
        default	       : vohref_int = 1'bx;
    endcase
end
wire vohref_final = ENABLE_VDDA_H===1'b1 ? vohref_int : 1'bx;
assign #(startup_time_voutref,0) VOUTREF = (REFLEAK_BIAS===1'bx) ? 1'bx : (REFLEAK_BIAS===1 ? vohref_final:1'bz);
assign VOUTREF_DFT = dft_refgen_final===1 ? VOUTREF : (dft_refgen_final===0 ? 1'bz : 1'bx);
assign REFLEAK_BIAS = vcchib!==1 ? 1'bx : (vreg_en_final || (ibuf_sel_final && vref_sel_int_final));
reg vinref_tmp;
always @(*)
begin
    if (ibuf_sel_final===1'bx
            || (ibuf_sel_final===1 && (vref_sel_int_final===1'bx || vtrip_sel_final===1'bx))
            || (ibuf_sel_final===1 && vref_sel_int_final===1 && (vcchib!==1 || vohref_int!==1))
            || (ibuf_sel_final===1 && vref_sel_int_final===1 && vtrip_sel_final===0 && ^voh_sel_final[2:0]===1'bx))
        vinref_tmp = 1'bx;
    else
        vinref_tmp = ibuf_sel_final===0 ? 1'bz : 1'b1;
end
assign #(startup_time_vinref,0) VINREF = vinref_tmp;
assign VINREF_DFT = dft_refgen_final===1 ? VINREF : (dft_refgen_final===0 ? 1'bz : 1'bx);
endmodule
`endif // FUNCTIONAL

`endif // USE_POWER_PINS

`default_nettype wire
`endif  // SKY130_FD_IO__TOP_REFGEN_NEW_V


//--------EOF---------

/**
 * Copyright 2020 The SkyWater PDK Authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 * SPDX-License-Identifier: Apache-2.0
 */

`ifndef SKY130_FD_IO__TOP_SIO_V
`define SKY130_FD_IO__TOP_SIO_V

/**
 * top_sio: Special I/O PAD that provides additionally a
 *          regulated output buffer and a differential input buffer.
 *          SIO cells are ONLY available IN pairs (see top_sio_macro).
 *
 * Verilog top module.
 *
 * WARNING: This file is autogenerated, do not modify directly!
 */

`timescale 1ns / 1ps
`default_nettype none

`ifdef USE_POWER_PINS

`ifdef FUNCTIONAL
/*
 * Copyright 2020 The SkyWater PDK Authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 * SPDX-License-Identifier: Apache-2.0
*/

module sky130_fd_io__top_sio (IN_H, PAD_A_NOESD_H, PAD, DM, HLD_H_N, INP_DIS, IN,
                              ENABLE_H, OE_N, SLOW, VTRIP_SEL, VINREF, VOUTREF, VREG_EN, IBUF_SEL,
                              REFLEAK_BIAS, PAD_A_ESD_0_H, TIE_LO_ESD, HLD_OVR, OUT,
                              PAD_A_ESD_1_H
                              ,VSSIO, VSSIO_Q, VSSD, VCCD, VDDIO, VCCHIB, VDDIO_Q
                             );
output IN_H;
inout PAD_A_NOESD_H;
inout PAD;
input [2:0] DM;
input HLD_H_N;
input INP_DIS;
output IN;
input ENABLE_H;
input OE_N;
input SLOW;
input VTRIP_SEL;
input VINREF;
input VOUTREF;
input VREG_EN;
input IBUF_SEL;
input REFLEAK_BIAS;
inout PAD_A_ESD_0_H;
output TIE_LO_ESD;
input HLD_OVR;
input OUT;
inout PAD_A_ESD_1_H;
inout VSSIO;
inout VSSIO_Q;
inout VSSD;
inout VCCD;
inout VDDIO;
inout VCCHIB;
inout VDDIO_Q;
reg [2:0] dm_final;
reg slow_final, vtrip_sel_final, inp_dis_final, out_final, oe_n_final, hld_ovr_final;
reg ibuf_sel_final, vreg_en_final;
wire notifier_dm, notifier_slow, notifier_oe_n, notifier_out, notifier_vtrip_sel, notifier_hld_ovr, notifier_inp_dis, notifier_vreg_en,notifier_ibuf_sel;
wire notifier_enable_h;
wire  pwr_good_hold_ovr_mode  = (VDDIO_Q===1) && (VDDIO===1)  && (VSSD===0)    && (VCCHIB===1);
wire  pwr_good_active_mode    = (VDDIO_Q===1) && (VDDIO===1)  && (VSSD===0)    && (VCCD===1);
wire  pwr_good_hold_mode      = (VDDIO_Q===1) && (VDDIO===1)  && (VSSD===0);
wire  pwr_good_inpbuff_lv     = (VDDIO_Q===1) && (VCCHIB===1) && (VSSD===0)    && (VDDIO===1) && (VSSIO===0);
wire  pwr_good_inpbuff_hv     = (VDDIO_Q===1) && (VSSD===0)   && (VDDIO===1) && (VSSIO===0);
wire  pwr_good_output_driver  = (VDDIO===1)   && (VDDIO_Q===1)&& (VSSIO===0)   && (VSSD===0);
wire pad_tristate = oe_n_final === 1 || dm_final === 3'b000 || dm_final === 3'b001;
wire x_on_pad  =  !pwr_good_output_driver
     || (dm_final !== 3'b000 && dm_final !== 3'b001 && oe_n_final===1'bx)
     || (^dm_final[2:0] === 1'bx && oe_n_final===1'b0)
     || (slow_final===1'bx && dm_final !== 3'b000 && dm_final !== 3'b001 && oe_n_final===1'b0)
     || (vreg_en_final===1'bx && dm_final !== 3'b000 && dm_final !== 3'b001 && oe_n_final===1'b0)
     || ((VOUTREF!==1'b1 || REFLEAK_BIAS!==1'b1) && vreg_en_final===1'b1 && dm_final !== 3'b000 && dm_final !== 3'b001 && oe_n_final===1'b0 );
`ifdef SKY130_FD_IO_TOP_SIO_SLOW_BEHV
parameter SLOW_1_DELAY= 101;
parameter SLOW_0_DELAY= 42;
`else
parameter SLOW_1_DELAY= 0;
parameter SLOW_0_DELAY= 0;
`endif
integer slow_1_delay,slow_0_delay,slow_delay;
initial slow_1_delay = SLOW_1_DELAY;
initial slow_0_delay = SLOW_0_DELAY;
always @(*)
begin
    if (SLOW===1)
        slow_delay = slow_1_delay;
    else
        slow_delay = slow_0_delay;
end
bufif1 (pull1, strong0) #slow_delay  dm2 (PAD, out_final, x_on_pad===1 ? 1'bx : (pad_tristate===0 && dm_final===3'b010));
bufif1 (strong1, pull0)  #slow_delay dm3 (PAD, out_final, x_on_pad===1 ? 1'bx : (pad_tristate===0 && dm_final===3'b011));
bufif1 (highz1, strong0) #slow_delay dm4 (PAD, out_final, x_on_pad===1 ? 1'bx : (pad_tristate===0 && dm_final===3'b100));
bufif1 (strong1, highz0) #slow_delay dm5 (PAD, out_final, x_on_pad===1 ? 1'bx : (pad_tristate===0 && dm_final===3'b101));
bufif1 (strong1, strong0)#slow_delay dm6 (PAD, out_final, x_on_pad===1 ? 1'bx : (pad_tristate===0 && dm_final===3'b110));
bufif1 (pull1, pull0)   #slow_delay  dm7 (PAD, out_final, x_on_pad===1 ? 1'bx : (pad_tristate===0 && dm_final===3'b111));
tran pad_esd_1 (PAD,PAD_A_NOESD_H);
tran pad_esd_2 (PAD,PAD_A_ESD_0_H);
tran pad_esd_3 (PAD,PAD_A_ESD_1_H);
wire x_on_in  =  (pwr_good_inpbuff_hv===0)
     || (inp_dis_final===1'bx    && dm_final !== 3'b000)
     || (inp_dis_final===0 	     && ^dm_final[2:0] === 1'bx )
     || (vtrip_sel_final===1'bx  && inp_dis_final===0  && dm_final !== 3'b000)
     || (ibuf_sel_final===1'bx   && inp_dis_final===0  && dm_final !== 3'b000)
     || (VINREF!==1'b1  && inp_dis_final===0  && dm_final !== 3'b000 && ibuf_sel_final===1);
wire disable_inp_buff = (dm_final===3'b000 || inp_dis_final===1);
assign IN_H = x_on_in===1 ? 1'bx : (disable_inp_buff===1 ? 0 : (^PAD===1'bx ? 1'bx : PAD));
assign IN = pwr_good_inpbuff_lv===1 ? IN_H : 1'bx;
assign TIE_LO_ESD = VSSIO===1'b0 ? 1'b0 : 1'bx;
always @(*)
begin : LATCH_dm
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode || (ENABLE_H===1 && ^HLD_H_N===1'bx))
        dm_final 	<= 3'bxxx;
    else if (ENABLE_H===0)
        dm_final 	<= 3'b000;
    else if (HLD_H_N===1)
        dm_final 	<= (^DM[2:0]	=== 1'bx	|| !pwr_good_active_mode) ? 3'bxxx : DM;
end
always @(notifier_enable_h or notifier_dm)
begin
    disable LATCH_dm; dm_final <= 3'bxxx;
end
always @(*)
begin : LATCH_inp_dis
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode || (ENABLE_H===1 && ^HLD_H_N===1'bx))
        inp_dis_final 	<= 1'bx;
    else if (ENABLE_H===0)
        inp_dis_final 	<= 1'b0;
    else if (HLD_H_N===1)
        inp_dis_final 	<= (^INP_DIS === 1'bx	|| !pwr_good_active_mode) ? 1'bx : INP_DIS;
end
always @(notifier_enable_h or notifier_inp_dis)
begin
    disable LATCH_inp_dis; inp_dis_final <= 1'bx;
end
always @(*)
begin : LATCH_vtrip_sel
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode || (ENABLE_H===1 && ^HLD_H_N===1'bx))
        vtrip_sel_final 	<= 1'bx;
    else if (ENABLE_H===0)
        vtrip_sel_final 	<= 1'b0;
    else if (HLD_H_N===1)
        vtrip_sel_final 	<= (^VTRIP_SEL === 1'bx	|| !pwr_good_active_mode) ? 1'bx : VTRIP_SEL;
end
always @(notifier_enable_h or notifier_vtrip_sel)
begin
    disable LATCH_vtrip_sel; vtrip_sel_final <= 1'bx;
end
always @(*)
begin : LATCH_slow
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode || (ENABLE_H===1 && ^HLD_H_N===1'bx))
        slow_final 	<= 1'bx;
    else if (ENABLE_H===0)
        slow_final 	<= 1'b0;
    else if (HLD_H_N===1)
        slow_final 	<= (^SLOW === 1'bx	|| !pwr_good_active_mode) ? 1'bx : SLOW;
end
always @(notifier_enable_h or notifier_slow)
begin
    disable LATCH_slow; slow_final <= 1'bx;
end
always @(*)
begin : LATCH_hld_ovr
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode || (ENABLE_H===1 && ^HLD_H_N===1'bx))
        hld_ovr_final 	<= 1'bx;
    else if (ENABLE_H===0)
        hld_ovr_final 	<= 1'b0;
    else if (HLD_H_N===1)
        hld_ovr_final 	<= (^HLD_OVR === 1'bx	|| !pwr_good_active_mode) ? 1'bx : HLD_OVR;
end
always @(notifier_enable_h or notifier_hld_ovr)
begin
    disable LATCH_hld_ovr; hld_ovr_final <= 1'bx;
end
always @(*)
begin : LATCH_vreg_en
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode || (ENABLE_H===1 && ^HLD_H_N===1'bx))
        vreg_en_final 	<= 1'bx;
    else if (ENABLE_H===0)
        vreg_en_final 	<= 1'b0;
    else if (HLD_H_N===1)
        vreg_en_final 	<= (^VREG_EN === 1'bx	|| !pwr_good_active_mode) ? 1'bx : VREG_EN;
end
always @(notifier_enable_h or notifier_vreg_en)
begin
    disable LATCH_vreg_en; vreg_en_final <= 1'bx;
end
always @(*)
begin : LATCH_ibuf_sel
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode || (ENABLE_H===1 && ^HLD_H_N===1'bx))
        ibuf_sel_final 	<= 1'bx;
    else if (ENABLE_H===0)
        ibuf_sel_final 	<= 1'b0;
    else if (HLD_H_N===1)
        ibuf_sel_final 	<= (^IBUF_SEL === 1'bx	|| !pwr_good_active_mode) ? 1'bx : IBUF_SEL;
end
always @(notifier_enable_h or notifier_ibuf_sel)
begin
    disable LATCH_ibuf_sel; ibuf_sel_final <= 1'bx;
end
always @(*)
begin : LATCH_oe_n
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode || (ENABLE_H===1 && (^HLD_H_N===1'bx || (HLD_H_N===0 && hld_ovr_final===1'bx))))
        oe_n_final 	<= 1'bx;
    else if (ENABLE_H===0)
        oe_n_final 	<= 1'b0;
    else if (HLD_H_N===1 || hld_ovr_final===1)
        oe_n_final  	<= (^OE_N  === 1'bx  || !pwr_good_hold_ovr_mode) ? 1'bx   : OE_N;
end
always @(notifier_enable_h or notifier_oe_n)
begin
    disable LATCH_oe_n; oe_n_final <= 1'bx;
end
always @(*)
begin : LATCH_out
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode || (ENABLE_H===1 && (^HLD_H_N===1'bx || (HLD_H_N===0 && hld_ovr_final===1'bx))))
        out_final 	<= 1'bx;
    else if (ENABLE_H===0)
        out_final 	<= 1'b0;
    else if (HLD_H_N===1 || hld_ovr_final===1)
        out_final  	<= (^OUT  === 1'bx  || !pwr_good_hold_ovr_mode) ? 1'bx   : OUT;
end
always @(notifier_enable_h or notifier_out)
begin
    disable LATCH_out; out_final <= 1'bx;
end
reg dis_err_msgs;
initial
begin
    dis_err_msgs = 1'b1;
`ifdef SKY130_FD_IO_TOP_SIO_DIS_ERR_MSGS
`else
    #1;
    dis_err_msgs = 1'b0;
`endif
end
always @(*)
begin
    if (!dis_err_msgs)
    begin
        if (vreg_en_final===1 && (dm_final!==3'b011 && dm_final!==3'b110 && dm_final!==3'b101))
            $display(" ===INFO=== sky130_fd_io__top_sio :  In regulated output driver mode (vreg_en_final=1), dm_final should be either \011 / 101 / 110 (i.E.strong-pullup mode) inorder for regulated mode to be effective : DM (= %b) and VREG_EN (= %b): %m",dm_final,vreg_en_final,$stime);
    end
end
endmodule
`else  // FUNCTIONAL
/*
 * Copyright 2020 The SkyWater PDK Authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 * SPDX-License-Identifier: Apache-2.0
*/

module sky130_fd_io__top_sio (IN_H, PAD_A_NOESD_H, PAD, DM, HLD_H_N, INP_DIS, IN,
                              ENABLE_H, OE_N, SLOW, VTRIP_SEL, VINREF, VOUTREF, VREG_EN, IBUF_SEL,
                              REFLEAK_BIAS, PAD_A_ESD_0_H, TIE_LO_ESD, HLD_OVR, OUT,
                              PAD_A_ESD_1_H
                              ,VSSIO, VSSIO_Q, VSSD, VCCD, VDDIO, VCCHIB, VDDIO_Q
                             );
output IN_H;
inout PAD_A_NOESD_H;
inout PAD;
input [2:0] DM;
input HLD_H_N;
input INP_DIS;
output IN;
input ENABLE_H;
input OE_N;
input SLOW;
input VTRIP_SEL;
input VINREF;
input VOUTREF;
input VREG_EN;
input IBUF_SEL;
input REFLEAK_BIAS;
inout PAD_A_ESD_0_H;
output TIE_LO_ESD;
input HLD_OVR;
input OUT;
inout PAD_A_ESD_1_H;
inout VSSIO;
inout VSSIO_Q;
inout VSSD;
inout VCCD;
inout VDDIO;
inout VCCHIB;
inout VDDIO_Q;
reg [2:0] dm_final;
reg slow_final, vtrip_sel_final, inp_dis_final, out_final, oe_n_final, hld_ovr_final;
reg ibuf_sel_final, vreg_en_final;
wire notifier_dm, notifier_slow, notifier_oe_n, notifier_out, notifier_vtrip_sel, notifier_hld_ovr, notifier_inp_dis, notifier_vreg_en,notifier_ibuf_sel;
wire notifier_enable_h;
wire  pwr_good_hold_ovr_mode  = (VDDIO_Q===1) && (VDDIO===1)  && (VSSD===0)    && (VCCHIB===1);
wire  pwr_good_active_mode    = (VDDIO_Q===1) && (VDDIO===1)  && (VSSD===0)    && (VCCD===1);
wire  pwr_good_hold_mode      = (VDDIO_Q===1) && (VDDIO===1)  && (VSSD===0);
wire  pwr_good_inpbuff_lv     = (VDDIO_Q===1) && (VCCHIB===1) && (VSSD===0)    && (VDDIO===1) && (VSSIO===0);
wire  pwr_good_inpbuff_hv     = (VDDIO_Q===1) && (VSSD===0)   && (VDDIO===1) && (VSSIO===0);
wire  pwr_good_output_driver  = (VDDIO===1)   && (VDDIO_Q===1)&& (VSSIO===0)   && (VSSD===0);
wire pad_tristate = oe_n_final === 1 || dm_final === 3'b000 || dm_final === 3'b001;
wire x_on_pad  =  !pwr_good_output_driver
     || (dm_final !== 3'b000 && dm_final !== 3'b001 && oe_n_final===1'bx)
     || (^dm_final[2:0] === 1'bx && oe_n_final===1'b0)
     || (slow_final===1'bx && dm_final !== 3'b000 && dm_final !== 3'b001 && oe_n_final===1'b0)
     || (vreg_en_final===1'bx && dm_final !== 3'b000 && dm_final !== 3'b001 && oe_n_final===1'b0)
     || ((VOUTREF!==1'b1 || REFLEAK_BIAS!==1'b1) && vreg_en_final===1'b1 && dm_final !== 3'b000 && dm_final !== 3'b001 && oe_n_final===1'b0 );
`ifdef SKY130_FD_IO_TOP_SIO_SLOW_BEHV
parameter SLOW_1_DELAY= 101;
parameter SLOW_0_DELAY= 42;
`else
parameter SLOW_1_DELAY= 0;
parameter SLOW_0_DELAY= 0;
`endif
integer slow_1_delay,slow_0_delay,slow_delay;
initial slow_1_delay = SLOW_1_DELAY;
initial slow_0_delay = SLOW_0_DELAY;
always @(*)
begin
    if (SLOW===1)
        slow_delay = slow_1_delay;
    else
        slow_delay = slow_0_delay;
end
bufif1 (pull1, strong0) #slow_delay  dm2 (PAD, out_final, x_on_pad===1 ? 1'bx : (pad_tristate===0 && dm_final===3'b010));
bufif1 (strong1, pull0)  #slow_delay dm3 (PAD, out_final, x_on_pad===1 ? 1'bx : (pad_tristate===0 && dm_final===3'b011));
bufif1 (highz1, strong0) #slow_delay dm4 (PAD, out_final, x_on_pad===1 ? 1'bx : (pad_tristate===0 && dm_final===3'b100));
bufif1 (strong1, highz0) #slow_delay dm5 (PAD, out_final, x_on_pad===1 ? 1'bx : (pad_tristate===0 && dm_final===3'b101));
bufif1 (strong1, strong0)#slow_delay dm6 (PAD, out_final, x_on_pad===1 ? 1'bx : (pad_tristate===0 && dm_final===3'b110));
bufif1 (pull1, pull0)   #slow_delay  dm7 (PAD, out_final, x_on_pad===1 ? 1'bx : (pad_tristate===0 && dm_final===3'b111));
tran pad_esd_1 (PAD,PAD_A_NOESD_H);
tran pad_esd_2 (PAD,PAD_A_ESD_0_H);
tran pad_esd_3 (PAD,PAD_A_ESD_1_H);
wire x_on_in  =  (pwr_good_inpbuff_hv===0)
     || (inp_dis_final===1'bx    && dm_final !== 3'b000)
     || (inp_dis_final===0 	     && ^dm_final[2:0] === 1'bx )
     || (vtrip_sel_final===1'bx  && inp_dis_final===0  && dm_final !== 3'b000)
     || (ibuf_sel_final===1'bx   && inp_dis_final===0  && dm_final !== 3'b000)
     || (VINREF!==1'b1  && inp_dis_final===0  && dm_final !== 3'b000 && ibuf_sel_final===1);
wire disable_inp_buff = (dm_final===3'b000 || inp_dis_final===1);
assign IN_H = x_on_in===1 ? 1'bx : (disable_inp_buff===1 ? 0 : (^PAD===1'bx ? 1'bx : PAD));
assign IN = pwr_good_inpbuff_lv===1 ? IN_H : 1'bx;
assign TIE_LO_ESD = VSSIO===1'b0 ? 1'b0 : 1'bx;
always @(*)
begin : LATCH_dm
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode || (ENABLE_H===1 && ^HLD_H_N===1'bx))
        dm_final 	<= 3'bxxx;
    else if (ENABLE_H===0)
        dm_final 	<= 3'b000;
    else if (HLD_H_N===1)
        dm_final 	<= (^DM[2:0]	=== 1'bx	|| !pwr_good_active_mode) ? 3'bxxx : DM;
end
always @(notifier_enable_h or notifier_dm)
begin
    disable LATCH_dm; dm_final <= 3'bxxx;
end
always @(*)
begin : LATCH_inp_dis
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode || (ENABLE_H===1 && ^HLD_H_N===1'bx))
        inp_dis_final 	<= 1'bx;
    else if (ENABLE_H===0)
        inp_dis_final 	<= 1'b0;
    else if (HLD_H_N===1)
        inp_dis_final 	<= (^INP_DIS === 1'bx	|| !pwr_good_active_mode) ? 1'bx : INP_DIS;
end
always @(notifier_enable_h or notifier_inp_dis)
begin
    disable LATCH_inp_dis; inp_dis_final <= 1'bx;
end
always @(*)
begin : LATCH_vtrip_sel
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode || (ENABLE_H===1 && ^HLD_H_N===1'bx))
        vtrip_sel_final 	<= 1'bx;
    else if (ENABLE_H===0)
        vtrip_sel_final 	<= 1'b0;
    else if (HLD_H_N===1)
        vtrip_sel_final 	<= (^VTRIP_SEL === 1'bx	|| !pwr_good_active_mode) ? 1'bx : VTRIP_SEL;
end
always @(notifier_enable_h or notifier_vtrip_sel)
begin
    disable LATCH_vtrip_sel; vtrip_sel_final <= 1'bx;
end
always @(*)
begin : LATCH_slow
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode || (ENABLE_H===1 && ^HLD_H_N===1'bx))
        slow_final 	<= 1'bx;
    else if (ENABLE_H===0)
        slow_final 	<= 1'b0;
    else if (HLD_H_N===1)
        slow_final 	<= (^SLOW === 1'bx	|| !pwr_good_active_mode) ? 1'bx : SLOW;
end
always @(notifier_enable_h or notifier_slow)
begin
    disable LATCH_slow; slow_final <= 1'bx;
end
always @(*)
begin : LATCH_hld_ovr
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode || (ENABLE_H===1 && ^HLD_H_N===1'bx))
        hld_ovr_final 	<= 1'bx;
    else if (ENABLE_H===0)
        hld_ovr_final 	<= 1'b0;
    else if (HLD_H_N===1)
        hld_ovr_final 	<= (^HLD_OVR === 1'bx	|| !pwr_good_active_mode) ? 1'bx : HLD_OVR;
end
always @(notifier_enable_h or notifier_hld_ovr)
begin
    disable LATCH_hld_ovr; hld_ovr_final <= 1'bx;
end
always @(*)
begin : LATCH_vreg_en
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode || (ENABLE_H===1 && ^HLD_H_N===1'bx))
        vreg_en_final 	<= 1'bx;
    else if (ENABLE_H===0)
        vreg_en_final 	<= 1'b0;
    else if (HLD_H_N===1)
        vreg_en_final 	<= (^VREG_EN === 1'bx	|| !pwr_good_active_mode) ? 1'bx : VREG_EN;
end
always @(notifier_enable_h or notifier_vreg_en)
begin
    disable LATCH_vreg_en; vreg_en_final <= 1'bx;
end
always @(*)
begin : LATCH_ibuf_sel
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode || (ENABLE_H===1 && ^HLD_H_N===1'bx))
        ibuf_sel_final 	<= 1'bx;
    else if (ENABLE_H===0)
        ibuf_sel_final 	<= 1'b0;
    else if (HLD_H_N===1)
        ibuf_sel_final 	<= (^IBUF_SEL === 1'bx	|| !pwr_good_active_mode) ? 1'bx : IBUF_SEL;
end
always @(notifier_enable_h or notifier_ibuf_sel)
begin
    disable LATCH_ibuf_sel; ibuf_sel_final <= 1'bx;
end
always @(*)
begin : LATCH_oe_n
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode || (ENABLE_H===1 && (^HLD_H_N===1'bx || (HLD_H_N===0 && hld_ovr_final===1'bx))))
        oe_n_final 	<= 1'bx;
    else if (ENABLE_H===0)
        oe_n_final 	<= 1'b0;
    else if (HLD_H_N===1 || hld_ovr_final===1)
        oe_n_final  	<= (^OE_N  === 1'bx  || !pwr_good_hold_ovr_mode) ? 1'bx   : OE_N;
end
always @(notifier_enable_h or notifier_oe_n)
begin
    disable LATCH_oe_n; oe_n_final <= 1'bx;
end
always @(*)
begin : LATCH_out
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode || (ENABLE_H===1 && (^HLD_H_N===1'bx || (HLD_H_N===0 && hld_ovr_final===1'bx))))
        out_final 	<= 1'bx;
    else if (ENABLE_H===0)
        out_final 	<= 1'b0;
    else if (HLD_H_N===1 || hld_ovr_final===1)
        out_final  	<= (^OUT  === 1'bx  || !pwr_good_hold_ovr_mode) ? 1'bx   : OUT;
end
always @(notifier_enable_h or notifier_out)
begin
    disable LATCH_out; out_final <= 1'bx;
end
reg dis_err_msgs;
initial
begin
    dis_err_msgs = 1'b1;
`ifdef SKY130_FD_IO_TOP_SIO_DIS_ERR_MSGS
`else
    #1;
    dis_err_msgs = 1'b0;
`endif
end
always @(*)
begin
    if (!dis_err_msgs)
    begin
        if (vreg_en_final===1 && (dm_final!==3'b011 && dm_final!==3'b110 && dm_final!==3'b101))
            $display(" ===INFO=== sky130_fd_io__top_sio :  In regulated output driver mode (vreg_en_final=1), dm_final should be either \011 / 101 / 110 (i.E.strong-pullup mode) inorder for regulated mode to be effective : DM (= %b) and VREG_EN (= %b): %m",dm_final,vreg_en_final,$stime);
    end
end
endmodule
`endif // FUNCTIONAL

`else  // USE_POWER_PINS

`ifdef FUNCTIONAL
/*
 * Copyright 2020 The SkyWater PDK Authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 * SPDX-License-Identifier: Apache-2.0
*/

module sky130_fd_io__top_sio (IN_H, PAD_A_NOESD_H, PAD, DM, HLD_H_N, INP_DIS, IN,
                              ENABLE_H, OE_N, SLOW, VTRIP_SEL, VINREF, VOUTREF, VREG_EN, IBUF_SEL,
                              REFLEAK_BIAS, PAD_A_ESD_0_H, TIE_LO_ESD, HLD_OVR, OUT,
                              PAD_A_ESD_1_H
                             );
output IN_H;
inout PAD_A_NOESD_H;
inout PAD;
input [2:0] DM;
input HLD_H_N;
input INP_DIS;
output IN;
input ENABLE_H;
input OE_N;
input SLOW;
input VTRIP_SEL;
input VINREF;
input VOUTREF;
input VREG_EN;
input IBUF_SEL;
input REFLEAK_BIAS;
inout PAD_A_ESD_0_H;
output TIE_LO_ESD;
input HLD_OVR;
input OUT;
inout PAD_A_ESD_1_H;
supply0 vssio;
supply0 vssio_q;
supply0 vssd;
supply1 vccd;
supply1 vddio;
supply1 vcchib;
supply1 vddio_q;
reg [2:0] dm_final;
reg slow_final, vtrip_sel_final, inp_dis_final, out_final, oe_n_final, hld_ovr_final;
reg ibuf_sel_final, vreg_en_final;
wire notifier_dm, notifier_slow, notifier_oe_n, notifier_out, notifier_vtrip_sel, notifier_hld_ovr, notifier_inp_dis, notifier_vreg_en,notifier_ibuf_sel;
wire notifier_enable_h;
wire  pwr_good_inpbuff_hv      	= 1;
wire  pwr_good_inpbuff_lv      	= 1;
wire  pwr_good_output_driver  	= 1;
wire  pwr_good_hold_mode	= 1;
wire  pwr_good_hold_ovr_mode	= 1;
wire  pwr_good_active_mode      = 1;
wire pad_tristate = oe_n_final === 1 || dm_final === 3'b000 || dm_final === 3'b001;
wire x_on_pad  =  !pwr_good_output_driver
     || (dm_final !== 3'b000 && dm_final !== 3'b001 && oe_n_final===1'bx)
     || (^dm_final[2:0] === 1'bx && oe_n_final===1'b0)
     || (slow_final===1'bx && dm_final !== 3'b000 && dm_final !== 3'b001 && oe_n_final===1'b0)
     || (vreg_en_final===1'bx && dm_final !== 3'b000 && dm_final !== 3'b001 && oe_n_final===1'b0)
     || ((VOUTREF!==1'b1 || REFLEAK_BIAS!==1'b1) && vreg_en_final===1'b1 && dm_final !== 3'b000 && dm_final !== 3'b001 && oe_n_final===1'b0 );
`ifdef SKY130_FD_IO_TOP_SIO_SLOW_BEHV
parameter SLOW_1_DELAY= 101;
parameter SLOW_0_DELAY= 42;
`else
parameter SLOW_1_DELAY= 0;
parameter SLOW_0_DELAY= 0;
`endif
integer slow_1_delay,slow_0_delay,slow_delay;
initial slow_1_delay = SLOW_1_DELAY;
initial slow_0_delay = SLOW_0_DELAY;
always @(*)
begin
    if (SLOW===1)
        slow_delay = slow_1_delay;
    else
        slow_delay = slow_0_delay;
end
bufif1 (pull1, strong0) #slow_delay  dm2 (PAD, out_final, x_on_pad===1 ? 1'bx : (pad_tristate===0 && dm_final===3'b010));
bufif1 (strong1, pull0)  #slow_delay dm3 (PAD, out_final, x_on_pad===1 ? 1'bx : (pad_tristate===0 && dm_final===3'b011));
bufif1 (highz1, strong0) #slow_delay dm4 (PAD, out_final, x_on_pad===1 ? 1'bx : (pad_tristate===0 && dm_final===3'b100));
bufif1 (strong1, highz0) #slow_delay dm5 (PAD, out_final, x_on_pad===1 ? 1'bx : (pad_tristate===0 && dm_final===3'b101));
bufif1 (strong1, strong0)#slow_delay dm6 (PAD, out_final, x_on_pad===1 ? 1'bx : (pad_tristate===0 && dm_final===3'b110));
bufif1 (pull1, pull0)   #slow_delay  dm7 (PAD, out_final, x_on_pad===1 ? 1'bx : (pad_tristate===0 && dm_final===3'b111));
tran pad_esd_1 (PAD,PAD_A_NOESD_H);
tran pad_esd_2 (PAD,PAD_A_ESD_0_H);
tran pad_esd_3 (PAD,PAD_A_ESD_1_H);
wire x_on_in  =  (pwr_good_inpbuff_hv===0)
     || (inp_dis_final===1'bx    && dm_final !== 3'b000)
     || (inp_dis_final===0 	     && ^dm_final[2:0] === 1'bx )
     || (vtrip_sel_final===1'bx  && inp_dis_final===0  && dm_final !== 3'b000)
     || (ibuf_sel_final===1'bx   && inp_dis_final===0  && dm_final !== 3'b000)
     || (VINREF!==1'b1  && inp_dis_final===0  && dm_final !== 3'b000 && ibuf_sel_final===1);
wire disable_inp_buff = (dm_final===3'b000 || inp_dis_final===1);
assign IN_H = x_on_in===1 ? 1'bx : (disable_inp_buff===1 ? 0 : (^PAD===1'bx ? 1'bx : PAD));
assign IN = pwr_good_inpbuff_lv===1 ? IN_H : 1'bx;
assign TIE_LO_ESD = vssio===1'b0 ? 1'b0 : 1'bx;
always @(*)
begin : LATCH_dm
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode || (ENABLE_H===1 && ^HLD_H_N===1'bx))
        dm_final 	<= 3'bxxx;
    else if (ENABLE_H===0)
        dm_final 	<= 3'b000;
    else if (HLD_H_N===1)
        dm_final 	<= (^DM[2:0]	=== 1'bx	|| !pwr_good_active_mode) ? 3'bxxx : DM;
end
always @(notifier_enable_h or notifier_dm)
begin
    disable LATCH_dm; dm_final <= 3'bxxx;
end
always @(*)
begin : LATCH_inp_dis
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode || (ENABLE_H===1 && ^HLD_H_N===1'bx))
        inp_dis_final 	<= 1'bx;
    else if (ENABLE_H===0)
        inp_dis_final 	<= 1'b0;
    else if (HLD_H_N===1)
        inp_dis_final 	<= (^INP_DIS === 1'bx	|| !pwr_good_active_mode) ? 1'bx : INP_DIS;
end
always @(notifier_enable_h or notifier_inp_dis)
begin
    disable LATCH_inp_dis; inp_dis_final <= 1'bx;
end
always @(*)
begin : LATCH_vtrip_sel
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode || (ENABLE_H===1 && ^HLD_H_N===1'bx))
        vtrip_sel_final 	<= 1'bx;
    else if (ENABLE_H===0)
        vtrip_sel_final 	<= 1'b0;
    else if (HLD_H_N===1)
        vtrip_sel_final 	<= (^VTRIP_SEL === 1'bx	|| !pwr_good_active_mode) ? 1'bx : VTRIP_SEL;
end
always @(notifier_enable_h or notifier_vtrip_sel)
begin
    disable LATCH_vtrip_sel; vtrip_sel_final <= 1'bx;
end
always @(*)
begin : LATCH_slow
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode || (ENABLE_H===1 && ^HLD_H_N===1'bx))
        slow_final 	<= 1'bx;
    else if (ENABLE_H===0)
        slow_final 	<= 1'b0;
    else if (HLD_H_N===1)
        slow_final 	<= (^SLOW === 1'bx	|| !pwr_good_active_mode) ? 1'bx : SLOW;
end
always @(notifier_enable_h or notifier_slow)
begin
    disable LATCH_slow; slow_final <= 1'bx;
end
always @(*)
begin : LATCH_hld_ovr
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode || (ENABLE_H===1 && ^HLD_H_N===1'bx))
        hld_ovr_final 	<= 1'bx;
    else if (ENABLE_H===0)
        hld_ovr_final 	<= 1'b0;
    else if (HLD_H_N===1)
        hld_ovr_final 	<= (^HLD_OVR === 1'bx	|| !pwr_good_active_mode) ? 1'bx : HLD_OVR;
end
always @(notifier_enable_h or notifier_hld_ovr)
begin
    disable LATCH_hld_ovr; hld_ovr_final <= 1'bx;
end
always @(*)
begin : LATCH_vreg_en
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode || (ENABLE_H===1 && ^HLD_H_N===1'bx))
        vreg_en_final 	<= 1'bx;
    else if (ENABLE_H===0)
        vreg_en_final 	<= 1'b0;
    else if (HLD_H_N===1)
        vreg_en_final 	<= (^VREG_EN === 1'bx	|| !pwr_good_active_mode) ? 1'bx : VREG_EN;
end
always @(notifier_enable_h or notifier_vreg_en)
begin
    disable LATCH_vreg_en; vreg_en_final <= 1'bx;
end
always @(*)
begin : LATCH_ibuf_sel
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode || (ENABLE_H===1 && ^HLD_H_N===1'bx))
        ibuf_sel_final 	<= 1'bx;
    else if (ENABLE_H===0)
        ibuf_sel_final 	<= 1'b0;
    else if (HLD_H_N===1)
        ibuf_sel_final 	<= (^IBUF_SEL === 1'bx	|| !pwr_good_active_mode) ? 1'bx : IBUF_SEL;
end
always @(notifier_enable_h or notifier_ibuf_sel)
begin
    disable LATCH_ibuf_sel; ibuf_sel_final <= 1'bx;
end
always @(*)
begin : LATCH_oe_n
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode || (ENABLE_H===1 && (^HLD_H_N===1'bx || (HLD_H_N===0 && hld_ovr_final===1'bx))))
        oe_n_final 	<= 1'bx;
    else if (ENABLE_H===0)
        oe_n_final 	<= 1'b0;
    else if (HLD_H_N===1 || hld_ovr_final===1)
        oe_n_final  	<= (^OE_N  === 1'bx  || !pwr_good_hold_ovr_mode) ? 1'bx   : OE_N;
end
always @(notifier_enable_h or notifier_oe_n)
begin
    disable LATCH_oe_n; oe_n_final <= 1'bx;
end
always @(*)
begin : LATCH_out
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode || (ENABLE_H===1 && (^HLD_H_N===1'bx || (HLD_H_N===0 && hld_ovr_final===1'bx))))
        out_final 	<= 1'bx;
    else if (ENABLE_H===0)
        out_final 	<= 1'b0;
    else if (HLD_H_N===1 || hld_ovr_final===1)
        out_final  	<= (^OUT  === 1'bx  || !pwr_good_hold_ovr_mode) ? 1'bx   : OUT;
end
always @(notifier_enable_h or notifier_out)
begin
    disable LATCH_out; out_final <= 1'bx;
end
reg dis_err_msgs;
initial
begin
    dis_err_msgs = 1'b1;
`ifdef SKY130_FD_IO_TOP_SIO_DIS_ERR_MSGS
`else
    #1;
    dis_err_msgs = 1'b0;
`endif
end
always @(*)
begin
    if (!dis_err_msgs)
    begin
        if (vreg_en_final===1 && (dm_final!==3'b011 && dm_final!==3'b110 && dm_final!==3'b101))
            $display(" ===INFO=== sky130_fd_io__top_sio :  In regulated output driver mode (vreg_en_final=1), dm_final should be either \011 / 101 / 110 (i.E.strong-pullup mode) inorder for regulated mode to be effective : DM (= %b) and VREG_EN (= %b): %m",dm_final,vreg_en_final,$stime);
    end
end
endmodule
`else  // FUNCTIONAL
/*
 * Copyright 2020 The SkyWater PDK Authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 * SPDX-License-Identifier: Apache-2.0
*/

module sky130_fd_io__top_sio (IN_H, PAD_A_NOESD_H, PAD, DM, HLD_H_N, INP_DIS, IN,
                              ENABLE_H, OE_N, SLOW, VTRIP_SEL, VINREF, VOUTREF, VREG_EN, IBUF_SEL,
                              REFLEAK_BIAS, PAD_A_ESD_0_H, TIE_LO_ESD, HLD_OVR, OUT,
                              PAD_A_ESD_1_H
                             );
output IN_H;
inout PAD_A_NOESD_H;
inout PAD;
input [2:0] DM;
input HLD_H_N;
input INP_DIS;
output IN;
input ENABLE_H;
input OE_N;
input SLOW;
input VTRIP_SEL;
input VINREF;
input VOUTREF;
input VREG_EN;
input IBUF_SEL;
input REFLEAK_BIAS;
inout PAD_A_ESD_0_H;
output TIE_LO_ESD;
input HLD_OVR;
input OUT;
inout PAD_A_ESD_1_H;
supply0 vssio;
supply0 vssio_q;
supply0 vssd;
supply1 vccd;
supply1 vddio;
supply1 vcchib;
supply1 vddio_q;
reg [2:0] dm_final;
reg slow_final, vtrip_sel_final, inp_dis_final, out_final, oe_n_final, hld_ovr_final;
reg ibuf_sel_final, vreg_en_final;
wire notifier_dm, notifier_slow, notifier_oe_n, notifier_out, notifier_vtrip_sel, notifier_hld_ovr, notifier_inp_dis, notifier_vreg_en,notifier_ibuf_sel;
wire notifier_enable_h;
wire  pwr_good_inpbuff_hv      	= 1;
wire  pwr_good_inpbuff_lv      	= 1;
wire  pwr_good_output_driver  	= 1;
wire  pwr_good_hold_mode	= 1;
wire  pwr_good_hold_ovr_mode	= 1;
wire  pwr_good_active_mode      = 1;
wire pad_tristate = oe_n_final === 1 || dm_final === 3'b000 || dm_final === 3'b001;
wire x_on_pad  =  !pwr_good_output_driver
     || (dm_final !== 3'b000 && dm_final !== 3'b001 && oe_n_final===1'bx)
     || (^dm_final[2:0] === 1'bx && oe_n_final===1'b0)
     || (slow_final===1'bx && dm_final !== 3'b000 && dm_final !== 3'b001 && oe_n_final===1'b0)
     || (vreg_en_final===1'bx && dm_final !== 3'b000 && dm_final !== 3'b001 && oe_n_final===1'b0)
     || ((VOUTREF!==1'b1 || REFLEAK_BIAS!==1'b1) && vreg_en_final===1'b1 && dm_final !== 3'b000 && dm_final !== 3'b001 && oe_n_final===1'b0 );
`ifdef SKY130_FD_IO_TOP_SIO_SLOW_BEHV
parameter SLOW_1_DELAY= 101;
parameter SLOW_0_DELAY= 42;
`else
parameter SLOW_1_DELAY= 0;
parameter SLOW_0_DELAY= 0;
`endif
integer slow_1_delay,slow_0_delay,slow_delay;
initial slow_1_delay = SLOW_1_DELAY;
initial slow_0_delay = SLOW_0_DELAY;
always @(*)
begin
    if (SLOW===1)
        slow_delay = slow_1_delay;
    else
        slow_delay = slow_0_delay;
end
bufif1 (pull1, strong0) #slow_delay  dm2 (PAD, out_final, x_on_pad===1 ? 1'bx : (pad_tristate===0 && dm_final===3'b010));
bufif1 (strong1, pull0)  #slow_delay dm3 (PAD, out_final, x_on_pad===1 ? 1'bx : (pad_tristate===0 && dm_final===3'b011));
bufif1 (highz1, strong0) #slow_delay dm4 (PAD, out_final, x_on_pad===1 ? 1'bx : (pad_tristate===0 && dm_final===3'b100));
bufif1 (strong1, highz0) #slow_delay dm5 (PAD, out_final, x_on_pad===1 ? 1'bx : (pad_tristate===0 && dm_final===3'b101));
bufif1 (strong1, strong0)#slow_delay dm6 (PAD, out_final, x_on_pad===1 ? 1'bx : (pad_tristate===0 && dm_final===3'b110));
bufif1 (pull1, pull0)   #slow_delay  dm7 (PAD, out_final, x_on_pad===1 ? 1'bx : (pad_tristate===0 && dm_final===3'b111));
tran pad_esd_1 (PAD,PAD_A_NOESD_H);
tran pad_esd_2 (PAD,PAD_A_ESD_0_H);
tran pad_esd_3 (PAD,PAD_A_ESD_1_H);
wire x_on_in  =  (pwr_good_inpbuff_hv===0)
     || (inp_dis_final===1'bx    && dm_final !== 3'b000)
     || (inp_dis_final===0 	     && ^dm_final[2:0] === 1'bx )
     || (vtrip_sel_final===1'bx  && inp_dis_final===0  && dm_final !== 3'b000)
     || (ibuf_sel_final===1'bx   && inp_dis_final===0  && dm_final !== 3'b000)
     || (VINREF!==1'b1  && inp_dis_final===0  && dm_final !== 3'b000 && ibuf_sel_final===1);
wire disable_inp_buff = (dm_final===3'b000 || inp_dis_final===1);
assign IN_H = x_on_in===1 ? 1'bx : (disable_inp_buff===1 ? 0 : (^PAD===1'bx ? 1'bx : PAD));
assign IN = pwr_good_inpbuff_lv===1 ? IN_H : 1'bx;
assign TIE_LO_ESD = vssio===1'b0 ? 1'b0 : 1'bx;
always @(*)
begin : LATCH_dm
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode || (ENABLE_H===1 && ^HLD_H_N===1'bx))
        dm_final 	<= 3'bxxx;
    else if (ENABLE_H===0)
        dm_final 	<= 3'b000;
    else if (HLD_H_N===1)
        dm_final 	<= (^DM[2:0]	=== 1'bx	|| !pwr_good_active_mode) ? 3'bxxx : DM;
end
always @(notifier_enable_h or notifier_dm)
begin
    disable LATCH_dm; dm_final <= 3'bxxx;
end
always @(*)
begin : LATCH_inp_dis
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode || (ENABLE_H===1 && ^HLD_H_N===1'bx))
        inp_dis_final 	<= 1'bx;
    else if (ENABLE_H===0)
        inp_dis_final 	<= 1'b0;
    else if (HLD_H_N===1)
        inp_dis_final 	<= (^INP_DIS === 1'bx	|| !pwr_good_active_mode) ? 1'bx : INP_DIS;
end
always @(notifier_enable_h or notifier_inp_dis)
begin
    disable LATCH_inp_dis; inp_dis_final <= 1'bx;
end
always @(*)
begin : LATCH_vtrip_sel
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode || (ENABLE_H===1 && ^HLD_H_N===1'bx))
        vtrip_sel_final 	<= 1'bx;
    else if (ENABLE_H===0)
        vtrip_sel_final 	<= 1'b0;
    else if (HLD_H_N===1)
        vtrip_sel_final 	<= (^VTRIP_SEL === 1'bx	|| !pwr_good_active_mode) ? 1'bx : VTRIP_SEL;
end
always @(notifier_enable_h or notifier_vtrip_sel)
begin
    disable LATCH_vtrip_sel; vtrip_sel_final <= 1'bx;
end
always @(*)
begin : LATCH_slow
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode || (ENABLE_H===1 && ^HLD_H_N===1'bx))
        slow_final 	<= 1'bx;
    else if (ENABLE_H===0)
        slow_final 	<= 1'b0;
    else if (HLD_H_N===1)
        slow_final 	<= (^SLOW === 1'bx	|| !pwr_good_active_mode) ? 1'bx : SLOW;
end
always @(notifier_enable_h or notifier_slow)
begin
    disable LATCH_slow; slow_final <= 1'bx;
end
always @(*)
begin : LATCH_hld_ovr
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode || (ENABLE_H===1 && ^HLD_H_N===1'bx))
        hld_ovr_final 	<= 1'bx;
    else if (ENABLE_H===0)
        hld_ovr_final 	<= 1'b0;
    else if (HLD_H_N===1)
        hld_ovr_final 	<= (^HLD_OVR === 1'bx	|| !pwr_good_active_mode) ? 1'bx : HLD_OVR;
end
always @(notifier_enable_h or notifier_hld_ovr)
begin
    disable LATCH_hld_ovr; hld_ovr_final <= 1'bx;
end
always @(*)
begin : LATCH_vreg_en
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode || (ENABLE_H===1 && ^HLD_H_N===1'bx))
        vreg_en_final 	<= 1'bx;
    else if (ENABLE_H===0)
        vreg_en_final 	<= 1'b0;
    else if (HLD_H_N===1)
        vreg_en_final 	<= (^VREG_EN === 1'bx	|| !pwr_good_active_mode) ? 1'bx : VREG_EN;
end
always @(notifier_enable_h or notifier_vreg_en)
begin
    disable LATCH_vreg_en; vreg_en_final <= 1'bx;
end
always @(*)
begin : LATCH_ibuf_sel
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode || (ENABLE_H===1 && ^HLD_H_N===1'bx))
        ibuf_sel_final 	<= 1'bx;
    else if (ENABLE_H===0)
        ibuf_sel_final 	<= 1'b0;
    else if (HLD_H_N===1)
        ibuf_sel_final 	<= (^IBUF_SEL === 1'bx	|| !pwr_good_active_mode) ? 1'bx : IBUF_SEL;
end
always @(notifier_enable_h or notifier_ibuf_sel)
begin
    disable LATCH_ibuf_sel; ibuf_sel_final <= 1'bx;
end
always @(*)
begin : LATCH_oe_n
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode || (ENABLE_H===1 && (^HLD_H_N===1'bx || (HLD_H_N===0 && hld_ovr_final===1'bx))))
        oe_n_final 	<= 1'bx;
    else if (ENABLE_H===0)
        oe_n_final 	<= 1'b0;
    else if (HLD_H_N===1 || hld_ovr_final===1)
        oe_n_final  	<= (^OE_N  === 1'bx  || !pwr_good_hold_ovr_mode) ? 1'bx   : OE_N;
end
always @(notifier_enable_h or notifier_oe_n)
begin
    disable LATCH_oe_n; oe_n_final <= 1'bx;
end
always @(*)
begin : LATCH_out
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode || (ENABLE_H===1 && (^HLD_H_N===1'bx || (HLD_H_N===0 && hld_ovr_final===1'bx))))
        out_final 	<= 1'bx;
    else if (ENABLE_H===0)
        out_final 	<= 1'b0;
    else if (HLD_H_N===1 || hld_ovr_final===1)
        out_final  	<= (^OUT  === 1'bx  || !pwr_good_hold_ovr_mode) ? 1'bx   : OUT;
end
always @(notifier_enable_h or notifier_out)
begin
    disable LATCH_out; out_final <= 1'bx;
end
reg dis_err_msgs;
initial
begin
    dis_err_msgs = 1'b1;
`ifdef SKY130_FD_IO_TOP_SIO_DIS_ERR_MSGS
`else
    #1;
    dis_err_msgs = 1'b0;
`endif
end
always @(*)
begin
    if (!dis_err_msgs)
    begin
        if (vreg_en_final===1 && (dm_final!==3'b011 && dm_final!==3'b110 && dm_final!==3'b101))
            $display(" ===INFO=== sky130_fd_io__top_sio :  In regulated output driver mode (vreg_en_final=1), dm_final should be either \011 / 101 / 110 (i.E.strong-pullup mode) inorder for regulated mode to be effective : DM (= %b) and VREG_EN (= %b): %m",dm_final,vreg_en_final,$stime);
    end
end
endmodule
`endif // FUNCTIONAL

`endif // USE_POWER_PINS

`default_nettype wire
`endif  // SKY130_FD_IO__TOP_SIO_V


//--------EOF---------

/**
 * Copyright 2020 The SkyWater PDK Authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 * SPDX-License-Identifier: Apache-2.0
 */

`ifndef SKY130_FD_IO__TOP_SIO_MACRO_V
`define SKY130_FD_IO__TOP_SIO_MACRO_V

/**
 * top_sio_macro: sky130_fd_io__sio_macro consists of two SIO cells
 *                and a reference generator cell.
 *
 * Verilog top module.
 *
 * WARNING: This file is autogenerated, do not modify directly!
 */

`timescale 1ns / 1ps
`default_nettype none

`ifdef USE_POWER_PINS

`ifdef FUNCTIONAL
/*
 * Copyright 2020 The SkyWater PDK Authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 * SPDX-License-Identifier: Apache-2.0
*/

module sky130_fd_io__top_sio_macro (
           VCCD,
           VCCHIB,
           VDDA,
           VDDIO,
           VDDIO_Q,
           VSSD,
           VSSIO,
           VSSIO_Q,
           VSWITCH,
           VSSA,
           IN,
           IN_H,
           TIE_LO_ESD,
           AMUXBUS_A,
           AMUXBUS_B,
           PAD,
           PAD_A_ESD_0_H,
           PAD_A_ESD_1_H,
           PAD_A_NOESD_H,
           VINREF_DFT,
           VOUTREF_DFT,
           DFT_REFGEN,
           DM0,
           DM1,
           HLD_H_N,
           HLD_H_N_REFGEN,
           HLD_OVR,
           IBUF_SEL,
           IBUF_SEL_REFGEN,
           INP_DIS,
           ENABLE_H,
           ENABLE_VDDA_H,
           OE_N,
           OUT,
           SLOW,
           VOH_SEL,
           VOHREF,
           VREF_SEL,
           VREG_EN,
           VREG_EN_REFGEN,
           VTRIP_SEL,
           VTRIP_SEL_REFGEN
       );
wire VOUTREF;
wire VINREF;
wire REFLEAK_BIAS;
inout VCCD;
inout VCCHIB;
inout VDDA;
inout VDDIO;
inout VDDIO_Q;
inout VSSD;
inout VSSIO;
inout VSSIO_Q;
inout VSWITCH;
inout VSSA;
inout AMUXBUS_A;
inout AMUXBUS_B;
inout VINREF_DFT;
inout VOUTREF_DFT;
input DFT_REFGEN;
input HLD_H_N_REFGEN;
input IBUF_SEL_REFGEN;
input ENABLE_VDDA_H;
input ENABLE_H;
input VOHREF;
input VREG_EN_REFGEN;
input VTRIP_SEL_REFGEN;
output [1:0]  TIE_LO_ESD;
output [1:0]  IN_H;
output [1:0]  IN;
inout [1:0]  PAD_A_NOESD_H;
inout [1:0]  PAD;
inout [1:0]  PAD_A_ESD_1_H;
inout [1:0]  PAD_A_ESD_0_H;
input [1:0]  SLOW;
input [1:0]  VTRIP_SEL;
input [1:0]  HLD_H_N;
input [1:0]  VREG_EN;
input [2:0]  VOH_SEL;
input [1:0]  INP_DIS;
input [1:0]  HLD_OVR;
input [1:0]  OE_N;
input [1:0]  VREF_SEL;
input [1:0]  IBUF_SEL;
input [2:0]  DM0;
input [2:0]  DM1;
input [1:0]  OUT;
reg 	notifier_enable_h_refgen,
     notifier_vtrip_sel_refgen,
     notifier_vreg_en_refgen,
     notifier_ibuf_sel_refgen,
     notifier_vref_sel,
     notifier_vref_sel_int,
     notifier_voh_sel,
     notifier_dft_refgen;
reg	 notifier_enable_h_0;
reg	 notifier_hld_ovr_0;
reg	 notifier_dm_0;
reg	 notifier_inp_dis_0;
reg	 notifier_vtrip_sel_0;
reg	 notifier_slow_0;
reg	 notifier_oe_n_0;
reg	 notifier_out_0;
reg	 notifier_vreg_en_0;
reg	 notifier_ibuf_sel_0;
reg	 notifier_enable_h_1;
reg	 notifier_hld_ovr_1;
reg	 notifier_dm_1;
reg	 notifier_inp_dis_1;
reg	 notifier_vtrip_sel_1;
reg	 notifier_slow_1;
reg	 notifier_oe_n_1;
reg	 notifier_out_1;
reg	 notifier_vreg_en_1;
reg	 notifier_ibuf_sel_1;
wire enable_vdda_h_and_enable_h = ENABLE_VDDA_H==1'b1 && ENABLE_H==1'b1;
sky130_fd_io__top_refgen_new REFGEN (
                                 .VSWITCH                                      (VSWITCH),
                                 .VSSIO_Q                                      (VSSIO_Q),
                                 .VDDIO_Q                                      (VDDIO_Q),
                                 .VSSIO                                        (VSSIO),
                                 .VSSD                                         (VSSD),
                                 .VCCHIB                                       (VCCHIB),
                                 .VDDIO                                        (VDDIO),
                                 .VCCD                                         (VCCD),
                                 .VDDA                                         (VDDA),
                                 .VSSA					  (VSSA),
                                 .VOH_SEL                                      (VOH_SEL[2:0]),
                                 .VREF_SEL                                     (VREF_SEL[1:0]),
                                 .VOHREF                                       (VOHREF),
                                 .VINREF_DFT                                   (VINREF_DFT),
                                 .VOUTREF_DFT                                  (VOUTREF_DFT),
                                 .DFT_REFGEN                                   (DFT_REFGEN),
                                 .AMUXBUS_A                                    (AMUXBUS_A),
                                 .AMUXBUS_B                                    (AMUXBUS_B),
                                 .VOUTREF                                      (VOUTREF),
                                 .VREG_EN                                      (VREG_EN_REFGEN),
                                 .IBUF_SEL                                     (IBUF_SEL_REFGEN),
                                 .VINREF                                       (VINREF),
                                 .VTRIP_SEL                                    (VTRIP_SEL_REFGEN),
                                 .ENABLE_H					  (ENABLE_H),
                                 .ENABLE_VDDA_H				  (ENABLE_VDDA_H),
                                 .HLD_H_N                                      (HLD_H_N_REFGEN),
                                 .REFLEAK_BIAS                                 (REFLEAK_BIAS)
                             );
sky130_fd_io__top_sio SIO_PAIR_1_ (
                          .VDDIO                                        (VDDIO),
                          .VCCD                                         (VCCD),
                          .VDDIO_Q                                      (VDDIO_Q),
                          .VCCHIB                                       (VCCHIB),
                          .VSSIO                                        (VSSIO),
                          .VSSIO_Q                                      (VSSIO_Q),
                          .VSSD                                         (VSSD),
                          .PAD                                          (PAD[1]),
                          .IN_H                                         (IN_H[1]),
                          .DM                                           (DM1[2:0]),
                          .HLD_H_N                                      (HLD_H_N[1]),
                          .PAD_A_ESD_1_H                                (PAD_A_ESD_1_H[1]),
                          .PAD_A_ESD_0_H                                (PAD_A_ESD_0_H[1]),
                          .ENABLE_H                                     (ENABLE_H),
                          .OUT                                          (OUT[1]),
                          .OE_N                                         (OE_N[1]),
                          .SLOW                                         (SLOW[1]),
                          .VTRIP_SEL                                    (VTRIP_SEL[1]),
                          .INP_DIS                                      (INP_DIS[1]),
                          .TIE_LO_ESD                                   (TIE_LO_ESD[1]),
                          .IN                                           (IN[1]),
                          .VINREF                                       (VINREF),
                          .VOUTREF                                      (VOUTREF),
                          .REFLEAK_BIAS                                 (REFLEAK_BIAS),
                          .PAD_A_NOESD_H                                (PAD_A_NOESD_H[1]),
                          .VREG_EN                                      (VREG_EN[1]),
                          .IBUF_SEL                                     (IBUF_SEL[1]),
                          .HLD_OVR                                      (HLD_OVR[1])
                      );
sky130_fd_io__top_sio SIO_PAIR_0_ (
                          .VDDIO                                        (VDDIO),
                          .VCCD                                         (VCCD),
                          .VDDIO_Q                                      (VDDIO_Q),
                          .VCCHIB                                       (VCCHIB),
                          .VSSIO                                        (VSSIO),
                          .VSSIO_Q                                      (VSSIO_Q),
                          .VSSD                                         (VSSD),
                          .PAD                                          (PAD[0]),
                          .IN_H                                         (IN_H[0]),
                          .DM                                           (DM0[2:0]),
                          .HLD_H_N                                      (HLD_H_N[0]),
                          .PAD_A_ESD_1_H                                (PAD_A_ESD_1_H[0]),
                          .PAD_A_ESD_0_H                                (PAD_A_ESD_0_H[0]),
                          .ENABLE_H                                     (ENABLE_H),
                          .OUT                                          (OUT[0]),
                          .OE_N                                         (OE_N[0]),
                          .SLOW                                         (SLOW[0]),
                          .VTRIP_SEL                                    (VTRIP_SEL[0]),
                          .INP_DIS                                      (INP_DIS[0]),
                          .TIE_LO_ESD                                   (TIE_LO_ESD[0]),
                          .IN                                           (IN[0]),
                          .VINREF                                       (VINREF),
                          .VOUTREF                                      (VOUTREF),
                          .REFLEAK_BIAS                                 (REFLEAK_BIAS),
                          .PAD_A_NOESD_H                                (PAD_A_NOESD_H[0]),
                          .VREG_EN                                      (VREG_EN[0]),
                          .IBUF_SEL                                     (IBUF_SEL[0]),
                          .HLD_OVR                                      (HLD_OVR[0])
                      );
endmodule
`else  // FUNCTIONAL
/*
 * Copyright 2020 The SkyWater PDK Authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 * SPDX-License-Identifier: Apache-2.0
*/

module sky130_fd_io__top_sio_macro (
           VCCD,
           VCCHIB,
           VDDA,
           VDDIO,
           VDDIO_Q,
           VSSD,
           VSSIO,
           VSSIO_Q,
           VSWITCH,
           VSSA,
           IN,
           IN_H,
           TIE_LO_ESD,
           AMUXBUS_A,
           AMUXBUS_B,
           PAD,
           PAD_A_ESD_0_H,
           PAD_A_ESD_1_H,
           PAD_A_NOESD_H,
           VINREF_DFT,
           VOUTREF_DFT,
           DFT_REFGEN,
           DM0,
           DM1,
           HLD_H_N,
           HLD_H_N_REFGEN,
           HLD_OVR,
           IBUF_SEL,
           IBUF_SEL_REFGEN,
           INP_DIS,
           ENABLE_H,
           ENABLE_VDDA_H,
           OE_N,
           OUT,
           SLOW,
           VOH_SEL,
           VOHREF,
           VREF_SEL,
           VREG_EN,
           VREG_EN_REFGEN,
           VTRIP_SEL,
           VTRIP_SEL_REFGEN
       );
wire VOUTREF;
wire VINREF;
wire REFLEAK_BIAS;
inout VCCD;
inout VCCHIB;
inout VDDA;
inout VDDIO;
inout VDDIO_Q;
inout VSSD;
inout VSSIO;
inout VSSIO_Q;
inout VSWITCH;
inout VSSA;
inout AMUXBUS_A;
inout AMUXBUS_B;
inout VINREF_DFT;
inout VOUTREF_DFT;
input DFT_REFGEN;
input HLD_H_N_REFGEN;
input IBUF_SEL_REFGEN;
input ENABLE_VDDA_H;
input ENABLE_H;
input VOHREF;
input VREG_EN_REFGEN;
input VTRIP_SEL_REFGEN;
output [1:0]  TIE_LO_ESD;
output [1:0]  IN_H;
output [1:0]  IN;
inout [1:0]  PAD_A_NOESD_H;
inout [1:0]  PAD;
inout [1:0]  PAD_A_ESD_1_H;
inout [1:0]  PAD_A_ESD_0_H;
input [1:0]  SLOW;
input [1:0]  VTRIP_SEL;
input [1:0]  HLD_H_N;
input [1:0]  VREG_EN;
input [2:0]  VOH_SEL;
input [1:0]  INP_DIS;
input [1:0]  HLD_OVR;
input [1:0]  OE_N;
input [1:0]  VREF_SEL;
input [1:0]  IBUF_SEL;
input [2:0]  DM0;
input [2:0]  DM1;
input [1:0]  OUT;
reg 	notifier_enable_h_refgen,
     notifier_vtrip_sel_refgen,
     notifier_vreg_en_refgen,
     notifier_ibuf_sel_refgen,
     notifier_vref_sel,
     notifier_vref_sel_int,
     notifier_voh_sel,
     notifier_dft_refgen;
reg	 notifier_enable_h_0;
reg	 notifier_hld_ovr_0;
reg	 notifier_dm_0;
reg	 notifier_inp_dis_0;
reg	 notifier_vtrip_sel_0;
reg	 notifier_slow_0;
reg	 notifier_oe_n_0;
reg	 notifier_out_0;
reg	 notifier_vreg_en_0;
reg	 notifier_ibuf_sel_0;
reg	 notifier_enable_h_1;
reg	 notifier_hld_ovr_1;
reg	 notifier_dm_1;
reg	 notifier_inp_dis_1;
reg	 notifier_vtrip_sel_1;
reg	 notifier_slow_1;
reg	 notifier_oe_n_1;
reg	 notifier_out_1;
reg	 notifier_vreg_en_1;
reg	 notifier_ibuf_sel_1;
wire enable_vdda_h_and_enable_h = ENABLE_VDDA_H==1'b1 && ENABLE_H==1'b1;
specify
    if ( VTRIP_SEL[1]==1'b1)  ( INP_DIS[1]    => IN[1] )      =  (3.422:0:3.422 , 2.337:0:2.337);
    if ( VTRIP_SEL[1]==1'b1)  ( INP_DIS[1]    => IN_H[1] )    =  (3.271:0:3.271 , 2.210:0:2.210);
    if ( VTRIP_SEL[1]==1'b1)  ( PAD[1]        => IN[1] )      =  (0.798:0:0.798 , 0.959:0:0.959);
    if ( VTRIP_SEL[1]==1'b1)  ( PAD[1]        => IN_H[1] )    =  (0.931:0:0.931 , 0.935:0:0.935);
    if ( VTRIP_SEL[0]==1'b1)  ( INP_DIS[0]    => IN[0]  )     =  (3.422:0:3.422 , 2.337:0:2.337);
    if ( VTRIP_SEL[0]==1'b1)  ( INP_DIS[0]    => IN_H[0] )    =  (3.271:0:3.271 , 2.210:0:2.210);
    if ( VTRIP_SEL[0]==1'b1)  ( PAD[0]        => IN[0] )      =  (0.798:0:0.798 , 0.959:0:0.959);
    if ( VTRIP_SEL[0]==1'b1)  ( PAD[0]        => IN_H[0] )    =  (0.931:0:0.931 , 0.935:0:0.935);
    if ( VTRIP_SEL[1]==1'b0)  ( INP_DIS[1]    => IN[1] )      =  (3.422:0:3.422 , 2.337:0:2.337);
    if ( VTRIP_SEL[1]==1'b0)  ( INP_DIS[1]    => IN_H[1] )    =  (3.271:0:3.271 , 2.209:0:2.209);
    if ( VTRIP_SEL[1]==1'b0)  ( PAD[1]        => IN[1] )      =  (0.816:0:0.816 , 0.866:0:0.866);
    if ( VTRIP_SEL[1]==1'b0)  ( PAD[1]        => IN_H[1] )    =  (0.950:0:0.950 , 0.841:0:0.841);
    if ( VTRIP_SEL[0]==1'b0)  ( INP_DIS[0]    => IN[0] )      =  (3.422:0:3.422 , 2.337:0:2.337);
    if ( VTRIP_SEL[0]==1'b0)  ( INP_DIS[0]    => IN_H[0] )    =  (3.271:0:3.271 , 2.209:0:2.209);
    if ( VTRIP_SEL[0]==1'b0)  ( PAD[0]        => IN[0] )      =  (0.816:0:0.816 , 0.866:0:0.866);
    if ( VTRIP_SEL[0]==1'b0)  ( PAD[0]        => IN_H[0] )    =  (0.950:0:0.950 , 0.841:0:0.841);
    if ( DM0[2] == 1'b0 & DM0[1] == 1'b1 & DM0[0] == 1'b0 & SLOW[0] == 1'b0 ) 				( OE_N[0]	=> PAD[0] ) 	=  (0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0);
    if ( DM0[2] == 1'b0 & DM0[1] == 1'b1 & DM0[0] == 1'b0 & SLOW[0] == 1'b1 ) 				( OE_N[0]	=> PAD[0] ) 	=  (0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0);
    if ( DM0[2] == 1'b0 & DM0[1] == 1'b1 & DM0[0] == 1'b1 & SLOW[0] == 1'b0 ) 				( OE_N[0]	=> PAD[0] ) 	=  (0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0);
    if ( DM0[2] == 1'b0 & DM0[1] == 1'b1 & DM0[0] == 1'b1 & SLOW[0] == 1'b1 ) 				( OE_N[0]	=> PAD[0] ) 	=  (0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0);
    if ( DM0[2] == 1'b1 & DM0[1] == 1'b0 & DM0[0] == 1'b0 & SLOW[0] == 1'b0 ) 				( OE_N[0]	=> PAD[0] ) 	=  (0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0);
    if ( DM0[2] == 1'b1 & DM0[1] == 1'b0 & DM0[0] == 1'b0 & SLOW[0] == 1'b1 ) 				( OE_N[0]	=> PAD[0] ) 	=  (0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0);
    if ( DM0[2] == 1'b1 & DM0[1] == 1'b0 & DM0[0] == 1'b1 & SLOW[0] == 1'b0 ) 				( OE_N[0]	=> PAD[0] ) 	=  (0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0);
    if ( DM0[2] == 1'b1 & DM0[1] == 1'b0 & DM0[0] == 1'b1 & SLOW[0] == 1'b1 ) 				( OE_N[0]	=> PAD[0] ) 	=  (0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0);
    if ( DM0[2] == 1'b1 & DM0[1] == 1'b1 & DM0[0] == 1'b0 & SLOW[0] == 1'b0 ) 				( OE_N[0]	=> PAD[0] ) 	=  (0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0);
    if ( DM0[2] == 1'b1 & DM0[1] == 1'b1 & DM0[0] == 1'b0 & SLOW[0] == 1'b1 ) 				( OE_N[0]	=> PAD[0] ) 	=  (0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0);
    if ( DM0[2] == 1'b1 & DM0[1] == 1'b1 & DM0[0] == 1'b1 & SLOW[0] == 1'b0 ) 				( OE_N[0]	=> PAD[0] ) 	=  (0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0);
    if ( DM0[2] == 1'b1 & DM0[1] == 1'b1 & DM0[0] == 1'b1 & SLOW[0] == 1'b1 ) 				( OE_N[0]	=> PAD[0] ) 	=  (0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0);
    if ( DM0[2] == 1'b0 & DM0[1] == 1'b1 & DM0[0] == 1'b0 & SLOW[0] == 1'b0 & OE_N[0] == 1'b0 ) 	( OUT[0]	=> PAD[0] ) 	=  (0:0:0, 0:0:0);
    if ( DM0[2] == 1'b0 & DM0[1] == 1'b1 & DM0[0] == 1'b0 & SLOW[0] == 1'b1 & OE_N[0] == 1'b0 ) 	( OUT[0]	=> PAD[0] ) 	=  (0:0:0, 0:0:0);
    if ( DM0[2] == 1'b0 & DM0[1] == 1'b1 & DM0[0] == 1'b1 & SLOW[0] == 1'b0 & OE_N[0] == 1'b0 ) 	( OUT[0]	=> PAD[0] ) 	=  (0:0:0, 0:0:0);
    if ( DM0[2] == 1'b0 & DM0[1] == 1'b1 & DM0[0] == 1'b1 & SLOW[0] == 1'b1 & OE_N[0] == 1'b0 ) 	( OUT[0]	=> PAD[0] ) 	=  (0:0:0, 0:0:0);
    if ( DM0[2] == 1'b1 & DM0[1] == 1'b0 & DM0[0] == 1'b0 & SLOW[0] == 1'b0 & OE_N[0] == 1'b0 ) 	( OUT[0]	=> PAD[0] ) 	=  (0:0:0, 0:0:0);
    if ( DM0[2] == 1'b1 & DM0[1] == 1'b0 & DM0[0] == 1'b0 & SLOW[0] == 1'b1 & OE_N[0] == 1'b0 ) 	( OUT[0]	=> PAD[0] ) 	=  (0:0:0, 0:0:0);
    if ( DM0[2] == 1'b1 & DM0[1] == 1'b0 & DM0[0] == 1'b1 & SLOW[0] == 1'b0 & OE_N[0] == 1'b0 ) 	( OUT[0]	=> PAD[0] ) 	=  (0:0:0, 0:0:0);
    if ( DM0[2] == 1'b1 & DM0[1] == 1'b0 & DM0[0] == 1'b1 & SLOW[0] == 1'b1 & OE_N[0] == 1'b0 ) 	( OUT[0]	=> PAD[0] ) 	=  (0:0:0, 0:0:0);
    if ( DM0[2] == 1'b1 & DM0[1] == 1'b1 & DM0[0] == 1'b0 & SLOW[0] == 1'b0 & OE_N[0] == 1'b0 ) 	( OUT[0]	=> PAD[0] ) 	=  (0:0:0, 0:0:0);
    if ( DM0[2] == 1'b1 & DM0[1] == 1'b1 & DM0[0] == 1'b0 & SLOW[0] == 1'b1 & OE_N[0] == 1'b0 ) 	( OUT[0]	=> PAD[0] ) 	=  (0:0:0, 0:0:0);
    if ( DM0[2] == 1'b1 & DM0[1] == 1'b1 & DM0[0] == 1'b1 & SLOW[0] == 1'b0 & OE_N[0] == 1'b0 ) 	( OUT[0]	=> PAD[0] ) 	=  (0:0:0, 0:0:0);
    if ( DM0[2] == 1'b1 & DM0[1] == 1'b1 & DM0[0] == 1'b1 & SLOW[0] == 1'b1 & OE_N[0] == 1'b0 ) 	( OUT[0]	=> PAD[0] ) 	=  (0:0:0, 0:0:0);
    if ( DM1[2] == 1'b0 & DM1[1] == 1'b1 & DM1[0] == 1'b0 & SLOW[1] == 1'b0 ) 				( OE_N[1]	=> PAD[1] ) 	=  (0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0);
    if ( DM1[2] == 1'b0 & DM1[1] == 1'b1 & DM1[0] == 1'b0 & SLOW[1] == 1'b1 ) 				( OE_N[1]	=> PAD[1] ) 	=  (0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0);
    if ( DM1[2] == 1'b0 & DM1[1] == 1'b1 & DM1[0] == 1'b1 & SLOW[1] == 1'b0 ) 				( OE_N[1]	=> PAD[1] ) 	=  (0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0);
    if ( DM1[2] == 1'b0 & DM1[1] == 1'b1 & DM1[0] == 1'b1 & SLOW[1] == 1'b1 ) 				( OE_N[1]	=> PAD[1] ) 	=  (0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0);
    if ( DM1[2] == 1'b1 & DM1[1] == 1'b0 & DM1[0] == 1'b0 & SLOW[1] == 1'b0 ) 				( OE_N[1]	=> PAD[1] ) 	=  (0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0);
    if ( DM1[2] == 1'b1 & DM1[1] == 1'b0 & DM1[0] == 1'b0 & SLOW[1] == 1'b1 ) 				( OE_N[1]	=> PAD[1] ) 	=  (0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0);
    if ( DM1[2] == 1'b1 & DM1[1] == 1'b0 & DM1[0] == 1'b1 & SLOW[1] == 1'b0 ) 				( OE_N[1]	=> PAD[1] ) 	=  (0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0);
    if ( DM1[2] == 1'b1 & DM1[1] == 1'b0 & DM1[0] == 1'b1 & SLOW[1] == 1'b1 ) 				( OE_N[1]	=> PAD[1] ) 	=  (0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0);
    if ( DM1[2] == 1'b1 & DM1[1] == 1'b1 & DM1[0] == 1'b0 & SLOW[1] == 1'b0 ) 				( OE_N[1]	=> PAD[1] ) 	=  (0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0);
    if ( DM1[2] == 1'b1 & DM1[1] == 1'b1 & DM1[0] == 1'b0 & SLOW[1] == 1'b1 ) 				( OE_N[1]	=> PAD[1] ) 	=  (0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0);
    if ( DM1[2] == 1'b1 & DM1[1] == 1'b1 & DM1[0] == 1'b1 & SLOW[1] == 1'b0 ) 				( OE_N[1]	=> PAD[1] ) 	=  (0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0);
    if ( DM1[2] == 1'b1 & DM1[1] == 1'b1 & DM1[0] == 1'b1 & SLOW[1] == 1'b1 ) 				( OE_N[1]	=> PAD[1] ) 	=  (0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0);
    if ( DM1[2] == 1'b0 & DM1[1] == 1'b1 & DM1[0] == 1'b0 & SLOW[1] == 1'b0 & OE_N[1] == 1'b0 ) 	( OUT[1]	=> PAD[1] ) 	=  (0:0:0, 0:0:0);
    if ( DM1[2] == 1'b0 & DM1[1] == 1'b1 & DM1[0] == 1'b0 & SLOW[1] == 1'b1 & OE_N[1] == 1'b0 ) 	( OUT[1]	=> PAD[1] ) 	=  (0:0:0, 0:0:0);
    if ( DM1[2] == 1'b0 & DM1[1] == 1'b1 & DM1[0] == 1'b1 & SLOW[1] == 1'b0 & OE_N[1] == 1'b0 ) 	( OUT[1]	=> PAD[1] ) 	=  (0:0:0, 0:0:0);
    if ( DM1[2] == 1'b0 & DM1[1] == 1'b1 & DM1[0] == 1'b1 & SLOW[1] == 1'b1 & OE_N[1] == 1'b0 ) 	( OUT[1]	=> PAD[1] ) 	=  (0:0:0, 0:0:0);
    if ( DM1[2] == 1'b1 & DM1[1] == 1'b0 & DM1[0] == 1'b0 & SLOW[1] == 1'b0 & OE_N[1] == 1'b0 ) 	( OUT[1]	=> PAD[1] ) 	=  (0:0:0, 0:0:0);
    if ( DM1[2] == 1'b1 & DM1[1] == 1'b0 & DM1[0] == 1'b0 & SLOW[1] == 1'b1 & OE_N[1] == 1'b0 ) 	( OUT[1]	=> PAD[1] ) 	=  (0:0:0, 0:0:0);
    if ( DM1[2] == 1'b1 & DM1[1] == 1'b0 & DM1[0] == 1'b1 & SLOW[1] == 1'b0 & OE_N[1] == 1'b0 ) 	( OUT[1]	=> PAD[1] ) 	=  (0:0:0, 0:0:0);
    if ( DM1[2] == 1'b1 & DM1[1] == 1'b0 & DM1[0] == 1'b1 & SLOW[1] == 1'b1 & OE_N[1] == 1'b0 ) 	( OUT[1]	=> PAD[1] ) 	=  (0:0:0, 0:0:0);
    if ( DM1[2] == 1'b1 & DM1[1] == 1'b1 & DM1[0] == 1'b0 & SLOW[1] == 1'b0 & OE_N[1] == 1'b0 ) 	( OUT[1]	=> PAD[1] ) 	=  (0:0:0, 0:0:0);
    if ( DM1[2] == 1'b1 & DM1[1] == 1'b1 & DM1[0] == 1'b0 & SLOW[1] == 1'b1 & OE_N[1] == 1'b0 ) 	( OUT[1]	=> PAD[1] ) 	=  (0:0:0, 0:0:0);
    if ( DM1[2] == 1'b1 & DM1[1] == 1'b1 & DM1[0] == 1'b1 & SLOW[1] == 1'b0 & OE_N[1] == 1'b0 ) 	( OUT[1]	=> PAD[1] ) 	=  (0:0:0, 0:0:0);
    if ( DM1[2] == 1'b1 & DM1[1] == 1'b1 & DM1[0] == 1'b1 & SLOW[1] == 1'b1 & OE_N[1] == 1'b0 ) 	( OUT[1]	=> PAD[1] ) 	=  (0:0:0, 0:0:0);
    specparam t_setup=5;
    specparam t_hold=5;
    $width  (posedge HLD_H_N[1], 	(15.500:0:15.500));
    $width  (negedge HLD_H_N[1], 	(15.500:0:15.500));
    $width  (negedge HLD_H_N[0], 	(15.500:0:15.500));
    $width  (posedge HLD_H_N[0], 	(15.500:0:15.500));
    $width  (posedge HLD_H_N_REFGEN, 	(15.500:0:15.500));
    $width  (negedge HLD_H_N_REFGEN, 	(15.500:0:15.500));
    $width  (negedge HLD_OVR[1], 	(15.500:0:15.500));
    $width  (posedge HLD_OVR[1], 	(15.500:0:15.500));
    $width  (negedge HLD_OVR[0], 	(15.500:0:15.500));
    $width  (posedge HLD_OVR[0], 	(15.500:0:15.500));
    $setuphold (negedge ENABLE_H,    posedge HLD_H_N_REFGEN,	t_setup, t_hold,  notifier_enable_h_refgen);
    $setuphold (negedge ENABLE_H,    negedge HLD_H_N_REFGEN,	t_setup, t_hold,  notifier_enable_h_refgen);
    $setuphold (posedge ENABLE_H,    posedge HLD_H_N_REFGEN,	t_setup, t_hold,  notifier_enable_h_refgen);
    $setuphold (posedge ENABLE_H,    negedge HLD_H_N_REFGEN,	t_setup, t_hold,  notifier_enable_h_refgen);
    $setuphold (negedge HLD_H_N_REFGEN, posedge VTRIP_SEL_REFGEN,  	t_setup, t_hold,  notifier_vtrip_sel_refgen, 	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N_REFGEN, negedge VTRIP_SEL_REFGEN,  	t_setup, t_hold,  notifier_vtrip_sel_refgen, 	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N_REFGEN, posedge VREG_EN_REFGEN,    	t_setup, t_hold,  notifier_vreg_en_refgen,	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N_REFGEN, negedge VREG_EN_REFGEN,    	t_setup, t_hold,  notifier_vreg_en_refgen,	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N_REFGEN, posedge IBUF_SEL_REFGEN,   	t_setup, t_hold,  notifier_ibuf_sel_refgen,	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N_REFGEN, negedge IBUF_SEL_REFGEN,   	t_setup, t_hold,  notifier_ibuf_sel_refgen,	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N_REFGEN, posedge VREF_SEL[0],   		t_setup, t_hold,  notifier_vref_sel,	   	enable_vdda_h_and_enable_h==1'b1, enable_vdda_h_and_enable_h==1'b1);
    $setuphold (negedge HLD_H_N_REFGEN, negedge VREF_SEL[0],   		t_setup, t_hold,  notifier_vref_sel,	   	enable_vdda_h_and_enable_h==1'b1, enable_vdda_h_and_enable_h==1'b1);
    $setuphold (negedge HLD_H_N_REFGEN, posedge VREF_SEL[1],   		t_setup, t_hold,  notifier_vref_sel,	   	enable_vdda_h_and_enable_h==1'b1, enable_vdda_h_and_enable_h==1'b1);
    $setuphold (negedge HLD_H_N_REFGEN, negedge VREF_SEL[1],   		t_setup, t_hold,  notifier_vref_sel,	   	enable_vdda_h_and_enable_h==1'b1, enable_vdda_h_and_enable_h==1'b1);
    $setuphold (negedge HLD_H_N_REFGEN, posedge VREF_SEL[0],   		t_setup, t_hold,  notifier_vref_sel_int, 	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N_REFGEN, negedge VREF_SEL[0],   		t_setup, t_hold,  notifier_vref_sel_int, 	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N_REFGEN, posedge VREF_SEL[1],   		t_setup, t_hold,  notifier_vref_sel_int, 	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N_REFGEN, negedge VREF_SEL[1],   		t_setup, t_hold,  notifier_vref_sel_int, 	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N_REFGEN, posedge VOH_SEL[0],   		t_setup, t_hold,  notifier_voh_sel,	 	enable_vdda_h_and_enable_h==1'b1, enable_vdda_h_and_enable_h==1'b1);
    $setuphold (negedge HLD_H_N_REFGEN, posedge VOH_SEL[1],  		t_setup, t_hold,  notifier_voh_sel,	 	enable_vdda_h_and_enable_h==1'b1, enable_vdda_h_and_enable_h==1'b1);
    $setuphold (negedge HLD_H_N_REFGEN, posedge VOH_SEL[2],   		t_setup, t_hold,  notifier_voh_sel,	 	enable_vdda_h_and_enable_h==1'b1, enable_vdda_h_and_enable_h==1'b1);
    $setuphold (negedge HLD_H_N_REFGEN, negedge VOH_SEL[0],  		t_setup, t_hold,  notifier_voh_sel,	 	enable_vdda_h_and_enable_h==1'b1, enable_vdda_h_and_enable_h==1'b1);
    $setuphold (negedge HLD_H_N_REFGEN, negedge VOH_SEL[1],   		t_setup, t_hold,  notifier_voh_sel,	 	enable_vdda_h_and_enable_h==1'b1, enable_vdda_h_and_enable_h==1'b1);
    $setuphold (negedge HLD_H_N_REFGEN, negedge VOH_SEL[2],   		t_setup, t_hold,  notifier_voh_sel,	 	enable_vdda_h_and_enable_h==1'b1, enable_vdda_h_and_enable_h==1'b1);
    $setuphold (negedge HLD_H_N_REFGEN, posedge DFT_REFGEN,   		t_setup, t_hold,  notifier_dft_refgen,	 	enable_vdda_h_and_enable_h==1'b1, enable_vdda_h_and_enable_h==1'b1);
    $setuphold (negedge HLD_H_N_REFGEN, negedge DFT_REFGEN,   		t_setup, t_hold,  notifier_dft_refgen,	 	enable_vdda_h_and_enable_h==1'b1, enable_vdda_h_and_enable_h==1'b1);
    $setuphold (posedge HLD_H_N_REFGEN, posedge VTRIP_SEL_REFGEN,  	t_setup, t_hold,  notifier_vtrip_sel_refgen, 	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N_REFGEN, negedge VTRIP_SEL_REFGEN,  	t_setup, t_hold,  notifier_vtrip_sel_refgen, 	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N_REFGEN, posedge VREG_EN_REFGEN,    	t_setup, t_hold,  notifier_vreg_en_refgen,	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N_REFGEN, negedge VREG_EN_REFGEN,    	t_setup, t_hold,  notifier_vreg_en_refgen,	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N_REFGEN, posedge IBUF_SEL_REFGEN,   	t_setup, t_hold,  notifier_ibuf_sel_refgen,	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N_REFGEN, negedge IBUF_SEL_REFGEN,   	t_setup, t_hold,  notifier_ibuf_sel_refgen,	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N_REFGEN, posedge VREF_SEL[0],   		t_setup, t_hold,  notifier_vref_sel,	   	enable_vdda_h_and_enable_h==1'b1, enable_vdda_h_and_enable_h==1'b1);
    $setuphold (posedge HLD_H_N_REFGEN, negedge VREF_SEL[0],   		t_setup, t_hold,  notifier_vref_sel,	   	enable_vdda_h_and_enable_h==1'b1, enable_vdda_h_and_enable_h==1'b1);
    $setuphold (posedge HLD_H_N_REFGEN, posedge VREF_SEL[1],   		t_setup, t_hold,  notifier_vref_sel,	   	enable_vdda_h_and_enable_h==1'b1, enable_vdda_h_and_enable_h==1'b1);
    $setuphold (posedge HLD_H_N_REFGEN, negedge VREF_SEL[1],   		t_setup, t_hold,  notifier_vref_sel,	   	enable_vdda_h_and_enable_h==1'b1, enable_vdda_h_and_enable_h==1'b1);
    $setuphold (posedge HLD_H_N_REFGEN, posedge VREF_SEL[0],   		t_setup, t_hold,  notifier_vref_sel_int, 	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N_REFGEN, negedge VREF_SEL[0],   		t_setup, t_hold,  notifier_vref_sel_int, 	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N_REFGEN, posedge VREF_SEL[1],   		t_setup, t_hold,  notifier_vref_sel_int, 	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N_REFGEN, negedge VREF_SEL[1],   		t_setup, t_hold,  notifier_vref_sel_int, 	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N_REFGEN, posedge VOH_SEL[0],   		t_setup, t_hold,  notifier_voh_sel,	 	enable_vdda_h_and_enable_h==1'b1, enable_vdda_h_and_enable_h==1'b1);
    $setuphold (posedge HLD_H_N_REFGEN, posedge VOH_SEL[1],  		t_setup, t_hold,  notifier_voh_sel,	 	enable_vdda_h_and_enable_h==1'b1, enable_vdda_h_and_enable_h==1'b1);
    $setuphold (posedge HLD_H_N_REFGEN, posedge VOH_SEL[2],   		t_setup, t_hold,  notifier_voh_sel,	 	enable_vdda_h_and_enable_h==1'b1, enable_vdda_h_and_enable_h==1'b1);
    $setuphold (posedge HLD_H_N_REFGEN, negedge VOH_SEL[0],  		t_setup, t_hold,  notifier_voh_sel,	 	enable_vdda_h_and_enable_h==1'b1, enable_vdda_h_and_enable_h==1'b1);
    $setuphold (posedge HLD_H_N_REFGEN, negedge VOH_SEL[1],   		t_setup, t_hold,  notifier_voh_sel,	 	enable_vdda_h_and_enable_h==1'b1, enable_vdda_h_and_enable_h==1'b1);
    $setuphold (posedge HLD_H_N_REFGEN, negedge VOH_SEL[2],   		t_setup, t_hold,  notifier_voh_sel,	 	enable_vdda_h_and_enable_h==1'b1, enable_vdda_h_and_enable_h==1'b1);
    $setuphold (posedge HLD_H_N_REFGEN, posedge DFT_REFGEN,   		t_setup, t_hold,  notifier_dft_refgen,	 	enable_vdda_h_and_enable_h==1'b1, enable_vdda_h_and_enable_h==1'b1);
    $setuphold (posedge HLD_H_N_REFGEN, negedge DFT_REFGEN,   		t_setup, t_hold,  notifier_dft_refgen,	 	enable_vdda_h_and_enable_h==1'b1, enable_vdda_h_and_enable_h==1'b1);
    $setuphold (negedge ENABLE_H,   posedge HLD_H_N[0],    t_setup, t_hold,  	notifier_enable_h_0);
    $setuphold (negedge ENABLE_H,   negedge HLD_H_N[0],    t_setup, t_hold,  	notifier_enable_h_0);
    $setuphold (posedge ENABLE_H,   posedge HLD_H_N[0],    t_setup, t_hold,  	notifier_enable_h_0);
    $setuphold (posedge ENABLE_H,   negedge HLD_H_N[0],    t_setup, t_hold,  	notifier_enable_h_0);
    $setuphold (negedge HLD_H_N[0], posedge HLD_OVR[0],    t_setup, t_hold,	notifier_hld_ovr_0,   	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N[0], negedge HLD_OVR[0],    t_setup, t_hold,	notifier_hld_ovr_0,   	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N[0], posedge DM0[2],        t_setup, t_hold,  	notifier_dm_0, 		ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N[0], negedge DM0[2],        t_setup, t_hold,  	notifier_dm_0, 		ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N[0], posedge DM0[1],        t_setup, t_hold,  	notifier_dm_0, 		ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N[0], negedge DM0[1],        t_setup, t_hold,  	notifier_dm_0,		ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N[0], posedge DM0[0],        t_setup, t_hold,  	notifier_dm_0, 		ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N[0], negedge DM0[0],        t_setup, t_hold,  	notifier_dm_0, 		ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N[0], posedge INP_DIS[0],    t_setup, t_hold,	notifier_inp_dis_0,   	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N[0], negedge INP_DIS[0],    t_setup, t_hold,	notifier_inp_dis_0,   	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N[0], posedge VTRIP_SEL[0],  t_setup, t_hold,	notifier_vtrip_sel_0, 	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N[0], negedge VTRIP_SEL[0],  t_setup, t_hold,	notifier_vtrip_sel_0, 	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N[0], posedge SLOW[0],       t_setup, t_hold,	notifier_slow_0,	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N[0], negedge SLOW[0],       t_setup, t_hold,	notifier_slow_0,	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N[0], posedge OE_N[0],       t_setup, t_hold,	notifier_oe_n_0,	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N[0], negedge OE_N[0],       t_setup, t_hold,	notifier_oe_n_0,	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N[0], posedge OUT[0],        t_setup, t_hold,	notifier_out_0,		ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N[0], negedge OUT[0],        t_setup, t_hold,	notifier_out_0,		ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N[0], posedge VREG_EN[0],    t_setup, t_hold,	notifier_vreg_en_0,	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N[0], negedge VREG_EN[0],    t_setup, t_hold,	notifier_vreg_en_0,	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N[0], posedge IBUF_SEL[0],   t_setup, t_hold,	notifier_ibuf_sel_0,	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N[0], negedge IBUF_SEL[0],   t_setup, t_hold,	notifier_ibuf_sel_0,	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N[0], posedge HLD_OVR[0],    t_setup, t_hold,	notifier_hld_ovr_0,   	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N[0], negedge HLD_OVR[0],    t_setup, t_hold,	notifier_hld_ovr_0,   	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N[0], posedge DM0[2],        t_setup, t_hold,  	notifier_dm_0, 		ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N[0], negedge DM0[2],        t_setup, t_hold,  	notifier_dm_0, 		ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N[0], posedge DM0[1],        t_setup, t_hold,  	notifier_dm_0, 		ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N[0], negedge DM0[1],        t_setup, t_hold,  	notifier_dm_0,		ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N[0], posedge DM0[0],        t_setup, t_hold,  	notifier_dm_0, 		ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N[0], negedge DM0[0],        t_setup, t_hold,  	notifier_dm_0, 		ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N[0], posedge INP_DIS[0],    t_setup, t_hold,	notifier_inp_dis_0,   	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N[0], negedge INP_DIS[0],    t_setup, t_hold,	notifier_inp_dis_0,   	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N[0], posedge VTRIP_SEL[0],  t_setup, t_hold,	notifier_vtrip_sel_0, 	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N[0], negedge VTRIP_SEL[0],  t_setup, t_hold,	notifier_vtrip_sel_0, 	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N[0], posedge SLOW[0],       t_setup, t_hold,	notifier_slow_0,	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N[0], negedge SLOW[0],       t_setup, t_hold,	notifier_slow_0,	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N[0], posedge OE_N[0],       t_setup, t_hold,	notifier_oe_n_0,	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N[0], negedge OE_N[0],       t_setup, t_hold,	notifier_oe_n_0,	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N[0], posedge OUT[0],        t_setup, t_hold,	notifier_out_0,		ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N[0], negedge OUT[0],        t_setup, t_hold,	notifier_out_0,		ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N[0], posedge VREG_EN[0],    t_setup, t_hold,	notifier_vreg_en_0,	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N[0], negedge VREG_EN[0],    t_setup, t_hold,	notifier_vreg_en_0,	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N[0], posedge IBUF_SEL[0],   t_setup, t_hold,	notifier_ibuf_sel_0,	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N[0], negedge IBUF_SEL[0],   t_setup, t_hold,	notifier_ibuf_sel_0,	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge ENABLE_H,   posedge HLD_H_N[1],    t_setup, t_hold,  	notifier_enable_h_1);
    $setuphold (negedge ENABLE_H,   negedge HLD_H_N[1],    t_setup, t_hold,  	notifier_enable_h_1);
    $setuphold (posedge ENABLE_H,   posedge HLD_H_N[1],    t_setup, t_hold,  	notifier_enable_h_1);
    $setuphold (posedge ENABLE_H,   negedge HLD_H_N[1],    t_setup, t_hold,  	notifier_enable_h_1);
    $setuphold (negedge HLD_H_N[1], posedge HLD_OVR[1],    t_setup, t_hold,	notifier_hld_ovr_1,   	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N[1], negedge HLD_OVR[1],    t_setup, t_hold,	notifier_hld_ovr_1,   	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N[1], posedge DM1[2],        t_setup, t_hold,  	notifier_dm_1, 		ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N[1], negedge DM1[2],        t_setup, t_hold,  	notifier_dm_1, 		ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N[1], posedge DM1[1],        t_setup, t_hold,  	notifier_dm_1, 		ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N[1], negedge DM1[1],        t_setup, t_hold,  	notifier_dm_1,		ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N[1], posedge DM1[0],        t_setup, t_hold,  	notifier_dm_1, 		ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N[1], negedge DM1[0],        t_setup, t_hold,  	notifier_dm_1, 		ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N[1], posedge INP_DIS[1],    t_setup, t_hold,	notifier_inp_dis_1,   	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N[1], negedge INP_DIS[1],    t_setup, t_hold,	notifier_inp_dis_1,   	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N[1], posedge VTRIP_SEL[1],  t_setup, t_hold,	notifier_vtrip_sel_1, 	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N[1], negedge VTRIP_SEL[1],  t_setup, t_hold,	notifier_vtrip_sel_1, 	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N[1], posedge SLOW[1],       t_setup, t_hold,	notifier_slow_1,	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N[1], negedge SLOW[1],       t_setup, t_hold,	notifier_slow_1,	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N[1], posedge OE_N[1],       t_setup, t_hold,	notifier_oe_n_1,	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N[1], negedge OE_N[1],       t_setup, t_hold,	notifier_oe_n_1,	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N[1], posedge OUT[1],        t_setup, t_hold,	notifier_out_1,		ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N[1], negedge OUT[1],        t_setup, t_hold,	notifier_out_1,		ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N[1], posedge VREG_EN[1],    t_setup, t_hold,	notifier_vreg_en_1,	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N[1], negedge VREG_EN[1],    t_setup, t_hold,	notifier_vreg_en_1,	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N[1], posedge IBUF_SEL[1],   t_setup, t_hold,	notifier_ibuf_sel_1,	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N[1], negedge IBUF_SEL[1],   t_setup, t_hold,	notifier_ibuf_sel_1,	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N[1], posedge HLD_OVR[1],    t_setup, t_hold,	notifier_hld_ovr_1,   	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N[1], negedge HLD_OVR[1],    t_setup, t_hold,	notifier_hld_ovr_1,   	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N[1], posedge DM1[2],        t_setup, t_hold,  	notifier_dm_1, 		ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N[1], negedge DM1[2],        t_setup, t_hold,  	notifier_dm_1, 		ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N[1], posedge DM1[1],        t_setup, t_hold,  	notifier_dm_1, 		ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N[1], negedge DM1[1],        t_setup, t_hold,  	notifier_dm_1,		ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N[1], posedge DM1[0],        t_setup, t_hold,  	notifier_dm_1, 		ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N[1], negedge DM1[0],        t_setup, t_hold,  	notifier_dm_1, 		ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N[1], posedge INP_DIS[1],    t_setup, t_hold,	notifier_inp_dis_1,   	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N[1], negedge INP_DIS[1],    t_setup, t_hold,	notifier_inp_dis_1,   	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N[1], posedge VTRIP_SEL[1],  t_setup, t_hold,	notifier_vtrip_sel_1, 	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N[1], negedge VTRIP_SEL[1],  t_setup, t_hold,	notifier_vtrip_sel_1, 	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N[1], posedge SLOW[1],       t_setup, t_hold,	notifier_slow_1,	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N[1], negedge SLOW[1],       t_setup, t_hold,	notifier_slow_1,	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N[1], posedge OE_N[1],       t_setup, t_hold,	notifier_oe_n_1,	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N[1], negedge OE_N[1],       t_setup, t_hold,	notifier_oe_n_1,	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N[1], posedge OUT[1],        t_setup, t_hold,	notifier_out_1,		ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N[1], negedge OUT[1],        t_setup, t_hold,	notifier_out_1,		ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N[1], posedge VREG_EN[1],    t_setup, t_hold,	notifier_vreg_en_1,	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N[1], negedge VREG_EN[1],    t_setup, t_hold,	notifier_vreg_en_1,	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N[1], posedge IBUF_SEL[1],   t_setup, t_hold,	notifier_ibuf_sel_1,	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N[1], negedge IBUF_SEL[1],   t_setup, t_hold,	notifier_ibuf_sel_1,	ENABLE_H==1'b1, ENABLE_H==1'b1);
endspecify
assign REFGEN.NOTIFIER_ENABLE_H 	= notifier_enable_h_refgen;
assign REFGEN.NOTIFIER_VTRIP_SEL	= notifier_vtrip_sel_refgen;
assign REFGEN.NOTIFIER_VREG_EN 		= notifier_vreg_en_refgen;
assign REFGEN.NOTIFIER_IBUF_SEL		= notifier_ibuf_sel_refgen;
assign REFGEN.notifier_vref_sel		= notifier_vref_sel;
assign REFGEN.notifier_vref_sel_int	= notifier_vref_sel_int;
assign REFGEN.notifier_voh_sel		= notifier_voh_sel;
assign REFGEN.notifier_dft_refgen 	= notifier_dft_refgen;
assign SIO_PAIR_0_.NOTIFIER_ENABLE_H 	= notifier_enable_h_0;
assign SIO_PAIR_0_.NOTIFIER_HLD_OVR	= notifier_hld_ovr_0;
assign SIO_PAIR_0_.NOTIFIER_DM 		= notifier_dm_0;
assign SIO_PAIR_0_.NOTIFIER_INP_DIS 	= notifier_inp_dis_0;
assign SIO_PAIR_0_.NOTIFIER_VTRIP_SEL 	= notifier_vtrip_sel_0;
assign SIO_PAIR_0_.NOTIFIER_SLOW 	= notifier_slow_0;
assign SIO_PAIR_0_.NOTIFIER_OE_N	= notifier_oe_n_0;
assign SIO_PAIR_0_.NOTIFIER_OUT 	= notifier_out_0;
assign SIO_PAIR_0_.NOTIFIER_VREG_EN 	= notifier_vreg_en_0;
assign SIO_PAIR_0_.NOTIFIER_IBUF_SEL 	= notifier_ibuf_sel_0;
assign SIO_PAIR_1_.NOTIFIER_ENABLE_H 	= notifier_enable_h_1;
assign SIO_PAIR_1_.NOTIFIER_HLD_OVR	= notifier_hld_ovr_1;
assign SIO_PAIR_1_.NOTIFIER_DM 		= notifier_dm_1;
assign SIO_PAIR_1_.NOTIFIER_INP_DIS 	= notifier_inp_dis_1;
assign SIO_PAIR_1_.NOTIFIER_VTRIP_SEL 	= notifier_vtrip_sel_1;
assign SIO_PAIR_1_.NOTIFIER_SLOW 	= notifier_slow_1;
assign SIO_PAIR_1_.NOTIFIER_OE_N	= notifier_oe_n_1;
assign SIO_PAIR_1_.NOTIFIER_OUT 	= notifier_out_1;
assign SIO_PAIR_1_.NOTIFIER_VREG_EN 	= notifier_vreg_en_1;
assign SIO_PAIR_1_.NOTIFIER_IBUF_SEL 	= notifier_ibuf_sel_1;
sky130_fd_io__top_refgen_new REFGEN (
                                 .VSWITCH                                      (VSWITCH),
                                 .VSSIO_Q                                      (VSSIO_Q),
                                 .VDDIO_Q                                      (VDDIO_Q),
                                 .VSSIO                                        (VSSIO),
                                 .VSSD                                         (VSSD),
                                 .VCCHIB                                       (VCCHIB),
                                 .VDDIO                                        (VDDIO),
                                 .VCCD                                         (VCCD),
                                 .VDDA                                         (VDDA),
                                 .VSSA					  (VSSA),
                                 .VOH_SEL                                      (VOH_SEL[2:0]),
                                 .VREF_SEL                                     (VREF_SEL[1:0]),
                                 .VOHREF                                       (VOHREF),
                                 .VINREF_DFT                                   (VINREF_DFT),
                                 .VOUTREF_DFT                                  (VOUTREF_DFT),
                                 .DFT_REFGEN                                   (DFT_REFGEN),
                                 .AMUXBUS_A                                    (AMUXBUS_A),
                                 .AMUXBUS_B                                    (AMUXBUS_B),
                                 .VOUTREF                                      (VOUTREF),
                                 .VREG_EN                                      (VREG_EN_REFGEN),
                                 .IBUF_SEL                                     (IBUF_SEL_REFGEN),
                                 .VINREF                                       (VINREF),
                                 .VTRIP_SEL                                    (VTRIP_SEL_REFGEN),
                                 .ENABLE_H					  (ENABLE_H),
                                 .ENABLE_VDDA_H				  (ENABLE_VDDA_H),
                                 .HLD_H_N                                      (HLD_H_N_REFGEN),
                                 .REFLEAK_BIAS                                 (REFLEAK_BIAS)
                             );
sky130_fd_io__top_sio SIO_PAIR_1_ (
                          .VDDIO                                        (VDDIO),
                          .VCCD                                         (VCCD),
                          .VDDIO_Q                                      (VDDIO_Q),
                          .VCCHIB                                       (VCCHIB),
                          .VSSIO                                        (VSSIO),
                          .VSSIO_Q                                      (VSSIO_Q),
                          .VSSD                                         (VSSD),
                          .PAD                                          (PAD[1]),
                          .IN_H                                         (IN_H[1]),
                          .DM                                           (DM1[2:0]),
                          .HLD_H_N                                      (HLD_H_N[1]),
                          .PAD_A_ESD_1_H                                (PAD_A_ESD_1_H[1]),
                          .PAD_A_ESD_0_H                                (PAD_A_ESD_0_H[1]),
                          .ENABLE_H                                     (ENABLE_H),
                          .OUT                                          (OUT[1]),
                          .OE_N                                         (OE_N[1]),
                          .SLOW                                         (SLOW[1]),
                          .VTRIP_SEL                                    (VTRIP_SEL[1]),
                          .INP_DIS                                      (INP_DIS[1]),
                          .TIE_LO_ESD                                   (TIE_LO_ESD[1]),
                          .IN                                           (IN[1]),
                          .VINREF                                       (VINREF),
                          .VOUTREF                                      (VOUTREF),
                          .REFLEAK_BIAS                                 (REFLEAK_BIAS),
                          .PAD_A_NOESD_H                                (PAD_A_NOESD_H[1]),
                          .VREG_EN                                      (VREG_EN[1]),
                          .IBUF_SEL                                     (IBUF_SEL[1]),
                          .HLD_OVR                                      (HLD_OVR[1])
                      );
sky130_fd_io__top_sio SIO_PAIR_0_ (
                          .VDDIO                                        (VDDIO),
                          .VCCD                                         (VCCD),
                          .VDDIO_Q                                      (VDDIO_Q),
                          .VCCHIB                                       (VCCHIB),
                          .VSSIO                                        (VSSIO),
                          .VSSIO_Q                                      (VSSIO_Q),
                          .VSSD                                         (VSSD),
                          .PAD                                          (PAD[0]),
                          .IN_H                                         (IN_H[0]),
                          .DM                                           (DM0[2:0]),
                          .HLD_H_N                                      (HLD_H_N[0]),
                          .PAD_A_ESD_1_H                                (PAD_A_ESD_1_H[0]),
                          .PAD_A_ESD_0_H                                (PAD_A_ESD_0_H[0]),
                          .ENABLE_H                                     (ENABLE_H),
                          .OUT                                          (OUT[0]),
                          .OE_N                                         (OE_N[0]),
                          .SLOW                                         (SLOW[0]),
                          .VTRIP_SEL                                    (VTRIP_SEL[0]),
                          .INP_DIS                                      (INP_DIS[0]),
                          .TIE_LO_ESD                                   (TIE_LO_ESD[0]),
                          .IN                                           (IN[0]),
                          .VINREF                                       (VINREF),
                          .VOUTREF                                      (VOUTREF),
                          .REFLEAK_BIAS                                 (REFLEAK_BIAS),
                          .PAD_A_NOESD_H                                (PAD_A_NOESD_H[0]),
                          .VREG_EN                                      (VREG_EN[0]),
                          .IBUF_SEL                                     (IBUF_SEL[0]),
                          .HLD_OVR                                      (HLD_OVR[0])
                      );
endmodule
`endif // FUNCTIONAL

`else  // USE_POWER_PINS

`ifdef FUNCTIONAL
/*
 * Copyright 2020 The SkyWater PDK Authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 * SPDX-License-Identifier: Apache-2.0
*/

module sky130_fd_io__top_sio_macro (
           IN,
           IN_H,
           TIE_LO_ESD,
           AMUXBUS_A,
           AMUXBUS_B,
           PAD,
           PAD_A_ESD_0_H,
           PAD_A_ESD_1_H,
           PAD_A_NOESD_H,
           VINREF_DFT,
           VOUTREF_DFT,
           DFT_REFGEN,
           DM0,
           DM1,
           HLD_H_N,
           HLD_H_N_REFGEN,
           HLD_OVR,
           IBUF_SEL,
           IBUF_SEL_REFGEN,
           INP_DIS,
           ENABLE_H,
           ENABLE_VDDA_H,
           OE_N,
           OUT,
           SLOW,
           VOH_SEL,
           VOHREF,
           VREF_SEL,
           VREG_EN,
           VREG_EN_REFGEN,
           VTRIP_SEL,
           VTRIP_SEL_REFGEN
       );
wire VOUTREF;
wire VINREF;
wire REFLEAK_BIAS;
supply1 vddio;
supply1 vddio_q;
supply1 vdda;
supply1 vccd;
supply1 vswitch;
supply1 vcchib;
supply0 vssd;
supply0 vssio;
supply0 vssio_q;
supply0 vssa;
inout AMUXBUS_A;
inout AMUXBUS_B;
inout VINREF_DFT;
inout VOUTREF_DFT;
input DFT_REFGEN;
input HLD_H_N_REFGEN;
input IBUF_SEL_REFGEN;
input ENABLE_VDDA_H;
input ENABLE_H;
input VOHREF;
input VREG_EN_REFGEN;
input VTRIP_SEL_REFGEN;
output [1:0]  TIE_LO_ESD;
output [1:0]  IN_H;
output [1:0]  IN;
inout [1:0]  PAD_A_NOESD_H;
inout [1:0]  PAD;
inout [1:0]  PAD_A_ESD_1_H;
inout [1:0]  PAD_A_ESD_0_H;
input [1:0]  SLOW;
input [1:0]  VTRIP_SEL;
input [1:0]  HLD_H_N;
input [1:0]  VREG_EN;
input [2:0]  VOH_SEL;
input [1:0]  INP_DIS;
input [1:0]  HLD_OVR;
input [1:0]  OE_N;
input [1:0]  VREF_SEL;
input [1:0]  IBUF_SEL;
input [2:0]  DM0;
input [2:0]  DM1;
input [1:0]  OUT;
reg 	notifier_enable_h_refgen,
     notifier_vtrip_sel_refgen,
     notifier_vreg_en_refgen,
     notifier_ibuf_sel_refgen,
     notifier_vref_sel,
     notifier_vref_sel_int,
     notifier_voh_sel,
     notifier_dft_refgen;
reg	 notifier_enable_h_0;
reg	 notifier_hld_ovr_0;
reg	 notifier_dm_0;
reg	 notifier_inp_dis_0;
reg	 notifier_vtrip_sel_0;
reg	 notifier_slow_0;
reg	 notifier_oe_n_0;
reg	 notifier_out_0;
reg	 notifier_vreg_en_0;
reg	 notifier_ibuf_sel_0;
reg	 notifier_enable_h_1;
reg	 notifier_hld_ovr_1;
reg	 notifier_dm_1;
reg	 notifier_inp_dis_1;
reg	 notifier_vtrip_sel_1;
reg	 notifier_slow_1;
reg	 notifier_oe_n_1;
reg	 notifier_out_1;
reg	 notifier_vreg_en_1;
reg	 notifier_ibuf_sel_1;
wire enable_vdda_h_and_enable_h = ENABLE_VDDA_H==1'b1 && ENABLE_H==1'b1;
sky130_fd_io__top_refgen_new REFGEN (
                                 .VOH_SEL                                      (VOH_SEL[2:0]),
                                 .VREF_SEL                                     (VREF_SEL[1:0]),
                                 .VOHREF                                       (VOHREF),
                                 .VINREF_DFT                                   (VINREF_DFT),
                                 .VOUTREF_DFT                                  (VOUTREF_DFT),
                                 .DFT_REFGEN                                   (DFT_REFGEN),
                                 .AMUXBUS_A                                    (AMUXBUS_A),
                                 .AMUXBUS_B                                    (AMUXBUS_B),
                                 .VOUTREF                                      (VOUTREF),
                                 .VREG_EN                                      (VREG_EN_REFGEN),
                                 .IBUF_SEL                                     (IBUF_SEL_REFGEN),
                                 .VINREF                                       (VINREF),
                                 .VTRIP_SEL                                    (VTRIP_SEL_REFGEN),
                                 .ENABLE_H					  (ENABLE_H),
                                 .ENABLE_VDDA_H				  (ENABLE_VDDA_H),
                                 .HLD_H_N                                      (HLD_H_N_REFGEN),
                                 .REFLEAK_BIAS                                 (REFLEAK_BIAS)
                             );
sky130_fd_io__top_sio SIO_PAIR_1_ (
                          .PAD                                          (PAD[1]),
                          .IN_H                                         (IN_H[1]),
                          .DM                                           (DM1[2:0]),
                          .HLD_H_N                                      (HLD_H_N[1]),
                          .PAD_A_ESD_1_H                                (PAD_A_ESD_1_H[1]),
                          .PAD_A_ESD_0_H                                (PAD_A_ESD_0_H[1]),
                          .ENABLE_H                                     (ENABLE_H),
                          .OUT                                          (OUT[1]),
                          .OE_N                                         (OE_N[1]),
                          .SLOW                                         (SLOW[1]),
                          .VTRIP_SEL                                    (VTRIP_SEL[1]),
                          .INP_DIS                                      (INP_DIS[1]),
                          .TIE_LO_ESD                                   (TIE_LO_ESD[1]),
                          .IN                                           (IN[1]),
                          .VINREF                                       (VINREF),
                          .VOUTREF                                      (VOUTREF),
                          .REFLEAK_BIAS                                 (REFLEAK_BIAS),
                          .PAD_A_NOESD_H                                (PAD_A_NOESD_H[1]),
                          .VREG_EN                                      (VREG_EN[1]),
                          .IBUF_SEL                                     (IBUF_SEL[1]),
                          .HLD_OVR                                      (HLD_OVR[1])
                      );
sky130_fd_io__top_sio SIO_PAIR_0_ (
                          .PAD                                          (PAD[0]),
                          .IN_H                                         (IN_H[0]),
                          .DM                                           (DM0[2:0]),
                          .HLD_H_N                                      (HLD_H_N[0]),
                          .PAD_A_ESD_1_H                                (PAD_A_ESD_1_H[0]),
                          .PAD_A_ESD_0_H                                (PAD_A_ESD_0_H[0]),
                          .ENABLE_H                                     (ENABLE_H),
                          .OUT                                          (OUT[0]),
                          .OE_N                                         (OE_N[0]),
                          .SLOW                                         (SLOW[0]),
                          .VTRIP_SEL                                    (VTRIP_SEL[0]),
                          .INP_DIS                                      (INP_DIS[0]),
                          .TIE_LO_ESD                                   (TIE_LO_ESD[0]),
                          .IN                                           (IN[0]),
                          .VINREF                                       (VINREF),
                          .VOUTREF                                      (VOUTREF),
                          .REFLEAK_BIAS                                 (REFLEAK_BIAS),
                          .PAD_A_NOESD_H                                (PAD_A_NOESD_H[0]),
                          .VREG_EN                                      (VREG_EN[0]),
                          .IBUF_SEL                                     (IBUF_SEL[0]),
                          .HLD_OVR                                      (HLD_OVR[0])
                      );
endmodule
`else  // FUNCTIONAL
/*
 * Copyright 2020 The SkyWater PDK Authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 * SPDX-License-Identifier: Apache-2.0
*/

module sky130_fd_io__top_sio_macro (
           IN,
           IN_H,
           TIE_LO_ESD,
           AMUXBUS_A,
           AMUXBUS_B,
           PAD,
           PAD_A_ESD_0_H,
           PAD_A_ESD_1_H,
           PAD_A_NOESD_H,
           VINREF_DFT,
           VOUTREF_DFT,
           DFT_REFGEN,
           DM0,
           DM1,
           HLD_H_N,
           HLD_H_N_REFGEN,
           HLD_OVR,
           IBUF_SEL,
           IBUF_SEL_REFGEN,
           INP_DIS,
           ENABLE_H,
           ENABLE_VDDA_H,
           OE_N,
           OUT,
           SLOW,
           VOH_SEL,
           VOHREF,
           VREF_SEL,
           VREG_EN,
           VREG_EN_REFGEN,
           VTRIP_SEL,
           VTRIP_SEL_REFGEN
       );
wire VOUTREF;
wire VINREF;
wire REFLEAK_BIAS;
supply1 vddio;
supply1 vddio_q;
supply1 vdda;
supply1 vccd;
supply1 vswitch;
supply1 vcchib;
supply0 vssd;
supply0 vssio;
supply0 vssio_q;
supply0 vssa;
inout AMUXBUS_A;
inout AMUXBUS_B;
inout VINREF_DFT;
inout VOUTREF_DFT;
input DFT_REFGEN;
input HLD_H_N_REFGEN;
input IBUF_SEL_REFGEN;
input ENABLE_VDDA_H;
input ENABLE_H;
input VOHREF;
input VREG_EN_REFGEN;
input VTRIP_SEL_REFGEN;
output [1:0]  TIE_LO_ESD;
output [1:0]  IN_H;
output [1:0]  IN;
inout [1:0]  PAD_A_NOESD_H;
inout [1:0]  PAD;
inout [1:0]  PAD_A_ESD_1_H;
inout [1:0]  PAD_A_ESD_0_H;
input [1:0]  SLOW;
input [1:0]  VTRIP_SEL;
input [1:0]  HLD_H_N;
input [1:0]  VREG_EN;
input [2:0]  VOH_SEL;
input [1:0]  INP_DIS;
input [1:0]  HLD_OVR;
input [1:0]  OE_N;
input [1:0]  VREF_SEL;
input [1:0]  IBUF_SEL;
input [2:0]  DM0;
input [2:0]  DM1;
input [1:0]  OUT;
reg 	notifier_enable_h_refgen,
     notifier_vtrip_sel_refgen,
     notifier_vreg_en_refgen,
     notifier_ibuf_sel_refgen,
     notifier_vref_sel,
     notifier_vref_sel_int,
     notifier_voh_sel,
     notifier_dft_refgen;
reg	 notifier_enable_h_0;
reg	 notifier_hld_ovr_0;
reg	 notifier_dm_0;
reg	 notifier_inp_dis_0;
reg	 notifier_vtrip_sel_0;
reg	 notifier_slow_0;
reg	 notifier_oe_n_0;
reg	 notifier_out_0;
reg	 notifier_vreg_en_0;
reg	 notifier_ibuf_sel_0;
reg	 notifier_enable_h_1;
reg	 notifier_hld_ovr_1;
reg	 notifier_dm_1;
reg	 notifier_inp_dis_1;
reg	 notifier_vtrip_sel_1;
reg	 notifier_slow_1;
reg	 notifier_oe_n_1;
reg	 notifier_out_1;
reg	 notifier_vreg_en_1;
reg	 notifier_ibuf_sel_1;
wire enable_vdda_h_and_enable_h = ENABLE_VDDA_H==1'b1 && ENABLE_H==1'b1;
specify
    if ( VTRIP_SEL[1]==1'b1)  ( INP_DIS[1]    => IN[1] )      =  (3.422:0:3.422 , 2.337:0:2.337);
    if ( VTRIP_SEL[1]==1'b1)  ( INP_DIS[1]    => IN_H[1] )    =  (3.271:0:3.271 , 2.210:0:2.210);
    if ( VTRIP_SEL[1]==1'b1)  ( PAD[1]        => IN[1] )      =  (0.798:0:0.798 , 0.959:0:0.959);
    if ( VTRIP_SEL[1]==1'b1)  ( PAD[1]        => IN_H[1] )    =  (0.931:0:0.931 , 0.935:0:0.935);
    if ( VTRIP_SEL[0]==1'b1)  ( INP_DIS[0]    => IN[0]  )     =  (3.422:0:3.422 , 2.337:0:2.337);
    if ( VTRIP_SEL[0]==1'b1)  ( INP_DIS[0]    => IN_H[0] )    =  (3.271:0:3.271 , 2.210:0:2.210);
    if ( VTRIP_SEL[0]==1'b1)  ( PAD[0]        => IN[0] )      =  (0.798:0:0.798 , 0.959:0:0.959);
    if ( VTRIP_SEL[0]==1'b1)  ( PAD[0]        => IN_H[0] )    =  (0.931:0:0.931 , 0.935:0:0.935);
    if ( VTRIP_SEL[1]==1'b0)  ( INP_DIS[1]    => IN[1] )      =  (3.422:0:3.422 , 2.337:0:2.337);
    if ( VTRIP_SEL[1]==1'b0)  ( INP_DIS[1]    => IN_H[1] )    =  (3.271:0:3.271 , 2.209:0:2.209);
    if ( VTRIP_SEL[1]==1'b0)  ( PAD[1]        => IN[1] )      =  (0.816:0:0.816 , 0.866:0:0.866);
    if ( VTRIP_SEL[1]==1'b0)  ( PAD[1]        => IN_H[1] )    =  (0.950:0:0.950 , 0.841:0:0.841);
    if ( VTRIP_SEL[0]==1'b0)  ( INP_DIS[0]    => IN[0] )      =  (3.422:0:3.422 , 2.337:0:2.337);
    if ( VTRIP_SEL[0]==1'b0)  ( INP_DIS[0]    => IN_H[0] )    =  (3.271:0:3.271 , 2.209:0:2.209);
    if ( VTRIP_SEL[0]==1'b0)  ( PAD[0]        => IN[0] )      =  (0.816:0:0.816 , 0.866:0:0.866);
    if ( VTRIP_SEL[0]==1'b0)  ( PAD[0]        => IN_H[0] )    =  (0.950:0:0.950 , 0.841:0:0.841);
    if ( DM0[2] == 1'b0 & DM0[1] == 1'b1 & DM0[0] == 1'b0 & SLOW[0] == 1'b0 ) 				( OE_N[0]	=> PAD[0] ) 	=  (0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0);
    if ( DM0[2] == 1'b0 & DM0[1] == 1'b1 & DM0[0] == 1'b0 & SLOW[0] == 1'b1 ) 				( OE_N[0]	=> PAD[0] ) 	=  (0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0);
    if ( DM0[2] == 1'b0 & DM0[1] == 1'b1 & DM0[0] == 1'b1 & SLOW[0] == 1'b0 ) 				( OE_N[0]	=> PAD[0] ) 	=  (0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0);
    if ( DM0[2] == 1'b0 & DM0[1] == 1'b1 & DM0[0] == 1'b1 & SLOW[0] == 1'b1 ) 				( OE_N[0]	=> PAD[0] ) 	=  (0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0);
    if ( DM0[2] == 1'b1 & DM0[1] == 1'b0 & DM0[0] == 1'b0 & SLOW[0] == 1'b0 ) 				( OE_N[0]	=> PAD[0] ) 	=  (0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0);
    if ( DM0[2] == 1'b1 & DM0[1] == 1'b0 & DM0[0] == 1'b0 & SLOW[0] == 1'b1 ) 				( OE_N[0]	=> PAD[0] ) 	=  (0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0);
    if ( DM0[2] == 1'b1 & DM0[1] == 1'b0 & DM0[0] == 1'b1 & SLOW[0] == 1'b0 ) 				( OE_N[0]	=> PAD[0] ) 	=  (0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0);
    if ( DM0[2] == 1'b1 & DM0[1] == 1'b0 & DM0[0] == 1'b1 & SLOW[0] == 1'b1 ) 				( OE_N[0]	=> PAD[0] ) 	=  (0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0);
    if ( DM0[2] == 1'b1 & DM0[1] == 1'b1 & DM0[0] == 1'b0 & SLOW[0] == 1'b0 ) 				( OE_N[0]	=> PAD[0] ) 	=  (0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0);
    if ( DM0[2] == 1'b1 & DM0[1] == 1'b1 & DM0[0] == 1'b0 & SLOW[0] == 1'b1 ) 				( OE_N[0]	=> PAD[0] ) 	=  (0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0);
    if ( DM0[2] == 1'b1 & DM0[1] == 1'b1 & DM0[0] == 1'b1 & SLOW[0] == 1'b0 ) 				( OE_N[0]	=> PAD[0] ) 	=  (0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0);
    if ( DM0[2] == 1'b1 & DM0[1] == 1'b1 & DM0[0] == 1'b1 & SLOW[0] == 1'b1 ) 				( OE_N[0]	=> PAD[0] ) 	=  (0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0);
    if ( DM0[2] == 1'b0 & DM0[1] == 1'b1 & DM0[0] == 1'b0 & SLOW[0] == 1'b0 & OE_N[0] == 1'b0 ) 	( OUT[0]	=> PAD[0] ) 	=  (0:0:0, 0:0:0);
    if ( DM0[2] == 1'b0 & DM0[1] == 1'b1 & DM0[0] == 1'b0 & SLOW[0] == 1'b1 & OE_N[0] == 1'b0 ) 	( OUT[0]	=> PAD[0] ) 	=  (0:0:0, 0:0:0);
    if ( DM0[2] == 1'b0 & DM0[1] == 1'b1 & DM0[0] == 1'b1 & SLOW[0] == 1'b0 & OE_N[0] == 1'b0 ) 	( OUT[0]	=> PAD[0] ) 	=  (0:0:0, 0:0:0);
    if ( DM0[2] == 1'b0 & DM0[1] == 1'b1 & DM0[0] == 1'b1 & SLOW[0] == 1'b1 & OE_N[0] == 1'b0 ) 	( OUT[0]	=> PAD[0] ) 	=  (0:0:0, 0:0:0);
    if ( DM0[2] == 1'b1 & DM0[1] == 1'b0 & DM0[0] == 1'b0 & SLOW[0] == 1'b0 & OE_N[0] == 1'b0 ) 	( OUT[0]	=> PAD[0] ) 	=  (0:0:0, 0:0:0);
    if ( DM0[2] == 1'b1 & DM0[1] == 1'b0 & DM0[0] == 1'b0 & SLOW[0] == 1'b1 & OE_N[0] == 1'b0 ) 	( OUT[0]	=> PAD[0] ) 	=  (0:0:0, 0:0:0);
    if ( DM0[2] == 1'b1 & DM0[1] == 1'b0 & DM0[0] == 1'b1 & SLOW[0] == 1'b0 & OE_N[0] == 1'b0 ) 	( OUT[0]	=> PAD[0] ) 	=  (0:0:0, 0:0:0);
    if ( DM0[2] == 1'b1 & DM0[1] == 1'b0 & DM0[0] == 1'b1 & SLOW[0] == 1'b1 & OE_N[0] == 1'b0 ) 	( OUT[0]	=> PAD[0] ) 	=  (0:0:0, 0:0:0);
    if ( DM0[2] == 1'b1 & DM0[1] == 1'b1 & DM0[0] == 1'b0 & SLOW[0] == 1'b0 & OE_N[0] == 1'b0 ) 	( OUT[0]	=> PAD[0] ) 	=  (0:0:0, 0:0:0);
    if ( DM0[2] == 1'b1 & DM0[1] == 1'b1 & DM0[0] == 1'b0 & SLOW[0] == 1'b1 & OE_N[0] == 1'b0 ) 	( OUT[0]	=> PAD[0] ) 	=  (0:0:0, 0:0:0);
    if ( DM0[2] == 1'b1 & DM0[1] == 1'b1 & DM0[0] == 1'b1 & SLOW[0] == 1'b0 & OE_N[0] == 1'b0 ) 	( OUT[0]	=> PAD[0] ) 	=  (0:0:0, 0:0:0);
    if ( DM0[2] == 1'b1 & DM0[1] == 1'b1 & DM0[0] == 1'b1 & SLOW[0] == 1'b1 & OE_N[0] == 1'b0 ) 	( OUT[0]	=> PAD[0] ) 	=  (0:0:0, 0:0:0);
    if ( DM1[2] == 1'b0 & DM1[1] == 1'b1 & DM1[0] == 1'b0 & SLOW[1] == 1'b0 ) 				( OE_N[1]	=> PAD[1] ) 	=  (0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0);
    if ( DM1[2] == 1'b0 & DM1[1] == 1'b1 & DM1[0] == 1'b0 & SLOW[1] == 1'b1 ) 				( OE_N[1]	=> PAD[1] ) 	=  (0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0);
    if ( DM1[2] == 1'b0 & DM1[1] == 1'b1 & DM1[0] == 1'b1 & SLOW[1] == 1'b0 ) 				( OE_N[1]	=> PAD[1] ) 	=  (0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0);
    if ( DM1[2] == 1'b0 & DM1[1] == 1'b1 & DM1[0] == 1'b1 & SLOW[1] == 1'b1 ) 				( OE_N[1]	=> PAD[1] ) 	=  (0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0);
    if ( DM1[2] == 1'b1 & DM1[1] == 1'b0 & DM1[0] == 1'b0 & SLOW[1] == 1'b0 ) 				( OE_N[1]	=> PAD[1] ) 	=  (0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0);
    if ( DM1[2] == 1'b1 & DM1[1] == 1'b0 & DM1[0] == 1'b0 & SLOW[1] == 1'b1 ) 				( OE_N[1]	=> PAD[1] ) 	=  (0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0);
    if ( DM1[2] == 1'b1 & DM1[1] == 1'b0 & DM1[0] == 1'b1 & SLOW[1] == 1'b0 ) 				( OE_N[1]	=> PAD[1] ) 	=  (0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0);
    if ( DM1[2] == 1'b1 & DM1[1] == 1'b0 & DM1[0] == 1'b1 & SLOW[1] == 1'b1 ) 				( OE_N[1]	=> PAD[1] ) 	=  (0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0);
    if ( DM1[2] == 1'b1 & DM1[1] == 1'b1 & DM1[0] == 1'b0 & SLOW[1] == 1'b0 ) 				( OE_N[1]	=> PAD[1] ) 	=  (0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0);
    if ( DM1[2] == 1'b1 & DM1[1] == 1'b1 & DM1[0] == 1'b0 & SLOW[1] == 1'b1 ) 				( OE_N[1]	=> PAD[1] ) 	=  (0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0);
    if ( DM1[2] == 1'b1 & DM1[1] == 1'b1 & DM1[0] == 1'b1 & SLOW[1] == 1'b0 ) 				( OE_N[1]	=> PAD[1] ) 	=  (0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0);
    if ( DM1[2] == 1'b1 & DM1[1] == 1'b1 & DM1[0] == 1'b1 & SLOW[1] == 1'b1 ) 				( OE_N[1]	=> PAD[1] ) 	=  (0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0);
    if ( DM1[2] == 1'b0 & DM1[1] == 1'b1 & DM1[0] == 1'b0 & SLOW[1] == 1'b0 & OE_N[1] == 1'b0 ) 	( OUT[1]	=> PAD[1] ) 	=  (0:0:0, 0:0:0);
    if ( DM1[2] == 1'b0 & DM1[1] == 1'b1 & DM1[0] == 1'b0 & SLOW[1] == 1'b1 & OE_N[1] == 1'b0 ) 	( OUT[1]	=> PAD[1] ) 	=  (0:0:0, 0:0:0);
    if ( DM1[2] == 1'b0 & DM1[1] == 1'b1 & DM1[0] == 1'b1 & SLOW[1] == 1'b0 & OE_N[1] == 1'b0 ) 	( OUT[1]	=> PAD[1] ) 	=  (0:0:0, 0:0:0);
    if ( DM1[2] == 1'b0 & DM1[1] == 1'b1 & DM1[0] == 1'b1 & SLOW[1] == 1'b1 & OE_N[1] == 1'b0 ) 	( OUT[1]	=> PAD[1] ) 	=  (0:0:0, 0:0:0);
    if ( DM1[2] == 1'b1 & DM1[1] == 1'b0 & DM1[0] == 1'b0 & SLOW[1] == 1'b0 & OE_N[1] == 1'b0 ) 	( OUT[1]	=> PAD[1] ) 	=  (0:0:0, 0:0:0);
    if ( DM1[2] == 1'b1 & DM1[1] == 1'b0 & DM1[0] == 1'b0 & SLOW[1] == 1'b1 & OE_N[1] == 1'b0 ) 	( OUT[1]	=> PAD[1] ) 	=  (0:0:0, 0:0:0);
    if ( DM1[2] == 1'b1 & DM1[1] == 1'b0 & DM1[0] == 1'b1 & SLOW[1] == 1'b0 & OE_N[1] == 1'b0 ) 	( OUT[1]	=> PAD[1] ) 	=  (0:0:0, 0:0:0);
    if ( DM1[2] == 1'b1 & DM1[1] == 1'b0 & DM1[0] == 1'b1 & SLOW[1] == 1'b1 & OE_N[1] == 1'b0 ) 	( OUT[1]	=> PAD[1] ) 	=  (0:0:0, 0:0:0);
    if ( DM1[2] == 1'b1 & DM1[1] == 1'b1 & DM1[0] == 1'b0 & SLOW[1] == 1'b0 & OE_N[1] == 1'b0 ) 	( OUT[1]	=> PAD[1] ) 	=  (0:0:0, 0:0:0);
    if ( DM1[2] == 1'b1 & DM1[1] == 1'b1 & DM1[0] == 1'b0 & SLOW[1] == 1'b1 & OE_N[1] == 1'b0 ) 	( OUT[1]	=> PAD[1] ) 	=  (0:0:0, 0:0:0);
    if ( DM1[2] == 1'b1 & DM1[1] == 1'b1 & DM1[0] == 1'b1 & SLOW[1] == 1'b0 & OE_N[1] == 1'b0 ) 	( OUT[1]	=> PAD[1] ) 	=  (0:0:0, 0:0:0);
    if ( DM1[2] == 1'b1 & DM1[1] == 1'b1 & DM1[0] == 1'b1 & SLOW[1] == 1'b1 & OE_N[1] == 1'b0 ) 	( OUT[1]	=> PAD[1] ) 	=  (0:0:0, 0:0:0);
    specparam t_setup=5;
    specparam t_hold=5;
    $width  (posedge HLD_H_N[1], 	(15.500:0:15.500));
    $width  (negedge HLD_H_N[1], 	(15.500:0:15.500));
    $width  (negedge HLD_H_N[0], 	(15.500:0:15.500));
    $width  (posedge HLD_H_N[0], 	(15.500:0:15.500));
    $width  (posedge HLD_H_N_REFGEN, 	(15.500:0:15.500));
    $width  (negedge HLD_H_N_REFGEN, 	(15.500:0:15.500));
    $width  (negedge HLD_OVR[1], 	(15.500:0:15.500));
    $width  (posedge HLD_OVR[1], 	(15.500:0:15.500));
    $width  (negedge HLD_OVR[0], 	(15.500:0:15.500));
    $width  (posedge HLD_OVR[0], 	(15.500:0:15.500));
    $setuphold (negedge ENABLE_H,    posedge HLD_H_N_REFGEN,	t_setup, t_hold,  notifier_enable_h_refgen);
    $setuphold (negedge ENABLE_H,    negedge HLD_H_N_REFGEN,	t_setup, t_hold,  notifier_enable_h_refgen);
    $setuphold (posedge ENABLE_H,    posedge HLD_H_N_REFGEN,	t_setup, t_hold,  notifier_enable_h_refgen);
    $setuphold (posedge ENABLE_H,    negedge HLD_H_N_REFGEN,	t_setup, t_hold,  notifier_enable_h_refgen);
    $setuphold (negedge HLD_H_N_REFGEN, posedge VTRIP_SEL_REFGEN,  	t_setup, t_hold,  notifier_vtrip_sel_refgen, 	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N_REFGEN, negedge VTRIP_SEL_REFGEN,  	t_setup, t_hold,  notifier_vtrip_sel_refgen, 	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N_REFGEN, posedge VREG_EN_REFGEN,    	t_setup, t_hold,  notifier_vreg_en_refgen,	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N_REFGEN, negedge VREG_EN_REFGEN,    	t_setup, t_hold,  notifier_vreg_en_refgen,	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N_REFGEN, posedge IBUF_SEL_REFGEN,   	t_setup, t_hold,  notifier_ibuf_sel_refgen,	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N_REFGEN, negedge IBUF_SEL_REFGEN,   	t_setup, t_hold,  notifier_ibuf_sel_refgen,	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N_REFGEN, posedge VREF_SEL[0],   		t_setup, t_hold,  notifier_vref_sel,	   	enable_vdda_h_and_enable_h==1'b1, enable_vdda_h_and_enable_h==1'b1);
    $setuphold (negedge HLD_H_N_REFGEN, negedge VREF_SEL[0],   		t_setup, t_hold,  notifier_vref_sel,	   	enable_vdda_h_and_enable_h==1'b1, enable_vdda_h_and_enable_h==1'b1);
    $setuphold (negedge HLD_H_N_REFGEN, posedge VREF_SEL[1],   		t_setup, t_hold,  notifier_vref_sel,	   	enable_vdda_h_and_enable_h==1'b1, enable_vdda_h_and_enable_h==1'b1);
    $setuphold (negedge HLD_H_N_REFGEN, negedge VREF_SEL[1],   		t_setup, t_hold,  notifier_vref_sel,	   	enable_vdda_h_and_enable_h==1'b1, enable_vdda_h_and_enable_h==1'b1);
    $setuphold (negedge HLD_H_N_REFGEN, posedge VREF_SEL[0],   		t_setup, t_hold,  notifier_vref_sel_int, 	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N_REFGEN, negedge VREF_SEL[0],   		t_setup, t_hold,  notifier_vref_sel_int, 	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N_REFGEN, posedge VREF_SEL[1],   		t_setup, t_hold,  notifier_vref_sel_int, 	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N_REFGEN, negedge VREF_SEL[1],   		t_setup, t_hold,  notifier_vref_sel_int, 	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N_REFGEN, posedge VOH_SEL[0],   		t_setup, t_hold,  notifier_voh_sel,	 	enable_vdda_h_and_enable_h==1'b1, enable_vdda_h_and_enable_h==1'b1);
    $setuphold (negedge HLD_H_N_REFGEN, posedge VOH_SEL[1],  		t_setup, t_hold,  notifier_voh_sel,	 	enable_vdda_h_and_enable_h==1'b1, enable_vdda_h_and_enable_h==1'b1);
    $setuphold (negedge HLD_H_N_REFGEN, posedge VOH_SEL[2],   		t_setup, t_hold,  notifier_voh_sel,	 	enable_vdda_h_and_enable_h==1'b1, enable_vdda_h_and_enable_h==1'b1);
    $setuphold (negedge HLD_H_N_REFGEN, negedge VOH_SEL[0],  		t_setup, t_hold,  notifier_voh_sel,	 	enable_vdda_h_and_enable_h==1'b1, enable_vdda_h_and_enable_h==1'b1);
    $setuphold (negedge HLD_H_N_REFGEN, negedge VOH_SEL[1],   		t_setup, t_hold,  notifier_voh_sel,	 	enable_vdda_h_and_enable_h==1'b1, enable_vdda_h_and_enable_h==1'b1);
    $setuphold (negedge HLD_H_N_REFGEN, negedge VOH_SEL[2],   		t_setup, t_hold,  notifier_voh_sel,	 	enable_vdda_h_and_enable_h==1'b1, enable_vdda_h_and_enable_h==1'b1);
    $setuphold (negedge HLD_H_N_REFGEN, posedge DFT_REFGEN,   		t_setup, t_hold,  notifier_dft_refgen,	 	enable_vdda_h_and_enable_h==1'b1, enable_vdda_h_and_enable_h==1'b1);
    $setuphold (negedge HLD_H_N_REFGEN, negedge DFT_REFGEN,   		t_setup, t_hold,  notifier_dft_refgen,	 	enable_vdda_h_and_enable_h==1'b1, enable_vdda_h_and_enable_h==1'b1);
    $setuphold (posedge HLD_H_N_REFGEN, posedge VTRIP_SEL_REFGEN,  	t_setup, t_hold,  notifier_vtrip_sel_refgen, 	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N_REFGEN, negedge VTRIP_SEL_REFGEN,  	t_setup, t_hold,  notifier_vtrip_sel_refgen, 	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N_REFGEN, posedge VREG_EN_REFGEN,    	t_setup, t_hold,  notifier_vreg_en_refgen,	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N_REFGEN, negedge VREG_EN_REFGEN,    	t_setup, t_hold,  notifier_vreg_en_refgen,	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N_REFGEN, posedge IBUF_SEL_REFGEN,   	t_setup, t_hold,  notifier_ibuf_sel_refgen,	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N_REFGEN, negedge IBUF_SEL_REFGEN,   	t_setup, t_hold,  notifier_ibuf_sel_refgen,	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N_REFGEN, posedge VREF_SEL[0],   		t_setup, t_hold,  notifier_vref_sel,	   	enable_vdda_h_and_enable_h==1'b1, enable_vdda_h_and_enable_h==1'b1);
    $setuphold (posedge HLD_H_N_REFGEN, negedge VREF_SEL[0],   		t_setup, t_hold,  notifier_vref_sel,	   	enable_vdda_h_and_enable_h==1'b1, enable_vdda_h_and_enable_h==1'b1);
    $setuphold (posedge HLD_H_N_REFGEN, posedge VREF_SEL[1],   		t_setup, t_hold,  notifier_vref_sel,	   	enable_vdda_h_and_enable_h==1'b1, enable_vdda_h_and_enable_h==1'b1);
    $setuphold (posedge HLD_H_N_REFGEN, negedge VREF_SEL[1],   		t_setup, t_hold,  notifier_vref_sel,	   	enable_vdda_h_and_enable_h==1'b1, enable_vdda_h_and_enable_h==1'b1);
    $setuphold (posedge HLD_H_N_REFGEN, posedge VREF_SEL[0],   		t_setup, t_hold,  notifier_vref_sel_int, 	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N_REFGEN, negedge VREF_SEL[0],   		t_setup, t_hold,  notifier_vref_sel_int, 	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N_REFGEN, posedge VREF_SEL[1],   		t_setup, t_hold,  notifier_vref_sel_int, 	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N_REFGEN, negedge VREF_SEL[1],   		t_setup, t_hold,  notifier_vref_sel_int, 	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N_REFGEN, posedge VOH_SEL[0],   		t_setup, t_hold,  notifier_voh_sel,	 	enable_vdda_h_and_enable_h==1'b1, enable_vdda_h_and_enable_h==1'b1);
    $setuphold (posedge HLD_H_N_REFGEN, posedge VOH_SEL[1],  		t_setup, t_hold,  notifier_voh_sel,	 	enable_vdda_h_and_enable_h==1'b1, enable_vdda_h_and_enable_h==1'b1);
    $setuphold (posedge HLD_H_N_REFGEN, posedge VOH_SEL[2],   		t_setup, t_hold,  notifier_voh_sel,	 	enable_vdda_h_and_enable_h==1'b1, enable_vdda_h_and_enable_h==1'b1);
    $setuphold (posedge HLD_H_N_REFGEN, negedge VOH_SEL[0],  		t_setup, t_hold,  notifier_voh_sel,	 	enable_vdda_h_and_enable_h==1'b1, enable_vdda_h_and_enable_h==1'b1);
    $setuphold (posedge HLD_H_N_REFGEN, negedge VOH_SEL[1],   		t_setup, t_hold,  notifier_voh_sel,	 	enable_vdda_h_and_enable_h==1'b1, enable_vdda_h_and_enable_h==1'b1);
    $setuphold (posedge HLD_H_N_REFGEN, negedge VOH_SEL[2],   		t_setup, t_hold,  notifier_voh_sel,	 	enable_vdda_h_and_enable_h==1'b1, enable_vdda_h_and_enable_h==1'b1);
    $setuphold (posedge HLD_H_N_REFGEN, posedge DFT_REFGEN,   		t_setup, t_hold,  notifier_dft_refgen,	 	enable_vdda_h_and_enable_h==1'b1, enable_vdda_h_and_enable_h==1'b1);
    $setuphold (posedge HLD_H_N_REFGEN, negedge DFT_REFGEN,   		t_setup, t_hold,  notifier_dft_refgen,	 	enable_vdda_h_and_enable_h==1'b1, enable_vdda_h_and_enable_h==1'b1);
    $setuphold (negedge ENABLE_H,   posedge HLD_H_N[0],    t_setup, t_hold,  	notifier_enable_h_0);
    $setuphold (negedge ENABLE_H,   negedge HLD_H_N[0],    t_setup, t_hold,  	notifier_enable_h_0);
    $setuphold (posedge ENABLE_H,   posedge HLD_H_N[0],    t_setup, t_hold,  	notifier_enable_h_0);
    $setuphold (posedge ENABLE_H,   negedge HLD_H_N[0],    t_setup, t_hold,  	notifier_enable_h_0);
    $setuphold (negedge HLD_H_N[0], posedge HLD_OVR[0],    t_setup, t_hold,	notifier_hld_ovr_0,   	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N[0], negedge HLD_OVR[0],    t_setup, t_hold,	notifier_hld_ovr_0,   	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N[0], posedge DM0[2],        t_setup, t_hold,  	notifier_dm_0, 		ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N[0], negedge DM0[2],        t_setup, t_hold,  	notifier_dm_0, 		ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N[0], posedge DM0[1],        t_setup, t_hold,  	notifier_dm_0, 		ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N[0], negedge DM0[1],        t_setup, t_hold,  	notifier_dm_0,		ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N[0], posedge DM0[0],        t_setup, t_hold,  	notifier_dm_0, 		ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N[0], negedge DM0[0],        t_setup, t_hold,  	notifier_dm_0, 		ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N[0], posedge INP_DIS[0],    t_setup, t_hold,	notifier_inp_dis_0,   	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N[0], negedge INP_DIS[0],    t_setup, t_hold,	notifier_inp_dis_0,   	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N[0], posedge VTRIP_SEL[0],  t_setup, t_hold,	notifier_vtrip_sel_0, 	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N[0], negedge VTRIP_SEL[0],  t_setup, t_hold,	notifier_vtrip_sel_0, 	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N[0], posedge SLOW[0],       t_setup, t_hold,	notifier_slow_0,	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N[0], negedge SLOW[0],       t_setup, t_hold,	notifier_slow_0,	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N[0], posedge OE_N[0],       t_setup, t_hold,	notifier_oe_n_0,	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N[0], negedge OE_N[0],       t_setup, t_hold,	notifier_oe_n_0,	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N[0], posedge OUT[0],        t_setup, t_hold,	notifier_out_0,		ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N[0], negedge OUT[0],        t_setup, t_hold,	notifier_out_0,		ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N[0], posedge VREG_EN[0],    t_setup, t_hold,	notifier_vreg_en_0,	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N[0], negedge VREG_EN[0],    t_setup, t_hold,	notifier_vreg_en_0,	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N[0], posedge IBUF_SEL[0],   t_setup, t_hold,	notifier_ibuf_sel_0,	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N[0], negedge IBUF_SEL[0],   t_setup, t_hold,	notifier_ibuf_sel_0,	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N[0], posedge HLD_OVR[0],    t_setup, t_hold,	notifier_hld_ovr_0,   	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N[0], negedge HLD_OVR[0],    t_setup, t_hold,	notifier_hld_ovr_0,   	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N[0], posedge DM0[2],        t_setup, t_hold,  	notifier_dm_0, 		ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N[0], negedge DM0[2],        t_setup, t_hold,  	notifier_dm_0, 		ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N[0], posedge DM0[1],        t_setup, t_hold,  	notifier_dm_0, 		ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N[0], negedge DM0[1],        t_setup, t_hold,  	notifier_dm_0,		ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N[0], posedge DM0[0],        t_setup, t_hold,  	notifier_dm_0, 		ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N[0], negedge DM0[0],        t_setup, t_hold,  	notifier_dm_0, 		ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N[0], posedge INP_DIS[0],    t_setup, t_hold,	notifier_inp_dis_0,   	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N[0], negedge INP_DIS[0],    t_setup, t_hold,	notifier_inp_dis_0,   	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N[0], posedge VTRIP_SEL[0],  t_setup, t_hold,	notifier_vtrip_sel_0, 	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N[0], negedge VTRIP_SEL[0],  t_setup, t_hold,	notifier_vtrip_sel_0, 	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N[0], posedge SLOW[0],       t_setup, t_hold,	notifier_slow_0,	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N[0], negedge SLOW[0],       t_setup, t_hold,	notifier_slow_0,	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N[0], posedge OE_N[0],       t_setup, t_hold,	notifier_oe_n_0,	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N[0], negedge OE_N[0],       t_setup, t_hold,	notifier_oe_n_0,	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N[0], posedge OUT[0],        t_setup, t_hold,	notifier_out_0,		ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N[0], negedge OUT[0],        t_setup, t_hold,	notifier_out_0,		ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N[0], posedge VREG_EN[0],    t_setup, t_hold,	notifier_vreg_en_0,	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N[0], negedge VREG_EN[0],    t_setup, t_hold,	notifier_vreg_en_0,	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N[0], posedge IBUF_SEL[0],   t_setup, t_hold,	notifier_ibuf_sel_0,	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N[0], negedge IBUF_SEL[0],   t_setup, t_hold,	notifier_ibuf_sel_0,	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge ENABLE_H,   posedge HLD_H_N[1],    t_setup, t_hold,  	notifier_enable_h_1);
    $setuphold (negedge ENABLE_H,   negedge HLD_H_N[1],    t_setup, t_hold,  	notifier_enable_h_1);
    $setuphold (posedge ENABLE_H,   posedge HLD_H_N[1],    t_setup, t_hold,  	notifier_enable_h_1);
    $setuphold (posedge ENABLE_H,   negedge HLD_H_N[1],    t_setup, t_hold,  	notifier_enable_h_1);
    $setuphold (negedge HLD_H_N[1], posedge HLD_OVR[1],    t_setup, t_hold,	notifier_hld_ovr_1,   	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N[1], negedge HLD_OVR[1],    t_setup, t_hold,	notifier_hld_ovr_1,   	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N[1], posedge DM1[2],        t_setup, t_hold,  	notifier_dm_1, 		ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N[1], negedge DM1[2],        t_setup, t_hold,  	notifier_dm_1, 		ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N[1], posedge DM1[1],        t_setup, t_hold,  	notifier_dm_1, 		ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N[1], negedge DM1[1],        t_setup, t_hold,  	notifier_dm_1,		ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N[1], posedge DM1[0],        t_setup, t_hold,  	notifier_dm_1, 		ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N[1], negedge DM1[0],        t_setup, t_hold,  	notifier_dm_1, 		ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N[1], posedge INP_DIS[1],    t_setup, t_hold,	notifier_inp_dis_1,   	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N[1], negedge INP_DIS[1],    t_setup, t_hold,	notifier_inp_dis_1,   	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N[1], posedge VTRIP_SEL[1],  t_setup, t_hold,	notifier_vtrip_sel_1, 	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N[1], negedge VTRIP_SEL[1],  t_setup, t_hold,	notifier_vtrip_sel_1, 	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N[1], posedge SLOW[1],       t_setup, t_hold,	notifier_slow_1,	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N[1], negedge SLOW[1],       t_setup, t_hold,	notifier_slow_1,	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N[1], posedge OE_N[1],       t_setup, t_hold,	notifier_oe_n_1,	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N[1], negedge OE_N[1],       t_setup, t_hold,	notifier_oe_n_1,	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N[1], posedge OUT[1],        t_setup, t_hold,	notifier_out_1,		ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N[1], negedge OUT[1],        t_setup, t_hold,	notifier_out_1,		ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N[1], posedge VREG_EN[1],    t_setup, t_hold,	notifier_vreg_en_1,	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N[1], negedge VREG_EN[1],    t_setup, t_hold,	notifier_vreg_en_1,	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N[1], posedge IBUF_SEL[1],   t_setup, t_hold,	notifier_ibuf_sel_1,	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N[1], negedge IBUF_SEL[1],   t_setup, t_hold,	notifier_ibuf_sel_1,	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N[1], posedge HLD_OVR[1],    t_setup, t_hold,	notifier_hld_ovr_1,   	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N[1], negedge HLD_OVR[1],    t_setup, t_hold,	notifier_hld_ovr_1,   	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N[1], posedge DM1[2],        t_setup, t_hold,  	notifier_dm_1, 		ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N[1], negedge DM1[2],        t_setup, t_hold,  	notifier_dm_1, 		ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N[1], posedge DM1[1],        t_setup, t_hold,  	notifier_dm_1, 		ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N[1], negedge DM1[1],        t_setup, t_hold,  	notifier_dm_1,		ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N[1], posedge DM1[0],        t_setup, t_hold,  	notifier_dm_1, 		ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N[1], negedge DM1[0],        t_setup, t_hold,  	notifier_dm_1, 		ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N[1], posedge INP_DIS[1],    t_setup, t_hold,	notifier_inp_dis_1,   	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N[1], negedge INP_DIS[1],    t_setup, t_hold,	notifier_inp_dis_1,   	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N[1], posedge VTRIP_SEL[1],  t_setup, t_hold,	notifier_vtrip_sel_1, 	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N[1], negedge VTRIP_SEL[1],  t_setup, t_hold,	notifier_vtrip_sel_1, 	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N[1], posedge SLOW[1],       t_setup, t_hold,	notifier_slow_1,	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N[1], negedge SLOW[1],       t_setup, t_hold,	notifier_slow_1,	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N[1], posedge OE_N[1],       t_setup, t_hold,	notifier_oe_n_1,	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N[1], negedge OE_N[1],       t_setup, t_hold,	notifier_oe_n_1,	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N[1], posedge OUT[1],        t_setup, t_hold,	notifier_out_1,		ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N[1], negedge OUT[1],        t_setup, t_hold,	notifier_out_1,		ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N[1], posedge VREG_EN[1],    t_setup, t_hold,	notifier_vreg_en_1,	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N[1], negedge VREG_EN[1],    t_setup, t_hold,	notifier_vreg_en_1,	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N[1], posedge IBUF_SEL[1],   t_setup, t_hold,	notifier_ibuf_sel_1,	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N[1], negedge IBUF_SEL[1],   t_setup, t_hold,	notifier_ibuf_sel_1,	ENABLE_H==1'b1, ENABLE_H==1'b1);
endspecify
assign REFGEN.NOTIFIER_ENABLE_H 	= notifier_enable_h_refgen;
assign REFGEN.NOTIFIER_VTRIP_SEL	= notifier_vtrip_sel_refgen;
assign REFGEN.NOTIFIER_VREG_EN 		= notifier_vreg_en_refgen;
assign REFGEN.NOTIFIER_IBUF_SEL		= notifier_ibuf_sel_refgen;
assign REFGEN.notifier_vref_sel		= notifier_vref_sel;
assign REFGEN.notifier_vref_sel_int	= notifier_vref_sel_int;
assign REFGEN.notifier_voh_sel		= notifier_voh_sel;
assign REFGEN.notifier_dft_refgen 	= notifier_dft_refgen;
assign SIO_PAIR_0_.NOTIFIER_ENABLE_H 	= notifier_enable_h_0;
assign SIO_PAIR_0_.NOTIFIER_HLD_OVR	= notifier_hld_ovr_0;
assign SIO_PAIR_0_.NOTIFIER_DM 		= notifier_dm_0;
assign SIO_PAIR_0_.NOTIFIER_INP_DIS 	= notifier_inp_dis_0;
assign SIO_PAIR_0_.NOTIFIER_VTRIP_SEL 	= notifier_vtrip_sel_0;
assign SIO_PAIR_0_.NOTIFIER_SLOW 	= notifier_slow_0;
assign SIO_PAIR_0_.NOTIFIER_OE_N	= notifier_oe_n_0;
assign SIO_PAIR_0_.NOTIFIER_OUT 	= notifier_out_0;
assign SIO_PAIR_0_.NOTIFIER_VREG_EN 	= notifier_vreg_en_0;
assign SIO_PAIR_0_.NOTIFIER_IBUF_SEL 	= notifier_ibuf_sel_0;
assign SIO_PAIR_1_.NOTIFIER_ENABLE_H 	= notifier_enable_h_1;
assign SIO_PAIR_1_.NOTIFIER_HLD_OVR	= notifier_hld_ovr_1;
assign SIO_PAIR_1_.NOTIFIER_DM 		= notifier_dm_1;
assign SIO_PAIR_1_.NOTIFIER_INP_DIS 	= notifier_inp_dis_1;
assign SIO_PAIR_1_.NOTIFIER_VTRIP_SEL 	= notifier_vtrip_sel_1;
assign SIO_PAIR_1_.NOTIFIER_SLOW 	= notifier_slow_1;
assign SIO_PAIR_1_.NOTIFIER_OE_N	= notifier_oe_n_1;
assign SIO_PAIR_1_.NOTIFIER_OUT 	= notifier_out_1;
assign SIO_PAIR_1_.NOTIFIER_VREG_EN 	= notifier_vreg_en_1;
assign SIO_PAIR_1_.NOTIFIER_IBUF_SEL 	= notifier_ibuf_sel_1;
sky130_fd_io__top_refgen_new REFGEN (
                                 .VOH_SEL                                      (VOH_SEL[2:0]),
                                 .VREF_SEL                                     (VREF_SEL[1:0]),
                                 .VOHREF                                       (VOHREF),
                                 .VINREF_DFT                                   (VINREF_DFT),
                                 .VOUTREF_DFT                                  (VOUTREF_DFT),
                                 .DFT_REFGEN                                   (DFT_REFGEN),
                                 .AMUXBUS_A                                    (AMUXBUS_A),
                                 .AMUXBUS_B                                    (AMUXBUS_B),
                                 .VOUTREF                                      (VOUTREF),
                                 .VREG_EN                                      (VREG_EN_REFGEN),
                                 .IBUF_SEL                                     (IBUF_SEL_REFGEN),
                                 .VINREF                                       (VINREF),
                                 .VTRIP_SEL                                    (VTRIP_SEL_REFGEN),
                                 .ENABLE_H					  (ENABLE_H),
                                 .ENABLE_VDDA_H				  (ENABLE_VDDA_H),
                                 .HLD_H_N                                      (HLD_H_N_REFGEN),
                                 .REFLEAK_BIAS                                 (REFLEAK_BIAS)
                             );
sky130_fd_io__top_sio SIO_PAIR_1_ (
                          .PAD                                          (PAD[1]),
                          .IN_H                                         (IN_H[1]),
                          .DM                                           (DM1[2:0]),
                          .HLD_H_N                                      (HLD_H_N[1]),
                          .PAD_A_ESD_1_H                                (PAD_A_ESD_1_H[1]),
                          .PAD_A_ESD_0_H                                (PAD_A_ESD_0_H[1]),
                          .ENABLE_H                                     (ENABLE_H),
                          .OUT                                          (OUT[1]),
                          .OE_N                                         (OE_N[1]),
                          .SLOW                                         (SLOW[1]),
                          .VTRIP_SEL                                    (VTRIP_SEL[1]),
                          .INP_DIS                                      (INP_DIS[1]),
                          .TIE_LO_ESD                                   (TIE_LO_ESD[1]),
                          .IN                                           (IN[1]),
                          .VINREF                                       (VINREF),
                          .VOUTREF                                      (VOUTREF),
                          .REFLEAK_BIAS                                 (REFLEAK_BIAS),
                          .PAD_A_NOESD_H                                (PAD_A_NOESD_H[1]),
                          .VREG_EN                                      (VREG_EN[1]),
                          .IBUF_SEL                                     (IBUF_SEL[1]),
                          .HLD_OVR                                      (HLD_OVR[1])
                      );
sky130_fd_io__top_sio SIO_PAIR_0_ (
                          .PAD                                          (PAD[0]),
                          .IN_H                                         (IN_H[0]),
                          .DM                                           (DM0[2:0]),
                          .HLD_H_N                                      (HLD_H_N[0]),
                          .PAD_A_ESD_1_H                                (PAD_A_ESD_1_H[0]),
                          .PAD_A_ESD_0_H                                (PAD_A_ESD_0_H[0]),
                          .ENABLE_H                                     (ENABLE_H),
                          .OUT                                          (OUT[0]),
                          .OE_N                                         (OE_N[0]),
                          .SLOW                                         (SLOW[0]),
                          .VTRIP_SEL                                    (VTRIP_SEL[0]),
                          .INP_DIS                                      (INP_DIS[0]),
                          .TIE_LO_ESD                                   (TIE_LO_ESD[0]),
                          .IN                                           (IN[0]),
                          .VINREF                                       (VINREF),
                          .VOUTREF                                      (VOUTREF),
                          .REFLEAK_BIAS                                 (REFLEAK_BIAS),
                          .PAD_A_NOESD_H                                (PAD_A_NOESD_H[0]),
                          .VREG_EN                                      (VREG_EN[0]),
                          .IBUF_SEL                                     (IBUF_SEL[0]),
                          .HLD_OVR                                      (HLD_OVR[0])
                      );
endmodule
`endif // FUNCTIONAL

`endif // USE_POWER_PINS

`default_nettype wire
`endif  // SKY130_FD_IO__TOP_SIO_MACRO_V


//--------EOF---------

/**
 * Copyright 2020 The SkyWater PDK Authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 * SPDX-License-Identifier: Apache-2.0
 */

`ifndef SKY130_FD_IO__TOP_VREFCAPV2_V
`define SKY130_FD_IO__TOP_VREFCAPV2_V

/**
 * top_vrefcapv2: External capacitor to be connected to vrefgen block output.
 *
 * Verilog top module.
 */

`timescale 1ns/1ps
`default_nettype none

module sky130_fd_io__top_vrefcapv2 ( amuxbus_a, amuxbus_b, cneg, cpos 
`ifdef USE_POWER_PINS
	, vccd, vcchib, vdda, vddio, vddio_q, vssa, vssd, vssio, vssio_q, vswitch
`endif	
	 );

`ifdef USE_POWER_PINS
  inout vssio_q;
  inout vcchib;
  inout vdda;
  inout vssa;
  inout vccd;
  inout vddio_q;
  inout vddio;
  inout vswitch;
  inout vssio;
  inout vssd;
`else 
  supply0 vssio_q;
  supply1 vcchib;
  supply1 vdda;
  supply0 vssa;
  supply1 vccd;
  supply1 vddio_q;
  supply1 vddio;
  supply1 vswitch;
  supply0 vssio;
  supply0 vssd;
`endif
  
  inout cneg;
  inout cpos;
  inout amuxbus_a;
  inout amuxbus_b;
  
//======================================================================================================================================================   

// WARNING message if cpos / cneg terminals of the capacitor are not connected externally. 

reg dis_err_msgs;
integer warning_flag_cpos, warning_flag_cneg;

event event_warning_flag_cpos, event_warning_flag_cneg;

initial
begin
  
  dis_err_msgs = 1'b1;
  warning_flag_cpos = 0;
  warning_flag_cneg = 0;
  
  `ifdef S8IOM0S8_TOP_VREFCAPV2_DIS_ERR_MSGS
  `else
    #1;
    dis_err_msgs = 1'b0;
  `endif
end

wire #100 cpos_floating = cpos===1'bz;
wire #100 cneg_floating = cneg===1'bz;

always @(cpos_floating) 
begin
  	if (!dis_err_msgs && cpos_floating===1) 
  	begin
		 $display("\n ===ERROR=== sky130_fd_io__top_vrefcapv2 :  cpos terminal is unconnected %m\n",$stime);
		 ->event_warning_flag_cpos;
	end
end

always @(cneg_floating) 
begin
  	if (!dis_err_msgs && cneg_floating===1) 
  	begin
		 $display("\n ===ERROR=== sky130_fd_io__top_vrefcapv2 :  cneg terminal is unconnected %m\n",$stime);
		 ->event_warning_flag_cneg;
	end
end


//======================================================================================================================================   
  
endmodule

`default_nettype wire
`endif  // SKY130_FD_IO__TOP_VREFCAPV2_V


//--------EOF---------

/**
 * Copyright 2020 The SkyWater PDK Authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 * SPDX-License-Identifier: Apache-2.0
 */

`ifndef SKY130_FD_IO__TOP_XRES4V2_V
`define SKY130_FD_IO__TOP_XRES4V2_V

/**
 * top_xres4v2: XRES (Input buffer with Glitch filter).
 *
 * Verilog top module.
 *
 * WARNING: This file is autogenerated, do not modify directly!
 */

`timescale 1ns / 1ps
`default_nettype none

`ifdef USE_POWER_PINS

`ifdef FUNCTIONAL
/*
 * Copyright 2020 The SkyWater PDK Authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 * SPDX-License-Identifier: Apache-2.0
*/

module sky130_fd_io__top_xres4v2 ( TIE_WEAK_HI_H,  XRES_H_N, TIE_HI_ESD, TIE_LO_ESD,
                                   AMUXBUS_A, AMUXBUS_B, PAD, PAD_A_ESD_H, ENABLE_H, EN_VDDIO_SIG_H, INP_SEL_H, FILT_IN_H,
                                   DISABLE_PULLUP_H, PULLUP_H, ENABLE_VDDIO
                                   ,VCCD, VCCHIB, VDDA, VDDIO,VDDIO_Q, VSSA, VSSD, VSSIO, VSSIO_Q, VSWITCH
                                 );
output XRES_H_N;
inout AMUXBUS_A;
inout AMUXBUS_B;
inout PAD;
input DISABLE_PULLUP_H;
input ENABLE_H;
input EN_VDDIO_SIG_H;
input INP_SEL_H;
input FILT_IN_H;
inout PULLUP_H;
input ENABLE_VDDIO;
input VCCD;
input VCCHIB;
input VDDA;
input VDDIO;
input VDDIO_Q;
input VSSA;
input VSSD;
input VSSIO;
input VSSIO_Q;
input VSWITCH;
wire mode_vcchib;
wire pwr_good_xres_tmp 	= (VDDIO===1) && (VDDIO_Q===1) && ((mode_vcchib && ENABLE_VDDIO)===1 ? VCCHIB===1 : 1'b1) &&  (VSSIO===0) && (VSSD===0);
wire pwr_good_xres_h_n 		= (VDDIO_Q===1) && (VSSD===0);
wire pwr_good_pullup 		= (VDDIO===1) && (VSSD===0);
inout PAD_A_ESD_H;
output TIE_HI_ESD;
output TIE_LO_ESD;
inout TIE_WEAK_HI_H;
wire tmp1;
pullup (pull1) p1 (tmp1); tranif1 x_pull_1 (TIE_WEAK_HI_H, tmp1, pwr_good_pullup===0  ? 1'bx : 1);
tran p2 (PAD, PAD_A_ESD_H);
buf p4 (TIE_HI_ESD, VDDIO);
buf p5 (TIE_LO_ESD, VSSIO);
wire tmp;
pullup (pull1) p3 (tmp); tranif0 x_pull (PULLUP_H, tmp, pwr_good_pullup===0 || ^DISABLE_PULLUP_H===1'bx ? 1'bx : DISABLE_PULLUP_H);
parameter MAX_WARNING_COUNT = 100;
`ifdef SKY130_FD_IO_TOP_XRES4V2_DISABLE_DELAY
parameter MIN_DELAY = 0;
parameter MAX_DELAY = 0;
`else
parameter MIN_DELAY = 50;
parameter MAX_DELAY = 600;
`endif
integer min_delay, max_delay;
initial begin
    min_delay = MIN_DELAY;
    max_delay = MAX_DELAY;
end
`ifdef SKY130_FD_IO_TOP_XRES4V2_DISABLE_ENABLE_VDDIO_CHANGE_X
parameter DISABLE_ENABLE_VDDIO_CHANGE_X = 1;
`else
parameter DISABLE_ENABLE_VDDIO_CHANGE_X = 0;
`endif
integer     disable_enable_vddio_change_x    = DISABLE_ENABLE_VDDIO_CHANGE_X;
reg notifier_enable_h;
specify
`ifdef SKY130_FD_IO_TOP_XRES4V2_DISABLE_DELAY
    specparam DELAY = 0;
`else
    specparam DELAY = 50;
`endif
    if (INP_SEL_H==0  &  ENABLE_H==0  & ENABLE_VDDIO==0 & EN_VDDIO_SIG_H==1) (PAD   => XRES_H_N) =  (0:0:0 , 0:0:0);
    if (INP_SEL_H==0  &  ENABLE_H==1  & ENABLE_VDDIO==1 & EN_VDDIO_SIG_H==1) (PAD   => XRES_H_N) =  (0:0:0 , 0:0:0);
    if (INP_SEL_H==0  &  ENABLE_H==1  & ENABLE_VDDIO==1 & EN_VDDIO_SIG_H==0) (PAD   => XRES_H_N) =  (0:0:0 , 0:0:0);
    if (INP_SEL_H==0  &  ENABLE_H==0  & ENABLE_VDDIO==0 & EN_VDDIO_SIG_H==0) (PAD   => XRES_H_N) =  (0:0:0 , 0:0:0);
    if (INP_SEL_H==1) (FILT_IN_H => XRES_H_N) =  (0:0:0 , 0:0:0);
    specparam tsetup = 0;
    specparam thold = 5;
endspecify
reg corrupt_enable;
always @(notifier_enable_h)
begin
    corrupt_enable <= 1'bx;
end
initial
begin
    corrupt_enable = 1'b0;
end
always @(PAD or ENABLE_H or EN_VDDIO_SIG_H or ENABLE_VDDIO or INP_SEL_H or FILT_IN_H or pwr_good_xres_tmp or DISABLE_PULLUP_H or PULLUP_H or TIE_WEAK_HI_H)
begin
    corrupt_enable <= 1'b0;
end
assign mode_vcchib 	= ENABLE_H && !EN_VDDIO_SIG_H;
wire xres_tmp 	= (pwr_good_xres_tmp===0 || ^PAD===1'bx || (mode_vcchib===1'bx ) ||(mode_vcchib!==1'b0 && ^ENABLE_VDDIO===1'bx) || (corrupt_enable===1'bx) ||
                  (mode_vcchib===1'b1 && ENABLE_VDDIO===0 && (disable_enable_vddio_change_x===0)))
     ? 1'bx : PAD;
wire x_on_xres_h_n = (pwr_good_xres_h_n===0
                      || ^INP_SEL_H===1'bx
                      || INP_SEL_H===1 && ^FILT_IN_H===1'bx
                      || INP_SEL_H===0 && xres_tmp===1'bx);
assign #1  XRES_H_N = x_on_xres_h_n===1 ? 1'bx : (INP_SEL_H===1 ? FILT_IN_H : xres_tmp);
realtime t_pad_current_transition,t_pad_prev_transition;
realtime t_filt_in_h_current_transition,t_filt_in_h_prev_transition;
realtime pad_pulse_width, filt_in_h_pulse_width;
always @(PAD)
begin
    if (^PAD !== 1'bx)
    begin
        t_pad_prev_transition    	= t_pad_current_transition;
        t_pad_current_transition 	= $realtime;
        pad_pulse_width 	     	= t_pad_current_transition - t_pad_prev_transition;
    end
    else
    begin
        t_pad_prev_transition 		= 0;
        t_pad_current_transition 	= 0;
        pad_pulse_width 		= 0;
    end
end
always @(FILT_IN_H)
begin
    if (^FILT_IN_H !== 1'bx)
    begin
        t_filt_in_h_prev_transition    			= t_filt_in_h_current_transition;
        t_filt_in_h_current_transition 			= $realtime;
        filt_in_h_pulse_width 	     			= t_filt_in_h_current_transition - t_filt_in_h_prev_transition;
    end
    else
    begin
        t_filt_in_h_prev_transition 			= 0;
        t_filt_in_h_current_transition 			= 0;
        filt_in_h_pulse_width 				= 0;
    end
end
reg dis_err_msgs;
integer msg_count_pad, msg_count_filt_in_h;
event event_errflag_pad_pulse_width, event_errflag_filt_in_h_pulse_width;
initial
begin
    dis_err_msgs = 1'b1;
    msg_count_pad = 0; msg_count_filt_in_h = 0;
`ifdef SKY130_FD_IO_TOP_XRES4V2_DIS_ERR_MSGS
`else
    #1;
    dis_err_msgs = 1'b0;
`endif
end
always @(pad_pulse_width)
begin
    if (!dis_err_msgs)
    begin
        if (INP_SEL_H===0 && (pad_pulse_width > min_delay) && (pad_pulse_width < max_delay))
        begin
            msg_count_pad = msg_count_pad + 1;
            ->event_errflag_pad_pulse_width;
            if (msg_count_pad <= MAX_WARNING_COUNT)
            begin
                $display(" ===WARNING=== sky130_fd_io__top_xres4v2 :  Width of Input pulse for PAD input (= %3.2f ns)  is found to be in the range: %3d ns - %3d ns. In this range, the delay and pulse suppression of the input pulse are PVT dependent. : \%m",pad_pulse_width,min_delay,max_delay,$stime);
            end
            else
                if (msg_count_pad == MAX_WARNING_COUNT+1)
                begin
                    $display(" ===WARNING=== sky130_fd_io__top_xres4v2 :  Further WARNING messages will be suppressed as the message count has exceeded 100 %m",$stime);
                end
        end
    end
end
always @(filt_in_h_pulse_width)
begin
    if (!dis_err_msgs)
    begin
        if (INP_SEL_H===1 && (filt_in_h_pulse_width > min_delay) && (filt_in_h_pulse_width < max_delay))
        begin
            msg_count_filt_in_h = msg_count_filt_in_h + 1;
            ->event_errflag_filt_in_h_pulse_width;
            if (msg_count_filt_in_h <= MAX_WARNING_COUNT)
            begin
                $display(" ===WARNING=== sky130_fd_io__top_xres4v2 :  Width of Input pulse for FILT_IN_H input (= %3.2f ns)  is found to be in the range: %3d ns - %3d ns. In this range, the delay and pulse suppression of the input pulse are PVT dependent. : \%m",filt_in_h_pulse_width,min_delay,max_delay,$stime);
            end
            else
                if (msg_count_filt_in_h == MAX_WARNING_COUNT+1)
                begin
                    $display(" ===WARNING=== sky130_fd_io__top_xres4v2 :  Further WARNING messages will be suppressed as the message count has exceeded 100 %m",$stime);
                end
        end
    end
end
endmodule
`else  // FUNCTIONAL
/*
 * Copyright 2020 The SkyWater PDK Authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 * SPDX-License-Identifier: Apache-2.0
*/

module sky130_fd_io__top_xres4v2 ( TIE_WEAK_HI_H,  XRES_H_N, TIE_HI_ESD, TIE_LO_ESD,
                                   AMUXBUS_A, AMUXBUS_B, PAD, PAD_A_ESD_H, ENABLE_H, EN_VDDIO_SIG_H, INP_SEL_H, FILT_IN_H,
                                   DISABLE_PULLUP_H, PULLUP_H, ENABLE_VDDIO
                                   ,VCCD, VCCHIB, VDDA, VDDIO,VDDIO_Q, VSSA, VSSD, VSSIO, VSSIO_Q, VSWITCH
                                 );
output XRES_H_N;
inout AMUXBUS_A;
inout AMUXBUS_B;
inout PAD;
input DISABLE_PULLUP_H;
input ENABLE_H;
input EN_VDDIO_SIG_H;
input INP_SEL_H;
input FILT_IN_H;
inout PULLUP_H;
input ENABLE_VDDIO;
input VCCD;
input VCCHIB;
input VDDA;
input VDDIO;
input VDDIO_Q;
input VSSA;
input VSSD;
input VSSIO;
input VSSIO_Q;
input VSWITCH;
wire mode_vcchib;
wire pwr_good_xres_tmp 	= (VDDIO===1) && (VDDIO_Q===1) && ((mode_vcchib && ENABLE_VDDIO)===1 ? VCCHIB===1 : 1'b1) &&  (VSSIO===0) && (VSSD===0);
wire pwr_good_xres_h_n 		= (VDDIO_Q===1) && (VSSD===0);
wire pwr_good_pullup 		= (VDDIO===1) && (VSSD===0);
inout PAD_A_ESD_H;
output TIE_HI_ESD;
output TIE_LO_ESD;
inout TIE_WEAK_HI_H;
wire tmp1;
pullup (pull1) p1 (tmp1); tranif1 x_pull_1 (TIE_WEAK_HI_H, tmp1, pwr_good_pullup===0  ? 1'bx : 1);
tran p2 (PAD, PAD_A_ESD_H);
buf p4 (TIE_HI_ESD, VDDIO);
buf p5 (TIE_LO_ESD, VSSIO);
wire tmp;
pullup (pull1) p3 (tmp); tranif0 x_pull (PULLUP_H, tmp, pwr_good_pullup===0 || ^DISABLE_PULLUP_H===1'bx ? 1'bx : DISABLE_PULLUP_H);
parameter MAX_WARNING_COUNT = 100;
`ifdef SKY130_FD_IO_TOP_XRES4V2_DISABLE_DELAY
parameter MIN_DELAY = 0;
parameter MAX_DELAY = 0;
`else
parameter MIN_DELAY = 50;
parameter MAX_DELAY = 600;
`endif
integer min_delay, max_delay;
initial begin
    min_delay = MIN_DELAY;
    max_delay = MAX_DELAY;
end
`ifdef SKY130_FD_IO_TOP_XRES4V2_DISABLE_ENABLE_VDDIO_CHANGE_X
parameter DISABLE_ENABLE_VDDIO_CHANGE_X = 1;
`else
parameter DISABLE_ENABLE_VDDIO_CHANGE_X = 0;
`endif
integer     disable_enable_vddio_change_x    = DISABLE_ENABLE_VDDIO_CHANGE_X;
reg notifier_enable_h;
specify
`ifdef SKY130_FD_IO_TOP_XRES4V2_DISABLE_DELAY
    specparam DELAY = 0;
`else
    specparam DELAY = 50;
`endif
    if (INP_SEL_H==0  &  ENABLE_H==0  & ENABLE_VDDIO==0 & EN_VDDIO_SIG_H==1) (PAD   => XRES_H_N) =  (0:0:0 , 0:0:0);
    if (INP_SEL_H==0  &  ENABLE_H==1  & ENABLE_VDDIO==1 & EN_VDDIO_SIG_H==1) (PAD   => XRES_H_N) =  (0:0:0 , 0:0:0);
    if (INP_SEL_H==0  &  ENABLE_H==1  & ENABLE_VDDIO==1 & EN_VDDIO_SIG_H==0) (PAD   => XRES_H_N) =  (0:0:0 , 0:0:0);
    if (INP_SEL_H==0  &  ENABLE_H==0  & ENABLE_VDDIO==0 & EN_VDDIO_SIG_H==0) (PAD   => XRES_H_N) =  (0:0:0 , 0:0:0);
    if (INP_SEL_H==1) (FILT_IN_H => XRES_H_N) =  (0:0:0 , 0:0:0);
    specparam tsetup = 0;
    specparam thold = 5;
    $setuphold (posedge ENABLE_VDDIO, posedge ENABLE_H,     tsetup, thold,  notifier_enable_h);
    $setuphold (negedge ENABLE_H,     negedge ENABLE_VDDIO, tsetup, thold,  notifier_enable_h);
endspecify
reg corrupt_enable;
always @(notifier_enable_h)
begin
    corrupt_enable <= 1'bx;
end
initial
begin
    corrupt_enable = 1'b0;
end
always @(PAD or ENABLE_H or EN_VDDIO_SIG_H or ENABLE_VDDIO or INP_SEL_H or FILT_IN_H or pwr_good_xres_tmp or DISABLE_PULLUP_H or PULLUP_H or TIE_WEAK_HI_H)
begin
    corrupt_enable <= 1'b0;
end
assign mode_vcchib 	= ENABLE_H && !EN_VDDIO_SIG_H;
wire xres_tmp 	= (pwr_good_xres_tmp===0 || ^PAD===1'bx || (mode_vcchib===1'bx ) ||(mode_vcchib!==1'b0 && ^ENABLE_VDDIO===1'bx) || (corrupt_enable===1'bx) ||
                  (mode_vcchib===1'b1 && ENABLE_VDDIO===0 && (disable_enable_vddio_change_x===0)))
     ? 1'bx : PAD;
wire x_on_xres_h_n = (pwr_good_xres_h_n===0
                      || ^INP_SEL_H===1'bx
                      || INP_SEL_H===1 && ^FILT_IN_H===1'bx
                      || INP_SEL_H===0 && xres_tmp===1'bx);
assign #1  XRES_H_N = x_on_xres_h_n===1 ? 1'bx : (INP_SEL_H===1 ? FILT_IN_H : xres_tmp);
realtime t_pad_current_transition,t_pad_prev_transition;
realtime t_filt_in_h_current_transition,t_filt_in_h_prev_transition;
realtime pad_pulse_width, filt_in_h_pulse_width;
always @(PAD)
begin
    if (^PAD !== 1'bx)
    begin
        t_pad_prev_transition    	= t_pad_current_transition;
        t_pad_current_transition 	= $realtime;
        pad_pulse_width 	     	= t_pad_current_transition - t_pad_prev_transition;
    end
    else
    begin
        t_pad_prev_transition 		= 0;
        t_pad_current_transition 	= 0;
        pad_pulse_width 		= 0;
    end
end
always @(FILT_IN_H)
begin
    if (^FILT_IN_H !== 1'bx)
    begin
        t_filt_in_h_prev_transition    			= t_filt_in_h_current_transition;
        t_filt_in_h_current_transition 			= $realtime;
        filt_in_h_pulse_width 	     			= t_filt_in_h_current_transition - t_filt_in_h_prev_transition;
    end
    else
    begin
        t_filt_in_h_prev_transition 			= 0;
        t_filt_in_h_current_transition 			= 0;
        filt_in_h_pulse_width 				= 0;
    end
end
reg dis_err_msgs;
integer msg_count_pad, msg_count_filt_in_h;
event event_errflag_pad_pulse_width, event_errflag_filt_in_h_pulse_width;
initial
begin
    dis_err_msgs = 1'b1;
    msg_count_pad = 0; msg_count_filt_in_h = 0;
`ifdef SKY130_FD_IO_TOP_XRES4V2_DIS_ERR_MSGS
`else
    #1;
    dis_err_msgs = 1'b0;
`endif
end
always @(pad_pulse_width)
begin
    if (!dis_err_msgs)
    begin
        if (INP_SEL_H===0 && (pad_pulse_width > min_delay) && (pad_pulse_width < max_delay))
        begin
            msg_count_pad = msg_count_pad + 1;
            ->event_errflag_pad_pulse_width;
            if (msg_count_pad <= MAX_WARNING_COUNT)
            begin
                $display(" ===WARNING=== sky130_fd_io__top_xres4v2 :  Width of Input pulse for PAD input (= %3.2f ns)  is found to be in the range: %3d ns - %3d ns. In this range, the delay and pulse suppression of the input pulse are PVT dependent. : \%m",pad_pulse_width,min_delay,max_delay,$stime);
            end
            else
                if (msg_count_pad == MAX_WARNING_COUNT+1)
                begin
                    $display(" ===WARNING=== sky130_fd_io__top_xres4v2 :  Further WARNING messages will be suppressed as the message count has exceeded 100 %m",$stime);
                end
        end
    end
end
always @(filt_in_h_pulse_width)
begin
    if (!dis_err_msgs)
    begin
        if (INP_SEL_H===1 && (filt_in_h_pulse_width > min_delay) && (filt_in_h_pulse_width < max_delay))
        begin
            msg_count_filt_in_h = msg_count_filt_in_h + 1;
            ->event_errflag_filt_in_h_pulse_width;
            if (msg_count_filt_in_h <= MAX_WARNING_COUNT)
            begin
                $display(" ===WARNING=== sky130_fd_io__top_xres4v2 :  Width of Input pulse for FILT_IN_H input (= %3.2f ns)  is found to be in the range: %3d ns - %3d ns. In this range, the delay and pulse suppression of the input pulse are PVT dependent. : \%m",filt_in_h_pulse_width,min_delay,max_delay,$stime);
            end
            else
                if (msg_count_filt_in_h == MAX_WARNING_COUNT+1)
                begin
                    $display(" ===WARNING=== sky130_fd_io__top_xres4v2 :  Further WARNING messages will be suppressed as the message count has exceeded 100 %m",$stime);
                end
        end
    end
end
endmodule
`endif // FUNCTIONAL

`else  // USE_POWER_PINS

`ifdef FUNCTIONAL
/*
 * Copyright 2020 The SkyWater PDK Authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 * SPDX-License-Identifier: Apache-2.0
*/

module sky130_fd_io__top_xres4v2 ( TIE_WEAK_HI_H,  XRES_H_N, TIE_HI_ESD, TIE_LO_ESD,
                                   AMUXBUS_A, AMUXBUS_B, PAD, PAD_A_ESD_H, ENABLE_H, EN_VDDIO_SIG_H, INP_SEL_H, FILT_IN_H,
                                   DISABLE_PULLUP_H, PULLUP_H, ENABLE_VDDIO
                                 );
wire mode_vcchib;
output XRES_H_N;
inout AMUXBUS_A;
inout AMUXBUS_B;
inout PAD;
input DISABLE_PULLUP_H;
input ENABLE_H;
input EN_VDDIO_SIG_H;
input INP_SEL_H;
input FILT_IN_H;
inout PULLUP_H;
input ENABLE_VDDIO;
supply1 vccd;
supply1 vcchib;
supply1 vdda;
supply1 vddio;
supply1 vddio_q;
supply0 vssa;
supply0 vssd;
supply0 vssio;
supply0 vssio_q;
supply1 vswitch;
wire pwr_good_xres_tmp = 1;
wire pwr_good_xres_h_n 	  = 1;
wire pwr_good_pullup 	  = 1;
inout PAD_A_ESD_H;
output TIE_HI_ESD;
output TIE_LO_ESD;
inout TIE_WEAK_HI_H;
wire tmp1;
pullup (pull1) p1 (tmp1); tranif1 x_pull_1 (TIE_WEAK_HI_H, tmp1, pwr_good_pullup===0  ? 1'bx : 1);
tran p2 (PAD, PAD_A_ESD_H);
buf p4 (TIE_HI_ESD, vddio);
buf p5 (TIE_LO_ESD, vssio);
wire tmp;
pullup (pull1) p3 (tmp); tranif0 x_pull (PULLUP_H, tmp, pwr_good_pullup===0 || ^DISABLE_PULLUP_H===1'bx ? 1'bx : DISABLE_PULLUP_H);
parameter MAX_WARNING_COUNT = 100;
`ifdef SKY130_FD_IO_TOP_XRES4V2_DISABLE_DELAY
parameter MIN_DELAY = 0;
parameter MAX_DELAY = 0;
`else
parameter MIN_DELAY = 50;
parameter MAX_DELAY = 600;
`endif
integer min_delay, max_delay;
initial begin
    min_delay = MIN_DELAY;
    max_delay = MAX_DELAY;
end
`ifdef SKY130_FD_IO_TOP_XRES4V2_DISABLE_ENABLE_VDDIO_CHANGE_X
parameter DISABLE_ENABLE_VDDIO_CHANGE_X = 1;
`else
parameter DISABLE_ENABLE_VDDIO_CHANGE_X = 0;
`endif
integer     disable_enable_vddio_change_x    = DISABLE_ENABLE_VDDIO_CHANGE_X;
reg notifier_enable_h;
specify
`ifdef SKY130_FD_IO_TOP_XRES4V2_DISABLE_DELAY
    specparam DELAY = 0;
`else
    specparam DELAY = 50;
`endif
    if (INP_SEL_H==0  &  ENABLE_H==0  & ENABLE_VDDIO==0 & EN_VDDIO_SIG_H==1) (PAD   => XRES_H_N) =  (0:0:0 , 0:0:0);
    if (INP_SEL_H==0  &  ENABLE_H==1  & ENABLE_VDDIO==1 & EN_VDDIO_SIG_H==1) (PAD   => XRES_H_N) =  (0:0:0 , 0:0:0);
    if (INP_SEL_H==0  &  ENABLE_H==1  & ENABLE_VDDIO==1 & EN_VDDIO_SIG_H==0) (PAD   => XRES_H_N) =  (0:0:0 , 0:0:0);
    if (INP_SEL_H==0  &  ENABLE_H==0  & ENABLE_VDDIO==0 & EN_VDDIO_SIG_H==0) (PAD   => XRES_H_N) =  (0:0:0 , 0:0:0);
    if (INP_SEL_H==1) (FILT_IN_H => XRES_H_N) =  (0:0:0 , 0:0:0);
    specparam tsetup = 0;
    specparam thold = 5;
endspecify
reg corrupt_enable;
always @(notifier_enable_h)
begin
    corrupt_enable <= 1'bx;
end
initial
begin
    corrupt_enable = 1'b0;
end
always @(PAD or ENABLE_H or EN_VDDIO_SIG_H or ENABLE_VDDIO or INP_SEL_H or FILT_IN_H or pwr_good_xres_tmp or DISABLE_PULLUP_H or PULLUP_H or TIE_WEAK_HI_H)
begin
    corrupt_enable <= 1'b0;
end
assign mode_vcchib 	= ENABLE_H && !EN_VDDIO_SIG_H;
wire xres_tmp 	= (pwr_good_xres_tmp===0 || ^PAD===1'bx || (mode_vcchib===1'bx ) ||(mode_vcchib!==1'b0 && ^ENABLE_VDDIO===1'bx) || (corrupt_enable===1'bx) ||
                  (mode_vcchib===1'b1 && ENABLE_VDDIO===0 && (disable_enable_vddio_change_x===0)))
     ? 1'bx : PAD;
wire x_on_xres_h_n = (pwr_good_xres_h_n===0
                      || ^INP_SEL_H===1'bx
                      || INP_SEL_H===1 && ^FILT_IN_H===1'bx
                      || INP_SEL_H===0 && xres_tmp===1'bx);
assign #1  XRES_H_N = x_on_xres_h_n===1 ? 1'bx : (INP_SEL_H===1 ? FILT_IN_H : xres_tmp);
realtime t_pad_current_transition,t_pad_prev_transition;
realtime t_filt_in_h_current_transition,t_filt_in_h_prev_transition;
realtime pad_pulse_width, filt_in_h_pulse_width;
always @(PAD)
begin
    if (^PAD !== 1'bx)
    begin
        t_pad_prev_transition    	= t_pad_current_transition;
        t_pad_current_transition 	= $realtime;
        pad_pulse_width 	     	= t_pad_current_transition - t_pad_prev_transition;
    end
    else
    begin
        t_pad_prev_transition 		= 0;
        t_pad_current_transition 	= 0;
        pad_pulse_width 		= 0;
    end
end
always @(FILT_IN_H)
begin
    if (^FILT_IN_H !== 1'bx)
    begin
        t_filt_in_h_prev_transition    			= t_filt_in_h_current_transition;
        t_filt_in_h_current_transition 			= $realtime;
        filt_in_h_pulse_width 	     			= t_filt_in_h_current_transition - t_filt_in_h_prev_transition;
    end
    else
    begin
        t_filt_in_h_prev_transition 			= 0;
        t_filt_in_h_current_transition 			= 0;
        filt_in_h_pulse_width 				= 0;
    end
end
reg dis_err_msgs;
integer msg_count_pad, msg_count_filt_in_h;
event event_errflag_pad_pulse_width, event_errflag_filt_in_h_pulse_width;
initial
begin
    dis_err_msgs = 1'b1;
    msg_count_pad = 0; msg_count_filt_in_h = 0;
`ifdef SKY130_FD_IO_TOP_XRES4V2_DIS_ERR_MSGS
`else
    #1;
    dis_err_msgs = 1'b0;
`endif
end
always @(pad_pulse_width)
begin
    if (!dis_err_msgs)
    begin
        if (INP_SEL_H===0 && (pad_pulse_width > min_delay) && (pad_pulse_width < max_delay))
        begin
            msg_count_pad = msg_count_pad + 1;
            ->event_errflag_pad_pulse_width;
            if (msg_count_pad <= MAX_WARNING_COUNT)
            begin
                $display(" ===WARNING=== sky130_fd_io__top_xres4v2 :  Width of Input pulse for PAD input (= %3.2f ns)  is found to be in the range: %3d ns - %3d ns. In this range, the delay and pulse suppression of the input pulse are PVT dependent. : \%m",pad_pulse_width,min_delay,max_delay,$stime);
            end
            else
                if (msg_count_pad == MAX_WARNING_COUNT+1)
                begin
                    $display(" ===WARNING=== sky130_fd_io__top_xres4v2 :  Further WARNING messages will be suppressed as the message count has exceeded 100 %m",$stime);
                end
        end
    end
end
always @(filt_in_h_pulse_width)
begin
    if (!dis_err_msgs)
    begin
        if (INP_SEL_H===1 && (filt_in_h_pulse_width > min_delay) && (filt_in_h_pulse_width < max_delay))
        begin
            msg_count_filt_in_h = msg_count_filt_in_h + 1;
            ->event_errflag_filt_in_h_pulse_width;
            if (msg_count_filt_in_h <= MAX_WARNING_COUNT)
            begin
                $display(" ===WARNING=== sky130_fd_io__top_xres4v2 :  Width of Input pulse for FILT_IN_H input (= %3.2f ns)  is found to be in the range: %3d ns - %3d ns. In this range, the delay and pulse suppression of the input pulse are PVT dependent. : \%m",filt_in_h_pulse_width,min_delay,max_delay,$stime);
            end
            else
                if (msg_count_filt_in_h == MAX_WARNING_COUNT+1)
                begin
                    $display(" ===WARNING=== sky130_fd_io__top_xres4v2 :  Further WARNING messages will be suppressed as the message count has exceeded 100 %m",$stime);
                end
        end
    end
end
endmodule
`else  // FUNCTIONAL
/*
 * Copyright 2020 The SkyWater PDK Authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 * SPDX-License-Identifier: Apache-2.0
*/

module sky130_fd_io__top_xres4v2 ( TIE_WEAK_HI_H,  XRES_H_N, TIE_HI_ESD, TIE_LO_ESD,
                                   AMUXBUS_A, AMUXBUS_B, PAD, PAD_A_ESD_H, ENABLE_H, EN_VDDIO_SIG_H, INP_SEL_H, FILT_IN_H,
                                   DISABLE_PULLUP_H, PULLUP_H, ENABLE_VDDIO
                                 );
wire mode_vcchib;
output XRES_H_N;
inout AMUXBUS_A;
inout AMUXBUS_B;
inout PAD;
input DISABLE_PULLUP_H;
input ENABLE_H;
input EN_VDDIO_SIG_H;
input INP_SEL_H;
input FILT_IN_H;
inout PULLUP_H;
input ENABLE_VDDIO;
supply1 vccd;
supply1 vcchib;
supply1 vdda;
supply1 vddio;
supply1 vddio_q;
supply0 vssa;
supply0 vssd;
supply0 vssio;
supply0 vssio_q;
supply1 vswitch;
wire pwr_good_xres_tmp = 1;
wire pwr_good_xres_h_n 	  = 1;
wire pwr_good_pullup 	  = 1;
inout PAD_A_ESD_H;
output TIE_HI_ESD;
output TIE_LO_ESD;
inout TIE_WEAK_HI_H;
wire tmp1;
pullup (pull1) p1 (tmp1); tranif1 x_pull_1 (TIE_WEAK_HI_H, tmp1, pwr_good_pullup===0  ? 1'bx : 1);
tran p2 (PAD, PAD_A_ESD_H);
buf p4 (TIE_HI_ESD, vddio);
buf p5 (TIE_LO_ESD, vssio);
wire tmp;
pullup (pull1) p3 (tmp); tranif0 x_pull (PULLUP_H, tmp, pwr_good_pullup===0 || ^DISABLE_PULLUP_H===1'bx ? 1'bx : DISABLE_PULLUP_H);
parameter MAX_WARNING_COUNT = 100;
`ifdef SKY130_FD_IO_TOP_XRES4V2_DISABLE_DELAY
parameter MIN_DELAY = 0;
parameter MAX_DELAY = 0;
`else
parameter MIN_DELAY = 50;
parameter MAX_DELAY = 600;
`endif
integer min_delay, max_delay;
initial begin
    min_delay = MIN_DELAY;
    max_delay = MAX_DELAY;
end
`ifdef SKY130_FD_IO_TOP_XRES4V2_DISABLE_ENABLE_VDDIO_CHANGE_X
parameter DISABLE_ENABLE_VDDIO_CHANGE_X = 1;
`else
parameter DISABLE_ENABLE_VDDIO_CHANGE_X = 0;
`endif
integer     disable_enable_vddio_change_x    = DISABLE_ENABLE_VDDIO_CHANGE_X;
reg notifier_enable_h;
specify
`ifdef SKY130_FD_IO_TOP_XRES4V2_DISABLE_DELAY
    specparam DELAY = 0;
`else
    specparam DELAY = 50;
`endif
    if (INP_SEL_H==0  &  ENABLE_H==0  & ENABLE_VDDIO==0 & EN_VDDIO_SIG_H==1) (PAD   => XRES_H_N) =  (0:0:0 , 0:0:0);
    if (INP_SEL_H==0  &  ENABLE_H==1  & ENABLE_VDDIO==1 & EN_VDDIO_SIG_H==1) (PAD   => XRES_H_N) =  (0:0:0 , 0:0:0);
    if (INP_SEL_H==0  &  ENABLE_H==1  & ENABLE_VDDIO==1 & EN_VDDIO_SIG_H==0) (PAD   => XRES_H_N) =  (0:0:0 , 0:0:0);
    if (INP_SEL_H==0  &  ENABLE_H==0  & ENABLE_VDDIO==0 & EN_VDDIO_SIG_H==0) (PAD   => XRES_H_N) =  (0:0:0 , 0:0:0);
    if (INP_SEL_H==1) (FILT_IN_H => XRES_H_N) =  (0:0:0 , 0:0:0);
    specparam tsetup = 0;
    specparam thold = 5;
    $setuphold (posedge ENABLE_VDDIO, posedge ENABLE_H,     tsetup, thold,  notifier_enable_h);
    $setuphold (negedge ENABLE_H,     negedge ENABLE_VDDIO, tsetup, thold,  notifier_enable_h);
endspecify
reg corrupt_enable;
always @(notifier_enable_h)
begin
    corrupt_enable <= 1'bx;
end
initial
begin
    corrupt_enable = 1'b0;
end
always @(PAD or ENABLE_H or EN_VDDIO_SIG_H or ENABLE_VDDIO or INP_SEL_H or FILT_IN_H or pwr_good_xres_tmp or DISABLE_PULLUP_H or PULLUP_H or TIE_WEAK_HI_H)
begin
    corrupt_enable <= 1'b0;
end
assign mode_vcchib 	= ENABLE_H && !EN_VDDIO_SIG_H;
wire xres_tmp 	= (pwr_good_xres_tmp===0 || ^PAD===1'bx || (mode_vcchib===1'bx ) ||(mode_vcchib!==1'b0 && ^ENABLE_VDDIO===1'bx) || (corrupt_enable===1'bx) ||
                  (mode_vcchib===1'b1 && ENABLE_VDDIO===0 && (disable_enable_vddio_change_x===0)))
     ? 1'bx : PAD;
wire x_on_xres_h_n = (pwr_good_xres_h_n===0
                      || ^INP_SEL_H===1'bx
                      || INP_SEL_H===1 && ^FILT_IN_H===1'bx
                      || INP_SEL_H===0 && xres_tmp===1'bx);
assign #1  XRES_H_N = x_on_xres_h_n===1 ? 1'bx : (INP_SEL_H===1 ? FILT_IN_H : xres_tmp);
realtime t_pad_current_transition,t_pad_prev_transition;
realtime t_filt_in_h_current_transition,t_filt_in_h_prev_transition;
realtime pad_pulse_width, filt_in_h_pulse_width;
always @(PAD)
begin
    if (^PAD !== 1'bx)
    begin
        t_pad_prev_transition    	= t_pad_current_transition;
        t_pad_current_transition 	= $realtime;
        pad_pulse_width 	     	= t_pad_current_transition - t_pad_prev_transition;
    end
    else
    begin
        t_pad_prev_transition 		= 0;
        t_pad_current_transition 	= 0;
        pad_pulse_width 		= 0;
    end
end
always @(FILT_IN_H)
begin
    if (^FILT_IN_H !== 1'bx)
    begin
        t_filt_in_h_prev_transition    			= t_filt_in_h_current_transition;
        t_filt_in_h_current_transition 			= $realtime;
        filt_in_h_pulse_width 	     			= t_filt_in_h_current_transition - t_filt_in_h_prev_transition;
    end
    else
    begin
        t_filt_in_h_prev_transition 			= 0;
        t_filt_in_h_current_transition 			= 0;
        filt_in_h_pulse_width 				= 0;
    end
end
reg dis_err_msgs;
integer msg_count_pad, msg_count_filt_in_h;
event event_errflag_pad_pulse_width, event_errflag_filt_in_h_pulse_width;
initial
begin
    dis_err_msgs = 1'b1;
    msg_count_pad = 0; msg_count_filt_in_h = 0;
`ifdef SKY130_FD_IO_TOP_XRES4V2_DIS_ERR_MSGS
`else
    #1;
    dis_err_msgs = 1'b0;
`endif
end
always @(pad_pulse_width)
begin
    if (!dis_err_msgs)
    begin
        if (INP_SEL_H===0 && (pad_pulse_width > min_delay) && (pad_pulse_width < max_delay))
        begin
            msg_count_pad = msg_count_pad + 1;
            ->event_errflag_pad_pulse_width;
            if (msg_count_pad <= MAX_WARNING_COUNT)
            begin
                $display(" ===WARNING=== sky130_fd_io__top_xres4v2 :  Width of Input pulse for PAD input (= %3.2f ns)  is found to be in the range: %3d ns - %3d ns. In this range, the delay and pulse suppression of the input pulse are PVT dependent. : \%m",pad_pulse_width,min_delay,max_delay,$stime);
            end
            else
                if (msg_count_pad == MAX_WARNING_COUNT+1)
                begin
                    $display(" ===WARNING=== sky130_fd_io__top_xres4v2 :  Further WARNING messages will be suppressed as the message count has exceeded 100 %m",$stime);
                end
        end
    end
end
always @(filt_in_h_pulse_width)
begin
    if (!dis_err_msgs)
    begin
        if (INP_SEL_H===1 && (filt_in_h_pulse_width > min_delay) && (filt_in_h_pulse_width < max_delay))
        begin
            msg_count_filt_in_h = msg_count_filt_in_h + 1;
            ->event_errflag_filt_in_h_pulse_width;
            if (msg_count_filt_in_h <= MAX_WARNING_COUNT)
            begin
                $display(" ===WARNING=== sky130_fd_io__top_xres4v2 :  Width of Input pulse for FILT_IN_H input (= %3.2f ns)  is found to be in the range: %3d ns - %3d ns. In this range, the delay and pulse suppression of the input pulse are PVT dependent. : \%m",filt_in_h_pulse_width,min_delay,max_delay,$stime);
            end
            else
                if (msg_count_filt_in_h == MAX_WARNING_COUNT+1)
                begin
                    $display(" ===WARNING=== sky130_fd_io__top_xres4v2 :  Further WARNING messages will be suppressed as the message count has exceeded 100 %m",$stime);
                end
        end
    end
end
endmodule
`endif // FUNCTIONAL

`endif // USE_POWER_PINS

`default_nettype wire
`endif  // SKY130_FD_IO__TOP_XRES4V2_V


//--------EOF---------

