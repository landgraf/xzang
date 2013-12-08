------------------------------------------------------------------------------
--                              Adevlogs Log parser                         --
--                                                                          --
--        Copyright (C) 2013, Pavel Zhukov <pavel at zhukoff dot net>       --
--                                                                          --
--  This library is free software;  you can redistribute it and/or modify   --
--  it under terms of the  GNU General Public License  as published by the  --
--  Free Software  Foundation;  either version 3,  or (at your  option) any --
--  later version. This library is distributed in the hope that it will be  --
--  useful, but WITHOUT ANY WARRANTY;  without even the implied warranty of --
--  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.                    --
--                                                                          --
--  As a special exception under Section 7 of GPL version 3, you are        --
--  granted additional permissions described in the GCC Runtime Library     --
--  Exception, version 3.1, as published by the Free Software Foundation.   --
--                                                                          --
--  You should have received a copy of the GNU General Public License and   --
--  a copy of the GCC Runtime Library Exception along with this program;    --
--  see the files COPYING3 and COPYING.RUNTIME respectively.  If not, see   --
--  <http://www.gnu.org/licenses/>.                                         --
--                                                                          --
--  As a special exception, if other files instantiate generics from this   --
--  unit, or you link this unit with other files to produce an executable,  --
--  this  unit  does not  by itself cause  the resulting executable to be   --
--  covered by the GNU General Public License. This exception does not      --
--  however invalidate any other reasons why the executable file  might be  --
--  covered by the  GNU Public License.                                     --
------------------------------------------------------------------------------
package body debug_output is 

    procedure Debug(Str : in String) is 
    begin
        if is_debug_enabled then
            Put_Line("DEBUG: " & Str);
        end if;
    end Debug;
    procedure Debug(Str : in Unbounded_String) is 
    begin
        if is_debug_enabled then
            Debug(To_String(Str));
        end if;
    end Debug;
    procedure Error(Str : in String) is 
    begin
        Put_Line("ERROR: " & Str);
    end Error;
    procedure Error(Str : in Unbounded_String) is 
    begin
        Error(To_String(Str));
    end Error;
    procedure Warning(Str : in String) is 
    begin
        Put_Line("WARNING: " & Str);
    end Warning;
    procedure Warning(Str : in Unbounded_String) is 
    begin
        Warning(To_String(Str));
    end Warning;

end debug_output; 
