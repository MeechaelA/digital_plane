include<airfoil.scad>

//for (i=[1:1:tail_wing_num_spars])

//airfoil_rib(mesh_size, thickness, camber, camber_distance, tail_wing_chord, square_bar_dim, square_bar_distance, rod_diameter, rod_distance);
//
//airfoil_skin(mesh_size, tail_wing_num_spars+tail_wing_num_spars*tail_wing_rib_sep-body_diameter, camber, 0.2, camber_distance, tail_wing_chord, square_bar_dim, square_bar_distance, rod_diameter, rod_distance, false);

module wing(camber, camber_distance, chord, span, skin_thickness, rib_thickness, num_ribs, bar_size, bar_distance, rod_size, rod_distance, end_support, mesh_size){
        for (i=[0:1:num_ribs-1])
            translate([0, i+i*num_ribs+rib_thickness/2, 0.0])
            rotate([90.0,0.0,0.0])

            airfoil_rib(mesh_size, rib_thickness, camber, camber_distance, chord, bar_size, bar_distance, rod_size, rod_distance);
        
    translate([bar_distance, span/2, 0.0])
    rotate([-90.0, 0.0, 0.0])
    cube([bar_size, bar_size, span+end_support/2], center = true);
        
    translate([rod_distance, span/2, 0.0])
    rotate([-90.0, 0.0, 0.0])
    cylinder(span+end_support/2, rod_size, rod_size, center = true);

    rotate([-90.0, 0.0, 0.0])
    airfoil_skin(mesh_size, span, skin_thickness, camber, camber_distance, chord, bar_size, bar_distance, rod_size, rod_distance, false);

}


//camber = 4;
//camber_distance = 9;
//chord = 10;
//span = 100;
//skin_thickness = 1.0;
//
//wing(camber, camber_distance, chord, span, skin_thickness, 1, 10, 0.1, 0.25*chord, 0.1, 0.75*chord, 10, 2);

module skew(xy = 0, xz = 0, yx = 0, yz = 0, zx = 0, zy = 0) {
	matrix = [
		[ 1, tan(xy), tan(xz), 0 ],
		[ tan(yx), 1, tan(yz), 0 ],
		[ tan(zx), tan(zy), 1, 0 ],
		[ 0, 0, 0, 1 ]
	];
	multmatrix(matrix)
	children();
}

module wing_end(camber, camber_distance, chord, span, thickness_material, bar_attach, bar_size, bar_distance, rod_attach, rod_size, rod_distance, mesh_size){
    function cat(L1, L2) = [for(L=[L1, L2], a=L) a];
    function calc_y(x, t)  = 5.0*t*(0.2969*sqrt(x) - 0.1260*x-0.3516*x^2 + 0.2843*x^3 - 0.1015*x^4);

    mesh_end = 1 + 0.0;
    res = mesh_end/mesh_size;

    outer_camber_param = (camber+thickness_material)*10.0 + camber_distance/10.0;
    inner_camber_param = (camber-thickness_material)*10.0 + camber_distance/10.0;
    
    x = [0:res:mesh_end];
    t_outer = outer_camber_param/100;
    t_inner = inner_camber_param/100;

    airfoil_begin = [
        for (a = [0:res:mesh_end]) [a, calc_y(a, t_outer)],
        for (a = [0:res:mesh_end]) [a, -1.0*calc_y(a, t_outer)],
        [mesh_end, -1.0 * calc_y(mesh_end, t_outer)],
        [mesh_end, calc_y(mesh_end, t_outer)]
    ];

    airfoil_end = [
        for (a = [0:res:mesh_end]) [a, calc_y(a, t_inner)],
        for (a = [0:res:mesh_end]) [a, -1.0*calc_y(a, t_inner)],
        [mesh_end, -1.0 * calc_y(mesh_end, t_inner)],
        [mesh_end, calc_y(mesh_end, t_inner)]
    ];
        

    

    difference(){
        resize([chord, 0.0, 0])
        skew(xz=5.0)
        linear_extrude(span, scale=[0.1, 0.25], convexity=20, $fn=50)
        polygon(airfoil_begin);
        
        translate([bar_distance, -bar_size/2, -0.01])    
        cube([bar_size, bar_size, bar_attach], center = false);
            
      translate([rod_distance, 0, -0.01])
        cylinder(rod_attach, rod_size, rod_size, center = false);
  
    }
}

//camber = 4;
//camber_distance = 9;
//chord = 10;
//span = 10;
//skin_thickness = 1.0;
//wing_end(camber, camber_distance, chord, span, skin_thickness, 1, 0.1, chord*0.25, 1, 0.1, chord*0.75, 20);
