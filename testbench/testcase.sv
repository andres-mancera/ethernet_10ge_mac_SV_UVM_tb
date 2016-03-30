program testcase();

  import uvm_pkg::*;

  `include "testclass.sv"
  `include "../testcases/bringup_packet_test.sv"

  initial begin
    uvm_top.run_test();
  end

endprogram : testcase
