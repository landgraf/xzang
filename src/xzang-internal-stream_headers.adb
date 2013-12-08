with GNAT.CRC32; 
with Interfaces;
with ada.streams; 
package body xzang.internal.stream_headers is 

   function Check_Magic(Self : in stream_header) return Boolean 
   is (Self.magic = stream_magic);

   function bytes_to_header (bytes : in byte_array) 
      return stream_header
   is
      result : stream_header; 
      for result'address use bytes'address;
      pragma Import (Ada, Result);
   begin
      return result;
   end bytes_to_header;

   function Check_CRC32 (Self : in stream_header) return Boolean 
   is 
      use GNAT.CRC32;
      crc : GNAT.CRC32.CRC32;
      function flags_to_Sea (f : xzang.internal.stream_flags.stream_flag)
         return Ada.Streams.Stream_Element_Array is
         result : Ada.Streams.Stream_Element_Array(1..2); 
         for result'Address use f'Address;
      begin
         return result;
      end flags_to_sea;
      use Interfaces;
   begin
      Initialize(crc);
      update(crc, flags_to_Sea(self.stream_flags));
      return get_value(crc) = Interfaces.Unsigned_32'Val(self.crc32);
   end Check_CRC32;


   function stream_flags (Self : in stream_header) return stream_flag
   is (Self.stream_flags);

end xzang.internal.stream_headers; 

