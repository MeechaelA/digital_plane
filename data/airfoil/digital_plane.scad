include <airfoil.scad>
include <body_tube.scad>
include <nose_cone.scad>

mesh_size = 1000;
thickness = 1;

body_diameter = 2.0;
body_length = 80.0;
body_inner_radius = 1.5;

rear_wing_distance = body_length-10;
nose_length = 10.0;

camber = 12.0;
camber_distance = 20.0;

main_wing_ac = 25.0;
main_wing_rib_sep = 5.0;
main_wing_chord = 20.0;
main_wing_num_spars = 10;

square_bar_dim = 0.75;
square_bar_loc = 0.25;
square_bar_distance = main_wing_chord*0.25;

rod_loc = 0.25;
rod_distance = main_wing_chord*0.75;
rod_diameter = 0.4;

tail_distance = rear_wing_distance;
tail_wing_chord = 10.0;
tail_wing_rib_sep = 2.0;
tail_wing_num_spars = 5.0;

vert_tail_wing_rib_sep = 1.0;
vert_tail_num_spars = 2.0;

// Nose
translate([nose_length, 0.0 ,0.0])
rotate([0.0, -90.0, 0.0])
nose_cone(nose_length, body_diameter, 1, false, $fn=25);


difference(){
    // Body
    translate([nose_length, 0.0, 0.0])
    rotate([0.0, 90.0, 0.0])
    hollow_tube(body_length, body_diameter, body_inner_radius, false, $fn=50);
    //cylinder(body_length, body_diameter, body_diameter, center=false, $fn=25);


    // Support
    // Main Wing
    rotate([90.0, 0.0, 0.0])
    translate([nose_length+main_wing_ac+square_bar_distance, 0.0, 0.0])
    cube([square_bar_dim,square_bar_dim, 2*main_wing_num_spars*main_wing_rib_sep+2*main_wing_num_spars+thickness], center = true);
    //
    rotate([90.0, 0.0, 0.0])
    translate([nose_length+main_wing_ac+rod_distance, 0.0, 0.0])
    cylinder(2*main_wing_num_spars*main_wing_rib_sep+2*main_wing_num_spars+thickness,rod_diameter/2.0, rod_diameter/2.0, center = true, $fn=25);


    // Support
    // Rear Wing
    rotate([90.0, 0.0, 0.0])
    translate([tail_distance+square_bar_distance, 0.0, 0.0])
    cube([square_bar_dim,square_bar_dim, 2*tail_wing_num_spars*tail_wing_rib_sep+2*tail_wing_num_spars+thickness], center = true);
    //
    rotate([90.0, 0.0, 0.0])
    translate([tail_distance+rod_distance, 0.0, 0.0])
    cylinder(2*tail_wing_num_spars*tail_wing_rib_sep+2*tail_wing_num_spars+thickness,rod_diameter/2.0, rod_diameter/2.0, center = true, $fn=25);
}


// Front Right Wing
for (i=[1:1:main_wing_num_spars])
    translate([nose_length + main_wing_ac, i + i*main_wing_rib_sep , 0.0])
    rotate([90.0,0.0,0.0])
    airfoil(mesh_size, thickness, camber, camber_distance, main_wing_chord, square_bar_dim, square_bar_distance, rod_diameter, rod_distance);

// Front Left Wing
for (i=[1:1:main_wing_num_spars])
    translate([nose_length + main_wing_ac, -(i + i*main_wing_rib_sep ), 0.0])
    rotate([90.0,0.0,0.0])
    airfoil(mesh_size, thickness, camber, camber_distance, main_wing_chord, square_bar_dim, square_bar_distance, rod_diameter, rod_distance);

// Support
// Main Wing
rotate([90.0, 0.0, 0.0])
translate([nose_length+main_wing_ac+square_bar_distance, 0.0, 0.0])
cube([square_bar_dim,square_bar_dim, 2*main_wing_num_spars*main_wing_rib_sep+2*main_wing_num_spars+thickness], center = true);
//
rotate([90.0, 0.0, 0.0])
translate([nose_length+main_wing_ac+rod_distance, 0.0, 0.0])
cylinder(2*main_wing_num_spars*main_wing_rib_sep+2*main_wing_num_spars+thickness,rod_diameter/2.0, rod_diameter/2.0, center = true, $fn=25);

// Rear Right Wing
for (i=[1:1:tail_wing_num_spars])
    translate([rear_wing_distance, i + i*tail_wing_rib_sep , 0.0])
    rotate([90.0,0.0,0.0])
    airfoil(mesh_size, thickness, camber, camber_distance, main_wing_chord, square_bar_dim, square_bar_distance, rod_diameter, rod_distance);

// Rear Left Wing
for (i=[1:1:tail_wing_num_spars])
    translate([rear_wing_distance, -(i + i*tail_wing_rib_sep ), 0.0])
    rotate([90.0,0.0,0.0])
    airfoil(mesh_size, thickness, camber, camber_distance, main_wing_chord, square_bar_dim, square_bar_distance, rod_diameter, rod_distance);

// Support
// Rear Wing
rotate([90.0, 0.0, 0.0])
translate([tail_distance+square_bar_distance, 0.0, 0.0])
cube([square_bar_dim,square_bar_dim, 2*tail_wing_num_spars*tail_wing_rib_sep+2*tail_wing_num_spars+thickness], center = true);
//
rotate([90.0, 0.0, 0.0])
translate([tail_distance+rod_distance, 0.0, 0.0])
cylinder(2*tail_wing_num_spars*tail_wing_rib_sep+2*tail_wing_num_spars+thickness,rod_diameter/2.0, rod_diameter/2.0, center = true, $fn=25);


// Tail
for (i=[1:1:vert_tail_num_spars])
    rotate([90.0,0.0,0.0])
    translate([tail_distance, -(i + i*vert_tail_wing_rib_sep), 0.0])
    rotate([90.0,0.0,0.0])
    translate([0.0,0.0,-4*body_diameter])
    airfoil(mesh_size, thickness, camber, camber_distance, main_wing_chord, square_bar_dim, square_bar_distance, rod_diameter, rod_distance);

// Support
// Tail Wing
rotate([90.0,0.0,0.0])
translate([tail_distance+square_bar_distance, vert_tail_num_spars+vert_tail_num_spars*thickness, 0.0])
rotate([90.0,0.0,0.0])
cube([square_bar_dim,square_bar_dim, vert_tail_num_spars*vert_tail_wing_rib_sep+vert_tail_num_spars+thickness], center = true);
//
rotate([90.0,0.0,0.0])
translate([tail_distance+rod_distance, vert_tail_num_spars+vert_tail_num_spars*thickness, 0.0])
rotate([90.0,0.0,0.0])
cylinder(vert_tail_num_spars*vert_tail_wing_rib_sep+vert_tail_num_spars+thickness,rod_diameter/2.0, rod_diameter/2.0, center = true, $fn=25);


