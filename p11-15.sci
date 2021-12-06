//******************************************************************
// Problem P11-15
//******************************************************************

//*****************************************************************
// function declarations
//******************************************************************
function x = calcPointField(phi,dC)
  psiC = 2*%pi*dC*sin(phi);
  x = exp(-%i*psiC/2);
endfunction

function x = calcPairField(phi,d,dC)
  psiC = 2*%pi*dC*sin(phi);
  psi = 2*%pi*d*cos(phi);
  x = 2*cos(psi/2).*exp(%i*psiC/2);
endfunction

//******************************************************************
// main code
//******************************************************************

//******************************************************************
// set parameters
//******************************************************************
phi = 0:%pi/100:2*%pi;
d = 0.5;
dC = 0.5*sin(%pi/3);

//******************************************************************
// construct field
//******************************************************************
// construct field of single source
E1 = calcPointField(phi,dC);

// construct field of pair of sources
E2 = calcPairField(phi,d,dC);

// construct total field
E = E1 + E2;

//******************************************************************
// plot field
//******************************************************************
set("figure_style","new");
p = get("hdl");
p.title.text = "Triangle Array";
p.x_label.text = "Ex, V/m";
p.y_label.text = "Ey, V/m";
p.grid = [1 1];

x = abs(E) .* cos(phi);
y = abs(E) .* sin(phi);
plot2d(x,y);

