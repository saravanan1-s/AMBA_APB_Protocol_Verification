class apb_transaction;
   rand bit[31:0]paddr;
   rand bit[31:0]pwdata;
   rand bit pwrite;
   bit[31:0]prdata;
   bit pready;
   bit pslverr;
   bit penable;
   bit psel;
   constraint paadr_not{!(paddr inside {'h0,'h4,'h8,'hc});}
   constraint paddr_yes{soft paddr inside {11,'hff,'h55,'hAA,'h5A,'hA5,'hA0,'h0A,'h05,'h50,'hAB,'hBC,'hAC,'hBD,'hEF,'hFE,'hFA,'hFF};}
   constraint pwdata_yes{ soft pwdata inside{'hAAAA_AAAA,'h5555_5555,'hAAAA_5555,'h5555_AAAA,'hA5A5_A5A5,'h5A5A_5A5A,'hFFFF_FFFF,'hAA,'h55,'hFF};}
   function void disp(string tag);
       $display("%0s | paddr=%0h | pwrite=%0h | pwdata=%0h | prdata=%0h | pready=%0h | pslverr=%0h |",tag,paddr,pwrite,pwdata,prdata,pready,pslverr);
   endfunction : disp
endclass : apb_transaction

