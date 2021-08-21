module top #(parameter K = 20, K_float = 32'h41a00000, L = 24, M = 32'h45bb8000,
	threshold = 32'h2000000)
	(input clk, input txe, input rxf, output rd, output wr,
	input [15:0] x_in, inout [7:0] data_out, /*output [3:0] test,*/ output adc_clk);
parameter USB_send_ticks = 16;
//wire [9:0] inner_clk;
wire ready_trapezoidal;
wire USBStartTrapezoidal;
wire [31:0] y;
wire [31:0] pulse_height;
wire ready;
reg send = 0;
reg [5:0] USBcounter = 0;
reg [31:0] pulse_height_inner = 0;
reg start = 0;
reg [15:0] x_inner = 0;

wire rd_send;
wire rd_recv;
wire wr_send;
wire wr_recv;

assign rd = USBStartTrapezoidal ? rd_send : rd_recv;
assign wr = USBStartTrapezoidal ? wr_send : wr_recv;

/*assign test[0] = x_in[10];
assign test[1] = x_in[11];
assign test[2] = x_in[12];
assign test[3] = x_in[13];*/
//assign adc_clk = clk;

trapezoidal_filter  #(K, K_float, L, M)
	filter(.clk(clk & USBStartTrapezoidal), .x_in({16'h0, x_inner}), .y(y), .ready(ready_trapezoidal));
measure_pulse_height #(K, L) meas(.clk(clk & USBStartTrapezoidal), .y(y), .threshold(threshold),
	.start(ready_trapezoidal), .pulse_height(pulse_height), .ready(ready));
Send_Data_via_USB send_data(.clk(clk), .txe(txe), .data_in(pulse_height_inner),
	.rd(rd_send), .wr(wr_send), .data_out(data_out), .send(send));
Receive_Start_via_USB recv_start(.clk(clk & ~USBStartTrapezoidal), .data_in(data_out), .rxf(rxf),
	.rd(rd_recv), .wr(wr_recv), .Start(USBStartTrapezoidal));

//test_bench test(.clk(clk), .pulse_height(pulse_height), .ready(ready));
/*exp_test_bench test(.clk(inner_clk), .rxf(rxf),
	.txe(txe), .rd(rd), .wr(wr), .data_out(data_out));*/
//down_counter counter(.clock(clk), .q(inner_clk));
pll_config pll(.inclk0(clk), .c0(adc_clk));
	
always @(posedge clk)
begin
	if(USBStartTrapezoidal)
		if(ready)
		begin
			USBcounter <= USB_send_ticks;
			send <= 1;
			pulse_height_inner <= pulse_height;
		end
		else
			if (USBcounter > 0)
				USBcounter <= USBcounter - 1;
			else
				send <= 0;
end

always @(negedge adc_clk)
begin
	if (~USBStartTrapezoidal || ((start == 0) && (ready_trapezoidal == 1)))
	begin
		x_inner <= x_in;
		start <= 1;
	end
	else
	if ((start == 1) && (ready_trapezoidal == 0))
	begin
		start <= 0;
	end
end	
endmodule

module exp_test_bench #(parameter size = 1000, K = 6,
	K_float = 32'h40c00000, L = 24, M = 32'h42480000)
	(input clk, input rxf, input txe, output rd, output wr, inout [7:0] data_out);
parameter USB_send_ticks = 16;
parameter temp_count = 512;
reg [31:0] x = 0;
reg [16:0] counter = 0;
reg [31:0] input_signal [size-1:0];
reg send = 0;
reg [5:0] USBcounter = 0;
reg [31:0] pulse_height_inner = 0;
reg [31:0] temp_counter = 0;
wire [31:0] pulse_height;
wire [31:0] y;
wire ready_trapezoidal;
wire ready;
wire USBStartTrapezoidal;

wire rd_send;
wire rd_recv;
wire wr_send;
wire wr_recv;

assign rd = USBStartTrapezoidal ? rd_send : rd_recv;
assign wr = USBStartTrapezoidal ? wr_send : wr_recv;

trapezoidal_filter #(K, K_float, L, M) filter(.clk(clk & USBStartTrapezoidal), .x_in(x), .y(y),
	.ready(ready_trapezoidal));
