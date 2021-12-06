//******************************************************************
// Problem P4-25
//******************************************************************

//*****************************************************************
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

function d = calcDirectivity(phi,e)
  p = e.*conj(e);
  p = real(p);
  i = p.*sin(phi);
  d = inttrap(phi,i);
  d = 2*max(p)/d;
endfunction

//******************************************************************
// main code
//******************************************************************
phi = 0:%pi/100:2*%pi;
phi1 = 0:%pi/200:%pi;
theta = 0:360/200:360;
d = 0.25;
n = 12;
delta1 = 0;
E1 = Eendn(n,d,delta1,phi);

x = abs(E1) .* cos(phi);
y = abs(E1) .* sin(phi);
plot2d(x,y);

// calculate the directivities
D1 = calcDirectivity(phi1,E1);
