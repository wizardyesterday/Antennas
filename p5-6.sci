//******************************************************************
// Problem P5-6
//******************************************************************

//*****************************************************************
// function declarations
//******************************************************************
function x = E(b,p,phi)
  x1 = sin(phi);
  x2 = 1 - p*cos(phi);
  m = find(x2 == 0);
  x2(m) = 0.000001;
  a = b*%pi*((1/p) - cos(phi));
  x3 = sin(a);
  x = x1 .* x3 ./ x2;
endfunction

//******************************************************************
// main code
//******************************************************************

//******************************************************************
// set parameters
//******************************************************************
phi = 0:%pi/100:2*%pi;
b1 = 1;
b2 = 10;
p1 = 1;
p2 = 0.5;

//******************************************************************
// construct fields
//******************************************************************
E1 = E(b1,p1,phi);
E2 = E(b1,p2,phi);
E3 = E(b2,p1,phi);

//******************************************************************
// polar plot of fields
//******************************************************************
x = abs(E1) .* cos(phi);
y = abs(E1) .* sin(phi);
subplot(311);
plot2d(x,y);

x = abs(E2) .* cos(phi);
y = abs(E2) .* sin(phi);
subplot(312);
plot2d(x,y);

x = abs(E3) .* cos(phi);
y = abs(E3) .* sin(phi);
subplot(313);
plot2d(x,y);
