module hollow_tube(height, radius_outer, radius_inner, center){
    difference(){
        //major
        cylinder(height, radius_outer, radius_outer, center=center);
        //minor
        cylinder(height+height*0.01, radius_inner, radius_inner, center=center);
    }
}

//hollow_tube(10, 10, 9);