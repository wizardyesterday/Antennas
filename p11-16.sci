//******************************************************************
// Problem P11-16
//******************************************************************

//*****************************************************************
// function declarations
//******************************************************************
function x = calcE12Field(phi,d)
  psi = 2*%pi*d*sin(phi);
  x = exp(%i*psi/2) + %i*exp(-%i*psi/2);
endfunction

function x = calcE34Field(phi,d)
  psi = 2*%pi*d*sin(phi);
  x = -%i*exp(%i*psi/2) - exp(-%i*psi/2);
endfunction

function x = calcCompositeField(phi,d,E1,E2)
  psi = 2*%pi*d*cos(phi);
  x = E1.*exp(%i*psi/2) + E2.*exp(-%i*psi/2);
endfunction

//******************************************************************
// main code
//******************************************************************

//******************************************************************
// set parameters
//******************************************************************
phi = 0:%pi/100:2*%pi;
d = 0.5;

//******************************************************************
// construct field
//******************************************************************
// construct field due to sources 1 and 2
E12 = calcE12Field(phi,d);

// construct field due to sources 3 and 4
E34 = calcE34Field(phi,d);

// construct composite field
E = calcCompositeField(phi,d,E12,E34);

//******************************************************************
// plot field
//******************************************************************
set("figure_style","new");
p = get("hdl");
p.title.text = "Square Array";
p.x_label.text = "Ex, V/m";
p.y_label.text = "Ey, V/m";
p.grid = [1 1];

x = abs(E) .* cos(phi);
y = abs(E) .* sin(phi);
plot2d(x,y);

