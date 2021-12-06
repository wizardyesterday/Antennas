//******************************************************************
// Problem P11-10
//******************************************************************

//*****************************************************************
// function declarations
//******************************************************************
function x = calcIsotropicField(alpha,d,delta)
  psi = 2*%pi*d*cos(alpha) + delta;
  x = 2*cos(psi/2);
endfunction

function x = calcVerticalStubField(alpha,l)
  lr = 2*%pi*l;
  psi = lr*sin(alpha);
  a1 = cos(psi) - cos(lr);
  a2 = cos(alpha);
  m = find(a2 == 0);
  a2(m) = 0.000001;
  x = a1./a2;
endfunction

//******************************************************************
// main code
//******************************************************************

//******************************************************************
// set parameters
//******************************************************************
alpha = 0:%pi/100:%pi;
phiNull = 221*%pi/180;
l = 0.25;
d = 0.3;
delta = %pi*(1 - 2*d*cos(phiNull));

//******************************************************************
// construct field
//******************************************************************
// construct isotropic field
Eiso = calcIsotropicField(alpha,d,delta);

// construct field for single vertical stub
Estub = calcVerticalStubField(alpha,l);

// construct fields for array of vertical stubs
E = Estub .* Eiso;
Emax = max(abs(E));
E = E / Emax;

//******************************************************************
// plot field
//******************************************************************
set("figure_style","new");
p = get("hdl");
p.title.text = "Two-tower BC Array With Null At Phi: 221 Degrees";
p.x_label.text = "Ex, (normalized)";
p.y_label.text = "Ey, (normalized)";
p.grid = [1 1];

x = abs(E) .* cos(alpha);
y = abs(E) .* sin(alpha);
plot2d(x,y);

