within MODSIM_Modelica.mechanics.multibody.examples;

model MassSpringDamperSystem_graph
  Modelica.Blocks.Sources.Step step1(height = 1000, startTime = 1)  annotation(Placement(visible = true, transformation(origin = {-36, -58}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.Translational.Sources.Force force1(useSupport = true)  annotation(Placement(visible = true, transformation(origin = {-16, -26}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Mechanics.Translational.Components.Fixed fixed2 annotation(Placement(visible = true, transformation(origin = {12, -26}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Mechanics.Translational.Components.Fixed fixed1 annotation(Placement(visible = true, transformation(origin = {-16, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  Modelica.Mechanics.Translational.Components.Spring spring1(c = 1000)  annotation(Placement(visible = true, transformation(origin = {-32, 38}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Mechanics.Translational.Components.Damper damper1(d = 10)  annotation(Placement(visible = true, transformation(origin = {0, 40}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Mechanics.Translational.Components.Mass mass1 annotation(Placement(visible = true, transformation(origin = {-16, 8}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
equation
  connect(mass1.flange_b, force1.flange) annotation(Line(points = {{-16, -2}, {-16, -2}, {-16, -16}, {-16, -16}}, color = {0, 127, 0}));
  connect(mass1.flange_a, damper1.flange_b) annotation(Line(points = {{-16, 18}, {0, 18}, {0, 30}, {0, 30}, {0, 30}}, color = {0, 127, 0}));
  connect(spring1.flange_b, mass1.flange_a) annotation(Line(points = {{-32, 28}, {-32, 28}, {-32, 18}, {-16, 18}, {-16, 18}}, color = {0, 127, 0}));
  connect(damper1.flange_a, fixed1.flange) annotation(Line(points = {{0, 50}, {0, 50}, {0, 60}, {-16, 60}, {-16, 60}, {-16, 60}}, color = {0, 127, 0}));
  connect(spring1.flange_a, fixed1.flange) annotation(Line(points = {{-32, 48}, {-32, 48}, {-32, 60}, {-16, 60}, {-16, 60}}, color = {0, 127, 0}));
  connect(force1.f, step1.y) annotation(Line(points = {{-16, -38}, {-16, -38}, {-16, -58}, {-26, -58}, {-26, -58}, {-24, -58}}, color = {0, 0, 127}));
  connect(force1.support, fixed2.flange) annotation(Line(points = {{-6, -26}, {12, -26}, {12, -26}, {12, -26}}, color = {0, 127, 0}));
  annotation(uses(Modelica(version = "3.2.1")), experiment(StartTime = 0, StopTime = 3, Tolerance = 0.001, Interval = 0.01));
end MassSpringDamperSystem_graph;