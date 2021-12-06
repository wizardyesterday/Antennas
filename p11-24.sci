//******************************************************************
// P11-24
//******************************************************************

//*****************************************************************
// function declarations
//******************************************************************
function x = calcArrayField(n,d,delta,phi)
  psi = 2*%pi*d*cos(phi) + delta;
  x1 = sin(n*psi/2);
  x2 = sin(psi/2);
  m = find(x1 == 0);
  x1(m) = 0.000001
  m = find(x2 == 0);
  x2(m) = 0.000001/n;
  x = x1 ./ x2;
  x = x / n;
endfunction

function x = calcDelta(d,phi)
  x = -2*%pi*d*cos(phi);
endfunction

//******************************************************************
// main code
//******************************************************************

//******************************************************************
// set parameters
//******************************************************************
phi = 0:%pi/100:2*%pi;
d = 0.5;
n = 24;
phi1 = %pi/2;
phi2 = %pi/2 + 25*%pi/180;
phi3 = %pi/2 + 50*%pi/180;
phi4 = %pi/2 + 75*%pi/180;

//******************************************************************
// compute progressive phases
//******************************************************************
delta1 = calcDelta(d,phi1);
delta2 = calcDelta(d,phi2);
delta3 = calcDelta(d,phi3);
delta4 = calcDelta(d,phi4);

//******************************************************************
// construct fields
//******************************************************************
E1 = calcArrayField(n,d,delta1,phi);
E2 = calcArrayField(n,d,delta2,phi);
E3 = calcArrayField(n,d,delta3,phi);
E4 = calcArrayField(n,d,delta4,phi);


//******************************************************************
// plot field
//******************************************************************
set("figure_style","new");

subplot(221);
title("24 Dipole Array Pattern at Max = 0 Degrees From Broadside");
a = gca();
a.grid = [1 1];
a.x_label.text = "Ex";
a.y_label.text = "Ey";
x = abs(E1) .* cos(phi);
y = abs(E1) .* sin(phi);
plot2d(x,y);

subplot(222);
title("24 Dipole Array Pattern at Max = 25 Degrees From Broadside");
a = gca();
a.grid = [1 1];
a.x_label.text = "Ex";
a.y_label.text = "Ey";
x = abs(E2) .* cos(phi);
y = abs(E2) .* sin(phi);
plot2d(x,y);

subplot(223);
title("24 Dipole Array Pattern at Max = 50 Degrees From Broadside");
a = gca();
a.grid = [1 1];
a.x_label.text = "Ex";
a.y_label.text = "Ey";
x = abs(E3) .* cos(phi);
y = abs(E3) .* sin(phi);
plot2d(x,y);

subplot(224);
title("24 Dipole Array Pattern at Max = 75 Degrees From Broadside");
a = gca();
a.grid = [1 1];
a.x_label.text = "Ex";
a.y_label.text = "Ey";
x = abs(E4) .* cos(phi);
y = abs(E4) .* sin(phi);
plot2d(x,y);

