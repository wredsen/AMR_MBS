within MODSIM_Modelica.electrical.analog.examples;

model RC_circuit_text "RC circuit textual model"

	MODSIM_Modelica.electrical.analog.basic.Ground    Ground1;
	MODSIM_Modelica.electrical.analog.basic.Resistor  Resistor1(R=1000);
	MODSIM_Modelica.electrical.analog.basic.Capacitor Capacitor1(C=100e-6);
	MODSIM_Modelica.electrical.analog.basic.ConstantVoltageSource ConstantVoltageSource1(uS=1);
equation 
	connect(Resistor1.n,               Capacitor1.p);
	connect(Capacitor1.n,              Ground1.p);
	connect(Ground1.p,                 ConstantVoltageSource1.n);
	connect(ConstantVoltageSource1.p,  Resistor1.p); 
end RC_circuit_text;