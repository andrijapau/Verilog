module display_encoding(KEY1,KEY0,SW,HEX5,HEX4,HEX3,HEX2,HEX1,HEX0,LEDR);

	input KEY1,KEY0;
	input [8:0]SW;
	output LEDR[9:0];
	output [5:0]HEX5,HEX4,HEX3,HEX2,HEX1,HEX0;

	wire [7:0]Q,S;
	assign LEDR[9:1] = 0;

	D_Pos_FF_Reset FF(SW[7:0],KEY0,Q,SW[8]);
	Eightbit_ripple add(SW[7:0],Q,0,S,LEDR[0];
	hexdisp S1(S[7:4],HEX5);
	hexdisp S0(S[3:0],HEX4);
	hexdisp A1(Q[7:4],HEX3);
	hexdisp A0(Q[3:0],HEX2);
	hexdisp B1(SW[7:4],HEX1);
	hexdisp B0(SW[3:0],HEX0);

endmodule

module hexdisp(h,Display)
	input [3:0]h;
	output reg [6:0]Display;

	always @(*)
		case (h)
			4'h0: Display = 7'b100_0000;
			4'h1: Display = 7'b111_1001;
			4'h2: Display = 7'b010_0100;
         4'h3: Display = 7'b011_0000;
         4'h4: Display = 7'b001_1001;
         4'h5: Display = 7'b001_0010;
         4'h6: Display = 7'b000_0010;
         4'h7: Display = 7'b111_1000;
         4'h8: Display = 7'b000_0000;
         4'h9: Display = 7'b001_1000;
         4'hA: Display = 7'b000_1000;
         4'hB: Display = 7'b000_0011;
         4'hC: Display = 7'b100_0110;
         4'hD: Display = 7'b010_0001;
         4'hE: Display = 7'b000_0110;
         4'hF: Display = 7'b000_1110;
         default: Display = 7'h7f;
		endcase
endmodule
