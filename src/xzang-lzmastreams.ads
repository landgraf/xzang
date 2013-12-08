with xzang.internal.readers;
with xzang.internal.stream_headers;
with xzang.internal.stream_footers;
with xzang.internal.decompressors;
with Ada.Streams;
with xzang.internal.types; use xzang.internal.types;
package xzang.lzmastreams is

   PARSE_ERROR : exception;

   type lzmastream(Name : US.String_Access := new String'("");
      Length : Ada.Streams.Stream_Element_Offset := 1000) is tagged limited private;
   type lzmastream_access is access all lzmastream;

   not overriding
   procedure Close (Self : in out lzmastream);
   --  close associated reader and decompressor

   not overriding
   function Next_String (Self : in out lzmastream) return String;
   --  return new string
   --  DEPRECATED

   not overriding
   function EOS (Self : in out lzmastream) return Boolean;
   --  return True if end of file has been reached


   not overriding
   function Init (Name : in String; Buffer : in Integer)
      return lzmastream_access;
   --  init readers and decompressors

   private
   type lzmastream(Name : US.String_Access := new String'("");
      Length : Ada.Streams.Stream_Element_Offset := 1000) is tagged limited
   record
      filereader : xzang.internal.readers.reader(Name,Length);
      decompressor : xzang.internal.decompressors.decompressor;
      header : internal.stream_headers.stream_header;
      footer : internal.stream_footers.stream_footer;
   end record;
end xzang.lzmastreams;

