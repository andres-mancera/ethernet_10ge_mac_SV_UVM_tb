//////////////////////////////////////////////////////////////////////
//                                                                  //
//  File name : oversized_packet_test.sv                            //
//  Author    : G. Andres Mancera                                   //
//  License   : GNU Lesser General Public License                   //
//  Course    : System and Functional Verification Using UVM        //
//              UCSC Silicon Valley Extension                       //
//                                                                  //
//////////////////////////////////////////////////////////////////////
`ifndef OVERSIZED_PACKET_TEST__SV
`define OVERSIZED_PACKET_TEST__SV


class oversized_packet_test extends virtual_sequence_test_base;

  `uvm_component_utils( oversized_packet_test )

  function new(input string name, input uvm_component parent);
    super.new(name, parent);
  endfunction : new


  virtual function void build_phase(input uvm_phase phase);
    super.build_phase(phase);
    `uvm_info(get_name(), $sformatf("Hierarchy: %m"), UVM_NONE )
    factory.set_type_override_by_type(  packet::get_type() ,
                                        packet_oversized::get_type() );
  endfunction : build_phase

endclass : oversized_packet_test

`endif  // OVERSIZED_PACKET_TEST__SV
