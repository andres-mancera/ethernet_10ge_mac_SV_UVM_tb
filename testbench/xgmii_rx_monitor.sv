//////////////////////////////////////////////////////////////////////
//                                                                  //
//  File name : xgmii_rx_monitor.sv                                 //
//  Author    : G. Andres Mancera                                   //
//  License   : GNU Lesser General Public License                   //
//  Course    : System and Functional Verification Using UVM        //
//              UCSC Silicon Valley Extension                       //
//                                                                  //
//////////////////////////////////////////////////////////////////////
`ifndef XGMII_RX_MONITOR__SV
`define XGMII_RX_MONITOR__SV


class xgmii_rx_monitor extends uvm_monitor;

  virtual xge_mac_interface             mon_vi;
  int unsigned                          m_num_captured;
  uvm_analysis_port #(xgmii_packet)     ap_mon;

  `uvm_component_utils( xgmii_rx_monitor )

  function new(input string name="xgmii_rx_monitor", input uvm_component parent);
    super.new(name, parent);
  endfunction : new


  virtual function void build_phase(input uvm_phase phase);
    super.build_phase(phase);
    m_num_captured = 0;
    ap_mon = new ( "ap_mon", this );
    uvm_config_db#(virtual xge_mac_interface)::get(this, "", "mon_vi", mon_vi);
    if ( mon_vi==null )
      `uvm_fatal(get_name(), "Virtual Interface for monitor not set!");
  endfunction : build_phase


  virtual task run_phase(input uvm_phase phase);
    xgmii_packet    rcv_pkt;
    `uvm_info( get_name(), $sformatf("HIERARCHY: %m"), UVM_HIGH);

    forever begin
      @(mon_vi.mon_cb)
      begin
        rcv_pkt = xgmii_packet::type_id::create("rcv_pkt", this);
        rcv_pkt.control = mon_vi.mon_cb.xgmii_rxc;
        rcv_pkt.data    = mon_vi.mon_cb.xgmii_rxd;
        `uvm_info( get_name(), $psprintf("XGMII Transaction: \n%0s", rcv_pkt.sprint()), UVM_HIGH)
        ap_mon.write( rcv_pkt );
        m_num_captured++;
      end
    end
  endtask : run_phase


  function void report_phase( uvm_phase phase );
    `uvm_info( get_name( ), $sformatf( "REPORT: Captured %0d xgmii transactions", m_num_captured ), UVM_LOW )
  endfunction : report_phase

endclass : xgmii_rx_monitor

`endif  //XGMII_RX_MONITOR__SV
