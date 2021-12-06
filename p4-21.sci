//******************************************************************
// Problem P4-21
//******************************************************************

//******************************************************************
// function declarations
//******************************************************************
function x = E(d,delta,phi)
  psi = 2*%pi*d*cos(phi) + delta;
  x = cos(psi/2);
endfunction

function delta = calcDelta(d,phi)
  phiRad = phi*%pi/180;
  delta = %pi - 2*%pi*d*cos(phiRad);
endfunction

//******************************************************************
// main code
//******************************************************************

phi = 0:%pi/100:2*%pi;
phiq = phi - %pi/2;
o = phi*180/%pi;
d1 = 1.06;
d2 = 1.06;
delta1 = 0;
delta2 = 0;
E1 = E(d1,delta1,phi);
E2 = E(d2,delta2,phiq);
Et = E1.*E2;
x = abs(Et).*cos(phi);
y = abs(Et).*sin(phi);
plot(x,y);
