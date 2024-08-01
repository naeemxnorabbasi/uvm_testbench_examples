class env extends uvm_env;
`uvm_component_utils(env)
 
function new(input string inst = "env", uvm_component c);
super.new(inst,c);
endfunction
 
 add_agent   aa;
 mul_agent   ma;
 vsequencer  vseqr;
 sco s;




virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);
 aa = add_agent::type_id::create("aa",this);
 ma = mul_agent::type_id::create("ma", this);
 vseqr = vsequencer::type_id::create("vseqr", this);
 s   = sco::type_id::create("s", this);


endfunction
 
 function void connect_phase( uvm_phase phase );
   super.connect_phase(phase);
   vseqr.VA = aa.a_seqr;
   vseqr.VM = ma.m_seqr;
  
   aa.m.send.connect(s.recva);
   ma.m.send.connect(s.recvm);
endfunction: connect_phase




endclass              
