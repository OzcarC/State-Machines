`timescale 1ns/1ps

module dFF(
    input D, clk,
    output Q
);
    always @(posedge clk) begin
        Q <=D;
    end
endmodule

module mooreSM(input in, clk, output out0,out1,out2);

    wire ps0,ps1, ps0_bar, ps1_bar, in_bar;
    wire ns0,ns1,top_ns0,bot_ns0, top_ns1, bot_ns1;

    not(ps0_bar,ps0);
    not(ps1_bar,ps1);
    not(in_bar,in);

    and(top_ns1, ps1,in_bar);
    and(bot_ns1, in, ps0);
    or(ns1,top_ns1,bot_ns1);

    xor(top_ns0,in,ps0);
    and(bot_ns0,in,ps1_bar);
    or(ns0,top_ns0,bot_ns0);

    dFF d0(ns0,clk,ps0);
    dFF d1(ns1,clk,ps1);
    
    and(out2,ps1,ps0_bar);
    assign out1 = ps0;
    assign out0 = ~(ps0 ^ ps1);

endmodule