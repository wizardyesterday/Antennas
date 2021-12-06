//******************************************************************
// Problem P4-17
//******************************************************************

//******************************************************************
// function declarations
//******************************************************************
function x = Eendn(n,d,delta,phi)
  psi = 2*%pi*d*cos(phi) + delta;
  zeta = ((n-1)/2)*psi;
  x1 = sin(n*psi/2);
  x2 = sin(psi/2);
  m = find(x1 == 0);
  x1(m) = 0.000001
  m = find(x2 == 0);
  x2(m) = 0.000001/n;
  x = exp(%i*zeta).*x1./x2/n;
endfunction

function x = Ecentern(n,d,delta,phi)
  psi = 2*%pi*d*cos(phi) + delta;
  x1 = sin(n*psi/2);
  x2 = sin(psi/2);
  m = find(x1 == 0);
  x1(m) = 0.000001
  m = find(x2 == 0);
  x2(m) = 0.000001/n;
  x = x1./x2/n;
endfunction

//******************************************************************
// main code
//******************************************************************
phi = 0:%pi/100:2*%pi;
theta = 0:360/200:360;
d = 1/2;
n = 4;
delta1 = 0;
delta2 = -2*%pi*d;
E1a = Eendn(n,d,delta1,phi);
E1b = Ecentern(n,d,delta1,phi);
E2a = Eendn(n,d,delta2,phi);
E2b = Ecentern(n,d,delta2,phi);

o1a = atan(imag(E1a),real(E1a))*180/%pi;
o1b = atan(imag(E1b),real(E1b))*180/%pi;
o2a = atan(imag(E2a),real(E2a))*180/%pi;
o2b = atan(imag(E2b),real(E2b))*180/%pi;

x = abs(E1a) .* cos(phi);
y = abs(E1a) .* sin(phi);
subplot(4,2,1);
plot2d(x,y);
subplot(4,2,3);
plot(theta,abs(E1a));
subplot(4,2,5);
plot2d(theta,o1a);
subplot(4,2,7);
plot2d(theta,o1b);

x = abs(E2a) .* cos(phi);
y = abs(E2a) .* sin(phi);
subplot(4,2,2);
plot2d(x,y);
subplot(4,2,4);
plot(theta,abs(E2a));
subplot(4,2,6);
plot2d(theta,o2a);
subplot(4,2,8);
plot2d(theta,o2b);

