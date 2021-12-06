//******************************************************************
// Problem P12-5
//******************************************************************

//*****************************************************************
// function declarations
//******************************************************************
function x = computeFieldUniform(phi)
  psi = 16*%pi*sin(phi);
  x1 = sin(psi);
  x2 = psi;
  m = find(x2 == 0);
  x2(m) = .0001;
  x = x1 ./ x2;
endfunction

function x = computeFieldCosine(phi)
  psi1 = 16*%pi*sin(phi) + %pi/2;
  psi2 = 16*%pi*sin(phi) - %pi/2;
  x1 = sin(psi1);
  x2 = psi1;
  m = find(x2 == 0);
  x2(m) = .0001;
  xs = x1 ./ x2;
  x1 = sin(psi2);
  x2 = psi2;
  m = find(x2 == 0);
  x2(m) = .0001;
  xd = x1 ./ x2;
  x = xs + xd;
  x = x / max(abs(x));
endfunction

//******************************************************************
// main code
//******************************************************************

//******************************************************************
// set parameters
//******************************************************************
phid = -15:0.005:15;
phi = phid*%pi/180;

//******************************************************************
// construct fields
//******************************************************************
E1 = computeFieldUniform(phi);
E2 = computeFieldCosine(phi);

//******************************************************************
// rectangular plot of field
//******************************************************************
set("figure_style","new");
p = get("hdl");

title("Field Pattern of Cylindrical Parabolic Reflector, a;b = 16 Lamda");
a = gca();
a.margins = [0.125 0.2 0.125 0.125];
a.margins = [0.125 0.2 0.125 0.2];
a.grid = [1 1];
a.x_label.text = "phi, degrees";
a.y_label.text = "|E|";

p.line_style = 1;
plot2d(phid,abs(E1));

p.line_style = 6;
plot2d(phid,abs(E2));
