 
  
class sco extends uvm_scoreboard;
`uvm_component_utils(sco)
 
  uvm_analysis_imp_add#(add_transaction,sco) recva;
  uvm_analysis_imp_mul#(mul_transaction,sco) recvm;
 
  add_transaction atr;
  mul_transaction mtr;
 
 
 
 
   function new(input string inst = "mul_sco", uvm_component parent = null);
   super.new(inst,parent);
   endfunction
  
   virtual function void build_phase(uvm_phase phase);
   super.build_phase(phase);
     recva = new("recva", this);
     recvm = new("recvm", this);
    
     atr = add_transaction::type_id::create("atr");
     mtr = mul_transaction::type_id::create("mtr");
   endfunction
  
  
   virtual function void write_mul(mul_transaction tr);
     mtr = tr;
           if (mtr.mul_in1 >= 0 && mtr.mul_in2 >= 0)
           begin
             if(mtr.mul_out == mtr.mul_in1 * mtr.mul_in2)
               `uvm_info("MUL_SCO", $sformatf("TEST PASSED : MOUT:%0d MIN1:%0d MIN2:%0d",mtr.mul_out, mtr.mul_in1, mtr.mul_in2), UVM_NONE)
            else
              `uvm_info("MUL_SCO", $sformatf("TEST FAILED : MOUT:%0d MIN1:%0d MIN2:%0d",mtr.mul_out, mtr.mul_in1, mtr.mul_in2), UVM_NONE)
           end 
              else
                 return;
 endfunction
 
 
virtual function void write_add(add_transaction tr);
    atr = tr;
    if(atr.add_in1 >= 0 && atr.add_in2 >= 0)
          begin
            if(atr.add_out == atr.add_in1 + atr.add_in2)
              `uvm_info("ADD_SCO", $sformatf("TEST PASSED : AOUT:%0d AIN1:%0d AIN2:%0d",atr.add_out, atr.add_in1, atr.add_in2), UVM_NONE)
            else
                  `uvm_error("ADD_SCO" , "TEST FAILED")
          end
    else
         return;
                 
 endfunction
 
 
 
endclass 
 
