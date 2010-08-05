module carry_look_ahead_4bit(a,b,c_in,sum,c_out);
input [3:0] a,b;
input c_in;

output [3:0] sum;
output c_out;

wire [3:0] g,p,c;

assign g[3:0] = {a[3]&b[3],a[2]&b[2],a[1]&b[1],a[0]&b[0]} ; 
assign p[3:0] = {a[3]^b[3],a[2]^b[2],a[1]^b[1],a[0]^b[0]} ;
assign c[1] = g[0] + p[0]&c_in;
assign c[2] = g[0]&p[1] + p[0]&c_in&p[1] +g[1];
assign c[3] = g[0]&p[1]&p[2] +p[0]&c_in&p[1]&p[2] +g[1]&p[2] +g[2];
assign c_out = g[0]&p[1]&p[2]&p[3] +p[0]&c_in&p[1]&p[2]&p[3] +g[1]&p[2]&p[3] +g[2]&p[3] +g[3];

assign sum = {p[3]^c[3],p[2]^c[2],p[1]^c[1],p[0]^c_in };
endmodule
