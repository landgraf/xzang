with xzang.internal.types; use xzang.internal.types;
with Ada.Streams.Stream_IO;
with Ada.Unchecked_Deallocation;
with Ada.Finalization;

package xzang.internal.readers is

   type reader(
      Filename : US.String_Access := new String'("NONE");
      Max_Length : Ada.Streams.Stream_Element_Offset := 1000
      ) is limited new Ada.Finalization.Limited_Controlled with private;
   type reader_access is access all reader;

   function Read (Self : in reader; Number_Of_Bytes : in Natural)
      return byte_array;
      --  read number of bytes and return them to the stream

   function Read (Self : in reader; Number_Of_Bits : in Natural)
      return bit_array;
      --  read number of bits and return them to the stream
   
   function Read (Self : in reader)
      return Ada.Streams.Stream_element_Array
      with Pre => Ada.Streams.Stream_Element'Size = 8;
      --  read Stream_Element_Array and return it to the stream
      --  Only if Element size equals to 1 byte

   procedure Reset (Self : in out Reader);
   --  Reset stream. Start from the beginning of file
   --  Not available for network streams for example

   procedure Free_Ptr (Self : in out Reader);
   -- FIXME
   -- stub should be implemented

   overriding
   procedure Finalize (Self : in out Reader);

   overriding
   procedure Initialize (Self : in out Reader);

   not overriding
   function EOF (Self : in out reader) return Boolean;
   -- return True then end of file has been reached

   not overriding
   function Read_VLI (Self : in out reader) return byte_array; 
   -- Return byte_array with variable-length integer represenration
   -- see 1.2. Multibyte Integers section in the format.txt file

private

   procedure Open (Self : in out reader);

   procedure Close (Self : in out Reader);

   type reader(
      Filename : US.String_Access := new String'("NONE");
      Max_Length : Ada.Streams.Stream_Element_Offset := 1000
      ) is limited new Ada.Finalization.Limited_Controlled with record
      Stream : Ada.Streams.Stream_IO.Stream_Access;
      File : Ada.Streams.Stream_IO.File_Type;
      Last : Ada.Streams.Stream_element_offset;
      Initialized : Boolean := False;
      Buffer : Ada.Streams.Stream_element_Array(1..Max_Length);
   end record;

   procedure Free_String is new Ada.Unchecked_Deallocation (
      Name => US.String_Access,
      Object => String);



end xzang.internal.readers;

