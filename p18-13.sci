//******************************************************************
// Problem P18-13
//******************************************************************

//*****************************************************************
// function declarations
//******************************************************************
function Zi = calcZi(Zc,Zl,Beta,d)
  z1 = Zl + %i*Zc*tan(Beta*d);
  z2 = Zc + %i*Zl*tan(Beta*d);
  Zi = Zc*z1/z2;
endfunction

function Zi = calcZiShort(Zc,Beta,d)
  Zi = %i*Zc*tan(Beta*d);
endfunction

function rhoDb = calcRhoInDb(Z0,Zl)
  rho = (Zl - Z0)/(Zl + Z0);
  rhoDb = 20*log10(abs(rho));
endfunction

//******************************************************************
// main code
//******************************************************************

//******************************************************************
// set parameters
//******************************************************************
c = 3e8;
e0 = 8.854e-12;
u0 = 4e-7*%pi;

er = 1.1;
ur = 1;

Beta = 2*%pi*c*sqrt(er*e0*ur*u0);
Z0 = sqrt(u0/e0);
Zc = Z0*sqrt(ur/er);

d = 0.1:0.01:0.37;
R1 = 250;
R2 = 625;
R3 = 1563;

//******************************************************************
// compute impedances
//******************************************************************
dlength = size(d);
dlength = dlength(2);

for i=1:1:dlength
  // impedance at first section
  Zi0 = calcZiShort(Zc,Beta,d(i));

  // first load impedance
  Zl1 = Zi0*R1/(Zi0 + R1);

  // impedance at second section
  Zi1 = calcZi(Zc,Zl1,Beta,d(i));

  // second load impedance
  Zl2 = Zi1*R2/(Zi1 + R2);

  // impedance at third section
  Zi2 = calcZi(Zc,Zl2,Beta,d(i));

  // input impedance
  Zi = Zi2*R3/(Zi2 + R3);

  // reflection coefficient
  rhoDb(i) = calcRhoInDb(Z0,Zi);
end

//******************************************************************
// plot reflection coefficient
//******************************************************************
set("figure_style","new");

title("Reflection Coefficient Versus Sheet Spacing");
a = gca();
a.margins = [0.125 0.2 0.125 0.125];
a.margins = [0.125 0.2 0.125 0.2];
a.grid = [1 1];
a.x_label.text = "Spacing, lamda";
a.y_label.text = "Reflection Coefficient, dB";
plot2d(d,rhoDb);

