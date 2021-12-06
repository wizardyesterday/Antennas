//******************************************************************
// Problem P7-2
//******************************************************************

//*****************************************************************
// function declarations
//******************************************************************
function x = Eendn(n,slamda,phi)
  psi = 2*%pi*slamda*(1-cos(phi)) + %pi/n;
  x1 = sin(n*psi/2);
  x2 = sin(psi/2);
  m = find(x1 == 0);
  x1(m) = 0.000001;
  m = find(x2 == 0);
  x2(m) = 0.000001*sin(%pi/(2*n));
  x = sin(%pi/(2*n)).*cos(phi).*(x1./x2);
endfunction

function hpbw = calcHpbw(n,clamda,slamda)
  hpbw = 52/(clamda*sqrt(n*slamda));
endfunction

function gain = calcGain(n,clamda,slamda)
  gain = 12*clamda*clamda*n*slamda;
endfunction

function axialRatio = calcAxialRatio(clamda,slamda)
  llamda = sqrt(clamda*clamda + slamda*slamda);
  p = llamda/(slamda + 1);
  alpha = atan(slamda/clamda);
  axialRatio = abs(llamda*(sin(alpha) - (1/p)));
endfunction

//******************************************************************
// main code
//******************************************************************

//******************************************************************
// set parameters
//******************************************************************
phi = 0:%pi/100:2*%pi;
n = 10;
d = 100e-3;
s = 70e-3;
f1 = 10e9;
f2 = 300e6;
c = %pi*d;
l = sqrt(c*c + s*s);
lamda1 = 3e8/f1;
lamda2 = 3e8/f2;
dlamda1 = d/lamda1;
dlamda2 = d/lamda2;
slamda1 = s/lamda1;
slamda2 = s/lamda2;
clamda1 = c/lamda1;
clamda2 = c/lamda2;
llamda1 = l/lamda1;
llamda2 = l/lamda2;

//******************************************************************
// construct fields
//******************************************************************
E1 = Eendn(n,slamda1,phi);
E2 = Eendn(n,slamda2,phi);

//******************************************************************
// polar plot of field 1
//******************************************************************
x = abs(E1) .* cos(phi);
y = abs(E1) .* sin(phi);
subplot(211);
plot2d(x,y);

//******************************************************************
// polar plot of field 2
//******************************************************************
x = abs(E2) .* cos(phi);
y = abs(E2) .* sin(phi);
subplot(212);
plot2d(x,y);

//******************************************************************
// calculate half power bandwidths
//******************************************************************
hpbw1 = calcHpbw(n,clamda1,slamda1);
hpbw2 = calcHpbw(n,clamda2,slamda2);


//******************************************************************
// calculate gains
//******************************************************************
g1 = calcGain(n,clamda1,slamda1);
g2 = calcGain(n,clamda2,slamda2);

//******************************************************************
// calculate axial ratios
//******************************************************************
ar1 = calcAxialRatio(clamda1,slamda1);
ar2 = calcAxialRatio(clamda2,slamda2);

