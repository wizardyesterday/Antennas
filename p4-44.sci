//******************************************************************
// Problem P4-44
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

function o = calcBeamArea(phi,e)
  p = e.*conj(e);
  p = real(p);
  i = p;
  o = inttrap(phi,i);
endfunction

//******************************************************************
// main code
//******************************************************************
phi = 0:%pi/100:2*%pi;
phiHalf = 0:%pi/200:%pi;
d = 0.5;
n = 24;
delta = -2*%pi*d;
phiNull = acos(1 - 1/(n*d));
phiNull1 = 0:phiNull/200:phiNull;
E1 = Eendn(n,d,delta,phi);
E2 = Eendn(n,d,delta,phiNull1);

// calculate beam areas
Om = 2 * calcBeamArea(phiNull1,E2);
Oa = calcBeamArea(phiHalf,E1);

// calculate beam efficiency
em = Om/Oa;
