with xzang.lzmastreams; use xzang.lzmastreams;
with Ada.Directories; use Ada.Directories;
with Ada.Command_Line; use Ada.Command_Line;
with Ada.Text_IO; use Ada.Text_IO;
procedure xza is
   strm  : lzmastream_access;
begin
   if Ada.Command_Line.Argument_Count = 0 or else not
         Exists(Argument(1)) then
      Put_Line("File was not specified or doesn't exist...");
      return;
   end if;
      strm := Init(Argument(1), 1000);
      loop
         Put_Line(strm.next_string);
         exit when strm.EOS;
      end loop;

      strm.close;

end xza;

