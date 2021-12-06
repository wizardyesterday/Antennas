//******************************************************************
// Problem P6-7
//******************************************************************

//*****************************************************************
// function declarations
//******************************************************************
function x = E(c,phi)
  v = sin(phi);
  v = v * c;
  x = besselj(1,v);
endfunction

function r = calcRadiationResistance(c)
  a = 60*%pi*%pi*c;
  v = 0:.01:2*c;
  i = besselj(2,v);
  r = inttrap(v,i);
  r = r * a;
endfunction

function d = calcDirectivity(c,phi)
  v = sin(phi);
  v = v * c;
  n1 = besselj(1,v);
  n1 = n1 .* n1;
  n1 = max(n1);
  n1 = 2 * c * n1;
  v = 0:.01:2*c;
  i = besselj(2,v);
  d1 = inttrap(v,i);
  d = n1 ./ d1;
endfunction

//******************************************************************
// main code
//******************************************************************

//******************************************************************
// set parameters
//******************************************************************
phi = 0:%pi/100:2*%pi;
c1 = %pi/3;
c2 = 0.75*%pi;
c3 = 2*%pi;

//******************************************************************
// construct fields
//******************************************************************
E1 = E(c1,phi);
E2 = E(c2,phi);
E3 = E(c3,phi);

//******************************************************************
// polar plot of field
//******************************************************************
x = abs(E1) .* cos(phi);
y = abs(E1) .* sin(phi);
subplot(311);
plot2d(y,x);

x = abs(E2) .* cos(phi);
y = abs(E2) .* sin(phi);
subplot(312);
plot2d(y,x);

x = abs(E3) .* cos(phi);
y = abs(E3) .* sin(phi);
subplot(313);
plot2d(y,x);

//******************************************************************
// calculate radiation resistances
//******************************************************************
Rr1 = calcRadiationResistance(c1);
Rr2 = calcRadiationResistance(c2);
Rr3 = calcRadiationResistance(c3);

//******************************************************************
// calculate directivities
//******************************************************************
d1 = calcDirectivity(c1,phi);
d2 = calcDirectivity(c2,phi);
d3 = calcDirectivity(c3,phi);

