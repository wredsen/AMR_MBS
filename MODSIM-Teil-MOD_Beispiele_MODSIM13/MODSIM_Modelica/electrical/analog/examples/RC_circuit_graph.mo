within MODSIM_Modelica.electrical.analog.examples;

model RC_circuit_graph
  Modelica.Electrical.Analog.Basic.Ground ground1 annotation(Placement(visible = true, transformation(origin = {-22, -24}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Basic.Resistor resistor1(R = 1000) annotation(Placement(visible = true, transformation(origin = {10, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Basic.Capacitor capacitor1(C = 100e-6) annotation(Placement(visible = true, transformation(origin = {32, 2}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltage1(V = 1) annotation(Placement(visible = true, transformation(origin = {-22, 2}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
equation
  connect(constantVoltage1.n, ground1.p) annotation(Line(points = {{-22, -8}, {-22, -8}, {-22, -14}, {-22, -14}}, color = {0, 0, 255}));
  connect(capacitor1.n, ground1.p) annotation(Line(points = {{32, -8}, {32, -8}, {32, -14}, {-22, -14}, {-22, -14}}, color = {0, 0, 255}));
  connect(resistor1.n, capacitor1.p) annotation(Line(points = {{20, 20}, {32, 20}, {32, 12}, {32, 12}}, color = {0, 0, 255}));
  connect(constantVoltage1.p, resistor1.p) annotation(Line(points = {{-22, 12}, {-22, 12}, {-22, 20}, {0, 20}, {0, 20}}, color = {0, 0, 255}));
  annotation(uses(Modelica(version = "3.2.1")), experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-06, Interval = 0.01));
end RC_circuit_graph;