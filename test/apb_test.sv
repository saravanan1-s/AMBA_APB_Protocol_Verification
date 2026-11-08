class apb_test;
   virtual apb_interface vif;
   apb_environment env;
   apb_write_read wr;
   apb_write wt;
   apb_read rd;
   apb_slverr slv;
   apb_reset rst;
   apb_ww_write_read ww_wr;
   apb_ww_write ww_wt;
   apb_ww_read ww_rd;
   apb_ww_slverr ww_slv;
   apb_ww_reset ww_rst;
   function new(virtual apb_interface vif);
      this.vif=vif;
      env=new(vif);
        endfunction : new
   task run();
      if($test$plusargs("apb_write_read_test"))begin
         wr=new(env.gdmbx);
         env.gen=wr;
         env.run();
      end
      else if($test$plusargs("apb_write_test"))begin
         wt=new(env.gdmbx);
         env.gen=wt;
         env.run();
      end
       else if($test$plusargs("apb_read_test"))begin
         rd=new(env.gdmbx);
         env.gen=rd;
         env.run();
      end
      else if($test$plusargs("apb_slverr_test"))begin
         slv=new(env.gdmbx);
         env.gen=slv;
         env.run();
      end
      else if($test$plusargs("apb_reset_test"))begin
         rst=new(env.gdmbx);
         env.gen=rst;
         fork
         env.run();
         #100 vif.presetn=1'b0;
         #150 vif.presetn=1'b1;

         #250 vif.presetn=1'b0;
         #350 vif.presetn=1'b1;
         
         #500 vif.presetn=1'b0;
         #550 vif.presetn=1'b1;
      join
      end
      else if($test$plusargs("apb_ww_write_read_test"))begin
         ww_wr=new(env.gdmbx);
         env.gen=ww_wr;
         env.run();
         
      end
      else if($test$plusargs("apb_ww_write_test"))begin
         ww_wt=new(env.gdmbx);
         env.gen=ww_wt;
         env.run();
         
      end

      else if($test$plusargs("apb_ww_read_test"))begin
         ww_rd=new(env.gdmbx);
         env.gen=ww_rd;
         env.run();
         
      end
       else if($test$plusargs("apb_ww_slverr_test"))begin
         ww_slv=new(env.gdmbx);
         env.gen=ww_slv;
         env.run();
      end
       else if($test$plusargs("apb_ww_slverr_test"))begin
         ww_slv=new(env.gdmbx);
         env.gen=ww_slv;
         env.run();
      end
       else if($test$plusargs("apb_ww_reset_test"))begin
         ww_rst=new(env.gdmbx);
         env.gen=ww_rst;
         env.run();
      end
   endtask : run
endclass : apb_test