measure_pulse_height #(K, L) meas(.clk(clk & USBStartTrapezoidal), .y(y), .threshold(32'h64C),
	.start(ready_trapezoidal), .pulse_height(pulse_height), .ready(ready));
Send_Data_via_USB send_data(.clk(clk), .txe(txe), .data_in(pulse_height_inner),
	.rd(rd_send), .wr(wr_send), .data_out(data_out), .send(send));
Receive_Start_via_USB recv_start(.clk(clk & ~USBStartTrapezoidal), .data_in(data_out), .rxf(rxf),
	.rd(rd_recv), .wr(wr_recv), .Start(USBStartTrapezoidal));
	
initial begin
	$readmemh("input.hex", input_signal);
	x = input_signal[0];
end

always @(posedge clk)
begin
	if(USBStartTrapezoidal)
		if(ready)
		begin
			USBcounter <= USB_send_ticks;
			send <= 1;
			pulse_height_inner <= pulse_height;
		end
		else
			if (USBcounter > 0)
				USBcounter <= USBcounter - 1;
			else
				send <= 0;
end

always @(posedge ready_trapezoidal)
begin
	x <= input_signal[counter + 1];
	if (counter == size - 1)
		counter <= 0;
	else
		counter <= counter + 1;
end
endmodule

module test_bench #(parameter n = 16, size = 256, slope_rising_step = 1)
	(input clk,	output [n-1:0] pulse_height, output ready);

reg [n-1:0] trapezoidal_signal [size-1:0];
reg [n-1:0] output_signal = 0;
reg [n-1:0] pulse_height_inner = 0;
reg ready_inner = 0;
reg [n-1:0] counter = 0;
reg [n-1:0] i = 0;

