`timescale 1ns/1ps

module dFF(
    input D, clk,
    output Q;
);
    always @(posedge clk) begin
        Q <=D;
    end
endmodule

module mooreSM(input in);


endmodule