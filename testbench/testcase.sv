program testcase();

  import uvm_pkg::*;

  `include "testclass.sv"

  initial begin
    uvm_top.run_test();
  end

endprogram : testcase
