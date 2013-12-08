with xzang.internal.types; use xzang.internal.types;
package xzang.internal.block_headers is

   type block_header_flag is record
      number_of_filters : bit_array(0 .. 1);
      reserved : bit_array(2 .. 5) := (others => 0);
      compressed_present : bit := 0;
      uncompressed_present : bit := 0;
   end record;

   type block_header
       is record
      header_size : Integer := 0;
      number_of_filters : Integer := 0;
      has_compressed  : Boolean := False;
      has_uncompressed : Boolean := False;
      compressed : Integer := 0;
      uncompressed : Integer := 0;
   end record;

end xzang.internal.block_headers;

