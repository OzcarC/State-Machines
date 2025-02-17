`timescale 1ns/1ps

module mooreTb;

    reg in, clk, reset;
    reg [2:0] state;
    wire [2:0] out;
    integer i,j;

    mooreSM dat(.in(in),.clk(clk),.reset(reset),.out(out));

    initial begin
        $dumpfile("wave1.vcd");
        $dumpvars(0, mooreTb);

        clk = 1;
        reset = 0;
        in = 1;
        #1 reset = 1;
        for(i=0; i<50;i=i+1) begin
            #10 clk = ~clk;
        end
    end
    initial begin
        #15 in = 0;
        #50 in = 1;
        #100 reset = 0;
        #50 reset = 1;
        #100 in = 0;
        #50 in = 1;
    end

    always @(out,reset,in) begin
        state <= out-1;
        $monitor("state:%d\t\tout:%d\tin: %d     reset: %d",state,out,in,reset);
    end

endmodule