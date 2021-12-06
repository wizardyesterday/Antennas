//******************************************************************
// Problem P16-4
//******************************************************************

//*****************************************************************
// function declarations
//******************************************************************
function x = computeDipoleField(phi)
  psi = 0.5*%pi*cos(phi);
  x1 = cos(psi);
  x2 = sin(phi);
  m = find(abs(x2) < 0.001);
  x2(m) = 100000;
  x = x1 ./ x2;
endfunction

function x = computeE12(phi)
  e1 = computeDipoleField(phi-%pi/3);
  e2 = computeDipoleField(phi+%pi/3);
  psi = 0.125*%pi*cos(phi);
  x = e1.*exp(%i*psi) + e2.*exp(-%i*psi);
endfunction

function x = computeArrayField(phi)
  e0 = computeDipoleField(phi);
  e12 = computeE12(phi);
  psi = 0.125*sqrt(3)*%pi*sin(phi);
  x = e0.*exp(%i*psi) + e12.*exp(-%i*psi);
endfunction

//******************************************************************
// main code
//******************************************************************

//******************************************************************
// set parameters
//******************************************************************
phid = -180:0.01:180;
phi = phid*%pi/180;

//******************************************************************
// compute fields
//******************************************************************
// compute field of array
E = computeArrayField(phi);

//******************************************************************
// plot field
//******************************************************************
set("figure_style","new");

title("E(phi) For Triangular Loop");
a = gca();
a.margins = [0.125 0.2 0.125 0.125];
a.margins = [0.125 0.2 0.125 0.2];
a.grid = [1 1];
a.x_label.text = "x";
a.y_label.text = "y";
x = abs(E) .* cos(phi);
y = abs(E) .* sin(phi);
plot2d(x,y);
