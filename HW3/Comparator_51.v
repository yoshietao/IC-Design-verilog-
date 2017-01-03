`timescale 1ns/1ps
module COMPARATOR_51(median, i0, i1, i2, i3, i4);
	//DO NOT CHANGE!
	output [2:0] median;
	input  [5:0] i0, i1, i2, i3, i4;
	//---------------------------------------------------
	//Write your design here
	//assign median = 3'b011;
	wire [9:0] temp, ntemp; 
	wire [4:0] ct;
	
	xorctrl X0(i0,i1,temp[0]);
	xorctrl X1(i0,i2,temp[1]);
	xorctrl X2(i0,i3,temp[2]);
	xorctrl X3(i0,i4,temp[3]);
	xorctrl X4(i1,i2,temp[4]);
	xorctrl X5(i1,i3,temp[5]);
	xorctrl X6(i1,i4,temp[6]);
	xorctrl X7(i2,i3,temp[7]);
	xorctrl X8(i2,i4,temp[8]);
	xorctrl X9(i3,i4,temp[9]);
	
	IV v0(ntemp[0], temp[0]);
	IV v1(ntemp[1], temp[1]);
	IV v2(ntemp[2], temp[2]);
	IV v3(ntemp[3], temp[3]);
	IV v4(ntemp[4], temp[4]);
	IV v5(ntemp[5], temp[5]);
	IV v6(ntemp[6], temp[6]);
	IV v7(ntemp[7], temp[7]);
	IV v8(ntemp[8], temp[8]);
	IV v9(ntemp[9], temp[9]);
	
	CK k0(ct[0], temp[0], temp[1], temp[2], temp[3]);
	CK k1(ct[1], ntemp[0], temp[4], temp[5], temp[6]);
	CK k2(ct[2], ntemp[1], ntemp[4], temp[7], temp[8]);
	CK k3(ct[3], ntemp[2], ntemp[5], ntemp[7], temp[9]);
	CK k4(ct[4], ntemp[3], ntemp[6], ntemp[8], ntemp[9]);
	
	PDEC p0(median, ct);
endmodule



module xorctrl(
	input [8:0] A,
	input [8:0] B,
	output      out
);
	wire [5:0] C;
	wire [5:0] D;
	
	EO xor1(.Z(C[0]),
			.A(A[0]),
			.B(B[0]));
	MUX21H mux1(.Z(D[0]),
				.A(0),
				.B(A[0]),
				.CTRL(C[0]));
	EO xor2(.Z(C[1]),
			.A(A[1]),
			.B(B[1]));
	MUX21H mux2(.Z(D[1]),
				.A(D[0]),
				.B(A[1]),
				.CTRL(C[1]));
	EO xor3(.Z(C[2]),
			.A(A[2]),
			.B(B[2]));
	MUX21H mux3(.Z(D[2]),
				.A(D[1]),
				.B(A[2]),
				.CTRL(C[2]));
	EO xor4(.Z(C[3]),
			.A(A[3]),
			.B(B[3]));
	MUX21H mux4(.Z(D[3]),
				.A(D[2]),
				.B(A[3]),
				.CTRL(C[3]));
	EO xor5(.Z(C[4]),
			.A(A[4]),
			.B(B[4]));
	MUX21H mux5(.Z(D[4]),
				.A(D[3]),
				.B(A[4]),
				.CTRL(C[4]));
	EO xor6(.Z(C[5]),
			.A(A[5]),
			.B(B[5]));
	MUX21H mux6(.Z(out),
				.A(D[4]),
				.B(A[5]),
				.CTRL(C[5]));
        
endmodule

module CK(Z, A, B, C, D);	//1.065
	output	Z;
	input	A, B, C, D;
	wire	U, V, W, X, Y;
	
	EO e0(U, A, B);			//0.343
	EO e1(V, C, D);
	EO e2(W, U, V);			//0.686
	
	AN4 a0(X, A, B, C, D);	//0.371
	NR4	n0(Y, A, B, C, D);	//0.345
	NR3 n1(Z, W, X, Y);		//0.716+0.349
endmodule

module PDEC(A, B);	//1.065
	output	[2:0] A;
	input	[4:0] B;
	
	EO e0(A[0], B[1], B[3]);
	EO e1(A[1], B[2], B[3]);
    MUX21H m0(A[2],0,1,B[4]);
endmodule












