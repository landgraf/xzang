with xzang.internal.types; use xzang.internal.types;
with xzang.internal.variable_length_integers;
with xzang.internal.block_filters; use xzang.internal.block_filters;
package body xzang.internal.blocks is




   procedure Read (Self : in out block; R : in out reader) is
   begin
      Read(Self.header, R);
   end Read;

end xzang.internal.blocks;

