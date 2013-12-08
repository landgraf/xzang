with xzang.internal.types; use xzang.internal.types;
package xzang.internal.variable_length_integers is

   function Decode (Source : in byte_array) return Integer
      with Pre => Integer'Val(Source'Last) = 16#FF#;
end xzang.internal.variable_length_integers;

