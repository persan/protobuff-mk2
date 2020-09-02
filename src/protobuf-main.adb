with GNAT.Traceback.Symbolic;
with GNAT.Exception_Traces;
with Ada.Text_IO; use Ada.Text_IO;

procedure Protobuf.Main is

begin
   GNAT.Exception_Traces.Trace_On (GNAT.Exception_Traces.Every_Raise);
   GNAT.Exception_Traces.Set_Trace_Decorator (GNAT.Traceback.Symbolic.Symbolic_Traceback_No_Hex'Access);
   Put_Line ("Useless");
end Protobuf.Main;
