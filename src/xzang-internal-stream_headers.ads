with  xzang.internal.types; use  xzang.internal.types;
with xzang.internal.stream_flags; 
use xzang.internal.stream_flags;
package xzang.internal.stream_headers is 

   type stream_header is private;

   function stream_flags (Self : in stream_header) return stream_flag;
   --  Getter of stream_flags field

   function Check_Magic(Self : in stream_header) return Boolean;
   --  Check if header magic is lzma header (i.e. check if stream is lzma
   --  stream
   
   function Check_CRC32 (Self : in stream_header) return Boolean; 
   --     The CRC32 is calculated from the Stream Flags field. It is
   --     stored as an unsigned 32-bit little endian integer. If the
   --     calculated value does not match the stored one, the decoder
   --     MUST indicate an error.
   

   function bytes_to_header (bytes : in byte_array) return stream_header;
   --  Convert bytes (byte array) to header
   --  Potentially unsafe operation but we check header afterwards
   --  See: Check_ functions above
   
   private
   type stream_header is record
      magic : byte_array(1 .. 6) := (others => 0);
      stream_flags :  stream_flag;
      CRC32 :  four_byte_number  := 0;
   end record;
   for stream_header use record
      magic at 0 range 0 .. 47; 
      stream_flags at 0 range 48 .. 63;
      crc32 at 0 range 64 .. 95;
   end record;
   for stream_header'Size use 12*byte'Size;
   for stream_header'Alignment use 1; 

   stream_magic : constant byte_array  :=                               
      (16#FD#, 16#37#, 16#7A#, 16#58#,16#5A#, 16#00#);
end xzang.internal.stream_headers; 

