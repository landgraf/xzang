with xzang.internal.types; use xzang.internal.types;
with xzang.internal.readers; use xzang.internal.readers;
with Interfaces; use Interfaces;
with xzang.internal.block_filters; use xzang.internal.block_filters;
package xzang.internal.block_headers is

   type block_header is private;
   procedure Read (Self : in out block_header; R : in out Reader);

   private
   type block_header
       is record
      header_size : Integer := 0;
      number_of_filters : Integer := 0;
      has_compressed  : Boolean := False;
      has_uncompressed : Boolean := False;
      compressed : Interfaces.Unsigned_64 := 0;
      uncompressed : Interfaces.Unsigned_64 := 0;
      offset : Integer := 0;
      filter : block_filter;
   end record;

end xzang.internal.block_headers;

