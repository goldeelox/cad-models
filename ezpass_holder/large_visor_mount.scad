$fn=25;
ezWidth = 88.75;
ezLength = 76.15;
ezHeight = 13;
smooth = 1;

module ezpass() {
    // base
    translate([0,0,smooth]) minkowski() {
        linear_extrude(height=ezHeight-smooth*2,scale=.9837) {
            square([ezWidth-smooth*2,ezLength-smooth*2], center=true);
        }
        sphere(1);
    }
    
    // top bump
    bumpWidth = 84;
    bumpLength = 37.7;
    bumpHeight = 5.3;
    minkowski() {
        translate([0,ezLength/2 - bumpLength/2 - 2 - smooth/2,ezHeight+bumpHeight/2-smooth/2-1])
           cube([bumpWidth-smooth,bumpLength-smooth,bumpHeight-smooth+1], center=true);
        cylinder(r=smooth);
    }
}
module clip() {
    cube([11.8,42,0.7],center=true);
}
module tray() {
    minkowski() {
        // size up tray to ezpass dimensions with 2mm padding
        translate([0,8,13-6]) cube([ezWidth+4,50,ezHeight+4], center=true);
        sphere(1);
    }
}

module v1() {
    difference() {
        tray();
        scale([1.01,1,1]) ezpass();
        translate([0,0,-1]) scale([1.02,1,1]) clip();
    }
}
rotate([90,0,0]) v1();
rotate([90,0,0]) ezpass();

