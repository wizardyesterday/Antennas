//******************************************************************
// Problem P12-12
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

function x = computePhiField(phi)
  psi1 = %pi*cos(phi);
  psi2 = %pi*sin(phi); 
  x1 = cos(psi1);
  x2 = cos(psi2);
  x = abs(x1 - x2);
endfunction

function x = computeThetaField(theta)
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
phid = -45:0.01:45;
thetad = 0:0.01:180;
phi = phid*%pi/180;
theta = thetad*%pi/180;
beta = 2*%pi;
n = 1;
L = 0.5;
s = 0.5;
d12 = sqrt(2) * s;
d14 = 2 * s;
Gdipoleiso = 2.15;

//******************************************************************
// compute fields
//******************************************************************
E1 = computePhiField(phi);
E1n = E1 / max(abs(E1));
E2 = computeThetaField(theta);
E2n = E2 / max(abs(E2));

//******************************************************************
// compute terminal impedance
//******************************************************************
z11 = calcZ11(n);
z12 = calcZ21(L,d12);
z14 = calcZ21(L,d14);
zt = z11 + z14 - 2*z12;

//******************************************************************
// compute gain
//******************************************************************
r11 = real(z11);
rt = real(zt);
Gf = 2 * abs(E1) * sqrt(r11/rt);
Gflog = 20*log10(max(Gf));
Gflogiso = Gflog + Gdipoleiso;

//******************************************************************
// plot field
//******************************************************************
set("figure_style","new");

subplot(211);
title("Field of Half Wave Dipole 0.5  Wavelength Over a Square Corner");
a = gca();
a.margins = [0.125 0.2 0.125 0.125];
a.margins = [0.125 0.2 0.125 0.2];
a.grid = [1 1];
a.x_label.text = "phi, degrees";
a.y_label.text = "|E|";
plot2d(phid,abs(E1n));

subplot(212);
title("Field of Half Wave Dipole 0.5  Wavelength Over a Square Corner");
a = gca();
a.margins = [0.125 0.2 0.125 0.125];
a.margins = [0.125 0.2 0.125 0.2];
a.grid = [1 1];
a.x_label.text = "theta, degrees";
a.y_label.text = "|E|";
plot2d(thetad,abs(E2n));

