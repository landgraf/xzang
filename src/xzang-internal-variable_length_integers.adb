package body xzang.internal.variable_length_integers is

   function Decode (Source : in byte_array) return Unsigned_64 is
      Result : Unsigned_64 := 0;
      Modvalue : constant := 2**8;
      Tmp : Unsigned_64;
   begin
      if Source'Length > 1 then
         for I in 1..Source'Length - 1 loop
            warning("Shifting");
            Result := Shift_Left(Result, 7) + (abs (Unsigned_64'Val(Source(I) - 128)));
         end loop;
      end if;
      Tmp := Unsigned_64'val(Source(1)) ;
      Result := Result + Unsigned_64'val(Source(1));
      return Result;
   end Decode;
end xzang.internal.variable_length_integers;

