`timescale 1ns/1ps

module dFF(
    input D, clk, reset,
    output reg Q
);
    always @(posedge clk) begin
            Q <=D;
    end
endmodule

module counterDecoder(
    input stop, clk,
    output out, 
    output [3:0] countOut
);

    reg [3:0] ps;
    wire [3:0] ns, inc;

    always @(posedge clk)
        ps <= ns;

    assign inc = ps+1;

    assign ns = stop ? ps : (ps == 7) ? 0 :inc;

    assign countOut = ps;
    assign out = (ps == 2) ? 1:0;

endmodule

