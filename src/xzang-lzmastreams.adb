with xzang.internal.stream_flags;
package body xzang.lzmastreams is

   function Is_LZMA_Stream (Self : in lzmastream) return Boolean
   is (internal.stream_headers.check_magic(self.header) and then
      internal.stream_headers.check_crc32(self.header));

   procedure Read_footer (Self : in out lzmastream) is
      use internal.stream_footers;
      use internal.stream_headers;
      use xzang.internal.stream_flags;
   begin
      self.footer := bytes_to_footer(Self.filereader.read(self.footer'Size));
      if not check_magic(self.footer) then
         raise parse_error;
      end if;
      if not check_magic(self.footer) or else
         stream_flags(self.footer) /= stream_flags(self.header) then
         raise PARSE_ERROR;
      end if;
   end Read_footer;

   procedure Read_Header (Self : in out lzmastream) is
      use internal.stream_headers;
   begin
      self.header := bytes_to_header(Self.filereader.read(self.header'Size));
   end Read_Header;

   function Init(Name : in String; Buffer : in Integer)
      return lzmastream_access
   is
      Name_Access : US.String_Access := new String'(Name);
      Length : Ada.Streams.Stream_Element_Offset :=
         Ada.Streams.Stream_Element_Offset(Buffer);
      Self : lzmastream_access := new lzmastream(Name => Name_Access,
         Length => Length);
   begin
      read_header(Self.all);
      --  After all
      --  read_footer(Self.all);
      if not Is_LZMA_Stream(Self.all) then
         raise PARSE_ERROR with ("File: " & Name & "is not xz stream " &
            "or corrupted");
      end if;
      return Self;
   end Init;


   not overriding
   procedure Close (Self : in out lzmastream) is
   begin
      xzang.internal.readers.Free_Ptr(Self.filereader);
   end Close;

   not overriding
   function Next_String (Self : in out lzmastream) return String is
   begin
      raise NOT_IMPLEMENTED;
      return "NONE";
   end Next_String;

   not overriding
   function EOS (Self : in out lzmastream) return Boolean is
      (Self.filereader.EOF);
end xzang.lzmastreams;

