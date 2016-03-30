program testcase();

  import uvm_pkg::*;

  `include "testclass.sv"
  `include "test_lib.svh"

  initial begin
    uvm_top.run_test();
  end

endprogram : testcase
