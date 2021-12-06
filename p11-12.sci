//******************************************************************
// Problem P11-12
//******************************************************************

//*****************************************************************
// function declarations
//******************************************************************
function x = calcTowerField(alpha,phi,d,delta)
  psi = 2*%pi*d*cos(alpha)*cos(phi) + delta;
  a1 = (%pi/2)*cos(%pi/2 - alpha);
  a2 = %pi/2 - alpha;
  x1 = cos(psi/2);
  x2 = cos(a1);
  x3 = sin(a2);
  x = x1 .* x2 ./ x3;
endfunction

//******************************************************************
// main code
//******************************************************************

//******************************************************************
// set parameters
//******************************************************************
alpha = 0:%pi/100:%pi;
phi = 0:%pi/100:2*%pi;
alphaNull = 30*%pi/180;
phiNull = 135*%pi/180;
l = 1/4;
d = 3/8;
phiPrime = acos(cos(phiNull)*cos(alphaNull));
delta = %pi*(1 - 2*d*cos(phiNull));

//******************************************************************
// construct field
//******************************************************************
Ealpha0 = calcTowerField(0,phi,d,delta);
EalphaNull = calcTowerField(alphaNull,phi,d,delta);
EphiNull = calcTowerField(alpha,phiNull,d,delta);

//******************************************************************
// plot field
//******************************************************************
set("figure_style","new");

subplot(131);
title("Horizontal Pattern at Alpha = 0");
a = gca();
a.grid = [1 1];
a.x_label.text = "Ex";
a.y_label.text = "Ey";
x = abs(Ealpha0) .* cos(phi);
y = abs(Ealpha0) .* sin(phi);
plot2d(y,x);

subplot(132);
title("Horizontal Pattern at Alpha = 30 Degrees");
a = gca();
a.grid = [1 1];
a.x_label.text = "Ex";
a.y_label.text = "Ey";
x = abs(EalphaNull) .* cos(phi);
y = abs(EalphaNull) .* sin(phi);
plot2d(y,x);

subplot(133);
title("Vertical Pattern at Phi = 135 Degrees");
a = gca();
a.grid = [1 1];
a.x_label.text = "Ex";
a.y_label.text = "Ey";
x = abs(EphiNull) .* cos(alpha);
y = abs(EphiNull) .* sin(alpha);
plot2d(x,y);

