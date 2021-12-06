//******************************************************************
// Problem P11-6
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

function  i = calcArrayCurrent(z11,z12,a,delta)
  r11 = real(z11);
  r12 = real(z12);
  x12 = imag(z12);
  a1 = 0.5;
  a2 = r11 + 0.5*((1/a) + a)*r12*cos(delta) + 0.5*((1/a)-a)*x12*sin(delta);
  i = sqrt(a1/a2);
endfunction

function  i = calcDipoleCurrent(z11)
  r11 = real(z11);
  i = sqrt(1/r11);
endfunction

function x = calcDipoleEH(phi)
  a = size(phi);
  a = a(2);
  x = ones(1,a);
endfunction

function x = calcDipoleEV(theta)
  x1 = cos((%pi/2)*cos(theta));
  x2 = sin(theta);
  m = find(x2 == 0);
  x2(m) = 0.000001;
  x = x1./x2;
endfunction

function x = calcArrayEh(phi,d,delta)
  psi = 2*%pi*d*cos(phi) + delta;
  x = cos(psi/2);
endfunction

function x = calcArrayEv(theta,d,delta)
  psi = 2*%pi*d*sin(theta) + delta;
  alpha = (%pi/2)*cos(theta);
  x1 = cos(psi/2).*cos(alpha);
  x2 = sin(theta);
  m = find(x2 == 0);
  x2(m) = 0.000001;
  x = x1./x2;
endfunction

//******************************************************************
// main code
//******************************************************************

//******************************************************************
// set parameters
//******************************************************************
phi = 0:%pi/100:2*%pi;
theta = -%pi:%pi/100:%pi;
d = 0.25;
a = 0.5;
delta = 120*(%pi/180);
n = 1;
l = 0.5;
beta = 2*%pi;


//******************************************************************
// compute self and mutual impedances
//******************************************************************
z11 = calcZ11(n);
z12 = calcZ21(l,d);

//******************************************************************
// construct fields for dipole and array
//******************************************************************
eDipoleH = calcDipoleEH(phi);
eDipoleV = calcDipoleEV(theta);
eArrayH = calcArrayEh(phi,d,delta);
eArrayV = calcArrayEv(theta,d,delta);

// calculate currents
i0 = calcDipoleCurrent(z11);
i1 = calcArrayCurrent(z11,z12,a,delta);

// scale for absolute fields
eDipoleH = i0 * eDipoleH;
eDipoleV = i0 * eDipoleV;
eArrayH = 2 * i1 * eArrayH;
eArrayV = 2 * i1 * eArrayV;

//******************************************************************
// plot horizontal fields
//******************************************************************
subplot(121);
x = abs(eDipoleH) .* cos(phi);
y = abs(eDipoleH) .* sin(phi);
plot2d(x,y);

x = abs(eArrayH) .* cos(phi);
y = abs(eArrayH) .* sin(phi);
plot2d(x,y);

//******************************************************************
// plot vertical fields
//******************************************************************
subplot(122);
x = abs(eDipoleV) .* cos(phi);
y = abs(eDipoleV) .* sin(phi);
plot2d(y,x);

x = abs(eArrayV) .* cos(phi);
y = abs(eArrayV) .* sin(phi);
plot2d(y,x);
