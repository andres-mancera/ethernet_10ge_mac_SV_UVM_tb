`ifndef ENV__SV
`define ENV__SV

`include "packet_tx_agent.sv"


class env extends uvm_env;

  packet_tx_agent   pkt_tx_agent;

  `uvm_component_utils(env)

  function new(input string name, input uvm_component parent);
    super.new(name, parent);
  endfunction : new


  virtual function void build_phase( input uvm_phase phase );
    super.build_phase( phase );
    pkt_tx_agent = packet_tx_agent::type_id::create( "pkt_tx_agent", this );
  endfunction : build_phase

endclass : env

`endif //ENV__SV
