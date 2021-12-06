//******************************************************************
// Problem P16-3
//******************************************************************

//*****************************************************************
// function declarations
//******************************************************************
function x = computeDipoleField(phi)
  psi = 0.5*%pi*cos(phi);
  x1 = cos(psi);
  x2 = sin(phi);
  m = find(x2 == 0);
  x2(m) = 0.000001;
  x = x1 ./ x2;
endfunction

function x = computeArrayField(phi)
  psi = 0.5*%pi*cos(phi);
  x = cos(psi);
endfunction

//******************************************************************
// main code
//******************************************************************

//******************************************************************
// set parameters
//******************************************************************
phid = -180:0.01:180;
phi = phid*%pi/180;

//******************************************************************
// compute fields
//******************************************************************
// compute dipole fields
Edipole12 = computeDipoleField(phi-%pi/2);
Edipole34 = computeDipoleField(phi);

// compute array fields
Earray12 = computeArrayField(phi-%pi/2);
Earray34 = computeArrayField(phi);

// compute total fields of each contribution
E12 = Edipole12 .* Earray12;
E34 = Edipole34 .* Earray34;

// compute total field
E = E12 + E34;

//******************************************************************
// plot field
//******************************************************************
set("figure_style","new");

title("E(phi) For Square Loop");
a = gca();
a.margins = [0.125 0.2 0.125 0.125];
a.margins = [0.125 0.2 0.125 0.2];
a.grid = [1 1];
a.x_label.text = "x";
a.y_label.text = "y";
x = abs(E) .* cos(phi);
y = abs(E) .* sin(phi);
plot2d(x,y);
