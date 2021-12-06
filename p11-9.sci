//******************************************************************
// Problem P11-9
//******************************************************************

//*****************************************************************
// function declarations
//******************************************************************
function x = calcIsotropicField(phi,d,delta)
  psi = 2*%pi*d*cos(phi) + delta;
  x = 2*cos(psi/2);
endfunction

function x = calcVerticalStubField(alpha,l,r,p,r11,r1l)
  lr = 2*%pi*l;
  psi = lr*sin(alpha);
  a1 = cos(psi) - cos(lr);
  a2 = cos(alpha);
  i = sqrt(p/(r11+r1l));
  x = (60/r)*i*a1/a2;
endfunction

//******************************************************************
// main code
//******************************************************************

//******************************************************************
// set parameters
//******************************************************************
phi = 0:%pi/100:2*%pi;
delta = %pi/2;
l = 0.25;
d = 0.25;
r = 1600;
P = 1000;
r1l = 0;
r11 = 36.5;
alpha = [0 20 40 60 80]*%pi/180;

//******************************************************************
// construct field
//******************************************************************
// construct isotropic field
Eisox = calcIsotropicField(phi,d,delta);

// construct field for single vertical stubs
Estub1 = calcVerticalStubField(alpha(1),l,r,P,r11,r1l);
Estub2 = calcVerticalStubField(alpha(2),l,r,P,r11,r1l);
Estub3 = calcVerticalStubField(alpha(3),l,r,P,r11,r1l);
Estub4 = calcVerticalStubField(alpha(4),l,r,P,r11,r1l);
Estub5 = calcVerticalStubField(alpha(5),l,r,P,r11,r1l);

// construct fields for arrays of vertical stubs
E1 = Estub1 * Eisox;
E2 = Estub2 * Eisox;
E3 = Estub3 * Eisox;
E4 = Estub4 * Eisox;
E5 = Estub5 * Eisox;

//******************************************************************
// plot fields
//******************************************************************
set("figure_style","new");
p = get("hdl");
p.title.text = "Two-tower BC Array, Distance 1.6km, Power 1kW";
p.x_label.text = "Ex, mV/m";
p.y_label.text = "Ey, mV/m";
p.grid = [1 1];

p.line_style = 0;
x = abs(E1) .* cos(phi);
y = abs(E1) .* sin(phi);
plot2d(x,y);

p.line_style = 5;
x = abs(E2) .* cos(phi);
y = abs(E2) .* sin(phi);
plot2d(x,y);

p.line_style = 2;
x = abs(E3) .* cos(phi);
y = abs(E3) .* sin(phi);
plot2d(x,y);

p.line_style = 3;
x = abs(E4) .* cos(phi);
y = abs(E4) .* sin(phi);
plot2d(x,y);

p.line_style = 4;
x = abs(E5) .* cos(phi);
y = abs(E5) .* sin(phi);
plot2d(x,y);

