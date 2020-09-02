package Protobuf.Field_Types is

   package Float_Fields is new Float_Fields_Generic (Float);
   package Long_Float_Fields is new Float_Fields_Generic (Long_Float);
   package Long_Long_Float_Fields is new Float_Fields_Generic (Long_Long_Float);

   package Short_Short_Integer_Fields is new Integer_Fields_Generic (Short_Short_Integer);
   package Short_Integer_Fields is new Integer_Fields_Generic (Short_Integer);
   package Integer_Fields is new Integer_Fields_Generic (Integer);
   package Long_Integer_Fields is new Integer_Fields_Generic (Long_Integer);
   package Boolean_Fields is new Enum_Fields_Generic (Boolean);

   package String_Fields is new String_Fields_Generic (String);

end Protobuf.Field_Types;
