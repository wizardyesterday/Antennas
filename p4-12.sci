//******************************************************************
// Problem P4-12
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
phi1=135;
phi2=180;
d1 = 0.3;
d2 = 0.2;
delta1 = calcDelta(d1,phi1);
delta2 = calcDelta(d2,phi2);
E1 = E(d1,delta1,phi);
E2 = E(d2,delta2,phi);
Et = E1 .* E2;
x = abs(Et).*cos(phi+%pi/4);
y = abs(Et).*sin(phi+%pi/4);
plot(x,y);
