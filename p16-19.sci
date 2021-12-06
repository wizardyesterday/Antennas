//******************************************************************
// Problem P16-19
//******************************************************************

//*****************************************************************
// function declarations
//******************************************************************
function x = computeEpsilonR(erp,sigma,f)
  e0 = 8.85e-12;
  erpp = sigma/(2*%pi*f*e0);
  x = erp - %i*erpp;
endfunction

function x = computeRhoPer(er,alpha)
  x1 = sin(alpha);
  x2 = sqrt(er - cos(alpha).*cos(alpha));
  x = (x1 - x2)./(x1 + x2);
endfunction

function x = computeRhoPar(er,alpha)
  x1 = er * sin(alpha);
  x2 = sqrt(er - cos(alpha).*cos(alpha));
  x = (x1 - x2)./(x1 + x2);
endfunction

function x = computeEper(alpha,h,erp,sigma,f)
  er = computeEpsilonR(erp,sigma,f);
  rho = computeRhoPer(er,alpha);
  x = 1 + rho.*exp(%i*2*beta*h*sin(alpha));
endfunction

function x = computeEpar(alpha,h,erp,sigma,f)
  er = computeEpsilonR(erp,sigma,f);
  rho = computeRhoPar(er,alpha);
  x = cos(alpha).*(1 + rho.*exp(%i*2*h*beta*sin(alpha)));
endfunction

//******************************************************************
// main code
//******************************************************************

//******************************************************************
// set parameters
//******************************************************************
alphad = 0:0.1:90;
alpha = alphad*%pi/180;
beta = 2*%pi;
h = 1/4;
erp = 12;
sigma = 2e-3;
fper = [100e3 100e6];
fpar = [1e6 100e6];

//******************************************************************
// compute fields
//******************************************************************
// compute vertical field
Eper1 = computeEper(alpha,h,erp,sigma,fper(1));
Eper2 = computeEper(alpha,h,erp,sigma,fper(2));

// compute horizontal field
Epar1 = computeEpar(alpha,h,erp,sigma,fpar(1));
Epar2 = computeEpar(alpha,h,erp,sigma,fpar(2));

//******************************************************************
// plot fields
//******************************************************************
set("figure_style","new");

subplot(221);
title("E Field with Horizontal Dipole, f = 100KHz");
a = gca();
a.margins = [0.225 0.1 0.125 0.2];
a.grid = [1 1];
a.x_label.text = "x";
a.y_label.text = "y";
x = abs(Eper1) .* cos(alpha);
y = abs(Eper1) .* sin(alpha);
plot2d(x,y);

subplot(222);
title("E Field with Horizontal Dipole, f = 100MHz");
a = gca();
a.margins = [0.225 0.1 0.125 0.2];
a.grid = [1 1];
a.x_label.text = "x";
a.y_label.text = "y";
x = abs(Eper2) .* cos(alpha);
y = abs(Eper2) .* sin(alpha);
plot2d(x,y);

subplot(223);
title("E Field with Vertical Dipole, f = 1MHz");
a = gca();
a.margins = [0.225 0.1 0.125 0.2];
a.grid = [1 1];
a.x_label.text = "x";
a.y_label.text = "y";
x = abs(Epar1) .* cos(alpha);
y = abs(Epar1) .* sin(alpha);
plot2d(x,y);

subplot(224);
title("E Field with Vertical Dipole, f = 100MHz");
a = gca();
a.margins = [0.225 0.1 0.125 0.2];
a.grid = [1 1];
a.x_label.text = "x";
a.y_label.text = "y";
x = abs(Epar2) .* cos(alpha);
y = abs(Epar2) .* sin(alpha);
plot2d(x,y);

