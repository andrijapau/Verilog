module Eightbit_ripple(B,A,cin,S,cout);

	input [7:0]B,A;
	input cin;
	output [9:0]S;
	output cout;

	wire(c1,c2,c3,c4,c5,c6,c7,c8);

	fulladder FA0(B[0],A[0],cin,c1,S[0]);
	fulladder FA1(B[1],A[1],c1,c2,S[1]);
	fulladder FA2(B[2],A[2],c2,c3,S[2]);
	fulladder FA3(B[3],A[3],c3,c4,S[3]);
	fulladder FA4(B[4],A[4],c4,c5,S[4]);
	fulladder FA5(B[5],A[5],c5,c6,S[5]);
	fulladder FA6(B[6],A[6],c6,c7,S[6]);
	fulladder FA7(B[7],A[7],c7,cout,S[7]);

endmodule

module fulladder(b,a,ci,co,s);

	input b,a,ci;
	output co,s;

	assign co = (a&ci)|(b&ci)|(b&a);
	assign s = a^b^ci;

endmodule


module D_Pos_FF_Reset(D,clock,Q,resetN);
	input D, clock, resetN;
	output reg Q;
	always @(posedge clock or negedge resetN) begin
		if (resetN == 0) begin
			Q <= 1'b0;
		else
			Q <= D;
		end
	end
endmodule

module Eightbit_counter_TFF(KEY0,SW,HEX1,HEX0);
	input KEY0;
	input [1:0]SW;
	output [6:0]HEX1,HEX0;

	wire q1,q2,q3,q4,q5,q6,q7,q8,x1,x2,x3,x4,x5,x6,x7,x8;
	wire [4:0] h1,h0;

	// Need 8 Flip Flops for the counter, note that the output (xi) of Si becomes the input of S(i+1)
	D_FF S0(SW[1],KEY0,SW[0],q1,x1);
	D_FF S1(x1,KEY0,SW[0],q2,x2);
	D_FF S2(x2,KEY0,SW[0],q3,x3);
	D_FF S3(x3,KEY0,SW[0],q4,x4);
	D_FF S4(x4,KEY0,SW[0],q5,x5);
	D_FF S5(x5,KEY0,SW[0],q6,x6);
	D_FF S6(x6,KEY0,SW[0],q7,x7);
	D_FF S7(x7,KEY0,SW[0],q8,x8);

	// Assigning the hex display
	assign h0 = {q4,q3,q2,q1};
	assign h1 = {q8,q7,q6,q5};

	hexdisp H0(h0,HEX0);
	hexdisp H1(h1,HEX1);

endmodule

module D_FF(E,clock,ResetN,q,X);
	input E,clock,ResetN;
	output X;
	output reg q;
	always@(negedge ResetN or posedge clock)
	begin
		if(~ResetN)  // if
			q<=1'b0;
		else
			q<=E;
	end
	assign X = E&q;
endmodule

module counter(SW,KEY0,HEX3,HEX2,HEX1,HEX0);
	input SW[1],SW[0],KEY0;
	output [6:0]HEX3,HEX2,HEX1,HEX0;

	wire [15:0]Q;

	counter_accum S1(Q,SW[1],KEY0,SW[0]);

	hexdisp H3(Q[15:12],HEX3);
	hexdisp H2(Q[11:8],HEX2);
	hexdisp H1(Q[7:4],HEX1);
	hexdisp H0(Q[3:0],HEX0);
endmodule

module counter_accum(out,enable,clock,reset);
	input enables,clock,reset;
	output [15:0] out;

	reg [7:0] out;

	always@(posedge clock)
		if (reset)
			out <= 8'b0;
		else if (enable)
			out <= out + 1;
endmodule
