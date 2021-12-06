//******************************************************************
// Problem P4-23
//******************************************************************

//*****************************************************************
// function declarations
//******************************************************************
function x = E(a,phi)
  psi = 2*%pi*a*sin(phi);
  x1 = sin(psi/2);
  x2 = psi/2;
  m = find(x1 == 0);
  x1(m) = 0.000001
  m = find(x2 == 0);
  x2(m) = 0.000001;
  x = x1./x2;
endfunction

function d = calcDirectivity(a,b)
  d = 4*%pi*a*b;
endfunction

//******************************************************************
// main code
//******************************************************************
phi = 0:%pi/100:2*%pi;
theta = 0:360/200:360;
a = 10;
b = 20;
Ea = E(a,phi);
Eb = E(b,phi);

x = abs(Ea) .* cos(phi);
y = abs(Ea) .* sin(phi);
subplot(2,1,1);
plot2d(x,y);

x = abs(Eb) .* cos(phi);
y = abs(Eb) .* sin(phi);
subplot(2,1,2);
plot2d(x,y);

// calculate the directivity
D = calcDirectivity(a,b);
