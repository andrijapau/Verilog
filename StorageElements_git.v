module storage_elements(D,Clock,Q1,Q2,Q3);

	input D,Clock;
	output Q1,Q2,Q3;

	D_Latch DL(D, Clock, Q1);
	D_Positive_FF DP(D, Clock, Q2);
	D_Negative_FF DN(D, Clock, Q3);

endmodule

module D_Latch(D, clock, Q);

	input D, clock;
	output reg Q;
	always @(D,clock)
		begin
			if (clock == 1) begin
				Q = D;
				end
		end

endmodule

module D_Positive_FF(D, clock, Q);
	input D, clock;
	output reg Q;
	always @(posedge clock)
		begin
			Q <= D;
		end
endmodule

module D_Negative_FF(D, clock, Q);

	input D, clock;
	output reg Q;
	always @(negedge clock)
		begin
			Q <= D;
		end

endmodule
