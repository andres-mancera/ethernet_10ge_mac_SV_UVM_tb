//////////////////////////////////////////////////////////////////////
//                                                                  //
//  File name : wishbone_monitor.sv                                 //
//  Author    : G. Andres Mancera                                   //
//  License   : GNU Lesser General Public License                   //
//  Course    : System and Functional Verification Using UVM        //
//              UCSC Silicon Valley Extension                       //
//                                                                  //
//////////////////////////////////////////////////////////////////////
`ifndef WISHBONE_MONITOR__SV
`define WISHBONE_MONITOR__SV


class wishbone_monitor extends uvm_monitor;

  virtual xge_mac_interface             mon_vi;
  int unsigned                          m_num_captured;
  uvm_analysis_port #(wishbone_item)    ap_mon;

  `uvm_component_utils( wishbone_monitor )

  function new(input string name="wishbone_monitor", input uvm_component parent);
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
    wishbone_item   rcv_pkt;
    `uvm_info( get_name(), $sformatf("HIERARCHY: %m"), UVM_HIGH);

    forever begin
      @(mon_vi.mon_cb)
      begin
        if ( mon_vi.mon_cb.wb_ack_o && mon_vi.mon_cb.wb_cyc_i && mon_vi.mon_cb.wb_stb_i ) begin
          rcv_pkt = wishbone_item::type_id::create("rcv_pkt", this);
          rcv_pkt.xtxn_addr = mon_vi.mon_cb.wb_adr_i;
          rcv_pkt.xtxn_data = mon_vi.mon_cb.wb_dat_o;
          rcv_pkt.xtxn_n    = wishbone_item::xtxn_mode'(mon_vi.mon_cb.wb_we_i);
          `uvm_info( get_name(), $psprintf("Wishbone Transaction: \n%0s", rcv_pkt.sprint()), UVM_HIGH)
          ap_mon.write( rcv_pkt );
          m_num_captured++;
        end
      end
    end
  endtask : run_phase


  function void report_phase( uvm_phase phase );
    `uvm_info( get_name( ), $sformatf( "REPORT: Captured %0d wishbone transactions", m_num_captured ), UVM_LOW )
  endfunction : report_phase

endclass : wishbone_monitor

`endif  //WISHBONE_MONITOR__SV
