
class mul_driver extends uvm_driver #(mul_transaction);
 `uvm_component_utils(mul_driver)


 virtual mul_if mif;
 mul_transaction tr;




 function new(input string path = "mul_driver", uvm_component parent = null);
   super.new(path,parent);
 endfunction


virtual function void build_phase(uvm_phase phase);
   super.build_phase(phase);
    tr = mul_transaction::type_id::create("tr");
    
  if(!uvm_config_db#(virtual mul_if)::get(this,"","mif",mif))
    `uvm_error("mul_driver","Unable to access Interface");
 endfunction




 




 virtual task run_phase(uvm_phase phase);
      forever
         begin
   
           seq_item_port.get(tr);           
          `uvm_info("MUL_DRV", $sformatf(" mul_in1:%0d mul_in2:%0d ",tr.mul_in1,tr.mul_in2), UVM_NONE);
           mif.rst     <= 1'b0;
           mif.mul_in1 <= tr.mul_in1;
           mif.mul_in2 <= tr.mul_in2;
           repeat(3) @(posedge mif.clk);
       end
 endtask
 


endclass
   
