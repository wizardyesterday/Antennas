//******************************************************************
// Problem P12-11
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

function x = computeField(phi,s)
  psi1 = 2*%pi*s*cos(phi);
  psi2 = 2*%pi*s*sin(phi);
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
beta = 2*%pi;
n = 1;
L = 0.5;
s = 0.25;
d12 = sqrt(2) * s;
d14 = 2 * s;

//******************************************************************
// compute field
//******************************************************************
E = computeField(phi,s);

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
GdipoleLog = 2.15;
Glog = Gflog + GdipoleLog;


