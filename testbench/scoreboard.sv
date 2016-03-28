`ifndef SCOREBOARD__SV
`define SCOREBOARD__SV

typedef uvm_in_order_comparator #(packet) packet_comparator;


class scoreboard extends uvm_scoreboard;

  packet        pkt_tx_agent_q [$];
  packet        pkt_rx_agent_q [$];
  int unsigned  m_matches;
  int unsigned  m_mismatches;
  uvm_event     check_packet_event;

  `uvm_component_utils( scoreboard )

  `uvm_analysis_imp_decl( _from_pkt_tx_agent )
  uvm_analysis_imp_from_pkt_tx_agent #( packet, scoreboard )    from_pkt_tx_agent;
  `uvm_analysis_imp_decl( _from_pkt_rx_agent )
  uvm_analysis_imp_from_pkt_rx_agent #( packet, scoreboard )    from_pkt_rx_agent;


  function new( input string name="scoreboard", input uvm_component parent );
    super.new(name, parent);
  endfunction : new

  virtual function void build_phase( input uvm_phase phase );
    super.build_phase( phase );
    m_matches       = 0;
    m_mismatches    = 0;
    from_pkt_tx_agent   = new ("from_pkt_tx_agent", this);
    from_pkt_rx_agent   = new ("from_pkt_rx_agent", this);
    check_packet_event  = new ( "check_packet_event" );
  endfunction : build_phase


  virtual function write_from_pkt_tx_agent( packet tx_packet );
    pkt_tx_agent_q.push_back( tx_packet );
  endfunction : write_from_pkt_tx_agent


  virtual function write_from_pkt_rx_agent( packet rx_packet );
    pkt_rx_agent_q.push_back( rx_packet );
    check_packet_event.trigger( );
  endfunction : write_from_pkt_rx_agent


  virtual task check_packet( );
    check_packet_event.wait_trigger( );
    check_packet_queues( );
  endtask : check_packet


  virtual function void check_packet_queues() ;
    packet          tx_pkt;
    packet          rx_pkt;
    int unsigned    error;
    int unsigned    mismatch;
    while ( pkt_tx_agent_q.size() && pkt_rx_agent_q.size() ) begin
      error = 0;
      tx_pkt = pkt_tx_agent_q.pop_front( );
      rx_pkt = pkt_rx_agent_q.pop_front( );
      if ( tx_pkt.mac_dst_addr != rx_pkt.mac_dst_addr ) begin
        `uvm_error( get_name(), $psprintf( "MAC_DST_ADDR MISMATCH!, Exp=0x%0x, Act=0x%0x",
                    tx_pkt.mac_dst_addr, rx_pkt.mac_dst_addr ) )
        error++;
      end
      if ( tx_pkt.mac_src_addr != rx_pkt.mac_src_addr ) begin
        `uvm_error( get_name(), $psprintf( "MAC_SRC_ADDR MISMATCH!, Exp=0x%0x, Act=0x%0x",
                    tx_pkt.mac_src_addr, rx_pkt.mac_src_addr ) )
        error++;
      end
      if ( tx_pkt.ether_type != rx_pkt.ether_type ) begin
        `uvm_error( get_name(), $psprintf( "ETHER_TYPE MISMATCH!, Exp=0x%0x, Act=0x%0x",
                    tx_pkt.ether_type, rx_pkt.ether_type ) )
        error++;
      end
      if ( tx_pkt.payload.size() > rx_pkt.payload.size() ) begin
        `uvm_error( get_name(), $psprintf( "PAYLOAD SIZE MISMATCH!, Exp=%0d, Act=%0d",
                    tx_pkt.payload.size(), rx_pkt.payload.size() ) )
        compare_payload_bytes( tx_pkt.payload, rx_pkt.payload, rx_pkt.payload.size(), mismatch );
        if ( mismatch )
          error++;
      end
      else if ( tx_pkt.payload.size() < rx_pkt.payload.size() ) begin
        `uvm_error( get_name(), $psprintf( "PAYLOAD SIZE MISMATCH!, Exp=%0d, Act=%0d",
                    tx_pkt.payload.size(), rx_pkt.payload.size() ) )
        compare_payload_bytes( tx_pkt.payload, rx_pkt.payload, tx_pkt.payload.size(), mismatch );
        if ( mismatch )
          error++;
      end
      else begin
        compare_payload_bytes( tx_pkt.payload, rx_pkt.payload, tx_pkt.payload.size(), mismatch );
        if ( mismatch )
          error++;
      end

      if ( error )  m_mismatches++;
      else          m_matches++;
    end
  endfunction : check_packet_queues


  function compare_payload_bytes( bit[7:0] exp_bytes[], bit[7:0] act_bytes[], 
                                  int unsigned length, ref int unsigned mismatch );
    mismatch = 0;
    for ( int i=0; i<length; i++ ) begin
      if ( exp_bytes[i] != act_bytes[i] ) begin
        `uvm_error( get_name(), $psprintf( "PAYLOAD[%0d] MISMATCH!, Exp=0x%0x, Act=0x%0x",
                    i, exp_bytes[i], act_bytes[i] ) )
        mismatch++;
      end
      else begin
        `uvm_info( get_name(), $psprintf( "PAYLOAD[%0d] MATCH!, Exp=0x%0x, Act=0x%0x",
                    i, exp_bytes[i], act_bytes[i] ), UVM_FULL )
      end
    end
  endfunction : compare_payload_bytes


  task run_phase ( input uvm_phase phase );
    `uvm_info( get_name(), $sformatf("HIERARCHY: %m"), UVM_HIGH);
    fork
      check_packet( );
    join_none
  endtask : run_phase


  virtual function void report_phase ( input uvm_phase phase );
    super.report_phase( phase );
    `uvm_info( get_name( ), $sformatf( "REPORT: Packet Matches   =%0d", m_matches ), UVM_LOW )
    `uvm_info( get_name( ), $sformatf( "REPORT: Packet Mismatches=%0d", m_mismatches), UVM_LOW )
  endfunction : report_phase

endclass : scoreboard

`endif  //SCOREBOARD__SV
