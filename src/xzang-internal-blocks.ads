with xzang.internal.block_headers; use xzang.internal.block_headers;
with xzang.internal.readers; use xzang.internal.readers;
with xzang.internal.block_filters; use xzang.internal.block_filters;
package xzang.internal.blocks is
   BLOCK_ERROR : exception;
   type block is private;

   procedure Read (Self : in out block; R : in out reader);

   private
   type block is record
      header : block_header;
      filter : block_filter;
   end record;

end xzang.internal.blocks;

