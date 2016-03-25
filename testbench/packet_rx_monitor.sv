`ifndef PACKET_RX_MONITOR__SV
`define PACKET_RX_MONITOR__SV


class packet_rx_monitor extends uvm_monitor #(packet);

  virtual xge_mac_interface     mon_vi;
  uvm_analysis_port #(packet)   ap_rx_mon;

  `uvm_component_utils( packet_rx_monitor )

  function new(input string name="packet_rx_monitor", input uvm_component parent);
    super.new(name, parent);
  endfunction : new


  virtual function void build_phase(input uvm_phase phase);
    super.build_phase(phase);
    ap_rx_mon = new ( "ap_rx_mon", this );
    uvm_config_db#(virtual xge_mac_interface)::get(this, "", "mon_vi", mon_vi);
    if ( mon_vi==null )
      `uvm_fatal(get_name(), "Virtual Interface for monitor not set!");
  endfunction : build_phase


  virtual task run_phase(input uvm_phase phase);
    packet  rcv_pkt;

    `uvm_info( get_name(), $sformatf("HIERARCHY: %m"), UVM_HIGH);
    // Initial assignment for pkt_rx interface signals.
    mon_vi.pkt_rx_ren   <= 1'b0;
    // FIXME: Add all the code to collect transactions.

  endtask : run_phase

endclass : packet_rx_monitor

`endif  //PACKET_RX_MONITOR__SV

