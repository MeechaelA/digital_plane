function cat(L1, L2) = [for(L=[L1, L2], a=L) a];
function calc_y(x, t)  = 5.0*t*(0.2969*sqrt(x) - 0.1260*x-0.3516*x^2 + 0.2843*x^3 - 0.1015*x^4);

mesh_size = 1000;
mesh_end = 1;
res = mesh_end/mesh_size;
thickness = 4;
wing_chord = 2.0;
square_bar_dim = 0.1;
rod_diameter = 0.05/2;
camber = 2.0;
camber_chord_distance = 40.0;

camber_param = camber*10.0 + camber_chord_distance/10.0;

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
    resize([wing_chord, 0.0, 0.0])
    polygon(airfoil);
    color("lightBlue")
    rotate([0.0,0.0,0.0])
    translate([0.25*wing_chord, 0.0, 0.0])
    cube([square_bar_dim,square_bar_dim,thickness+thickness*0.01], center = true);
    
    translate([0.6*wing_chord, 0.0, 0.0])
    cylinder(h=thickness+thickness*0.01, r=rod_diameter, center = true, $fn=25);
} 
