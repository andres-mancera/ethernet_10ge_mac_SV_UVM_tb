class env extends uvm_env;

   `uvm_component_utils(env)

   function new(input string name, input uvm_component parent);
      super.new(name, parent);
   endfunction

endclass : env
