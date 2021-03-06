//******************************************************************
// Problem P11-21
//******************************************************************

//*****************************************************************
// function declarations
//******************************************************************
function x = calcDipoleField(phi)
  x1 = cos((%pi/2)*cos(phi));
  x2 = sin(phi);
  m = find(x2 == 0);
  x2(m) = 0.000001;
  x = x1 ./ x2;
endfunction

function x = calcArrayField(phi)
  psi = %pi*cos(phi);
  x = 2*(1 + cos(psi/2));
endfunction

//******************************************************************
// main code
//******************************************************************

//******************************************************************
// set parameters
//******************************************************************
phi = 0:%pi/100:2*%pi;

//******************************************************************
// construct fields
//******************************************************************
Earray = calcArrayField(phi);
Edipole = calcDipoleField(phi);
E = Edipole .* Earray;

//******************************************************************
// polar plot of field
//******************************************************************
set("figure_style","new");
p = get("hdl");
p.title.text = "Collinear Array of 3 Dipoles, d = l = lamda/2";
p.x_label.text = "Ex";
p.y_label.text = "Ey";
p.grid = [1 1];

x = abs(E) .* cos(phi);
y = abs(E) .* sin(phi);
plot2d(x,y);

