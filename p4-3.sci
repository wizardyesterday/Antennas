function x = E1()
  phi = 0:2*%pi/100:2*%pi;
  a = abs(cos(phi));
  b = exp(%i*phi);
  x = a.*b;
endfunction

function x = E2()
  phi = 0:2*%pi/100:2*%pi;
  a = abs(cos(phi-%pi/4));
  b = exp(%i*(phi-%pi/4));
  x = a.*b;
endfunction

function x = E(e1,e2,d)
  phi = 0:2*%pi/100:2*%pi;
  dr = %pi*d;
  psi = dr*cos(phi);
  p1 = exp(-%i*psi);
  p2 = exp(%i*psi);
  x = e1.*p1 + e2.*p2;
endfunction
