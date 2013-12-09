package body xzang.internal.variable_length_integers is

   function Decode (Source : in byte_array) return Unsigned_64 is
      Result : Unsigned_64 := 0;
   begin
       for I in 1..Source'Length - 1 loop
           Result := Shift_Left(Result + (Unsigned_64'Val(Source(I)) and 16#7F#), 7);
       end loop;
      Result := Result + Unsigned_64'val(Source(1));
      return Result;
   end Decode;
end xzang.internal.variable_length_integers;

