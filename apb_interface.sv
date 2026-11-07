interface apb_interface();
   logic pclk;
   logic presetn;
   logic [31:0]paddr;
   logic [31:0]pwdata;
   logic psel;
   logic penable;
   logic pwrite;
   logic pready;
   logic [31:0]prdata;
   logic pslverr;
   

   clocking dr_cb @(posedge pclk);
      output pwrite,paddr,pwdata,psel,penable;
      input pready,prdata,pslverr;
   endclocking
   clocking mo_cb @(posedge pclk);
      input paddr,pwdata,psel,penable,pwrite,pready,prdata,pslverr;
   endclocking
endinterface
