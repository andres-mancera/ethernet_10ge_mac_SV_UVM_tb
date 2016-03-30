`ifndef BRINGUP_PACKET_TEST__SV
`define BRINGUP_PACKET_TEST__SV


class bringup_packet_test extends virtual_sequence_test_base;

  `uvm_component_utils( bringup_packet_test )

  function new(input string name, input uvm_component parent);
    super.new(name, parent);
  endfunction : new


  virtual function void build_phase(input uvm_phase phase);
    super.build_phase(phase);
    `uvm_info(get_name(), $sformatf("Hierarchy: %m"), UVM_NONE )
    uvm_config_db #(int unsigned)::set(this, "m_env.pkt_tx_agent.pkt_tx_seqr.packet_sequence", "num_packets", 10 );
    factory.set_type_override_by_type(  packet::get_type() ,
                                        packet_bringup::get_type() );
  endfunction : build_phase

endclass : bringup_packet_test

`endif  // BRINGUP_PACKET_TEST__SV
