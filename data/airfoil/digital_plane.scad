include <body_tube.scad>
include <nose_cone.scad>
include <wing.scad>

mesh_size = 200;
thickness = 1;

body_diameter = 5.0;
body_length = 150.0;
body_inner_radius = 4.0;

nose_length = 20.0;
rear_wing_distance = body_length;

camber = 15.0;
camber_distance = 20.0;

wing_skin_thickness = 1.0;
main_wing_ac = 25.0;
main_wing_rib_sep = 5.0;
main_wing_chord = 20.0;
main_wing_num_spars = 10;
main_wing_span = 100;
main_wing_loc = (nose_length + body_length/3+10);


square_bar_dim = 0.75;
square_bar_loc = 0.25;
square_bar_distance = main_wing_chord*0.25;

rod_loc = 0.25;
rod_distance = main_wing_chord*0.75;
rod_diameter = 0.4;

tail_distance = rear_wing_distance;
tail_chord = 20.0;
tail_span = 15.0;
tail_rib_sep = 5.0;
tail_num_spars = 2.0;

vert_tail_wing_rib_sep = 1.0;
vert_tail_num_spars = 4.0;
end_cap_span = 10;

// Nose
translate([nose_length, 0.0 ,0.0])
rotate([0.0, -90.0, 0.0])
nose_cone(nose_length, body_diameter, 1, false, $fn=25);

// Body
translate([nose_length, 0.0, 0.0])
rotate([0.0, 90.0, 0.0])
hollow_tube(body_length, body_diameter, body_inner_radius, false, $fn=50);


// Front Right
translate([main_wing_loc, body_diameter, 0.0])
wing(camber, camber_distance, main_wing_chord, main_wing_span, wing_skin_thickness, 1, 10, 0.1, 0.25*main_wing_chord, 0.1, 0.75*main_wing_chord, 10, mesh_size);
translate([main_wing_loc, main_wing_span+body_diameter, 0.0])
rotate([-90, 0.0, 0.0])
wing_end(camber, camber_distance, tail_chord, end_cap_span, wing_skin_thickness, 1, 0.1, tail_chord*0.25, 1, 0.1, tail_chord*0.75, mesh_size);

// Front Left
translate([main_wing_loc, -body_diameter, 0.0])
rotate([-180, 0.0, 0.0])
wing(camber, camber_distance, main_wing_chord, main_wing_span, wing_skin_thickness, 1, 10, 0.1, 0.25*main_wing_chord, 0.1, 0.75*main_wing_chord, 10, mesh_size);
translate([main_wing_loc, -main_wing_span-body_diameter, 0.0])
rotate([90, 0.0, 0.0])
wing_end(camber, camber_distance, tail_chord, end_cap_span, wing_skin_thickness, 1, 0.1, tail_chord*0.25, 1, 0.1, tail_chord*0.75, mesh_size);

// Back Right
translate([tail_distance, body_diameter, 0.0])
wing(camber, camber_distance, tail_chord, tail_span, wing_skin_thickness, 1, tail_num_spars, 0.1, 0.25*tail_chord, 0.1, 0.75*tail_chord, 10, mesh_size);
translate([tail_distance, tail_span+body_diameter, 0])
rotate([-90, 0.0, 0.0])
wing_end(camber, camber_distance, tail_chord, end_cap_span, wing_skin_thickness, 1, 0.1, tail_chord*0.25, 1, 0.1, tail_chord*0.75, mesh_size);


// Back Left
translate([tail_distance, -body_diameter, 0.0])
rotate([-180, 0.0, 0.0])
wing(camber, camber_distance, tail_chord, tail_span, wing_skin_thickness, 1, tail_num_spars, 0.1, 0.25*tail_chord, 0.1, 0.75*tail_chord, 10, mesh_size);
translate([tail_distance, -tail_span-body_diameter, 0])
rotate([90, 0.0, 0.0])
wing_end(camber, camber_distance, tail_chord, end_cap_span, wing_skin_thickness, 1, 0.1, tail_chord*0.25, 1, 0.1, tail_chord*0.75, mesh_size);


// Vert Tail
translate([tail_distance, 0.0, body_diameter])
rotate([90.0, 0.0, 0.0])
wing(camber, camber_distance, tail_chord, tail_span, wing_skin_thickness, 1, tail_num_spars, 0.1, 0.25*tail_chord, 0.1, 0.75*tail_chord, 10, mesh_size);

translate([tail_distance, 0.0, body_diameter+tail_span])
//rotate([90.0, 0.0, 0.0])
wing_end(camber, camber_distance, tail_chord, end_cap_span, wing_skin_thickness, 1, 0.1, tail_chord*0.25, 1, 0.1, tail_chord*0.75, mesh_size);