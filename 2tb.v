`timescale 1ns/1ps

module countDecodeTb;

    reg stop, clk;
    wire out;
    wire [3:0] countOut;
    integer i,j;

    counterDecoder dat(.stop(stop),.clk(clk),.out(out), .countOut(countOut));

    initial begin
        $dumpfile("wave2.vcd");
        $dumpvars(0, countDecodeTb);

        clk = 0;
        for(i=0; i<50;i=i+1) begin
            #10 clk = ~clk;
        end
    end
    initial begin
        stop = 0;
        #75 stop = 1;
        #40 stop = 0;
        #120 stop = 1;
        #70 stop = 0;
    end

    always @(out,stop) begin
        $monitor("state:%d\t\tout:%d\tstop: %d",countOut,out,stop);
    end

endmodule