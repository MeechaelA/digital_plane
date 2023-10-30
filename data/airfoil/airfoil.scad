module airfoil_rib(mesh_size, thickness, camber, camber_distance, chord, square_bar_dim, square_bar_distance, rod_diameter, rod_distance)
    {

    function cat(L1, L2) = [for(L=[L1, L2], a=L) a];
    function calc_y(x, t)  = 5.0*t*(0.2969*sqrt(x) - 0.1260*x-0.3516*x^2 + 0.2843*x^3 - 0.1015*x^4);



    mesh_end = 1 + 0.0;
    res = mesh_end/mesh_size;

    camber_param = camber*10.0 + camber_distance/10.0;

    x = [0:res:mesh_end];
    t = camber_param/100;

    airfoil = [
        for (a = [0:res:mesh_end]) [a, calc_y(a, t)],
        for (a = [0:res:mesh_end]) [a, -1.0*calc_y(a, t)],
        [mesh_end, -1.0 * calc_y(mesh_end ,t)],
        [mesh_end, calc_y(mesh_end,t)]
    ];


    difference(){
        linear_extrude(height = thickness, center = true, scale = 1.0)
        resize([chord, 0.0, 0.0])
        polygon(airfoil);
        color("lightBlue")
        rotate([0.0,0.0,0.0])
        translate([square_bar_distance, 0.0, 0.0])
        cube([square_bar_dim,square_bar_dim,thickness+thickness*0.01], center = true);
        
        translate([rod_distance, 0.0, 0.0])
        cylinder(h=thickness+thickness*0.01, r=rod_diameter/2.0, center = true, $fn=25);
    }
}

//airfoil_rib(1000, 4, 9, 0.2, 50, 0.1, 1, 0.1, 5);

module airfoil_skin(mesh_size, thickness, thickness_material, camber, camber_distance, chord, square_bar_dim, square_bar_distance, rod_diameter, rod_distance, center)
    {

    function cat(L1, L2) = [for(L=[L1, L2], a=L) a];
    function calc_y(x, t)  = 5.0*t*(0.2969*sqrt(x) - 0.1260*x-0.3516*x^2 + 0.2843*x^3 - 0.1015*x^4);



    mesh_end = 1 + 0.0;
    res = mesh_end/mesh_size;

    outer_camber_param = (camber+thickness_material)*10.0 + camber_distance/10.0;
    inner_camber_param = (camber-thickness_material)*10.0 + camber_distance/10.0;
    
    x = [0:res:mesh_end];
    t_outer = outer_camber_param/100;
    t_inner = inner_camber_param/100;

    airfoil_outer = [
        for (a = [0:res:mesh_end]) [a, calc_y(a, t_outer)],
        for (a = [0:res:mesh_end]) [a, -1.0*calc_y(a, t_outer)],
        [mesh_end, -1.0 * calc_y(mesh_end, t_outer)],
        [mesh_end, calc_y(mesh_end, t_outer)]
    ];

    airfoil_inner = [
        for (a = [0:res:mesh_end]) [a, calc_y(a, t_inner)],
        for (a = [0:res:mesh_end]) [a, -1.0*calc_y(a, t_inner)],
        [mesh_end, -1.0 * calc_y(mesh_end, t_inner)],
        [mesh_end, calc_y(mesh_end, t_inner)]
    ];
 
    difference(){
        linear_extrude(height = thickness, center = center, scale = 1.0)
        resize([chord, 0.0, 0.0])
        polygon(airfoil_outer);

        linear_extrude(height = thickness*1.01, center = center, scale = 1.0)
        resize([chord, 0.0, 0.0])
        polygon(airfoil_inner);
        color("lightBlue");
    }
//    difference(){
//        linear_extrude(height = thickness, center = true, scale = 1.0)
//        resize([chord, 0.0, 0.0])
//        polygon(airfoil);
//        color("lightBlue")
//        rotate([0.0,0.0,0.0])
//        translate([square_bar_distance, 0.0, 0.0])
//        cube([square_bar_dim,square_bar_dim,thickness+thickness*0.01], center = true);
//        
//        translate([rod_distance, 0.0, 0.0])
//        cylinder(h=thickness+thickness*0.01, r=rod_diameter/2.0, center = true, $fn=25);
//    }
}

//airfoil_skin(1000, 4, 0.1, 9, 0.2, 50, 0.1, 1, 0.1, 5);
