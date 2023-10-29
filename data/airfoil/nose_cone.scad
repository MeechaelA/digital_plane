module nose_cone(length, radius, thickness, center){
    difference(){
        cylinder(length, radius, 0.0, center);
        translate([0, 0, -thickness])
        cylinder(length+length*0.01, radius, 0.0, center);
    }   
}

//nose_cone(10, 10, 1, true);