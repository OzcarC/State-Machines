`timescale 1ns/1ps

module dFF(
    input D, clk, reset,
    output reg Q
);
    always @(posedge clk) begin
        if(~reset) begin
            Q<=0;
        end
        else
            Q <=D;
    end
endmodule

module mooreSM(
    input in, clk, reset, 
    output [2:0] out
);

    wire out0,out2;

    wire ps0,ps1, ps0_bar, ps1_bar, in_bar;
    wire ns0,ns1;
    wire top_ns0,bot_ns0, top_ns1, bot_ns1;

    not(ps0_bar,ps0);
    not(ps1_bar,ps1);
    not(in_bar,in);

    and(top_ns1, ps1,in_bar);
    and(bot_ns1, in, ps0);
    or(ns1,top_ns1,bot_ns1);

    xor(top_ns0,in,ps0);
    and(bot_ns0,in,ps1_bar);
    or(ns0,top_ns0,bot_ns0);

    dFF d0(ns0,clk,reset,ps0);
    dFF d1(ns1,clk,reset,ps1);
    
    and(out[2],ps1,ps0_bar);
    assign out[1] = ps0;
    assign out[0] = ~(ps0 ^ ps1);

endmodule