measure_pulse_height #(n, size / 9, 2 * size / 9)
	meas (.clk(clk), .y(output_signal), .threshold(16'h00),
	.pulse_height(pulse_height), .ready(ready));
	
initial begin
	for (i = 0; i < size / 3; i = i + 1)
	begin
		trapezoidal_signal[i] = 0;
	end
	for (i = 2 * size / 3; i < size; i = i + 1)
	begin
		trapezoidal_signal[i] = 0;
	end
	
	for (i = size / 3; i < 4 * size / 9; i = i + 1)
	begin
		trapezoidal_signal[i] = trapezoidal_signal[i - 1] + slope_rising_step;
	end
	for (i = 4 * size / 9; i < 5 * size / 9; i = i + 1)
	begin
		trapezoidal_signal[i] = trapezoidal_signal[i - 1];
	end
	for (i = 5 * size / 9; i < 2 * size / 3; i = i + 1)
	begin
		trapezoidal_signal[i] = trapezoidal_signal[i - 1] - slope_rising_step;
	end
end

always @(posedge clk)
begin
	output_signal = trapezoidal_signal[counter];
	counter = counter + 1;
	if (counter == size)
		counter = 0;
end
endmodule

// K_float, M - 32-bit floating point numbers
module trapezoidal_filter #(parameter K = 6, K_float = 32'h40c00000, L = 24, M = 32'h42480000)
	(input clk, input [31:0] x_in, output [31:0] y, output ready);
parameter sub = 0;
parameter add = 1;

// States
parameter Start = 0;
parameter StartSubLfromX = 1;
parameter WaitSubLfromX = 2;
parameter WaitSubKfromX = 3;
parameter WaitAddZezofromX = 4;
parameter WaitAddAtoB = 5;
parameter WaitMulC = 6;
parameter WaitAddC = 7;
parameter WaitAddY = 8;
parameter WaitDivYbyK = 9;
parameter WaitDivYbyM = 10;
parameter WaitConversionY = 11;
parameter WaitConversionX = 12;
parameter WaitForNextX = 13;

parameter ConversionLatency = 7;
	
reg [31:0] a = 0;
reg [31:0] b = 0;
reg [31:0] c = 0;
reg [31:0] y_inner = 0;
//reg [31:0] y_inner_output = 0;
wire signed [31:0] x_inner;
wire signed [31:0] y_conv;
reg [31:0] delay = 0;
reg [31:0] delayed_xs [K + L - 1:0];
reg [31:0] i = 0;
reg ready_inner = 0;
assign y = ready_inner ? y_conv : 0;
assign ready = ready_inner;
reg [3:0] state = Start;
reg [31:0] counter = 0;

reg [31:0] addSubLeftArg, addSubRightArg;
reg addSubOperation = sub;
reg addSubLoadRegisters = 0;
reg addSubReset = 0;
wire [2:0] addSubStatus;
wire addSubBusy;
wire [31:0] addSubResult;
	
Float32Add adder(.CLK(clk), .nRST(addSubReset), .leftArg(addSubLeftArg), .rightArg(addSubRightArg),
	.addSub(addSubOperation), .loadArgs(addSubLoadRegisters), .status(addSubStatus),
	.busy(addSubBusy), .sum(addSubResult));
	
reg mulReset = 0;
reg [31:0] mulLeftArg, mulRightArg;
reg mulLoadArgs = 0;
wire [2:0] mulStatus;
wire mulBusy;
wire [31:0] mulResult;
	
Float32Mul multiplier(.CLK(clk), .nRST(mulReset), .leftArg(mulLeftArg), .rightArg(mulRightArg),
	.loadArgs(mulLoadArgs), .status(mulStatus), .busy(mulBusy), .product(mulResult));

/*reg divReset = 0;
reg [31:0] divLeftArg, divRightArg;
reg divLoadArgs = 0;
wire [2:0] divStatus;
wire divBusy;
wire [31:0] divResult;*/
	
/*Float32Div divider(.CLK(clk), .nRST(divReset), .leftArg(divLeftArg), .rightArg(divRightArg),
	.loadArgs(divLoadArgs), .status(divStatus), .busy(divBusy), .quotient(divResult));*/
	
float_to_int_converter yficonverter(.clock(clk), .dataa(y_inner), .result(y_conv));
int_to_float_converter xifconverter(.clock(clk), .dataa(x_in), .result(x_inner));

always @(posedge clk)
begin
	case (state)
	Start: begin
		addSubReset <= 1;
		mulReset <= 1;
		//divReset <= 1;
		ready_inner <= 0;
		counter <= 0;
		state <= WaitConversionX;
	end
	
	WaitForNextX: begin
		state <= WaitConversionX;
	end
	
	WaitConversionX: begin
		ready_inner <= 0;
		if (counter < ConversionLatency)
			counter <= counter + 1;
		else
		begin
			if (delay > (K + L - 1))
			begin
				counter <= 0;
				state <= StartSubLfromX;
			end
			else
			begin
				counter <= 0;
				delayed_xs[delay] <= x_inner;
				delay <= delay + 1;
			end
		end
	end
	
	// a
	StartSubLfromX: begin
		addSubOperation <= sub;
		addSubLeftArg <= x_inner;
		addSubRightArg <= delayed_xs[L];
		addSubLoadRegisters <= 1;
		state <= WaitSubLfromX;
	end
	
	WaitSubLfromX:
		if (addSubLoadRegisters)
			addSubLoadRegisters <= 0;
		else
			if (~addSubBusy)
			begin
				addSubOperation <= sub;
				addSubLeftArg <= addSubResult;
				addSubRightArg <= delayed_xs[K];
				addSubLoadRegisters <= 1;
				state <= WaitSubKfromX;
			end
			
	WaitSubKfromX:
		if (addSubLoadRegisters)
			addSubLoadRegisters <= 0;
		else
			if (~addSubBusy)
			begin
				addSubOperation <= add;
				addSubLeftArg <= addSubResult;
				addSubRightArg <= delayed_xs[0];
				addSubLoadRegisters <= 1;
				state <= WaitAddZezofromX;
			end
	
	WaitAddZezofromX:
		if (addSubLoadRegisters)
			addSubLoadRegisters <= 0;
		else
			if (~addSubBusy)
			begin
				a <= addSubResult;
				// b
				addSubOperation <= add;
				addSubLeftArg <= addSubResult;
				addSubRightArg <= b;
				addSubLoadRegisters <= 1;
				state <= WaitAddAtoB;
			end
	
	WaitAddAtoB:
		if (addSubLoadRegisters)
			addSubLoadRegisters <= 0;
		else
			if (~addSubBusy)
			begin
				b <= addSubResult;
				// c
				mulLeftArg <= a;
				mulRightArg <= M;
				mulLoadArgs <= 1;
				state <= WaitMulC;
			end
			
	WaitMulC:
		if (mulLoadArgs)
			mulLoadArgs <= 0;
		else
			if (~mulBusy)
			begin
				addSubOperation <= add;
				addSubLeftArg <= b;
				addSubRightArg <= mulResult;
				addSubLoadRegisters <= 1;
				state <= WaitAddC;
			end
	
	WaitAddC:
		if (addSubLoadRegisters)
			addSubLoadRegisters <= 0;
		else
			if (~addSubBusy)
			begin
				c <= addSubResult;
				// y
				addSubOperation <= add;
				addSubLeftArg <= y_inner;
				addSubRightArg <= addSubResult;
				addSubLoadRegisters <= 1;
				state <= WaitAddY;
			end
	
	WaitAddY:
		if (addSubLoadRegisters)
			addSubLoadRegisters <= 0;
		else
			if (~addSubBusy)
			begin
				y_inner <= addSubResult;
				/*divLeftArg <= addSubResult;
				divRightArg <= K_float;
				divLoadArgs <= 1;*/
				state <= WaitConversionY;
			end
	
	/*WaitDivYbyK:
		if (divLoadArgs)
			divLoadArgs <= 0;
		else
			if (~divBusy)
			begin
				divLeftArg <= divResult;
				divRightArg <= M;
				divLoadArgs <= 1;
				state <= WaitDivYbyM;
			end
	
	WaitDivYbyM:
		if (divLoadArgs)
			divLoadArgs <= 0;
		else
			if (~divBusy)
			begin
				y_inner_output <= divResult;
				counter <= 0;
				state <= WaitConversionY;
			end*/
	
	WaitConversionY:
		if (counter < ConversionLatency)
			counter <= counter + 1;
		else
		begin
			ready_inner <= 1;
			counter <= 0;
			state <= WaitForNextX;
			
			// Add new x to delayed_xs
			for (i = 0; i < K + L - 1; i = i + 1)
			begin
				delayed_xs[i] <= delayed_xs[i + 1];
			end
			delayed_xs[K + L - 1] <= x_inner;
		end
	endcase
end
endmodule

module measure_pulse_height #(parameter K = 6, L = 24)
	(input clk, input signed [31:0] y, input [31:0] threshold, input start,
	output signed [31:0] pulse_height, output ready);
parameter Start = 0;
parameter Search_left_edge = 1;
parameter Search_right_edge = 2;

reg signed [31:0] prev_y = 0;
reg signed [31:0] pulse_height_inner = 0;
reg ready_inner = 0;
reg [1:0] state = Start;
reg first_y_read = 0;
reg [31:0] counter = 0;
reg wait_start = 0;

assign pulse_height = pulse_height_inner;
assign ready = ready_inner;

always @(posedge clk)
begin
	if (ready_inner)
		ready_inner <= 0;
	if (start)
		if (~wait_start)
			wait_start <= 1;
		else
		begin
			case (state)
			Start: begin
				ready_inner <= 0;
				pulse_height_inner <= 0;
				if (first_y_read == 0)
					first_y_read <= 1;
				else
					if ((y > prev_y) && (y - prev_y > threshold))
						state <= Search_left_edge;
			end
			
			Search_left_edge:
				if (((y > prev_y) && (y - prev_y < threshold)) || ((y < prev_y) && (prev_y - y < threshold)) || (y == prev_y))
				begin
					counter <= 0;
					state <= Search_right_edge;
					pulse_height_inner <= y + prev_y;
				end
			
			Search_right_edge:
				if (K >= L)
					if ((counter < (K - L)) /*&& (((y >= prev_y) && (y - prev_y < threshold)) || ((y <= prev_y) && (prev_y - y < threshold)))*/)
					begin
						pulse_height_inner <= pulse_height_inner + y;
						counter <= counter + 1;
					end
					else
					begin
						//if (counter == (K - L))
							//pulse_height_inner <= pulse_height_inner / (K - L + 2);
						//else
							//pulse_height_inner <= pulse_height_inner / (counter + 2);
						ready_inner <= 1;
						state <= Start;
					end
				else
					if ((counter < (L - K)) /*&& (((y >= prev_y) && (y - prev_y < threshold)) || ((y <= prev_y) && (prev_y - y < threshold)))*/)
					begin
						pulse_height_inner <= pulse_height_inner + y;
						counter <= counter + 1;
					end
					else
					begin
						//if (counter == (L - K))
							//pulse_height_inner <= pulse_height_inner / (L - K + 2);
						//else
							//pulse_height_inner <= pulse_height_inner / (counter + 2);
						ready_inner <= 1;
						state <= Start;
					end
		endcase
		prev_y <= y;
		wait_start <= 0;
	end
end
endmodule

module Send_Data_via_USB(input clk, input txe, input [31:0] data_in,
	input send, output rd, output wr, output [7:0] data_out);
parameter counter_freq = 1;
//parameter temp_count = 512;

reg rd_inner = 1;
reg wr_inner = 1;
reg [7:0] data = 0;
reg [1:0] counter = counter_freq;
reg [1:0] counter_octet = 0;
//reg [31:0] temp_counter = 0;

assign rd = rd_inner;
assign wr = wr_inner;
assign data_out = data;

always @(posedge clk)
begin
	/*if(temp_counter < temp_count)
		temp_counter <= temp_counter + 1;
	else
	begin*/
	if(~txe && send)
		if(counter)
		begin
			counter <= counter - 1;
			if(wr_inner)
			begin
				data <= data_in >> (8 * counter_octet);
				counter_octet <= counter_octet + 1;
			end
		end
		else
		begin
			wr_inner <= ~wr_inner;
			counter <= counter_freq;
		end
		//temp_counter <= 0;
	//end
end
endmodule

module Receive_Start_via_USB(input clk, input [7:0] data_in,
	input rxf, output rd, output wr, output Start);
parameter start = 0;
parameter get_data = 1;
parameter stop = 2;
parameter Start_template = 8'h00;

reg rd_inner = 1;
reg wr_inner = 1;
reg [1:0] state = start;
reg [7:0] data = 0;
reg Start_inner = 0;

assign rd = rd_inner;
assign wr = wr_inner;
assign Start = Start_inner;

always @(posedge clk)
begin
	case(state)
	start: begin
		if(~rxf && rd_inner)
		begin
			rd_inner <= 0;
			state <= get_data;
		end
	end
	get_data: begin
		data <= data_in;
		state <= stop;
	end
	stop: begin
		rd_inner <= 1;
		if (rxf)
			if (data != Start_template)
				state <= start;
			else
				Start_inner <= 1;
	end
	endcase
end
endmodule