class apb_scoreboard;
   apb_transaction tr;
   mailbox msmbx;
   virtual apb_interface vif;
   bit [31:0]mem[0:256];
   bit[31:0]exp_value;
   function new(mailbox msmbx,virtual apb_interface vif);
      this.msmbx=msmbx;
      this.vif=vif;
      apb_cov1=new();
   endfunction : new

   covergroup apb_cov1;
      cp1 : coverpoint tr.paddr{bins b1={[0:127]}; bins b2={{32{1'b1}}};}
      cp2 : coverpoint tr.pwdata{bins b3={[0:255]};}
      cp3 : coverpoint tr.prdata{bins b4={[0:255]};}
      cp4 : coverpoint tr.psel{bins b5={1}; ignore_bins b6={0};}
      cp5 : coverpoint tr.pwrite{bins b7={1}; bins b8={0};}
      cp6 : coverpoint tr.pslverr{bins b9={{32{1'b1}}}; bins b10={{32{1'b0}}};}
      cp2_x_cp5 : cross cp2,cp5;//{bins b25=binsof(cp2.b3) && binsof(cp5.b7);}
      cp3_x_cp5 : cross cp3,cp5{bins b35=binsof(cp3.b4) && binsof(cp5.b8);}
   endgroup : apb_cov1
   
   task run();
      forever begin
        if(vif.presetn==0)begin
           foreach(mem[i])
              mem[i]=i;
           @(posedge vif.pclk);
         end
        else begin
           msmbx.get(tr);
           apb_cov1.sample();
           tr.disp("SOC");
           $display("================================================================================");

           ->e1;
           if(tr.pwrite) begin
              mem[tr.paddr]=tr.pwdata;
           end
           else begin
              exp_value=mem[tr.paddr];
              if(exp_value==tr.prdata)
                 $display("PASS ==> %0h=%0h",exp_value,tr.prdata);
              else
                 $display("FAIL ==> %0h!=%0h",exp_value,tr.prdata);
           end
        end
     end
  endtask :run
  endclass : apb_scoreboard
