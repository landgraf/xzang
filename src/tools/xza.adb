with xzang.lzmastreams; 
with Ada.Directories; 
with Ada.Command_Line; use Ada.Command_Line;
with Ada.Text_IO; 
procedure xza is
   strm  : xzang.lzmastreams.lzmastream_access;
begin
   if Ada.Command_Line.Argument_Count = 0 or else not
         Ada.Directories.Exists(Argument(1)) then
      Ada.Text_IO.Put_Line("File was not specified or doesn't exist...");
      return;
   end if;
      strm := Xzang.Lzmastreams.Init(Argument(1), 1000);
      loop
         Ada.Text_IO.Put_Line(Strm.Next_String);
         exit when strm.EOS;
      end loop;

      strm.close;

end xza;

