/*
v2: 2009-06-01 removing the timing thing and bringing in donext input.
could use the multbusyFlag to ensure moutiplication corruption doesn't happen because of 20 cycle restriction being breached. But not doing this now.


v1: 2009-05-28 this is a systolic element only. Uses `include to put the right coeffs.
also makes use of mult and multALU units.


v0 2009-05-26: not taking care of positioning (2t/L-1)

*/

module systolic_PE1(inputword,outputword,clk30x,donext,reset);

`include "systolic_PE_core1.v"

`include "C_row1.v"

`include "systolic_PE_core2.v"