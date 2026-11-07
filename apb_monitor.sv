class apb_monitor;
   mailbox msmbx;
   virtual apb_interface vif;
   apb_transaction tr;
   function new(mailbox msmbx,virtual apb_interface vif);
      this.vif=vif;
      this.msmbx=msmbx;
   endfunction : new
   task run();
      forever begin
      tr=new();
         @(vif.mo_cb);
            if(vif.mo_cb.psel && (!vif.mo_cb.penable))begin
         @(vif.mo_cb);
            if(vif.mo_cb.psel && vif.mo_cb.penable) begin
               if($test$plusargs("zerowaitstate"))  begin
                  tr.pready   =vif.pready;
                  tr.prdata   =vif.prdata;
                  tr.pslverr  =vif.pslverr;
                  tr.pwrite   =vif.pwrite;//try vif.mo_cb.pwrite
                  tr.paddr    =vif.paddr;
                  tr.pwdata   =vif.pwdata;
                  tr.psel     =vif.psel;
                  tr.penable  =vif.penable;
               end

               else begin 
                  wait(vif.mo_cb.pready);
               tr.pready   =vif.pready;
               tr.prdata   =vif.prdata;
               tr.pslverr  =vif.pslverr;
               tr.pwrite   =vif.pwrite;//try vif.mo_cb.pwrite
               tr.paddr    =vif.paddr;
               tr.pwdata   =vif.pwdata;
               tr.psel     =vif.psel;
               tr.penable  =vif.penable;
            end
            end
      tr.disp("MON");
      msmbx.put(tr);
         end
      end
    
   endtask : run
endclass : apb_monitor
      
