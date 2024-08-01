
module ram_tb;
test t;
ram_if rif();
 
ram dut (.clk(rif.clk), .wr(rif.wr), .din(rif.din), .dout(rif.dout), .addr(rif.addr));
 
initial begin
rif.clk = 0;
end
 
always#10 rif.clk = ~rif.clk;
 
initial begin
t = new("TEST", null);
uvm_config_db #(virtual ram_if)::set(null, "*", "rif", rif);
run_test();
end
 
endmodule
 
