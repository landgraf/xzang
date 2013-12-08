package xzang.internal.types is 

   type bit is mod 2;
   for bit'Size use 1;
   for bit'Alignment use 1;

   type byte is mod 2**8;
   for byte'Size use 8;
   for byte'Alignment use 1;

   type Two_Byte_Number is range 0 .. 2**(2*8)-1;                       
   for Two_Byte_Number'Size use 16;
   for Two_Byte_Number'Alignment use 1;

   type Four_Byte_Number is range 0 .. 2** (4*8)-1;                     
   for Four_Byte_Number'Size use 32;    
   for Four_Byte_Number'Alignment use 1; 

   type byte_array is array (Natural range <>) of byte; 
   for byte_array'Alignment use 1;


end xzang.internal.types; 

