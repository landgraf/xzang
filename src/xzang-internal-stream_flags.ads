with xzang.internal.types; use xzang.internal.types;
package xzang.internal.stream_flags is 
   type four_bit_array is  array (1 .. 4) of bit; 
   for four_bit_array'Size use 4*bit'Size; 
   pragma Pack(four_bit_array);

   type stream_flag is record
      Stream_Version : byte;
      bit_field : four_bit_array := (others => 0);
      reserved : four_bit_array := (others => 0);
   end record;
   for stream_Flag use record
      Stream_Version at 0 range 0 .. 7;
      bit_field at 0 range 8 .. 11;
      reserved at 0 range 12 .. 15;
   end record;
   for stream_flag'Size use 2*byte'Size;

   type mask_name is (reserved, none, CRC32, CRC64, SHA256);
   function Decode_Mask (input : byte) return mask_name; 
   -- Get bit_field as parameter 
end xzang.internal.stream_flags; 

