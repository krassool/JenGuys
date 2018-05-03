function [a0, a1, a2, a3] = cubic_trajectory(u_0,u_f,u_0_dot,u_f_dot,t_f)

a0 = u_0;
a1 = u_0_dot;
a2 = (3/(t_f)^2)*(u_f-u_0)-(2/t_f)*u_0_dot-(1/t_f)*u_f_dot;
a3 = (-2/(t_f)^3)*(u_f-u_0)+(1/(t_f^2))*(u_f_dot+u_0_dot);
end

