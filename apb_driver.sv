class apb_driver;
   virtual apb_interface vif;
   mailbox gdmbx;
   apb_transaction tr;
   function new(mailbox gdmbx,virtual apb_interface vif);
      this.vif=vif;
      this.gdmbx=gdmbx;
   endfunction : new
   task run();
      forever begin
      gdmbx.get(tr);
      tr.disp("DRV");
         @(vif.dr_cb)
         vif.psel    <=0;  //IDLE
         vif.penable <=0;
         
         @(vif.dr_cb)
         vif.psel    <=1;  //SETUP
         vif.penable <=0;
         vif.pwrite  <=tr.pwrite;
         vif.paddr   <=tr.paddr;
         vif.pwdata  <=tr.pwdata;

         @(vif.dr_cb)
         vif.psel   <=1;  //ACCESS
         vif.penable <=1;
         if($test$plusargs("zerowaitstate"))begin continue; end //without wait
         /*else  begin //with wait4
            repeat(5)begin
               @(posedge vif.pclk);
               if(vif.dr_cb.pready==1) break;
               else continue;
            end        
         end*/
        else 
           wait(vif.dr_cb.pready);
   end
   endtask : run
endclass : apb_driver
