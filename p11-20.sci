//******************************************************************
// Problem P11-20
//******************************************************************

//*****************************************************************
// function declarations
//******************************************************************
function x = calcGaussianPattern(w,theta)
  x = exp(-w*theta.*theta/2);
endfunction

function x = calcSincPattern(w,theta)
  n = sin(w*theta);
  d = w*theta;
  m = find(d == 0);
  d(m) = 0.000001;
  n(m) = 0.000001;
  x = n ./ d;
endfunction

function x = calcBesselPattern(w,theta)
  x = besselj(0,w*theta);
endfunction

function [Ea, Eb] = calcSquarePattern(w,theta,phi)
  psiA = 2*%pi*w*sin(theta);
  psiB = 2*%pi*w*sin(phi);

  x1 = sin(psiA/2);
  x2 = psiA/2;
  m = find(x2 == 0);
  x2(m) = 0.000001;
  Ea = x1 ./ x2;

  x1 = sin(psiB/2);
  x2 = psiB/2;
  m = find(x2 == 0);
  x2(m) = 0.000001;
  Eb = x1 ./ x2;
endfunction

function x = calcSolidAngle(limits,field)
  i = field .* field .* sin(limits);
  x = inttrap(limits,i);
  x = 2 * %pi * x;
endfunction

function x = calcSolidAngleThetaPortion(limits,field)
  i = field .* field .* sin(%pi/2 - limits);
  x = inttrap(limits,i);
endfunction

function x = calcSolidAnglePhiPortion(limits,field)
  i = field .* field;
  x = inttrap(limits,i);
endfunction

//******************************************************************
// main code
//******************************************************************

//******************************************************************
// set parameters
//******************************************************************
thetaHp = 2*10*%pi/180;
a = 22.754;
b = 7.973;
c = 6.453;
d = 2.551;

thetaGnull = %pi;
thetaSnull = %pi/b;
thetaBnull = 0.372667;
thetaSQnull = .41;
phiSQnull = 2*%pi;

gaussianLimits = 0:thetaGnull/100:thetaGnull;
sincLimits= 0:thetaSnull/100:thetaSnull;
besselLimits= 0:thetaBnull/100:thetaBnull;
squareThetaLimits= 0:thetaSQnull/100:thetaSQnull;
squarePhiLimits = 0:phiSQnull/100:phiSQnull;

//******************************************************************
// calculate field patterns
//******************************************************************
Eg = calcGaussianPattern(a,gaussianLimits);
Es = calcSincPattern(b,sincLimits);
Eb = calcBesselPattern(c,besselLimits);
[Esqa, Esqb] = calcSquarePattern(d,squareThetaLimits,squarePhiLimits);

//******************************************************************
// calculate solid angles
//******************************************************************

omegaG = calcSolidAngle(gaussianLimits,Eg);
omegaS = calcSolidAngle(sincLimits,Es);
omegaB = calcSolidAngle(besselLimits,Eb);
omegaSQa = calcSolidAngleThetaPortion(squareThetaLimits,Esqa);
omegaSQb = calcSolidAnglePhiPortion(squarePhiLimits,Esqb);
omegaSQ = omegaSQa * omegaSQb;

rG = omegaG/(thetaHp*thetaHp);
rS = omegaS/(thetaHp*thetaHp);
rB = omegaB/(thetaHp*thetaHp);
rSQ = omegaSQ/(thetaHp*thetaHp);
