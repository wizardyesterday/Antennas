//******************************************************************
// Problem P11-17
//******************************************************************

//*****************************************************************
// function declarations
//******************************************************************
function x = calcElementField(b,p,phi)
  x1 = sin(phi);
  x2 = 1 - p*cos(phi);
  m = find(x2 == 0);
  x2(m) = 0.000001;
  a = b*%pi*((1/p) - cos(phi));
  x3 = sin(a);
  x = x1 .* x3 ./ x2;
endfunction

function x = calcTerminatedvField(b,p,beta,phi)
  d = b*sin(beta);
  psi = 2*%pi*d*sin(phi);
  E1 = calcElementField(b,p,phi-beta);
  E2 = calcElementField(b,p,phi+beta);
  x = E1 .* exp(-%i*psi/2) - E2 .* exp(%i*psi/2);
endfunction

//******************************************************************
// main code
//******************************************************************

//******************************************************************
// set parameters
//******************************************************************
phi = 0:%pi/100:2*%pi;
l = 5;
p = 1;
beta = %pi/8;

//******************************************************************
// construct field
//******************************************************************
// construct field for terminated V
E = calcTerminatedvField(l,p,beta,phi);

//******************************************************************
// plot fields
//******************************************************************
set("figure_style","new");

title("Terminated V Horizontal Pattern at gamma: 45 Degrees, l: 5 lamda");
a = gca();
a.grid = [1 1];
a.x_label.text = "Ex";
a.y_label.text = "Ey";
x = abs(E) .* cos(phi);
y = abs(E) .* sin(phi);
plot2d(x,y);

