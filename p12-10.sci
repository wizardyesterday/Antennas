//******************************************************************
// Problem P12-10
//******************************************************************

//*****************************************************************
// function declarations
//******************************************************************
function x = computeField(theta)
  psi1 = %pi*sin(theta);
  psi2 = 0.5*%pi*cos(theta);
  x1 = 1 - cos(psi1);
  x2 = cos(psi2);
  x3 = sin(theta);
  m = find(x3 == 0);
  x3(m) = .0001;
  x = (x1 .* x2) ./ x3;
endfunction

//******************************************************************
// main code
//******************************************************************

//******************************************************************
// set parameters
//******************************************************************
thetad = 0:0.01:180;
theta = thetad*%pi/180;

//******************************************************************
// construct fields
//******************************************************************
E = computeField(theta);

//******************************************************************
// rectangular plot of field
//******************************************************************
set("figure_style","new");
p = get("hdl");

title("Field Pattern of Square Corner Reflector, S =  Lamda/2");
a = gca();
a.margins = [0.125 0.2 0.125 0.125];
a.margins = [0.125 0.2 0.125 0.2];
a.grid = [1 1];
a.x_label.text = "theta, degrees";
a.y_label.text = "|E|";

plot2d(thetad,abs(E));

