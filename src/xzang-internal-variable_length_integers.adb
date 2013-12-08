package body xzang.internal.variable_length_integers is

   function Decode (Source : in byte_array) return Integer is
      Result : Integer := Integer'First;
      Modvalue : constant := 2**8;
   begin
      if Source'Length = 1 then
         return abs (Integer'val(Source(1)) - Modvalue);
      end if;
      raise Not_Implemented;
      return Result;
   end Decode;
end xzang.internal.variable_length_integers;

