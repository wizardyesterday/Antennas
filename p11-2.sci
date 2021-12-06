//******************************************************************
// Problem P11-2
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

function f = calcF(l,d)
  r11 = real(calcZ11(1));
  r00 = r11;
  r12 = real(calcZ21(l,d));
  f = sqrt(2*r00 ./(r11 - r12));
endfunction

function [phi1,phi2] = calcPhiForUnityGain(l,d)
  pid = %pi * d;
  f = calcF(l,d);
  a1 = asin(1/f);
  a2 = asin(-1/f);
  phi1 = acos(a1/pid) * 180 / %pi;
  phi2 = acos(a2/pid) * 180 / %pi;
endfunction

//******************************************************************
// main code
//******************************************************************

//******************************************************************
// set parameters
//******************************************************************
d1 = 0.5;
d2 = 0.25;
l = 0.5;
beta = 2*%pi;

//******************************************************************
// compute angles for unity gain
//******************************************************************
[phi11 phi21] = calcPhiForUnityGain(l,d1);
[phi12 phi22] = calcPhiForUnityGain(l,d2);
