with xzang.internal.types; use xzang.internal.types;
package xzang.internal.codecs is

   function htonl32(number : in Four_Byte_Number) return Four_Byte_Number;
   pragma Import(C, htonl32, "htonl");

   function htonl16(number : in Two_Byte_Number) return Two_Byte_Number;
   pragma Import(C, htonl16, "htonl");

end xzang.internal.codecs;

