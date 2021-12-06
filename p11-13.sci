//******************************************************************
// Problem P11-13
//******************************************************************

//*****************************************************************
// function declarations
//******************************************************************
function x = calcIsotropicField(phi,d,delta)
  psi = 2*%pi*d*cos(phi) + delta;
  x = 2*cos(psi/2);
endfunction

function x = calcVerticalStubField(alpha,l)
  lr = 2*%pi*l;
  psi = lr*sin(alpha);
  a1 = cos(psi) - cos(lr);
  a2 = cos(alpha);
  x = a1/a2;
endfunction

//******************************************************************
// main code
//******************************************************************

//******************************************************************
// set parameters
//******************************************************************
phi = 0:%pi/100:2*%pi;
phiNull = %pi/2;
l = 0.25;
d = 0.3;
alpha = [0 30 60]*%pi/180;
delta = %pi - 2*%pi*d*cos(phiNull);

//******************************************************************
// construct field
//******************************************************************
// construct isotropic field
Eiso = calcIsotropicField(phi,d,delta);

// construct field for single vertical stubs
Estub1 = calcVerticalStubField(alpha(1),l);
Estub2 = calcVerticalStubField(alpha(2),l);
Estub3 = calcVerticalStubField(alpha(3),l);

// construct fields for arrays of vertical stubs
E1 = Estub1 * Eiso;
E2 = Estub2 * Eiso;
E3 = Estub3 * Eiso;

//******************************************************************
// plot fields
//******************************************************************
set("figure_style","new");

subplot(131);
title("Horizontal Pattern at Alpha = 0");
a = gca();
a.grid = [1 1];
a.x_label.text = "Ex";
a.y_label.text = "Ey";
x = abs(E1) .* cos(phi);
y = abs(E1) .* sin(phi);
plot2d(y,x);

subplot(132);
title("Horizontal Pattern at Alpha = 30 Degrees");
a = gca();
a.grid = [1 1];
a.x_label.text = "Ex";
a.y_label.text = "Ey";
x = abs(E2) .* cos(phi);
y = abs(E2) .* sin(phi);
plot2d(y,x);

subplot(133);
title("Horizontal Pattern at Alpha = 60 Degrees");
a = gca();
a.grid = [1 1];
a.x_label.text = "Ex";
a.y_label.text = "Ey";
x = abs(E3) .* cos(phi);
y = abs(E3) .* sin(phi);
plot2d(y,x);

