with xzang.internal.types; use xzang.internal.types;
with xzang.internal.variable_length_integers;
with xzang.internal.block_filters; use xzang.internal.block_filters;
with Interfaces;
with Ada.Assertions; use ada.assertions;
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
      use Interfaces;
      Length : constant := 8;
      flags : byte := R.Read(1)(1);
      subtype Bitint is Natural range 0..1;
   begin
      Self.header.number_of_Filters :=
         Integer(flags and 16#03#) + 1;
      Assert ( Self.header.number_of_Filters > 0 and
         Self.header.number_of_Filters < 4 );
      if Integer(flags and 16#3C#) /= 0 then
         raise BLOCK_ERROR with "Reserved bits must be zero";
      end if;
      self.header.has_compressed := bitint(flags and 16#40#) /= 0;
      self.header.has_uncompressed := bitint(flags and 16#80#) /= 0;
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

   procedure Read_Filter_Flags (Self : in out block; R : in out reader) is
      use interfaces;
      filter : block_filter;
   begin
      filter.id :=
        xzang.internal.variable_length_integers.decode(R.Read_VLI);
      if filter.id /= 16#21# then
         raise constraint_error with "Only lzma parser is supported";
      end if;
      -- Filter IDs greater than or equal to 0x4000_0000_0000_0000
      -- (2^62) are reserved for implementation-specific internal use.
      -- These Filter IDs MUST never be used in List of Filter Flags.
      assert (filter.id < 2**62);
      filter.size :=
        xzang.internal.variable_length_integers.decode(R.Read_VLI);
      if filter.size /= 1 then
         raise constraint_error with "Only lzma parser is supported";
      end if;
      filter.properties :=
        xzang.internal.variable_length_integers.decode(R.Read_VLI);
   end Read_Filter_Flags;

   procedure Read (Self : in out block; R : in out reader) is
   begin
      Read_header_Size (Self, R);
      Read_Flags (Self, R);
      if self.header.has_compressed then
         Read_Compressed(Self, R);
      else
         warning("Compressed size is unknown");
      end if;
      if self.header.has_uncompressed then
         Read_uncompressed(Self, R);
      else
         warning("Uncompressed size is unknown");
      end if;
      for I in 1..Self.header.number_of_Filters loop
         Read_filter_flags(Self, R);
      end loop;
   end Read;

end xzang.internal.blocks;

