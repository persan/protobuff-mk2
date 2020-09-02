pragma Ada_2012;
package body Protobuf is

   ----------------
   -- Initialize --
   ----------------

   overriding procedure Initialize (Self : in out Field) is
   begin
      Self.Parent.Register (Self'Unrestricted_Access);
   end Initialize;

   --------------
   -- Finalize --
   --------------

   overriding procedure Finalize (Self : in out Field) is
   begin
      null;
   end Finalize;

   --------------
   -- Register --
   --------------

   overriding procedure Register (Self : in out Base_Message; F : Field_Access)
   is
   begin
      Self.Fields.Append (F);
   end Register;

   package body String_Fields_Generic is
      procedure Set (Self : in out Field; Value : Str) is
      begin
         Ada.Strings.Unbounded.Set_Unbounded_String (Self.Value, String (Value));
      end;
      function Get  (Self : Field) return Str is
      begin
         return Str (Ada.Strings.Unbounded.To_String (Self.Value));
      end;
   end String_Fields_Generic;

end Protobuf;
