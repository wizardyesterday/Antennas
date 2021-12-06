//******************************************************************
// Problem P12-8
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

function x = computePrimaryPattern(phi,s)
  psi1 = 2*%pi*s*cos(phi);
  psi2 = 2*%pi*s*sin(phi);
  x1 = cos(psi1);
  x2 = cos(psi2);
  x = 2*(x1 - x2);
endfunction

function x = computeSecondaryPattern(phi,d)
  psi = 2*%pi*d*sin(phi);
  x1 = cos(psi/2);
  x2 = cos(3*psi/2);
  x = 2*(x1 + x2);
endfunction

//******************************************************************
// main code
//******************************************************************

//******************************************************************
// set parameters
//******************************************************************
phi = 0:%pi/200:%pi;
theta = 180*phi/%pi;
beta = 2*%pi;
n = 1;
L = 0.5;
s = 0.4;
d = 1;
d12 = sqrt(2) * s;
d14 = 2 * s;
d17 = sqrt(10) * s;
d18 = sqrt(8) * s;
d19 = 4 * s;
d111 = sqrt(26) * s;
d112 = sqrt(20) * s;
d113 = 6 * s;
d115 = sqrt(50) * s;
d116 = sqrt(40) * s;
d215 = 8 * s;
d36 = 0.000001;

//******************************************************************
// compute field
//******************************************************************
Epri = computePrimaryPattern(phi,s);
Esec = computeSecondaryPattern(phi,d);
E = Epri .* Esec;

//******************************************************************
// compute radiation resistance
//******************************************************************
r11 = real(calcZ11(n));
r12 = real(calcZ21(L,d12));
r14 = real(calcZ21(L,d14));
r17 = real(calcZ21(L,d17));
r18 = real(calcZ21(L,d18));
r19 = real(calcZ21(L,d19));
r111 = real(calcZ21(L,d111));
r112 = real(calcZ21(L,d112));
r113 = real(calcZ21(L,d113));
r115 = real(calcZ21(L,d115));
r116 = real(calcZ21(L,d116));
r215 = real(calcZ21(L,d215));
r36 = real(calcZ21(L,d36));
a = [16 -56 44 -40 12 24 -24 8 12 -8 4 -4 6];
rvec = [r11 r12 r14 r17 r18 r19 r111 r112 r113 r115 r116 r215 r36]';
r = a * rvec;

//******************************************************************
// compute gain
//******************************************************************
Gf = 2 * abs(E) * sqrt(r11/r);
Gflog = 20*log10(max(Gf));

