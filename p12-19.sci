//******************************************************************
// Problem P12-19
//******************************************************************

//*****************************************************************
// function declarations
//******************************************************************
function x = computePhiField(phi)
  a = 20*%pi*sin(phi);
  d1 = 20*%pi*sin(phi);
  m = find(d1 == 0);
  d1(m) = 0.000001;

  n1 = 10*%pi;
  n2 = 4*%pi*sin(phi);
  d2 = (%pi/10)^2 - (2*%pi*sin(phi)).^2;
  
  x1 = n1 ./ d1;
  x2 = n2 ./ d2;
  x3 = sin(a);

  x = (x1 + x2) .* x3;
endfunction


//******************************************************************
// main code
//******************************************************************

//******************************************************************
// set parameters
//******************************************************************
phid = -8:0.01:8;
phi = phid*%pi/180;

//******************************************************************
// compute field
//******************************************************************
E1 = computePhiField(phi);
E1n = E1 / max(abs(E1));

//******************************************************************
// plot field
//******************************************************************
set("figure_style","new");

title("Field of 20-Lamda Line Source, Cosine Squared Taper");
a = gca();
a.margins = [0.125 0.2 0.125 0.125];
a.margins = [0.125 0.2 0.125 0.2];
a.grid = [1 1];
a.x_label.text = "phi, degrees";
a.y_label.text = "|E|";
plot2d(phid,abs(E1n));

