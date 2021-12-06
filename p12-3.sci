//******************************************************************
// Problem P12-3
//******************************************************************

//*****************************************************************
// function declarations
//******************************************************************
function x = computeField(phi,alpha)
  psi1 = %pi*cos(phi-alpha);
  psi2 = %pi*sin(phi+alpha); 
  x1 = cos(psi1);
  x2 = cos(psi2);
  x = abs(x1 - x2);
endfunction

//******************************************************************
// main code
//******************************************************************

//******************************************************************
// set parameters
//******************************************************************
phi = 0:%pi/200:%pi;
alpha = 20*%pi/180;

//******************************************************************
// compute field
//******************************************************************
E = computeField(phi,alpha);

//******************************************************************
// plot field
//******************************************************************
set("figure_style","new");

title("Field of Lamda/2  Dipole Lamda/2 Over a Square Corner PI/9 Off Axis");
a = gca();
a.x_label.text = "x";
a.y_label.text = "y";
a.grid = [1 1];

x = abs(E) .* cos(phi);
y = abs(E) .* sin(phi);
plot2d(x,y);
