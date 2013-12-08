with Ada.Finalization;
package xzang.internal.decompressors is
   type decompressor is new Ada.Finalization.Limited_Controlled
      with private;
   type decompressor_access is access all decompressor;

   private
   type decompressor is new Ada.Finalization.Limited_Controlled
      with null record;


end xzang.internal.decompressors;

