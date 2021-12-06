//******************************************************************
// Problem P12-7
//******************************************************************

//*****************************************************************
// function declarations
//******************************************************************
function a = cin(x)
  v = 0:.01:x;
  v(1) = .0000001;
  i = (1 - cos(v)) ./ v;
  a = inttrap(v,i);
endfunction

function a = si(x)
  v = 0:.01:x;
  v(1) = .0000001;
  i = sin(v) ./ v;
  a = inttrap(v,i);
endfunction

function a = ci(x)
  a = 0.577 + log(x) - cin(x);
endfunction

function z11 = calcZ11(n)
  r11 = 30 * cin(2*%pi*n);
  x11 = 30 * si(2*%pi*n);
  z11 = r11 + %i*x11;
endfunction

function z21 = calcZ21(l,d)
  a1 = beta*d;
  a2 = beta*(sqrt(d*d + l*l) + l);
  a3 = beta*(sqrt(d*d + l*l) - l);
  r21 = 30*(2*ci(a1) - ci(a2) - ci(a3));
  x21 = -30*(2*si(a1) - si(a2) - si(a3));
  z21 = r21 + %i*x21;
endfunction

function x = computePrimaryPattern(phi,d)
  psi = 2*%pi*d*cos(phi);
  x = sin(psi/2);
endfunction

function x = computeSecondaryPattern(phi,d)
  psi = 2*%pi*d*sin(phi);
  x = sin(psi/2);
endfunction

//******************************************************************
// main code
//******************************************************************

//******************************************************************
// set parameters
//******************************************************************
phi = 0:%pi/100:2*%pi;
alpha = %pi/4;
beta = 2*%pi;
n = 1;
L = 0.5;
s = 0.35;
d = sqrt(2) * s;
d12 = sqrt(2) * s;
d14 = 2 * s;

//******************************************************************
// compute field
//******************************************************************
E1 = computePrimaryPattern(phi-alpha,d);
E2 = computeSecondaryPattern(phi-alpha,d);
E = 2 * abs(E1 .* E2);

//******************************************************************
// compute radiation resistance
//******************************************************************
r11 = real(calcZ11(n));
r12 = real(calcZ21(L,d12));
r14 = real(calcZ21(L,d14));
rin = r11 + r14 - 2*r12;

//******************************************************************
// compute gain
//******************************************************************
Gf = 2* abs(E) * sqrt(r11/rin);
Gflog = 20*log10(max(Gf));

//******************************************************************
// plot field
//******************************************************************
set("figure_style","new");

title("Field of 4 Lamda/2  Dipoles 0.7Lamda in a Cross Pattern");
a = gca();
a.x_label.text = "x";
a.y_label.text = "y";
a.grid = [1 1];

x = abs(E) .* cos(phi);
y = abs(E) .* sin(phi);
plot2d(x,y);
