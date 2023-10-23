function cat(L1, L2) = [for(L=[L1, L2], a=L) a];

function calc_y(x, t)  = 5.0*t*(0.2969*sqrt(x) - 0.1260*x-0.3516*x^2 + 0.2843*x^3 - 0.1015*x^4);


n = 1000;
end = 1;
res = end/n;


thickness = 4;
wing_chord = 2.0;
square_bar_

x = [0:res:end];
t = 24.0/100;
airfoil = [
    for (a = [0:res:end]) [a, calc_y(a, t)],
    for (a = [0:res:end]) [a, -1.0*calc_y(a, t)],
    [end, -1.0 * calc_y(end,t)],
    [end, calc_y(end,t)]
];



difference(){
    linear_extrude(height = thickness, center = true, scale = 1.0)
    resize([wing_chord, 0.0, 0.0])
    polygon(airfoil);
    color("lightBlue")
    rotate([0.0,0.0,0.0])
    translate([0.25*wing_chord, 0.0, 0.0])
    cube([0.1,0.1,thickness], center = true);
    
    translate([0.6*wing_chord, 0.0, 0.0])
    cylinder(h=thickness, r=0.025, center = true, $fn=25);
} 