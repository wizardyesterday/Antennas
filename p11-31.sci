//******************************************************************
// P11-31
//******************************************************************

//*****************************************************************
// function declarations
//******************************************************************
function x = calcRhombicField(phi,h,l,alpha)
  hr = 2*%pi*h;
  lr = 2*%pi*l;
  psi = (1 - sin(phi)*cos(alpha))/2;
  n1 = cos(phi);
  n2 = sin(hr*sin(alpha));
  n3 = sin(lr*psi).*sin(lr*psi);
  x = n1*n2.*n3 ./ psi;
  x = x / max(abs(x));
endfunction

//******************************************************************
// main code
//******************************************************************

//******************************************************************
// set parameters
//******************************************************************
alpha = 0:%pi/200:%pi;
phi = [72.5 72.5 66.8 59]*%pi/180;
h = [0.831 0.831 0.831 0.5];
l = [5.53 4.1 3 3];

//******************************************************************
// construct fields
//******************************************************************
E26 = calcRhombicField(phi(1),h(1),l(1),alpha);
E27 = calcRhombicField(phi(2),h(2),l(2),alpha);
E29 = calcRhombicField(phi(3),h(3),l(3),alpha);
E30 = calcRhombicField(phi(4),h(4),l(4),alpha);

//******************************************************************
// plot fields
//******************************************************************
set("figure_style","new");

subplot(221);
title("E-type Rhombic Pattern");
a = gca();
a.margins = [0.125 0.2 0.125 0.125];
a.margins = [0.125 0.2 0.125 0.2];
a.grid = [1 1];
a.x_label.text = "Ex";
a.y_label.text = "Ey";
x = abs(E26) .* cos(alpha);
y = abs(E26) .* sin(alpha);
plot2d(x,y);

subplot(222);
title("Alignment-type Rhombic Pattern");
a = gca();
a.margins = [0.125 0.2 0.125 0.125];
a.margins = [0.125 0.2 0.125 0.2];
a.grid = [1 1];
a.x_label.text = "Ex";
a.y_label.text = "Ey";
x = abs(E27) .* cos(alpha);
y = abs(E27) .* sin(alpha);
plot2d(x,y);

subplot(223);
title("Compromise-type Rhombic Pattern, L=3");
a = gca();
a.margins = [0.125 0.2 0.125 0.125];
a.margins = [0.125 0.2 0.125 0.2];
a.grid = [1 1];
a.x_label.text = "Ex";
a.y_label.text = "Ey";
x = abs(E29) .* cos(alpha);
y = abs(E29) .* sin(alpha);
plot2d(x,y);

subplot(224);
title("Compromise-type Rhombic Pattern, H=0.5, L=3");
a = gca();
a.margins = [0.125 0.2 0.125 0.125];
a.margins = [0.125 0.2 0.125 0.2];
a.grid = [1 1];
a.x_label.text = "Ex";
a.y_label.text = "Ey";
x = abs(E30) .* cos(alpha);
y = abs(E30) .* sin(alpha);
plot2d(x,y);
