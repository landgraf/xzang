with xzang.internal.types; use xzang.internal.types;
with xzang.internal.block_header_flags; use xzang.internal.block_header_flags;
package xzang.internal.block_headers is 

   type block_header
       is record
      header_size : Integer := 0;
      flags : block_header_flag; --  bit_array(1..8); 
   end record;

end xzang.internal.block_headers; 

