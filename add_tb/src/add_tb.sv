module add_tb();
test t;
add_if aif();
 
add dut (.a(aif.a), .b(aif.b), .y(aif.y));
 
initial begin
 
$dumpfile("dump.vcd");
$dumpvars; 
t = new("TEST",null);
uvm_config_db #(virtual add_if)::set(null, "*", "aif", aif);
run_test();
end
 
endmodule
