//******************************************************************
// P11-25
//******************************************************************

//*****************************************************************
// function declarations
//******************************************************************
function x = calcHelixField(n,s,phi)
  psi = 2*%pi*(s*(1 - cos(phi)) + 1/(2*n));
  x1 = sin(n*psi/2);
  x2 = sin(psi/2);
  m = find(x1 == 0);
  x1(m) = 0.000001
  m = find(x2 == 0);
  x2(m) = 0.000001/n;
  x3 = sin((%pi/2)/n);
  x = x1 ./ x2;
  x = x .* x3;
endfunction

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

//******************************************************************
// main code
//******************************************************************

//******************************************************************
// set parameters
//******************************************************************
phi = 0:%pi/100:2*%pi;
theta = phi*180/%pi;
alpha = 12.5*%pi/180;
c = 1;
n = 4;
d = 1.5;
d = 0.5;
s = c*tan(alpha); 
nElements = 3;
delta = [-4.5605189 0 4.5605189];

//******************************************************************
// construct fields
//******************************************************************
Ehelix = calcHelixField(n,s,phi-%pi/2);
Earray1 = calcArrayField(nElements,d,delta(1),phi);
Earray2 = calcArrayField(nElements,d,delta(2),phi);
Earray3 = calcArrayField(nElements,d,delta(3),phi);
E1 = Ehelix .* Earray1;
E2 = Ehelix .* Earray2;
E3 = Ehelix .* Earray3;
E1n = E1 ./ max(abs(E1));
E3n = E3 ./ max(abs(E3));

//******************************************************************
// plot field
//******************************************************************
set("figure_style","new");

subplot(321);
title("3 Helix Array Pattern at Main Lobe Left of Broadside");
a = gca();
a.margins = [0.125 0.2 0.125 0.125];
a.margins = [0.125 0.2 0.125 0.2];
a.grid = [1 1];
a.x_label.text = "Ex";
a.y_label.text = "Ey";
x = abs(E1) .* cos(phi);
y = abs(E1) .* sin(phi);
plot2d(x,y);

subplot(323);
title("3 Helix Array Pattern at Main Lobe at Broadside");
a = gca();
a.margins = [0.125 0.2 0.125 0.125];
a.margins = [0.125 0.2 0.125 0.2];
a.grid = [1 1];
a.x_label.text = "Ex";
a.y_label.text = "Ey";
x = abs(E2) .* cos(phi);
y = abs(E2) .* sin(phi);
plot2d(x,y);

subplot(325);
title("3 Helix Array Pattern at Main Lobe Right of Broadside");
a = gca();
a.margins = [0.125 0.2 0.125 0.125];
a.margins = [0.125 0.2 0.125 0.2];
a.grid = [1 1];
a.x_label.text = "Ex";
a.y_label.text = "Ey";
x = abs(E3) .* cos(phi);
y = abs(E3) .* sin(phi);
plot2d(x,y);

subplot(322);
title("3 Helix Array Pattern at Main Lobe Left of Broadside");
a = gca();
a.margins = [0.125 0.2 0.125 0.125];
a.margins = [0.125 0.2 0.125 0.2];
a.grid = [1 1];
a.x_label.text = "phi, degrees";
a.y_label.text = "En";
plot2d(theta,abs(E1n));

subplot(324);
title("3 Helix Array Pattern at Main Lobe at Broadside");
a = gca();
a.margins = [0.125 0.2 0.125 0.125];
a.margins = [0.125 0.2 0.125 0.2];
a.grid = [1 1];
a.x_label.text = "phi, degrees";
a.y_label.text = "En";
plot2d(theta,abs(E2));

subplot(326);
title("3 Helix Array Pattern at Main Lobe Right of Broadside");
a = gca();
a.margins = [0.125 0.2 0.125 0.125];
a.margins = [0.125 0.2 0.125 0.2];
a.grid = [1 1];
a.x_label.text = "phi, degrees";
a.y_label.text = "En";
plot2d(theta,abs(E3n));

