//******************************************************************
// Problem P11-4
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

function x = calcEDipoleV(theta)
  a = size(theta);
  a = a(2);
  x = ones(1,a);
endfunction

function x = calcEDipoleH(phi)
  x1 = cos((%pi/2)*cos(phi));
  x2 = sin(phi);
  m = find(x2 == 0);
  x2(m) = 0.000001;
  x = x1./x2;
endfunction

function x = calcEW8jkV(d,theta)
  psi = 2*%pi*d*cos(theta);
  x = 2*sin(psi/2);
endfunction

function x = calcEW8jkH(d,phi)
  psi = 2*%pi*d*sin(phi);
  alpha = (%pi/2)*cos(phi);
  x1 = cos(alpha);
  x3 = sin(psi/2);
  x2 = sin(phi);
  m = find(x2 == 0);
  x2(m) = 0.000001;
  x = 2*(x1./x2).*x3;
endfunction

//******************************************************************
// main code
//******************************************************************

//******************************************************************
// set parameters
//******************************************************************
phi = 0:%pi/100:2*%pi;
theta = -%pi:%pi/100:%pi;
d = 1/8;
r1l = 1;
n = 1;
l = 0.5;
beta = 2*%pi;

//******************************************************************
// compute self resistance and self reactance terms
//******************************************************************
z11 = calcZ11(n);
r11 = real(z11);
z12 = calcZ21(l,d);
r12 = real(z12);

//******************************************************************
// compute radiation efficiency
//******************************************************************
r1 = r11 - r12;
eta = r1 / (r1 + r1l);
 
//******************************************************************
// Construct fields for dipole and array
//******************************************************************
eDipoleV = calcEDipoleV(theta);
eDipoleH = calcEDipoleH(phi);
eArrayV = calcEW8jkV(d,theta);
eArrayH = calcEW8jkH(d,phi);

eArrayV = eArrayV * eta;
eArrayH = eArrayH * eta;

//******************************************************************
// Plot fields in the horizontal plane
//******************************************************************
subplot(121);
x = abs(eDipoleH) .* cos(phi);
y = abs(eDipoleH) .* sin(phi);
plot2d(x,y);

x = abs(eArrayH) .* cos(phi);
y = abs(eArrayH) .* sin(phi);
plot2d(x,y);

//******************************************************************
// Plot fields in the vertical plane
//******************************************************************
subplot(122);
x = abs(eDipoleV) .* cos(phi);
y = abs(eDipoleV) .* sin(phi);
plot2d(y,x);

x = abs(eArrayV) .* cos(phi);
y = abs(eArrayV) .* sin(phi);
plot2d(y,x);
