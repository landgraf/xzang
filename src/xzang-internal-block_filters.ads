with Interfaces; use Interfaces;
with xzang.internal.readers; use xzang.internal.readers;
package xzang.internal.block_filters is

   type block_filter is private;
   procedure Read_Filter (Self : in out block_filter; R : in out Reader); 
   private
   type block_filter is record
      ID : Interfaces.Unsigned_64 := 0;
      Size : Interfaces.Unsigned_64 := 0;
      Properties : Interfaces.Unsigned_64 := 0;
      Dictionary_Size : Unsigned_32; 
   end record;

end xzang.internal.block_filters;

