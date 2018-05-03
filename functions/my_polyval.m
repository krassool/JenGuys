function [ u, u_dot ] = my_polyval(a0, a1, a2, a3, t);

u=          a0 + a1*t + a2*t.^2 + a3*t.^3 ;
u_dot=      a1 +    2*a2*t   +   3*a3 * t.^2 ;

end
