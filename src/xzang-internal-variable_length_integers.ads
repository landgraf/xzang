with xzang.internal.types; use xzang.internal.types;
with Interfaces; use Interfaces;
package xzang.internal.variable_length_integers is

   function Decode (Source : in byte_array) return Unsigned_64
      with Pre => Integer'Val(Source'Last) = 16#FF#;
end xzang.internal.variable_length_integers;

