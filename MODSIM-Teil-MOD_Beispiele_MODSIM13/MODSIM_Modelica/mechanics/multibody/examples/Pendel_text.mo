within MODSIM_Modelica.mechanics.multibody.examples;

model Pendel_text "2D mathematisches Pendel, textual model"

  /* Deklaration von Variablen mit festen Werten */
  parameter Real l = 1;      // Pendellänge
  constant  Real g = 9.81;   // Erdanziehungsbeschleunigung
  
  /* Anfangswerte */
  parameter Real x0=1;               // frei wählbare x-Koordinate
  parameter Real vy0=0;              // frei wählbare y-Geschwindigkeit
  parameter Real y0=-sqrt(l^2-x0^2); // Berechnung y0
  parameter Real vx0=-y0*vy0/x0;     // Berechnung vx0
  parameter Real lamda_t0 = (vx0^2+vy0^2-g*y0)/l^2; // Berechnung lamda_t0

  /* Deklaration von kontinuierlichen Variablen */
  Real x(fixed=true, start=x0);   // x-Koordinate
  Real y(fixed=true, start=y0);   // y-Koordinate
  Real vx(fixed=true, start=vx0); // x-Geschwindigkeit
  Real vy(fixed=true, start=vy0); // y-Geschwindigkeit
  Real lamda_t(fixed=true, start=lamda_t0); // Lagrange-Faktor

equation 

  /* DAE-Modell in Semi-expliziter Standardform */
  der(x)  = vx;
  der(vx) = -x*lamda_t;
  der(y)  = vy;
  der(vy) = -g - y*lamda_t;
  0 = x^2 + y^2 - l^2;

end Pendel_text;