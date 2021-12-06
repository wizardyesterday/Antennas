function x = Ea()
  phi = 0:2*%pi/100:2*%pi;
  dr = %pi*5/2;
  psi1 = dr*sin(phi);
  psi2 = dr*sin(phi)/4;
  psi3 = 3*dr*sin(phi)/4;
  p = exp(%i*psi3);
  nu = sin(psi1);
  nu = nu + 1e-6;
  de = sin(psi2);
  de = de + 1e-6;
  x = nu ./ de;
  x = x .* p;
endfunction

function x = Ec()
  phi = 0:2*%pi/100:2*%pi;
  dr = %pi*5/4;
  psi = dr*sin(phi);
  x = 1 + exp(%i*psi);
  x = x.*x.*x;
endfunction
