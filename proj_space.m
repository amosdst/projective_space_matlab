%% (C) 2017 Amos D.S.Tsai, All Rights Reserved
%

classdef proj_space
    methods (Static, Access = public)
        function draw_point(p, k, spec)
            if (p(3) == 0)
                % infinite point
                if (size(k, 2) == 1)
                    % draw single point marker
                    plot3(k * p(1), 0, k * p(2), spec, 'MarkerSize', 12);
                else
                    % draw ray space
                    px = @(k) k * p(1);
                    py = @(k) k * p(2);
                    pz = @(k) k * 0;

                    plot3(px(k), pz(k), py(k), spec);
                end
            else
                if (size(k, 2) == 1)
                    % draw single point marker
                    plot3(k * p(1) / p(3), k, k * p(2) / p(3), spec, 'MarkerSize', 12);
                else
                    % draw ray space
                    px = @(k) k * p(1) / p(3);
                    py = @(k) k * p(2) / p(3);
                    pz = @(k) k;

                    plot3(px(k), pz(k), py(k), spec);
                end
            end
        end
        
        function draw_points(p, k, specs)
            if (size(k, 2) == 1)
                % draw single point marker
                for i = 1 : 1 : size(p, 2)
                    plot3(k * p(1, i) / p(3, i), k, k * p(2, i) / p(3, i), specs{i}, 'MarkerSize', 12);
                end
            else
                % draw ray space
                for i = 1 : 1 : size(p, 2)
                    px = @(k) k * p(1, i) / p(3, i);
                    py = @(k) k * p(2, i) / p(3, i);
                    pz = @(k) k;

                    plot3(px(k), pz(k), py(k), specs{i});
                end
            end
        end
    
        function draw_line(line, p1, p2, spec)
            % y = (-1 / b) (a * x + c)       for hdiv-ed points (x y 1),  k = 1
            % y = (-1 / b) (a * x + c * w)   for h-scaled points (x y w), k = w
            %
            lx = linspace(p1(1), p2(1), 30);
            lz = linspace(p1(3), p2(3), 30);
            ly = @(x, w) -(line(1) * x + line(3) * w) / line(2);

            plot3(lx, lz, ly(lx, lz), spec);
        end

        function draw_open_line(line, x, k, spec)
            % y = (-1 / b) (a * x + c)       for hdiv-ed points (x y 1),  k = 1
            % y = (-1 / b) (a * x + c * w)   for h-scaled points (x y w), k = w
            %
            lx = x * k;
            lz = ones(1, size(x, 2)) * k;
            ly = @(x, w) -(line(1) * x + line(3) * w) / line(2);

            plot3(lx, lz, ly(lx, lz), spec);
        end
        
        function draw_line_section(line, p1, p2, k, spec)
            % y = (-1 / b) (a * x + c)       for hdiv-ed points (x y 1),  k = 1
            % y = (-1 / b) (a * x + c * w)   for h-scaled points (x y w), k = w
            %
            lx = linspace(k * p1(1) / p1(3), k * p2(1) / p2(3), 30);
            lz = ones(1, 30) * k;
            ly = @(x, w) -(line(1) * x + line(3) * w) / line(2);

            plot3(lx, lz, ly(lx, lz), spec);
        end
        
        function draw_line_on_plane(line, x, k, spec)
            % y = (-1 / b) (a * x + c)       for hdiv-ed points (x y 1),  k = 1
            % y = (-1 / b) (a * x + c * w)   for h-scaled points (x y w), k = w
            %
            lz = ones(1, size(x,2)) * k;
            ly = @(x, w) -(line(1) * x + line(3) * k) / line(2);

            plot3(x, lz, ly(x, lz), spec);
        end

        function draw_line_normal(line, k, spec)
            vx = @(k) k * line(1);
            vy = @(k) k * line(2);
            vz = @(k) k * line(3);

            plot3(vx(k), vz(k), vy(k), spec);
        end

        function draw_line_plane(line, x, y, spec)
            [X, Y] = meshgrid(x, y);
            Z = -(line(1) * X + line(2) * Y) / line(3);
            %surf(X, Z, Y);

            plot3(X, Z, Y, spec);
        end

        function draw_conic_mesh(c, x, y, spec, draw_conjugate)
            % conics : p^T C_conic p = 0 (C_conic is symetic) => c11 x^2 + c22 y^2 + c33 w^2 + 2 c12 xy + 2 c13 xw + 2 c23 yw = 0
            %  => A w^2 + B w + C = 0
            %     A = c33
            %     B = 2 c13 x + 2 c23 y
            %     C = c11 x^2 + c22 y^2 + 2 c12 xy
            %  => w = (-B +- sqrt(B^2 - 4AC)) / (1 / 2A)
            [X, Y] = meshgrid(x, y);
            A = c(3, 3);
            B = 2 * c(1, 3) * X + 2 * c(2, 3) * Y;
            C = c(1, 1) * X .* X + c(2, 2) * Y .* Y + 2 * c(1, 2) * X .* Y;

            if (draw_conjugate >= 0)
                Z1 = (-B + sqrt(B .* B - 4 * A .* C)) / (2 * A);
                plot3(X, Z1, Y, spec);
            end

            if (draw_conjugate <= 0)
                Z2 = (-B - sqrt(B .* B - 4 * A .* C)) / (2 * A);
                plot3(X, Z2, Y, spec);
            end
        end
        
        function draw_k_plane(k, x, y, spec)
            [X, Y] = meshgrid(x, y);
            Z = ones(size(X, 1), size(Y, 2)) * k;
            plot3(X, Z, Y, spec);
        end
        
        function draw_sphere(r, spec)
            [X, Y, Z] = sphere(30);
            plot3(r * X, r * Z, r * Y, spec);
        end
        
        function draw_sphere_at(p, r, spec)
            [X, Y, Z] = sphere(30);
            plot3(r * X + p(1), r * Z + p(3), r * Y + p(2), spec);
        end
    end
end



