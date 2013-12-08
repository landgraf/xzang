with xzang.internal.types; use xzang.internal.types;
package body xzang.internal.blocks is 

   procedure Read_header_Size (Self : in out block; R : in out Reader) 
   is 
      Length : constant := 1;
      raw_size : byte_array(1 .. Length) := 
         R.Read(Number_Of_Bytes => Length);
   begin
      Self.header.header_Size := 4*(Integer'Val(raw_size(1)) + 1);
   end Read_Header_Size; 

   procedure Read_Flags (Self : in out block; R : in out Reader)
   is 
      Length : constant := 8; 
      raw_flags : bit_array(1..Length) := 
         R.Read(Number_Of_Bits => Length);
   begin
      self.header.flags.number_Of_Filters := raw_flags (1 .. 2);
      self.header.flags.reserved := raw_flags (3 .. 6);
      for reserved of  self.header.flags.reserved  loop 
         if reserved /= 0 then
            raise BLOCK_ERROR with "Reserved must be null;";
         end if;
      end loop;
      self.header.flags.compressed_present := raw_flags (7);
      self.header.flags.uncompressed_present := raw_flags (8);
   end Read_Flags;

   procedure Read (Self : in out block; R : in out reader) is 
   begin
      Read_header_Size (Self, R); 
      Read_Flags (Self, R);
   end Read;

end xzang.internal.blocks; 

