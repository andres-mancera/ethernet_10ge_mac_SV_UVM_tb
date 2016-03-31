`ifndef ZERO_IPG_PACKET_TEST__SV
`define ZERO_IPG_PACKET_TEST__SV


class zero_ipg_packet_test extends virtual_sequence_test_base;

  `uvm_component_utils( zero_ipg_packet_test )

  function new(input string name, input uvm_component parent);
    super.new(name, parent);
  endfunction : new


  virtual function void build_phase(input uvm_phase phase);
    super.build_phase(phase);
    `uvm_info(get_name(), $sformatf("Hierarchy: %m"), UVM_NONE )
    factory.set_type_override_by_type(  packet::get_type() ,
                                        packet_zero_ipg::get_type() );
  endfunction : build_phase

endclass : zero_ipg_packet_test

`endif  // ZERO_IPG_PACKET_TEST__SV
