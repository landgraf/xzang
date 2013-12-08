with Interfaces; use Interfaces;
package xzang.internal.block_filters is

   type block_filter is record
      ID : Interfaces.Unsigned_64 := 0;
      Size : Interfaces.Unsigned_64 := 0;
      Properties : Interfaces.Unsigned_64 := 0;
   end record;

end xzang.internal.block_filters;

