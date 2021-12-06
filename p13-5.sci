//******************************************************************
// Problem P13-5
//******************************************************************

//*****************************************************************
// function declarations
//******************************************************************
function x = computeSlotField(theta)
  psi = 0.5*%pi*cos(theta);
  x1 = cos(psi);
  x2 = sin(theta);
  m = find(x2 == 0);
  x2(m) = 0.000001;
  x = x1 ./ x2;
endfunction

function x = computeArrayField(theta)
  psi = %pi*cos(theta);
  x = cos(psi);
endfunction

function x = computePhiField(phi);
  a = size(phi);
  a = a(2);
  x = ones(1,a);
endfunction

//******************************************************************
// main code
//******************************************************************

//******************************************************************
// set parameters
//******************************************************************
phid = -180:0.01:180;
phi = phid*%pi/180;
thetad = 0:0.01:180;
theta = thetad*%pi/180;

//******************************************************************
// compute fields
//******************************************************************
// compute field that is dependent on phi
Ephi = computePhiField(phi);

// compute field that is dependent on theta
Eslot = computeSlotField(theta);
Earray = computeArrayField(theta);
Etheta = Eslot .* Earray;

//******************************************************************
// plot field
//******************************************************************
set("figure_style","new");

subplot(211);
title("E(theta) For Array of Two Lamda/2 Slots");
a = gca();
a.margins = [0.125 0.2 0.125 0.125];
a.margins = [0.125 0.2 0.125 0.2];
a.grid = [1 1];
a.x_label.text = "x";
a.y_label.text = "y";
x = abs(Etheta) .* cos(theta);
y = abs(Etheta) .* sin(theta);
plot2d(x,y);

subplot(212);
title("E(phi) For Array of Two Lamda/2 Slots");
a = gca();
a.margins = [0.125 0.2 0.125 0.125];
a.margins = [0.125 0.2 0.125 0.2];
a.grid = [1 1];
a.x_label.text = "x";
a.y_label.text = "y";
x = abs(Ephi) .* cos(phi);
y = abs(Ephi) .* sin(phi);
plot2d(x,y);
