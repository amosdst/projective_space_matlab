%% (C) 2017 Amos D.S.Tsai, All Rights Reserved
%
clear  % clear workspace
clc    % clear command window
clf    % clear figure


%% isometry
clear;clc;clf
hold off;

% tranformation matrix function handle
%
% e          orientation-preserving(+1) or reverse orientation(-1)
% theta      rotation angle
% t_x, t_y   translation offset
%
H = @(e, theta, t_x, t_y)  [ e * cos(theta) -sin(theta) t_x; e * sin(theta) cos(theta) t_y; 0 0 1; ];

% tranformation function handle
%
% p          position input
% H          transformation matrix
%
do_transform = @(T, p) T * p;

H1 = H(1, 0, 0, 0)
H2 = H(1, 1 * pi / 4, 0, 0)
H3 = H(-1, 1 * pi / 4, 0, 0)

p1 = [ 1 1 1 ];
p2 = [ 1 2 1 ];
p3 = [ 2 2 1 ];
p4 = [ 2 1 1 ];
p5 = [ 1 1 1 ];

c = { do_transform(H1, p1') do_transform(H1, p2') do_transform(H1, p3') do_transform(H1, p4') do_transform(H1, p5') };
pp = [ c{1,:} ];
x1 = pp(1, 1:3);
y1 = pp(2, 1:3);

c = { do_transform(H2, p1') do_transform(H2, p2') do_transform(H2, p3') do_transform(H2, p4') do_transform(H2, p5') };
pp = [ c{1,:} ];
x2 = pp(1, 1:3);
y2 = pp(2, 1:3);

c = { do_transform(H3, p1') do_transform(H3, p2') do_transform(H3, p3') do_transform(H3, p4') do_transform(H3, p5') };
pp = [ c{1,:} ];
x3 = pp(1, 1:3);
y3 = pp(2, 1:3);

plot(x1, y1, 'r-', x2, y2, 'g-', x3, y3, 'b-');

title('isometry');
grid on;

x_range = [ -3 3 ];
y_range = [ -3 3 ];

set(gca, 'XLim', x_range);
set(gca, 'YLim', y_range);
set(gca, 'XAxisLocation', 'origin');
set(gca, 'YAxisLocation', 'origin');
set(gca, 'Box', 'off');
%set(gca, 'XTick', 0:1:4);
%set(gca, 'XTickLabel', {'0', '\pi/2', '\pi', '3\pi/2', '2\pi', '5\pi/2', '3\pi', '7\pi/2', '4pi'});

xlabel('x', 'FontAngle', 'italic', 'FontSize', 12, 'FontWeight', 'normal', 'Color', [0.5, 0.5, 0.5]);
ylabel('y', 'FontAngle', 'italic', 'FontSize', 12, 'FontWeight', 'normal', 'Color', [0.5, 0.5, 0.5]);


%% similarity
clear;clc;clf;
hold off;

% tranformation matrix function handle
%
% s          isotropic scaling factor
% theta      rotation angle
% t_x, t_y   translation offset
%
H = @(s, theta, t_x, t_y)  [ s * cos(theta) -s * sin(theta) t_x; s * sin(theta) s * cos(theta) t_y; 0 0 1; ];

% tranformation function handle
%
% p          position input
% H          transformation matrix
%
do_transform = @(T, p) T * p;

H1 = H(1, 0, 0, 0)
H2 = H(2, 1 * pi / 4, 0, 0)
H3 = H(-2, 1 * pi / 4, 0, 0)

p1 = [ 1 1 1 ];
p2 = [ 1 2 1 ];
p3 = [ 2 2 1 ];
p4 = [ 2 1 1 ];
p5 = [ 1 1 1 ];

c = { do_transform(H1, p1') do_transform(H1, p2') do_transform(H1, p3') do_transform(H1, p4') do_transform(H1, p5') };
pp = [ c{1,:} ];
x1 = pp(1, :);
y1 = pp(2, :);

c = { do_transform(H2, p1') do_transform(H2, p2') do_transform(H2, p3') do_transform(H2, p4') do_transform(H2, p5') };
pp = [ c{1,:} ];
x2 = pp(1, :);
y2 = pp(2, :);

c = { do_transform(H3, p1') do_transform(H3, p2') do_transform(H3, p3') do_transform(H3, p4') do_transform(H3, p5') };
pp = [ c{1,:} ];
x3 = pp(1, :);
y3 = pp(2, :);

plot(x1, y1, 'r-', x2, y2, 'g-', x3, y3, 'b-');

title('similarity');
grid on;

x_range = [ -6 6 ];
y_range = [ -6 6 ];

set(gca, 'XLim', x_range);
set(gca, 'YLim', y_range);
set(gca, 'XAxisLocation', 'origin');
set(gca, 'YAxisLocation', 'origin');
set(gca, 'Box', 'off');
%set(gca, 'XTick', 0:1:4);
%set(gca, 'XTickLabel', {'0', '\pi/2', '\pi', '3\pi/2', '2\pi', '5\pi/2', '3\pi', '7\pi/2', '4pi'});

xlabel('x', 'FontAngle', 'italic', 'FontSize', 12, 'FontWeight', 'normal', 'Color', [0.5, 0.5, 0.5]);
ylabel('y', 'FontAngle', 'italic', 'FontSize', 12, 'FontWeight', 'normal', 'Color', [0.5, 0.5, 0.5]);


%% affinity (affine transform)
clear;clc;clf;
hold off;

% tranformation matrix function handle
%
% s1, s2     anisotropic (non-isotropic) scaling factor
% phi        specifies the scaling direction (nemonic hints: rotate the
%            axis -phi angle, do scaling along the coordinates there, and
%            then rotate the axis back)
% theta      transformation rotation angle
% t_x, t_y   translation offset
%
H_phi = @(phi)  [ cos(phi) -sin(phi) 0; sin(phi) cos(phi) 0; 0 0 1; ];
H_s = @(s1, s2)  [ s1 0 0; 0 s2 0; 0 0 1; ];
H_t = @(theta, t_x, t_y)  [ cos(theta) -sin(theta) t_x; sin(theta) cos(theta) t_y; 0 0 1; ];
H = @(s1, s2, phi, theta, t_x, t_y)  H_t(theta, t_x, t_y) * H_phi(-phi) * H_s(s1, s2) * H_phi(phi);
%H = @(s1, s2, phi, theta, t_x, t_y)  H_phi(-phi) * H_s(s1, s2) * H_phi(phi);
%H = @(s1, s2, phi, theta, t_x, t_y)  H_s(s1, s2) * H_phi(phi);
%H = @(s1, s2, phi, theta, t_x, t_y)  H_s(s1, s2);
%H = @(s1, s2, phi, theta, t_x, t_y)  H_phi(phi);

% tranformation function handle
%
% p          position input
% H          transformation parameters
%2
%do_transform = @(s1, s2, phi, theta, t_x, t_y, p)  H_t(theta, t_x, t_y) * H_phi(-phi) * H_s(s1, s2) * H_phi(phi) * p;
%do_transform = @(H, p)  H_t(H(1,4), H(1,5), H(1,6)) * H_phi(-H(1,3)) * H_s(H(1,1), H(1,2)) * H_phi(H(1,3)) * p;
do_transform = @(H, p)  H * p;

H1 = H(1, 1, 0, 0, 0, 0);
H2 = H(2, 1, 1 * pi / 4, 0 * pi / 4, 0, 0);
H3 = H(1, 2, 1 * pi / 4, 0 * pi / 4, 0, 0);

p1 = [ 1 1 1 ];
p2 = [ 1 2 1 ];
p3 = [ 2 2 1 ];
p4 = [ 2 1 1 ];
p5 = [ 1 1 1 ];

c = { do_transform(H1, p1') do_transform(H1, p2') do_transform(H1, p3') do_transform(H1, p4') do_transform(H1, p5') };
pp = [ c{1,:} ];
x1 = pp(1, :);
y1 = pp(2, :);

c = { do_transform(H2, p1') do_transform(H2, p2') do_transform(H2, p3') do_transform(H2, p4') do_transform(H2, p5') };
pp = [ c{1,:} ];
x2 = pp(1, :);
y2 = pp(2, :);

c = { do_transform(H3, p1') do_transform(H3, p2') do_transform(H3, p3') do_transform(H3, p4') do_transform(H3, p5') };
pp = [ c{1,:} ];
x3 = pp(1, :);
y3 = pp(2, :);

plot(x1, y1, 'r-', x2, y2, 'g-', x3, y3, 'b-');

title('afinity');
grid on;

x_range = [ -6 6 ];
y_range = [ -6 6 ];

set(gca, 'XLim', x_range);
set(gca, 'YLim', y_range);
set(gca, 'XAxisLocation', 'origin');
set(gca, 'YAxisLocation', 'origin');
set(gca, 'Box', 'off');
%set(gca, 'XTick', 0:1:4);
%set(gca, 'XTickLabel', {'0', '\pi/2', '\pi', '3\pi/2', '2\pi', '5\pi/2', '3\pi', '7\pi/2', '4pi'});

xlabel('x', 'FontAngle', 'italic', 'FontSize', 12, 'FontWeight', 'normal', 'Color', [0.5, 0.5, 0.5]);
ylabel('y', 'FontAngle', 'italic', 'FontSize', 12, 'FontWeight', 'normal', 'Color', [0.5, 0.5, 0.5]);


%% the line passing the given two points
clear;clc;clf;
hold on;

% function handles for p
%

% points : [x y w]
% lines  : [a b c] for a * x + b * y + c * w = 0 if [x y z] lies on the line
%

% points
p = [ 1 1 1; 4 1 2 ]'

tr_specs = { 'r-' 'g-' };
mk_specs = { 'ko' 'ko' };

k = linspace(0, 8, 30);

% line
line = cross(p(:,1), p(:,2));

proj_space.draw_points(p, k, tr_specs);
proj_space.draw_points(p, 1, mk_specs);

proj_space.draw_line(line, p(:,1), p(:,2), 'b-');
proj_space.draw_line_section(line, p(:,1), p(:,2), 1, 'm-');
proj_space.draw_line_section(line, p(:,1), p(:,2), 2, 'm-');

title('line passing two points');
grid on;

view(30, 50);
camproj('perspective')
xlabel('x', 'FontAngle', 'italic', 'FontSize', 12, 'FontWeight', 'normal', 'Color', [0.5, 0.5, 0.5]);
ylabel('k', 'FontAngle', 'italic', 'FontSize', 12, 'FontWeight', 'normal', 'Color', [0.5, 0.5, 0.5]);
zlabel('y', 'FontAngle', 'italic', 'FontSize', 12, 'FontWeight', 'normal', 'Color', [0.5, 0.5, 0.5]);

%set(gca, 'XAxisLocation', 'origin');
%set(gca, 'YAxisLocation', 'origin');
%set(gca, 'ZAxisLocation', 'origin');
set(gca, 'Box', 'on');


%% intersection point of given two lines
clear;clc;clf;
hold on;

% function handles for p
%

% points : [x y w]
% lines  : [a b c] for a * x + b * y + c * w = 0 if [x y z] lies on the line
%

% lines
l1 = [ 2 -1 1 ];
l2 = [ 8 -2 -10 ];

x = linspace(-1, 8, 30);

% point
p = cross(l1, l2)

k = linspace(-11, 5, 60);

proj_space.draw_point(p, k, 'b-');

proj_space.draw_point(p, 1, 'kx');
proj_space.draw_open_line(l1, x, 1, 'r-');
proj_space.draw_open_line(l2, x, 1, 'g-');

proj_space.draw_point(p, p(3), 'kx');
proj_space.draw_open_line(l1, x, p(3), 'r-');
proj_space.draw_open_line(l2, x, p(3), 'g-');

proj_space.draw_point(p, l2(3), 'kx');
proj_space.draw_open_line(l1, x, l2(3), 'r-');
proj_space.draw_open_line(l2, x, l2(3), 'g-');

proj_space.draw_k_plane(0, (-30:30), (-200:100), 'y-');

title('line intersection');
grid on;
view(30, 50);
camproj('perspective')

xlabel('x', 'FontAngle', 'italic', 'FontSize', 12, 'FontWeight', 'normal', 'Color', [0.5, 0.5, 0.5]);
ylabel('k', 'FontAngle', 'italic', 'FontSize', 12, 'FontWeight', 'normal', 'Color', [0.5, 0.5, 0.5]);
zlabel('y', 'FontAngle', 'italic', 'FontSize', 12, 'FontWeight', 'normal', 'Color', [0.5, 0.5, 0.5]);

%set(gca, 'XAxisLocation', 'origin');
%set(gca, 'YAxisLocation', 'origin');
%set(gca, 'ZAxisLocation', 'origin');
set(gca, 'Box', 'on');


%% intersection point of given two lines (using line planes)
clear;clc;clf;
hold on;

% function handles for p
%

% points : [x y w]
% lines  : [a b c] for a * x + b * y + c * w = 0 if [x y z] lies on the line
%

% lines
l1 = [ 2 -1 1 ];
l2 = [ 8 -2 -10 ];

x = linspace(-1, 5, 30);
y = linspace(-1, 10, 30);

% point
p = cross(l1, l2)

k = linspace(-1, 2, 30);

proj_space.draw_point(p, k, 'b-');
proj_space.draw_point(p, 1, 'kx');

% all points perpendicular to the line normal forms a plane
proj_space.draw_line_normal(l1, k, 'r-');
proj_space.draw_line_normal(l2, k, 'g-');

% points lie on the intersection part of the two planes (y && b) form a line (red)
proj_space.draw_line_plane(l1, x, y, 'r-');
proj_space.draw_line_plane(l2, x, y, 'g-');
proj_space.draw_k_plane(1, x, y, 'y-');


title('line intersection (line-plane representation)');
grid on;
view(30, 50);
camproj('perspective')

xlabel('x', 'FontAngle', 'italic', 'FontSize', 12, 'FontWeight', 'normal', 'Color', [0.5, 0.5, 0.5]);
ylabel('k', 'FontAngle', 'italic', 'FontSize', 12, 'FontWeight', 'normal', 'Color', [0.5, 0.5, 0.5]);
zlabel('y', 'FontAngle', 'italic', 'FontSize', 12, 'FontWeight', 'normal', 'Color', [0.5, 0.5, 0.5]);

%set(gca, 'XAxisLocation', 'origin');
%set(gca, 'YAxisLocation', 'origin');
%set(gca, 'ZAxisLocation', 'origin');
set(gca, 'Box', 'on');


%% intersection point of parallel lines (using line planes)
clear;clc;clf;
hold on;

% function handles for p
%

% points : [x y w]
% lines  : [a b c] for a * x + b * y + c * w = 0 if [x y z] lies on the line
%

% lines
l1 = [ 2 -1 1 ];
l2 = [ 2 -1 3 ];
l3 = [ 2 -1 -2 ];

x = linspace(-1, 5, 30);
y = linspace(-1, 10, 30);

% point
p = cross(l1, l2)

k = linspace(-1, 2, 30);
%proj_space.draw_point(p, k, 'b-');
%proj_space.draw_point(p, 1, 'kx');

% all points perpendicular to the line normal forms a plane
proj_space.draw_line_normal(l1, k, 'r-');
proj_space.draw_line_normal(l2, k, 'g-');
proj_space.draw_line_normal(l3, k, 'b-');

% points lie on the intersection part of the two planes (y && b) form a line (red)
proj_space.draw_line_plane(l1, x, y, 'r-');
proj_space.draw_line_plane(l2, x, y, 'g-');
proj_space.draw_line_plane(l3, x, y, 'b-');
proj_space.draw_k_plane(0, x, y, 'y-');


title('parallel lines intersection');
grid on;
view(30, 50);
camproj('perspective')

xlabel('x', 'FontAngle', 'italic', 'FontSize', 12, 'FontWeight', 'normal', 'Color', [0.5, 0.5, 0.5]);
ylabel('k', 'FontAngle', 'italic', 'FontSize', 12, 'FontWeight', 'normal', 'Color', [0.5, 0.5, 0.5]);
zlabel('y', 'FontAngle', 'italic', 'FontSize', 12, 'FontWeight', 'normal', 'Color', [0.5, 0.5, 0.5]);

%set(gca, 'XAxisLocation', 'origin');
%set(gca, 'YAxisLocation', 'origin');
%set(gca, 'ZAxisLocation', 'origin');
set(gca, 'Box', 'on');


%% line L on the w = 1 plane
clear;clc;clf;
hold on;

% function handles for p
%

% points : [x y w]
% lines  : [a b c] for a * x + b * y + c * w = 0 if [x y z] lies on the line
%

% lines
l1 = [ 2 -1 1 ];
%l2 = [ 2 -1 3 ];
%l3 = [ 2 -1 -2 ];
w1 = [ 0 0 1 ];

x = linspace(-2, 5, 60);
y = linspace(-2, 10, 60);

k = linspace(-1, 2, 30);

% line intersection point with the infinite line (0 0 1)
p = cross(w1, l1)
proj_space.draw_point(p, k, 'k.');
proj_space.draw_point(p, 1, 'kx');

% all points perpendicular to the line normal forms a plane
proj_space.draw_line_normal(l1, k, 'r-');
%proj_space.draw_line_normal(l2, k, 'g-');
%proj_space.draw_line_normal(l3, k, 'b-');

% points lie on the intersection part of the two planes (y && b) form a line (red)
proj_space.draw_line_plane(l1, x, y, 'r-');
%proj_space.draw_line_plane(l2, x, y, 'g-');
%proj_space.draw_line_plane(l3, x, y, 'b-');

proj_space.draw_k_plane(0, x, y, 'y-');
proj_space.draw_k_plane(1, x, y, 'y-');

% points lie on the line and the w=1 plane
proj_space.draw_line_on_plane(l1, x, 1, 'b.');

proj_space.draw_sphere(1, 'c.');

title('line L on the w = 1 plane');
grid on;
view(30, 50);
camproj('perspective');

axis([-2 3 -2 3 -2 3]);
xlabel('x', 'FontAngle', 'italic', 'FontSize', 12, 'FontWeight', 'normal', 'Color', [0.5, 0.5, 0.5]);
ylabel('k', 'FontAngle', 'italic', 'FontSize', 12, 'FontWeight', 'normal', 'Color', [0.5, 0.5, 0.5]);
zlabel('y', 'FontAngle', 'italic', 'FontSize', 12, 'FontWeight', 'normal', 'Color', [0.5, 0.5, 0.5]);

%set(gca, 'XAxisLocation', 'origin');
%set(gca, 'YAxisLocation', 'origin');
%set(gca, 'ZAxisLocation', 'origin');
set(gca, 'Box', 'on');


%% point representation ways in the projection space
clear;clc;clf;
hold on;

% function handles for p
%

% points : [x y w]
% lines  : [a b c] for a * x + b * y + c * w = 0 if [x y z] lies on the line
%

% points
p = [ 1 1 1; 4 1 2 ]';

p1 = p(:,1) / norm(p(:,1));
p2 = p(:,2) / norm(p(:,2));

tr_specs = { 'r-' 'g-' };
mk_specs = { 'kx' 'kx' };

x = linspace(-2, 2, 30);
y = linspace(-2, 2, 30);
k = linspace(-2, 2, 30);

proj_space.draw_points(p, k, tr_specs);
proj_space.draw_point(p1, p1(3), mk_specs{1});
proj_space.draw_point(p2, p2(3), mk_specs{2});

proj_space.draw_k_plane(0, x, y, 'y-');
proj_space.draw_sphere(1, 'c.');

title('point representations');
grid on;
view(30, 50);
camproj('perspective')

xlabel('x', 'FontAngle', 'italic', 'FontSize', 12, 'FontWeight', 'normal', 'Color', [0.5, 0.5, 0.5]);
ylabel('k', 'FontAngle', 'italic', 'FontSize', 12, 'FontWeight', 'normal', 'Color', [0.5, 0.5, 0.5]);
zlabel('y', 'FontAngle', 'italic', 'FontSize', 12, 'FontWeight', 'normal', 'Color', [0.5, 0.5, 0.5]);

%set(gca, 'XAxisLocation', 'origin');
%set(gca, 'YAxisLocation', 'origin');
%set(gca, 'ZAxisLocation', 'origin');
set(gca, 'Box', 'on');


%% line representation ways in the projection space
clear;clc;clf;
hold on;

% function handles for p
%

% points : [x y w]
% lines  : [a b c] for a * x + b * y + c * w = 0 if [x y z] lies on the line
%

% lines
l1 = [ 3 -1 1 ];
%l1 = [ 8 -2 -10 ];

x = linspace(-3, 3, 30);
y = linspace(-6, 6, 30);
k = linspace(-1, 1, 30);

% all points perpendicular to the line normal forms a plane
proj_space.draw_line_normal(l1, k, 'g-');

% points lie on the intersection part of the two planes (y && b) form a line (red)
proj_space.draw_line_plane(l1, x, y, 'b-');
proj_space.draw_k_plane(1, x, y, 'y-');
proj_space.draw_open_line(l1, x, 1, 'r-');

proj_space.draw_sphere(1, 'c.');

title('line representations');
grid on;
view(30, 50);
camproj('perspective')

xlabel('x', 'FontAngle', 'italic', 'FontSize', 12, 'FontWeight', 'normal', 'Color', [0.5, 0.5, 0.5]);
ylabel('k', 'FontAngle', 'italic', 'FontSize', 12, 'FontWeight', 'normal', 'Color', [0.5, 0.5, 0.5]);
zlabel('y', 'FontAngle', 'italic', 'FontSize', 12, 'FontWeight', 'normal', 'Color', [0.5, 0.5, 0.5]);

%set(gca, 'XAxisLocation', 'origin');
%set(gca, 'YAxisLocation', 'origin');
%set(gca, 'ZAxisLocation', 'origin');
set(gca, 'Box', 'on');


%% conics representations in the projection space
clear;clc;clf;
hold on;

% function handles for p
%

% points : [x y w]
% lines  : [a b c] for a * x + b * y + c * w = 0 if [x y z] lies on the line
% conics : p^T C p = 0 (C is symetic) => c11 x^2 + c22 y^2 + c33 w^2 + 2 c12 xy + 2 c13 xw + 2 c23 yw = 0
%

% conicx
%C = [ 1 2 3; 2 1 4; 3 4 1 ];
%C = [ 1 0 0; 0 1 0; 0 0 -1 ];  % circle (x-a)^2 + (y-b)^2 = r^2
%C = [ 1 0 0; 0 0 -1; 0 -1 -2 ];  % parabola y = (x-a)^2 + c
C = [ 1 0 0; 0 -1 0; 0 0 -1 ];  % hyperbola (x-h)^2 / a^2 - (y-k)^2 / b^2 = 1

x = linspace(-2, 3, 60);
y = linspace(-2, 3, 60);
%k = linspace(-1, 1, 30);

% all points perpendicular to the line normal forms a plane
proj_space.draw_conic_mesh(C, x, y, 'r-', 0);

% points lie on the intersection part of the two planes (y && b) form a line (red)
%proj_space.draw_line_plane(l1, x, y, 'b-');
proj_space.draw_k_plane(1, x, y, 'y-');
%proj_space.draw_open_line(l1, x, 1, 'r-');

%proj_space.draw_sphere(1, 'c.');

title('conic representations');
grid on;
view(30, 50);
camproj('perspective')

xlabel('x', 'FontAngle', 'italic', 'FontSize', 12, 'FontWeight', 'normal', 'Color', [0.5, 0.5, 0.5]);
ylabel('k', 'FontAngle', 'italic', 'FontSize', 12, 'FontWeight', 'normal', 'Color', [0.5, 0.5, 0.5]);
zlabel('y', 'FontAngle', 'italic', 'FontSize', 12, 'FontWeight', 'normal', 'Color', [0.5, 0.5, 0.5]);

%set(gca, 'XAxisLocation', 'origin');
%set(gca, 'YAxisLocation', 'origin');
%set(gca, 'ZAxisLocation', 'origin');
set(gca, 'Box', 'on');


%% intersection of xy = 1 and y = 1
clear;clc;clf;
hold on;

y = @(x)  1 ./ x;
x = linspace(0.1, 8, 30);

plot(x, y(x), 'r-');

title('hyperbola');
grid on;

x_range = [ -3 8 ];
y_range = [ -3 8 ];

set(gca, 'XLim', x_range);
set(gca, 'YLim', y_range);
set(gca, 'XAxisLocation', 'origin');
set(gca, 'YAxisLocation', 'origin');
set(gca, 'Box', 'off');
%set(gca, 'XTick', 0:1:4);
%set(gca, 'XTickLabel', {'0', '\pi/2', '\pi', '3\pi/2', '2\pi', '5\pi/2', '3\pi', '7\pi/2', '4pi'});

xlabel('x', 'FontAngle', 'italic', 'FontSize', 12, 'FontWeight', 'normal', 'Color', [0.5, 0.5, 0.5]);
ylabel('y', 'FontAngle', 'italic', 'FontSize', 12, 'FontWeight', 'normal', 'Color', [0.5, 0.5, 0.5]);









%% template
clear;clc;

% function handles
%
x1 = @(k) (3 * k);
y1 = @(k) (2 * k);
z1 = @(k) (k);

x2 = @(k) (k);
y2 = @(k) (k);
z2 = @(k) (k);

x3 = @(k) (k);
y3 = @(k) (-2 * k);
z3 = @(k) (k);

k = linspace(0, 10, 100);

plot3(x1(k), y1(k), z1(k), 'r.', x2(k), y2(k), z2(k), 'g.', x3(k), y3(k), z3(k), 'b.');

%[X, Y] = meshgrid(k, k);
%Z = ones(1, size(k, 2));
%plot3(x1(k), z1(k), y1(k), 'r.', X, Z, Y, 'g.');

grid on;
view(30, 50);
camproj('perspective')

xlabel('x', 'FontAngle', 'italic', 'FontSize', 12, 'FontWeight', 'normal', 'Color', [0.5, 0.5, 0.5]);
ylabel('k', 'FontAngle', 'italic', 'FontSize', 12, 'FontWeight', 'normal', 'Color', [0.5, 0.5, 0.5]);
zlabel('y', 'FontAngle', 'italic', 'FontSize', 12, 'FontWeight', 'normal', 'Color', [0.5, 0.5, 0.5]);

%set(gca, 'XAxisLocation', 'origin');
%set(gca, 'YAxisLocation', 'origin');
%set(gca, 'ZAxisLocation', 'origin');
set(gca, 'Box', 'off');


