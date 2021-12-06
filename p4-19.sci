//******************************************************************
// Problem P4-19
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
d = 0.3;
phi1 = 131;
delta = calcDelta(d,phi1);
E1 = E(d,delta,phi);
x = abs(E1).*cos(phi+%pi/2);
y = abs(E1).*sin(phi+%pi/2);
plot(x,y);
