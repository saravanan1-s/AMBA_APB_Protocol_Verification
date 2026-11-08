class apb_environment;
   apb_generator gen;
   apb_driver drv;
   apb_monitor mon;
   apb_scoreboard sc;
   mailbox gdmbx;
   mailbox msmbx;
   virtual apb_interface vif;
   function new(virtual apb_interface vif);
      this.vif=vif;
      gdmbx=new(1);
      msmbx=new();
      gen=new(gdmbx);
      drv=new(gdmbx,vif);
      mon=new(msmbx,vif);
      sc=new(msmbx,vif);
      //pr=new(psmbx);
   endfunction : new
   task run();
      fork
        #40 gen.run();
         drv.run();
         mon.run();
         sc.run();
      join_none;
   endtask : run
endclass : apb_environment
