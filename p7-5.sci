//******************************************************************
// Problem P7-5
//******************************************************************

//*****************************************************************
// function declarations
//******************************************************************
function x = Eendn(n,p,llamda,slamda,phi)
  psi = 2*%pi*slamda*cos(phi) -  2*%pi*llamda/p;
  x1 = sin(n*psi/2);
  x2 = sin(psi/2);
  m = find(x1 == 0);
  x1(m) = 0.000001
  m = find(x2 == 0);
  x2(m) = 0.000001*sin(%pi/(2*n));
  x = sin(%pi/(2*n)).*cos(phi).*(x1./x2);
endfunction

function [ephit,ephitApprox] = calcEphit(f,vc,p,s,l,phi)
  alpha = atan(s/l);

  gamma = 3*%pi/2 + alpha + phi;
  gammap = %pi/2 - alpha + phi;
  cosGammapp = sin(alpha)*cos(phi);

  a = 1 - p*cos(gamma);
  ap = 1 - p*cos(gammap);
  app = 1 - p*cosGammapp;

  g = sqrt(%pi)*d/2;
  b = 2*%pi*f*g/(2*p*vc*cos(alpha));

  phase1 = -b*a;

  phase2 = -b*app;
  phase2 = phase2 - (l*2*%pi*f/(4*p*vc));
  phase2 = phase2 + ((2*%pi*f)/vc)*(s*cos(phi)/4 + g*sin(phi)); 

  phase3 = -b*ap;
  phase3 = phase2 - (l*2*%pi*f/(2*p*vc));
  phase3 = phase2 + ((2*%pi*f)/vc)*(s*cos(phi)/2 + g*sin(phi)); 

  phase4 = -b*app;
  phase4 = phase4 - 3*l*2*%pi*f/(4*p*vc); 
  phase4 = phase4 + ((2*%pi*f)/vc)*(3*s*cos(phi)/4); 

  e1 = (sin(gamma).*sin(b*a)./a).*exp(%i*phase1);
  e2 = (sin(b*app)*sin(alpha).*sin(phi)./app).*exp(%i*phase2);
  e3 = (sin(gammap).*sin(b*ap)./ap).*exp(%i*phase3);
  e4 = (sin(b*app)*sin(alpha).*sin(phi)./app).*exp(%i*phase4);

  ephit = e1 + e2 + e3 + e4;
  ephitApprox = e1 + e3;
endfunction

function ethetat = calcEthetat(f,vc,p,s,l,slamda,dlamda,phi)
  alpha = atan(s/l);

  gammapp = acos(sin(alpha)*cos(phi));
  cosGammapp = sin(alpha)*cos(phi);

  app = 1 - p*cosGammapp;

  g = sqrt(%pi)*d/2;
  b = 2*%pi*f*g/(2*p*vc*cos(alpha));

  x1 = sin(gammapp).*sin(b*app)*cos(alpha);
  x2 = app.*sqrt(1 - sin(alpha)*sin(alpha)*cos(phi).*cos(phi));
  arg1 = %pi*(slamda*cos(phi) - sqrt(%pi)*dlamda*sin(phi)) - 2*sqrt(%pi)*b;
  x3 = sin(arg1/2);

  ethetat = 2*x1.*x3./x2;
endfunction

function p = calcP(n,llamda,slamda)
  p = llamda / (slamda + (2*n + 1)/(2*n));
endfunction

//******************************************************************
// main code
//******************************************************************

//******************************************************************
// set parameters
//******************************************************************
phi = 0:%pi/100:2*%pi;
n = 6;
f = 400e6;
d = 231e-6;
s = 181e-3;
c = %pi*d;
l = sqrt(c*c + s*s);

vc = 3e8;
lamda = vc / f;
dlamda = d / lamda;
slamda = s / lamda;
clamda = c / lamda;
llamda = l / lamda;
p = calcP(n,llamda,slamda);

//******************************************************************
// set parameters need to construct phase arguments
//******************************************************************

//******************************************************************
// construct fields
//******************************************************************
[ephit,ephitApprox] = calcEphit(f,vc,p,s,l,phi);
en = Eendn(n,p,llamda,slamda,phi);

ephi = en .* ephit;
ephiApprox = en .* ephitApprox;

ethetat = calcEthetat(f,vc,p,s,l,slamda,dlamda,phi);
etheta = en .* ethetat;

//******************************************************************
// polar plot of field 1
//******************************************************************
x = abs(ephit) .* cos(phi);
y = abs(ephit) .* sin(phi);
subplot(321);
plot2d(x,y);

//******************************************************************
// polar plot of field 2
//******************************************************************
x = abs(ephi) .* cos(phi);
y = abs(ephi) .* sin(phi);
subplot(322);
plot2d(x,y);

//******************************************************************
// polar plot of field 3
//******************************************************************
x = abs(ephitApprox) .* cos(phi);
y = abs(ephitApprox) .* sin(phi);
subplot(323);
plot2d(x,y);

//******************************************************************
// polar plot of field 4
//******************************************************************
x = abs(ephiApprox) .* cos(phi);
y = abs(ephiApprox) .* sin(phi);
subplot(324);
plot2d(x,y);

//******************************************************************
// polar plot of field 5
//******************************************************************
x = abs(ethetat) .* cos(phi);
y = abs(ethetat) .* sin(phi);
subplot(325);
plot2d(x,y);

//******************************************************************
// polar plot of field 6
//******************************************************************
x = abs(etheta) .* cos(phi);
y = abs(etheta) .* sin(phi);
subplot(326);
plot2d(x,y);
