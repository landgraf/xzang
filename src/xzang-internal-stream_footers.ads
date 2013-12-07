with xzang.internal.types; use xzang.internal.types;                    
with xzang.internal.stream_flags; use xzang.internal.stream_flags;
package xzang.internal.stream_footers is 

   type stream_footer is record
      crc32 : four_byte_number := 0;
      Backward_Size : four_byte_number := 0;
      Stream_Flags :  stream_flag;
      magic    :  byte_Array(1 .. 2);
   end record;
   for stream_footer use record 
      crc32 at 0 range 0 .. 31;
      Backward_Size at 0 range 32 .. 63; 
      Stream_Flags at 0 range 64 .. 79; 
      magic at 0 range 80 .. 95;
   end record;
   for stream_footer'Size use 12*byte'Size;
   function bytes_to_footer (bytes : in byte_array) return stream_footer;
   function Check_magic (Self : stream_footer) return Boolean;
   private 
   magic : constant byte_array := (16#59#, 16#5A#);
end xzang.internal.stream_footers; 

