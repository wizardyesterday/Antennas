//******************************************************************
// Problem P4-29
//******************************************************************

//******************************************************************
// function declarations
//******************************************************************
function x = E2(d,delta,phi)
  psi = 2*%pi*d*cos(phi) + delta;
  f1 = 1 + exp(%i*psi);
  f2 = 1 + exp(%i*psi);
  x = f1.*f2;
endfunction

function x = E4(d,delta,phi)
  psi = 2*%pi*d*cos(phi) + delta;
  f1 = 1 + 3*exp(%i*psi);
  f2 = 1 + exp(%i*psi);
  x = f1.*f2;
endfunction

function x = E6(d,delta,phi)
  psi = 2*%pi*d*cos(phi) + delta;
  f1 = 1 + 5*exp(%i*psi) + 10*exp(%i*2*psi);
  f2 = 1 + exp(%i*psi);
  x = f1.*f2;
endfunction

//******************************************************************
// main code
//******************************************************************
phi = 0:%pi/100:2*%pi;
d = 0.5;
delta = 0;

E2m = abs(E2(d,delta,phi));
E4m = abs(E4(d,delta,phi));
E6m = abs(E6(d,delta,phi));

x = E2m.*cos(phi);
y = E2m.*sin(phi);
subplot(131)
plot2d(x,y);

x = E4m.*cos(phi);
y = E4m.*sin(phi);
subplot(132)
plot2d(x,y);

x = E6m.*cos(phi);
y = E6m.*sin(phi);
subplot(133)
plot2d(x,y);

