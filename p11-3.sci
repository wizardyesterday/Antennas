//******************************************************************
// Problem P11-3
//******************************************************************

//*****************************************************************
// function declarations
//******************************************************************
function x = calcEBroadsideH(d,phi)
  psi = 2*%pi*d*cos(phi)
  x = 2*cos(psi/2);
endfunction

function x = calcEBroadsideV(d,phi)
  alpha = (%pi/2)*cos(phi)
  x1 = cos(alpha);
  x2 = sin(phi);
  m = find(x2 == 0);
  x2(m) = 0.000001;
  x = 2*(x1./x2);
endfunction

function x = calcEEndfireH(d,phi)
  psi = 2*%pi*d*cos(phi);
  x = 2*sin(psi/2);
endfunction

function x = calcEEndfireV(d,phi)
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
d = 0.25

//******************************************************************
// construct fields
//******************************************************************
E1h = calcEBroadsideH(d,phi);
E1v = calcEBroadsideV(d,phi);
E2h = calcEEndfireH(d,phi);
E2v = calcEEndfireV(d,phi);

//******************************************************************
// polar plot of field 1
//******************************************************************
x = abs(E1h) .* cos(phi);
y = abs(E1h) .* sin(phi);
subplot(221);
plot2d(x,y);

x = abs(E1v) .* cos(phi);
y = abs(E1v) .* sin(phi);
subplot(222);
plot2d(y,x);

//******************************************************************
// polar plot of field 2
//******************************************************************
x = abs(E2h) .* cos(phi);
y = abs(E2h) .* sin(phi);
subplot(223);
plot2d(x,y);

x = abs(E2v) .* cos(phi);
y = abs(E2v) .* sin(phi);
subplot(224);
plot2d(y,x);

