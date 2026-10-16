module turnstile (
   input clk,rst,coin,push,
   output unlocked
);
   reg state;

   always @(posedge clk or posedge rst)begin
       if (rst)
          state <= 0;
       else 
          state <= coin | (state & ~push);
   end

   assign unlocked = state;
endmodule
