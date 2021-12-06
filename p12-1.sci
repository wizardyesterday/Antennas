//******************************************************************
// Problem P12-1
//******************************************************************

//*****************************************************************
// function declarations
//******************************************************************
function a = cin(x)
  v = 0:.01:x;
  v(1) = .0000001;
  i = (1 - cos(v)) ./ v;
  a = inttrap(v,i);
endfunction

function a = si(x)
  v = 0:.01:x;
  v(1) = .0000001;
  i = sin(v) ./ v;
  a = inttrap(v,i);
endfunction

function a = ci(x)
  a = 0.577 + log(x) - cin(x);
endfunction

function z11 = calcZ11(n)
  r11 = 30 * cin(2*%pi*n);
  x11 = 30 * si(2*%pi*n);
  z11 = r11 + %i*x11;
endfunction

function z21 = calcZ21(l,d)
  a1 = beta*d;
  a2 = beta*(sqrt(d*d + l*l) + l);
  a3 = beta*(sqrt(d*d + l*l) - l);
  r21 = 30*(2*ci(a1) - ci(a2) - ci(a3));
  x21 = -30*(2*si(a1) - si(a2) - si(a3));
  z21 = r21 + %i*x21;
endfunction

function gf = calcGain(r11,r12,rl)
  nu = r11 + rl;
  de = r11 + rl - r12;
  gf = sqrt(nu/de);
endfunction

function x = computeField(theta)
  psi1 = 0.5*%pi*cos(theta);
  psi2 = 0.3*%pi*sin(theta); 
  x1 = cos(psi1);
  x2 = sin(theta);
  x3 = sin(psi2);
  m = find(x2 == 0);
  x2(m) = 0.000001/n;
  x = x1 .* x3 ./ x2;
endfunction

//******************************************************************
// main code
//******************************************************************

//******************************************************************
// set parameters
//******************************************************************
theta = 0:%pi/200:%pi;
d12 = 0.3
n = 1;
l = 0.5;
beta = 2*%pi;
rl1 = 0;
rl2 = 10;

//******************************************************************
// compute self and mutual resistances
//******************************************************************
r11 = real(calcZ11(n));
r12 = real(calcZ21(l,d12));

//******************************************************************
// compute gains
//******************************************************************
gf1 = calcGain(r11,r12,rl1);
gf2 = calcGain(r11,r12,rl2);


//******************************************************************
// compute field
//******************************************************************
E = computeField(theta);

//******************************************************************
// plot field
//******************************************************************
set("figure_style","new");

title("Field of Half Wave Dipole 0.15 Wavelength Over a Plane");
a = gca();
a.x_label.text = "x";
a.y_label.text = "y";
a.grid = [1 1];

x = abs(E) .* cos(theta);
y = abs(E) .* sin(theta);
plot2d(x,y);
