//******************************************************************
// Problem P4-13
//******************************************************************

//******************************************************************
// function declarations
//******************************************************************
function x = E1(d,phi)
  psi = 2*%pi*d*cos(phi);
  x = 1 + exp(%i*psi);
  x = x / 2;
endfunction

function x = E2(d,phi)
  psi = 2*%pi*d*cos(phi);
  x = cos(psi/2);
endfunction

//******************************************************************
// main code
//******************************************************************
phi = 0:%pi/100:2*%pi;
theta = 0:360/200:360;
da = 3/4;
db = 3/2;
E1a = E1(da,phi);
E1b = E1(db,phi);
E2a = E2(da,phi);
E2b = E2(db,phi);
o1a = phasemag(E1a);
o1b = phasemag(E1b);
o2a = (sign(E2a) - 1) * (-90);
o2b = (sign(E2b) - 1) * (-90);

x = abs(E1a) .* cos(phi);
y = abs(E1a) .* sin(phi);
subplot(421);
plot2d(x,y);
subplot(422);
plot2d(theta,o1a);

x = abs(E1b) .* cos(phi);
y = abs(E1b) .* sin(phi);
subplot(423);
plot2d(x,y);
subplot(424);
plot2d(theta,o1b);

x = abs(E2a) .* cos(phi);
y = abs(E2a) .* sin(phi);
subplot(425);
plot2d(x,y);
subplot(426);
plot2d(theta,o2a);

x = abs(E2b) .* cos(phi);
y = abs(E2b) .* sin(phi);
subplot(427);
plot2d(x,y);
subplot(428);
plot2d(theta,o2b);
