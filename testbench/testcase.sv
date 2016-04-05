//////////////////////////////////////////////////////////////////////
//                                                                  //
//  File name : testcase.sv                                         //
//  Author    : G. Andres Mancera                                   //
//  License   : GNU Lesser General Public License                   //
//  Course    : System and Functional Verification Using UVM        //
//              UCSC Silicon Valley Extension                       //
//                                                                  //
//////////////////////////////////////////////////////////////////////
`ifndef TESTCASE__SV
`define TESTCASE__SV

program testcase();

  import uvm_pkg::*;

  `include "testclass.sv"
  `include "test_lib.svh"

  initial begin
    uvm_top.run_test();
  end

endprogram : testcase

`endif  // TESTCASE__SV
