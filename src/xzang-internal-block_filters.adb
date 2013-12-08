with Interfaces;
with xzang.internal.variable_length_integers;
with ada.assertions; use ada.assertions;
package body xzang.internal.block_filters is 

   procedure Read_Filter (Self : in out block_filter; R : in out Reader) is
      use interfaces;
      use xzang.internal.variable_length_integers;
   begin
      self.id :=
      xzang.internal.variable_length_integers.decode(R.Read_VLI);
      if self.id /= 16#21# then
         raise NOT_IMPLEMENTED with "Only lzma parser is supported";
      end if;
      -- Filter IDs greater than or equal to 0x4000_0000_0000_0000
      -- (2^62) are reserved for implementation-specific internal use.
      -- These Filter IDs MUST never be used in List of Filter Flags.
      assert (self.id < 2**62);
      self.size :=
         xzang.internal.variable_length_integers.decode(R.Read_VLI);
      if self.size /= 1 then
         raise NOT_IMPLEMENTED  with "Only lzma parser is supported";
      end if;
      self.properties :=
         xzang.internal.variable_length_integers.decode(R.Read_VLI);
      if (self.properties and 16#C0#) /= 0 then
         raise PARSE_ERROR with "Reserved fields are not null";
      end if;
      self.dictionary_size := unsigned_32(self.properties and 16#3F#); 
      if (self.properties and 16#3F#) = 16#40# then
         self.dictionary_size := 16#FFFF_FFFF#;
      else
         declare 
            bits : unsigned_32 := unsigned_32(self.properties and 16#3F#);
         begin
            self.dictionary_size := Interfaces.Shift_Left((2 or (bits and 1)), natural(bits)/2 + 11);
         end;
      end if;
   end Read_Filter;
end xzang.internal.block_filters; 

