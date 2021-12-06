//******************************************************************
// Problem P16-14
//******************************************************************

//*****************************************************************
// function declarations
//******************************************************************
function x = computeR0(d,h1,h2)
  x = sqrt((h1-h2).*(h1-h2) + d.*d);
endfunction

function x = computeR12(d,h1,h2)
  x = (h1+h2).*sqrt(1 + (d./(h1+h2)).*(d./(h1+h2)));
endfunction

function x = computeEv(d,h1,h2,lamda)
  r0 = computeR0(d,h1,h2);
  r12 = computeR12(d,h1,h2);
  deltaR = r12 - r0;
  x = 1 + cos(2*%pi*deltaR/lamda);
  m = find(x == 0);
  x(m) = 0.0001;
endfunction

function x = computeEh(d,h1,h2,lamda)
  r0 = computeR0(d,h1,h2);
  r12 = computeR12(d,h1,h2);
  deltaR = r12 - r0;
  x = 1 - cos(2*%pi*deltaR/lamda);
  m = find(x == 0);
  x(m) = 0.0001;
endfunction

//******************************************************************
// main code
//******************************************************************

//******************************************************************
// set parameters
//******************************************************************
h1 = 300
h2 = 0:1:100;
h2Size = size(h2);
d = 5000 * ones(1,h2Size(2));
f = 100e6;
c = 3e8;
lamda = c / f;

//******************************************************************
// compute fields
//******************************************************************
Ev = computeEv(d,h1,h2,lamda);
Eh = computeEh(d,h1,h2,lamda);
Ec = (Ev + Eh) / 2;

// convert to decibels
EcDb = 20*log10(Ec);
EvDb = 20*log10(Ev);
EhDb = 20*log10(Eh);

//******************************************************************
// plot fields
//******************************************************************
set("figure_style","new");

subplot(131);
title("E Field with Vertical Polarization");
a = gca();
a.margins = [0.225 0.1 0.125 0.2];
a.grid = [1 1];
a.x_label.text = "Ev, dB";
a.y_label.text = "h2, m";
plot2d(EvDb,h2);
a.data_bounds = [-20 10 0 100];

subplot(132);
title("E Field with Horizontal Polarization");
a = gca();
a.margins = [0.125 0.2 0.125 0.2];
a.grid = [1 1];
a.x_label.text = "Eh, dB";
a.y_label.text = "h2, m";
plot2d(EhDb,h2);
a.data_bounds = [-20 10 0 100];

subplot(133);
title("E Field with Circular Polarization");
a = gca();
a.margins = [0.125 0.2 0.125 0.2];
a.grid = [1 1];
a.x_label.text = "Ec, dB";
a.y_label.text = "h2, m";
plot2d(EcDb,h2);
a.data_bounds = [-20 10 0 100];

