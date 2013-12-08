with xzang.internal.types; use xzang.internal.types;
with xzang.internal.variable_length_integers;
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
      reserved_bits : bit_array(1 .. 4) := (others => 1);
   begin
      for I in 1 .. 2 loop
         self.header.number_of_filters := 
            self.header.number_of_filters + 2**(I-1)*Integer'Val(raw_flags(I));
      end loop;
      debug("Number of filters:" & self.header.number_Of_Filters'Img);
      reserved_bits := raw_flags (3 .. 6);
      for reserved of  reserved_bits  loop 
         if reserved /= 0 then
            raise BLOCK_ERROR with "Reserved must be null;";
         end if;
      end loop;
      self.header.has_compressed := 
         (case  raw_flags (7) is 
          when 1 => True, when 0 => False);
      self.header.has_uncompressed := 
         (case  raw_flags (8) is
         when 1 => True, when 0 => False);
   end Read_Flags;

   procedure Read_Compressed (Self : in out block; R : in out Reader) is
      Result : Integer := Integer'Last;
   begin
     self.header.compressed  := 
        xzang.internal.variable_length_integers.decode(R.Read_VLI);
   end Read_Compressed;

   procedure Read_Uncompressed (Self : in out block; R : in out Reader) is
   begin
     self.header.uncompressed  := 
        xzang.internal.variable_length_integers.decode(R.Read_VLI);
   end Read_Uncompressed;

   procedure Read (Self : in out block; R : in out reader) is 
   begin
      Read_header_Size (Self, R); 
      Read_Flags (Self, R);
      if self.header.has_compressed then 
         Read_Compressed(Self, R); 
      end if;
      if self.header.has_uncompressed then 
         Read_uncompressed(Self, R); 
      end if;
   end Read;

end xzang.internal.blocks; 

