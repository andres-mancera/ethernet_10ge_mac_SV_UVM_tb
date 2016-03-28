`ifndef ENV__SV
`define ENV__SV

`include "packet_tx_agent.sv"
`include "packet_rx_agent.sv"
`include "scoreboard.sv"


class env extends uvm_env;

  packet_tx_agent   pkt_tx_agent;
  packet_rx_agent   pkt_rx_agent;
  scoreboard        scbd;

  `uvm_component_utils(env)

  function new(input string name, input uvm_component parent);
    super.new(name, parent);
  endfunction : new


  virtual function void build_phase( input uvm_phase phase );
    super.build_phase( phase );
    pkt_tx_agent = packet_tx_agent::type_id::create( "pkt_tx_agent", this );
    pkt_rx_agent = packet_rx_agent::type_id::create( "pkt_rx_agent", this );
    scbd         = scoreboard::type_id::create( "scbd", this );
  endfunction : build_phase


  virtual function void connect_phase ( input uvm_phase phase );
    super.connect_phase( phase );
    pkt_tx_agent.ap_tx_agent.connect( scbd.from_pkt_tx_agent );
    pkt_rx_agent.ap_rx_agent.connect( scbd.from_pkt_rx_agent );
  endfunction : connect_phase

endclass : env

`endif  //ENV__SV
