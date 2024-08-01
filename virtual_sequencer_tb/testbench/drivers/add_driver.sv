

class add_driver extends uvm_driver #(add_transaction);
 `uvm_component_utils(add_driver)


 virtual add_if aif;
 add_transaction tr;




 function new(input string path = "drv", uvm_component parent = null);
   super.new(path,parent);
 endfunction


virtual function void build_phase(uvm_phase phase);
   super.build_phase(phase);
    tr = add_transaction::type_id::create("tr");
    
  if(!uvm_config_db#(virtual add_if)::get(this,"","aif",aif))
     `uvm_error("drv","Unable to access Interface");
 endfunction




 virtual task run_phase(uvm_phase phase);
   forever
    begin
   
           seq_item_port.get(tr);
           `uvm_info("ADD_DRV", $sformatf(" add_in1:%0d add_in2:%0d ",tr.add_in1,tr.add_in2), UVM_NONE);
           aif.rst     <= 1'b0;
           aif.add_in1 <= tr.add_in1;
           aif.add_in2 <= tr.add_in2;
           repeat(3) @(posedge aif.clk);     
   end
 endtask
 


endclass
   
