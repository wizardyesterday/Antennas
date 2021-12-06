//******************************************************************
// Problem P11-40
//******************************************************************

//*****************************************************************
// function declarations
//******************************************************************
function x = calcObservedFluxDensity(phi0,s)
  x = inttrap(phi0,s);
  x = x / (max(phi0) - min(phi0));
endfunction

//******************************************************************
// main code
//******************************************************************
phi = 0:.1:1;
phi0 = -1:.1:4;

// construct antenna pattern
p = 1 - phi;
p(1) = [];
p = [phi p];

// construct aperture distribution
b1 = [1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
b2 = [0 0 0 0 0 0 0 0 0 0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1] / 10;

// construct observed distribution
// construct contribution to point aperture
s1 = convol(p,b1);
// construct contribution due to rectangular aperture
s2 = convol(p,b2);
// total contribution is the sum of the point and rectangle aperture
s = s1 + s2;

// calculate observed flux density
Sdens = calcObservedFluxDensity(phi0,[s 0]);

//******************************************************************
// plot 
//******************************************************************
set("figure_style","new");

title("Observed Flux Density of Uniform Point and Rectangle Distribution");
a = gca();
a.margins = [0.125 0.2 0.125 0.125];
a.margins = [0.125 0.2 0.125 0.2];
a.grid = [1 1];
a.x_label.text = "phi0, degrees"; 
a.y_label.text = "S";
plot(phi0,[s 0]);
