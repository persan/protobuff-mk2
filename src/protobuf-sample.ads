with Protobuf.Field_Types;
package Protobuf.Sample is
   use Protobuf.Field_Types;

   type My_Message is new Protobuf.Base_Message with record
      Name  : String_Fields.Field (My_Message'Access, -1);
      Is_Valid : Boolean_Fields.Field (My_Message'Access, -1);
   end record;

   package My_Message_Fields is new Protobuf.Message_Fields_Generic (My_Message);

   type Msg2 is new Protobuf.Base_Message with record
      M : My_Message_Fields.Field (Msg2'Access, -1);
   end record;
end Protobuf.Sample;
