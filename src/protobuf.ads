with Ada.Finalization;
with Ada.Containers.Vectors;
with Ada.Strings.Unbounded;
with Ada.Streams;
package Protobuf is

   type Base_Message_Interface is limited interface;
   type Field_Id is range -1 .. Integer'Last;
   type Field (Parent : not null access Base_Message_Interface'Class; Id : Field_Id) is abstract new Ada.Finalization.Limited_Controlled with record
      null;
   end record with
     Read => Read,
     Write => Write;
   procedure Write (A : not null access Ada.Streams.Root_Stream_Type'Class; Date : Field) is null;
   procedure Read (A : not null access Ada.Streams.Root_Stream_Type'Class; Date : out Field) is null;

   type Field_Access is access all Field'Class with Storage_Size => 0;
   overriding procedure Initialize (Self : in out Field);
   overriding procedure Finalize   (Self : in out Field);

   procedure Register (Self : in out Base_Message_Interface; F : Field_Access) is abstract;

   generic
      type Enum is (<>);
   package Enum_Fields_Generic is
      type Field (Parent : not null access Base_Message_Interface'Class; Id : Field_Id) is new Protobuf.Field (Parent => Parent, Id => Id) with record
         Value : Enum;
      end record;
   end Enum_Fields_Generic;

   generic
      type Num is digits <>;
   package Float_Fields_Generic is
      type Field (Parent : not null access Base_Message_Interface'Class; Id : Field_Id) is new
        Protobuf.Field (Parent => Parent, Id => Id) with record
         Value : Num;
      end record;
   end Float_Fields_Generic;

   generic
      type Num is range <>;
   package Integer_Fields_Generic is
      type Field (Parent : not null access Base_Message_Interface'Class; Id : Field_Id) is new
        Protobuf.Field (Parent => Parent, Id => Id) with record
         Value : Num;
      end record;
   end Integer_Fields_Generic;


   generic
      type Str (<>) is new String;
   package String_Fields_Generic is
      type Field (Parent : not null access Base_Message_Interface'Class; Id : Field_Id) is new
        Protobuf.Field (Parent => Parent, Id => Id) with record
         Value : Ada.Strings.Unbounded.Unbounded_String;
      end record;
      procedure Set (Self : in out Field; Value : Str);
      function Get  (Self : Field) return Str;
   end String_Fields_Generic;

   type Base_Message is limited new Base_Message_Interface with private  with
     Read => Read,
     Write => Write;
   procedure Write (A : not null access Ada.Streams.Root_Stream_Type'Class; Date : Base_Message) is null;
   procedure Read (A : not null access Ada.Streams.Root_Stream_Type'Class; Date : out Base_Message) is null;
   overriding procedure Register (Self : in out Base_Message; F : Field_Access);

   generic
      type Message is new Base_Message with private;
   package Message_Fields_Generic is
      type Field (Parent : not null access Base_Message_Interface'Class; Id : Field_Id) is new Protobuf.Field
        (Parent => Parent, Id => Id) with record
         Value : Message;
      end record;
   end Message_Fields_Generic;

private
   package Field_Vectors is new Ada.Containers.Vectors (Index_Type => Natural, Element_Type => Field_Access);
   type Base_Message is limited new Base_Message_Interface with record
      Fields : Field_Vectors.Vector;
   end record;

end Protobuf;
