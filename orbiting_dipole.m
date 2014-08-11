%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% System Parameters (Play With These) %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Bar Magnet Parameters
moment_of_inertia = 10;
magnet_moment = [0; 1; 0];
initial_position = [0; 2000000; 0];
initial_velocity = [10000; 1000; 1000];

% Earth Parameters
earth_moment = [0; 7.94e22; 0];
mass_of_earth = 5.97219e24;

% Universal Constants
gravitational_constant = 6.67384e-11;

% Simulation Parameters
number_of_data_points = 500;
time_step = 5;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
% Output Vectors
x_position = zeros(number_of_data_points, 1);
y_position = zeros(number_of_data_points, 1);
z_position = zeros(number_of_data_points, 1);
x_projection = zeros(number_of_data_points, 1);
y_projection = zeros(number_of_data_points, 1);
z_projection = zeros(number_of_data_points, 1);
 
% Anonymous Functions
magnetic_field = @(m,r) 1e-7*(3*r*dot(m,r)/norm(r)^5 - m/norm(r)^3);
acceleration_of_gravity = @(r) -gravitational_constant*mass_of_earth*r/norm(r)^3;
acceleration_of_dipole = @(mu,B,I) cross(mu,B)/I;
final_v_omega = @(v,a) v + a*time_step;
final_x_theta = @(x,v,a) x + v*time_step + 0.5*a*time_step^2;
 
% Pre-Calculations
position = initial_position;
velocity = initial_velocity;
acceleration = acceleration_of_gravity(position);
theta = [0; 0; 0];
omega = [0; 0; 0];
alpha = acceleration_of_dipole(magnet_moment, magnetic_field(earth_moment, position), moment_of_inertia);

x_position(1,1) = position(1,1);
y_position(1,1) = position(2,1);
z_position(1,1) = position(3,1);

x_projection(1,1) = 0.3*norm(initial_position)*magnet_moment(1,1)/norm(magnet_moment);
y_projection(1,1) = 0.3*norm(initial_position)*magnet_moment(2,1)/norm(magnet_moment);
z_projection(1,1) = 0.3*norm(initial_position)*magnet_moment(3,1)/norm(magnet_moment);

for i = 2:number_of_data_points
 
    position = final_x_theta(position, velocity, acceleration);
    theta = final_x_theta(theta, omega, alpha);
    
    velocity = final_v_omega(velocity, acceleration);
    omega = final_v_omega(omega, alpha);
    
    acceleration = acceleration_of_gravity(position);
    alpha = acceleration_of_dipole(magnet_moment, magnetic_field(earth_moment, position), moment_of_inertia);
    
    x_position(i,1) = position(1,1);
    y_position(i,1) = position(2,1);
    z_position(i,1) = position(3,1);
    
    ps = theta(1,1);
    th = theta(2,1);
    ph = theta(3,1);
    
    B = [1 0 0; 0 cos(ps) sin(ps); 0 -sin(ps) cos(ps)];
    C = [cos(th) 0 -sin(th); 0 1 0; sin(th) 0 cos(th)];
    D = [cos(ph) sin(ph) 0; -sin(ph) cos(ph) 0; 0 0 1];
    projection = 0.3*norm(initial_position)*B*C*D*magnet_moment/norm(magnet_moment);
    
    x_projection(i,1) = projection(1,1);
    y_projection(i,1) = projection(2,1);
    z_projection(i,1) = projection(3,1);
    
    clf
    quiver3(x_position(i,1), y_position(i,1), z_position(i,1), x_projection(i,1), y_projection(i,1), z_projection(i,1))
    title('Path of the Magnet Around the Earth')
    axis([-2*norm(initial_position) 2*norm(initial_position) -2*norm(initial_position) 2*norm(initial_position) -2*norm(initial_position) 2*norm(initial_position)]);
    xlabel('x-position')
    ylabel('y-position')
    zlabel('z-position')
    F(i-1) = getframe;

end

quiver3(x_position, y_position, z_position, x_projection, y_projection, z_projection)
title('Path of the Magnet Around the Earth')
xlabel('x-position')
ylabel('y-position')
zlabel('z-position')
