within MODSIM_Modelica.mechanics.multibody.examples;

model TwoMassSystemRigid_graph
  Modelica.Mechanics.Translational.Sources.Force force1(useSupport = true)  annotation(Placement(visible = true, transformation(origin = {-42, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Sine sine1(amplitude = 100, freqHz = 10) annotation(Placement(visible = true, transformation(origin = {-82, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.Translational.Components.Mass mass1(m = 0.1) annotation(Placement(visible = true, transformation(origin = {-4, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.Translational.Components.Mass mass2(m = 0.2) annotation(Placement(visible = true, transformation(origin = {64, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.Translational.Components.Rod rod1(L = 0) annotation(Placement(visible = true, transformation(origin = {30, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.Translational.Components.Fixed fixed1 annotation(Placement(visible = true, transformation(origin = {-42, -8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(force1.support, fixed1.flange) annotation(Line(points = {{-42, 2}, {-42, -8}}, color = {0, 127, 0}));
  connect(sine1.y, force1.f) annotation(Line(points = {{-70, 12}, {-54, 12}}, color = {0, 0, 127}));
  connect(force1.flange, mass1.flange_a) annotation(Line(points = {{-32, 12}, {-14, 12}}, color = {0, 127, 0}));
  connect(rod1.flange_b, mass2.flange_a) annotation(Line(points = {{40, 12}, {54, 12}}, color = {0, 127, 0}));
  connect(rod1.flange_a, mass1.flange_b) annotation(Line(points = {{20, 12}, {6, 12}}, color = {0, 127, 0}));
  annotation(uses(Modelica(version = "3.2.1")), experiment(StartTime = 0, StopTime = 0.3, Tolerance = 1e-06, Interval = 0.001));
end TwoMassSystemRigid_graph;