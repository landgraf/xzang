package xzang.internal.types is 

   type bit is mod 2;
   for bit'Size use 1;

   type byte is mod 2**8;
   for byte'Size use 8;

   type Two_Byte_Number is range 0 .. 2**(2*8)-1;                       
   for Two_Byte_Number'Size use 16;

   type Four_Byte_Number is range 0 .. 2** (4*8)-1;                     
   for Four_Byte_Number'Size use 32;    

   type byte_array is array (Natural range <>) of byte; 


end xzang.internal.types; 

