with Ada.Assertions; use ada.assertions;
with xzang.internal.variable_length_integers;
package body xzang.internal.block_headers is 

   procedure Read_header_Size (Self : in out block_header; R : in out Reader) 
   is 
      Length : constant := 1;
      raw_size : byte_array(1 .. Length) :=
         R.Read(Number_Of_Bytes => Length);
   begin
      Self.header_Size := 4*(Integer'Val(raw_size(1))) + 4;
   end Read_Header_Size;


   procedure Read_Compressed (Self : in out block_header; R : in out Reader) is
      Result : Integer := Integer'Last;
   begin
     self.compressed  :=
        xzang.internal.variable_length_integers.decode(R.Read_VLI);
   end Read_Compressed;

   procedure Read_Uncompressed (Self : in out block_header; R : in out Reader) is
   begin
     self.uncompressed  :=
        xzang.internal.variable_length_integers.decode(R.Read_VLI);
   end Read_Uncompressed;

   procedure Read_Flags (Self : in out block_header; R : in out Reader)
   is
      use Interfaces;
      Length : constant := 8;
      flags : byte := R.Read(1)(1);
      subtype Bitint is Natural range 0..1;
   begin
      Self.number_of_Filters :=
         Integer(flags and 16#03#) + 1;
      Assert ( Self.number_of_Filters > 0 and
         Self.number_of_Filters < 4 );
      if Integer(flags and 16#3C#) /= 0 then
         raise CONSTRAINT_ERROR with "Reserved bits must be zero";
      end if;
      self.has_compressed := bitint(flags and 16#40#) /= 0;
      self.has_uncompressed := bitint(flags and 16#80#) /= 0;
   end Read_Flags;


   procedure Read_Filter (Self : in out block_header; R : in out reader) is
   begin
      Read_Filter(Self.filter, R); 
   end Read_Filter;

   procedure Read_CRC32 (Self : in out block_header; R : in out Reader) is 
      function bytes_to_crc32 (bytes : in byte_array)
         return four_byte_number
      is
         result : four_byte_number;
         for result'address use bytes'address;
         pragma Import (Ada, Result);
      begin
         return result;
      end bytes_to_crc32;
   begin
      self.CRC32 := bytes_to_crc32(R.Read(4));
   end Read_CRC32; 


   procedure Read (Self : in out block_header; R : in out Reader) is 
   begin
      self.offset := R.offset;
      Read_Header_Size(Self, R);
      Read_Flags(Self, R);
      if self.has_compressed then
         Read_Compressed(Self, R);
      end if;
      if self.has_uncompressed then
         Read_uncompressed(Self, R);
      end if;
      if Self.number_of_Filters /= 1 then
         raise NOT_IMPLEMENTED with "Multiple filters are not implemented";
      end if;
      Read_filter (Self, R);
      self.offset := (r.offset - self.offset)/8;
      declare
         padding : byte_array(1 .. Self.offset - 4) := 
            R.Read(Self.offset - 4); 
      begin
         for pad of padding loop
            if Integer'Val(pad) /= 0 then
               raise CONSTRAINT_ERROR with "Padding must be zeroed";
            end if;
         end loop;
      end;
      Read_CRC32(Self, R);
      pragma Compile_Time_Warning (Standard.True,  "CRC32 check is not implemented!");
      warning("CRC32 verification is not implemented yet. Trust it as is");

   end Read;
end xzang.internal.block_headers; 

