with Ada.Integer_Text_IO;  use Ada.Integer_Text_IO;
with Ada.Text_IO;          use Ada.Text_IO;
package body xzang.internal.stream_footers is

   function stream_flags (Self : in stream_footer) return stream_flag
   is (Self.stream_flags);

   function bytes_to_footer (bytes : in byte_array) return stream_footer
   is
      result : stream_footer;
      for result'address use bytes'address;
      pragma Import (Ada, Result);
   begin
      return result;
   end bytes_to_footer;

   function Check_magic (Self : stream_footer) return Boolean
   -- is  (Self.magic = magic);
   is
   begin
      if self.magic /= magic then
         for m of self.magic loop
            Put(iNteger'Val(m), Width =>7, Base=> 16);
         end loop;
      end if;
      return True;
   end Check_magic;

   function Check_CRC32 (Self : stream_footer) return Boolean is (False);
end xzang.internal.stream_footers;

