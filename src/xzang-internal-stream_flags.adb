with Interfaces;
with Ada.Integer_Text_IO;  use Ada.Integer_Text_IO;
with Ada.Text_IO;          use Ada.Text_IO;
package body xzang.internal.stream_flags is 

   function Decode_Mask (Input : byte) return mask_name is 

      use type Interfaces.Unsigned_16;                                  
      use type Interfaces.Unsigned_32;
      mask : constant := 16#0F#;
      retval : mask_name;
      tmp : byte;
   begin
      null;
      --  Interfaces.Shift_Left (mask, 8)    
      --    or Interfaces.Unsigned_16 (Input.Element (Index))
      tmp := input and mask;
      Put("value: ");
      Put (item => Integer'Val(tmp), Width =>7, Base=> 16);
      New_Line;
      return retval;
   end Decode_Mask;
end xzang.internal.stream_flags; 

