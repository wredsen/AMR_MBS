within MODSIM_Modelica.electrical.analog;

package basic

connector Pin "Pin  of an electric component"
  Real v      "Potential at the pin";
  flow Real i "Current flowing into the pin";
end Pin;

model Capacitor "Ideal capacitor"
  parameter Real C=100e-6 "Capacitance, 100uF";
  Real v; // voltage on capacitor pins 
  Pin p;  // positive pin
  Pin n;  // negative pin
equation
  v = p.v - n.v;        // v>0, if potential on positive pin is larger 
  0 = p.i + n.i;        // Kirchhoffian node law
  der(v) = (1/C) * p.i; // constitutive equation
end Capacitor;

model Resistor "Ideal resistor"
  parameter Real R=1000 "Resistance, 1000 Ohm";
  Real v; // voltage on capacitor pins
  Pin p;  // positive pin
  Pin n;  // negative pin
equation
  v = p.v - n.v;
  0 = p.i + n.i;
  v = R * p.i;
end Resistor;

model ConstantVoltageSource "Ideal constant voltage source"
  parameter Real uS=1 "Voltage, 1 V";
  Pin p;
  Pin n;
equation
  uS = p.v - n.v;
  0  = p.i + n.i;
end ConstantVoltageSource;

model Ground "Ideal ground "
  Pin p;
equation
  p.v = 0;
end Ground;

end basic;
