package body xzang.internal.readers is

   function Read(Self : in reader; Number_Of_Bytes : in Natural)
      return byte_array is
      buffer : byte_arraY(1..Number_Of_Bytes);
   begin
      for b of buffer loop
         byte'Read(Self.Stream, b);
      end loop;
      return buffer;
   end Read;

   function Read (Self : in reader; Number_Of_Bits : in Natural)
      return bit_array is
      buffer : bit_array(1..Number_Of_bits) := (others => 0); 
   begin
      for b of buffer loop
         bit'Read(Self.Stream, b); 
      end loop;
      return buffer;
   end Read;

   procedure Close(Self : in out Reader) is
   begin
      Ada.Streams.Stream_IO.Close (Self.File);
      Self.Initialized := False;
   end Close;

   function Read (Self : in reader)
      return Ada.Streams.Stream_element_Array
   is
      Sea : Ada.Streams.Stream_element_Array(1..Self.Max_Length);
      Last : Ada.Streams.Stream_element_offset;
   begin
      Ada.Streams.Stream_IO.Read (Self.File, Sea, Last );
      return Sea(1..Last);
   end Read;


   procedure Reset (Self : in out Reader) is
   begin
      Ada.Streams.Stream_IO.Reset(Self.FIle);
   end reset;

   procedure Open (Self : in out reader) is
   begin
      Ada.Streams.Stream_IO.Open
         (File => Self.File,
         Name => Self.Filename.all,
         Mode => Ada.Streams.Stream_IO.In_File);
      Self.Stream := Ada.Streams.Stream_IO.Stream (Self.File);
      Self.Initialized := True;
   end Open;

   procedure Free_Ptr (Self : in out Reader) is
   begin
      raise NOT_IMPLEMENTED with "xzang.internal.readers.Free_Ptr";
   end Free_Ptr;

   overriding
   procedure Finalize (Self : in out Reader) is
   begin
      Self.Close;
   end Finalize;

   overriding
   procedure Initialize (Self : in out Reader) is
   begin
      Self.Open;
   end Initialize;

   not overriding
   function EOF (Self : in out reader) return Boolean is
      (Ada.Streams.Stream_IO.End_Of_File (Self.File) );



end xzang.internal.readers;

