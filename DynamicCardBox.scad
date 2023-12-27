use <LatchObj.scad>

$_width=40;
$_height=60;

_thickness=3;

$_rounded=false;
$_rounded_radius=2;

bottomBox(60, 30, 88, _thickness, _thickness);

/*

box(innerWidth, innerHeight, thickness, roundCornerRadius) {
    boxSection(innerDepth);
    boxSection(innerDepth);
}

*/


module bottomBox(innerWidth=60, innerDepth=30, innerHeight=80, roundradius=2, thickness=3) {


    innerWidth=innerWidth+(thickness*2);
    innerDepth=innerDepth+(thickness*2);

    flenge_height=15.5;
    innerHeight=innerHeight-flenge_height;

    union() {
        
        // Bottom box
        difference() {    
            translate([roundradius, roundradius, 0]) {
                minkowski()
                {
                  cube([innerWidth-(roundradius*2), innerDepth-(roundradius*2), (innerHeight-1)]);
                  cylinder($fn=24, r=roundradius, h=1);
                }
            }
            translate([thickness, thickness, 2]) {
                cube([innerWidth-(2*thickness), innerDepth-(2*thickness), innerHeight+10]);
            }
        }
     
        // Top flenge
        difference() {
            translate([roundradius+(thickness/2), roundradius+(thickness/2), innerHeight]) {
                color("red") minkowski()
                {
                  cube([innerWidth-(roundradius*2)-(thickness), innerDepth-(roundradius*2)-(thickness), (flenge_height-1)]);
                  cylinder($fn=24, r=roundradius, h=1);
                }
                color("blue") {
                  //translate([(innerWidth-(roundradius*2))/2, innerDepth-(roundradius*2), (flenge_height/2)]) Latch();
                  //translate([(innerWidth-(roundradius*2))/2, -thickness, (flenge_height/2)]) rotate([180, 0, 0]) Latch();
                  //translate([(innerWidth-(roundradius*2)), 0, (flenge_height/2)])                     
                }
            }
            translate([thickness, thickness, innerHeight-5]) {
                cube([innerWidth-(2*thickness), innerDepth-(2*thickness), flenge_height+10]);
            }
        }
        

        rotate([0, 0, 90])
            translate([(innerDepth/2), -innerWidth+(thickness/2), innerHeight+(flenge_height/2)]) 
                rotate([180, 0, 0])
                    Latch(innerDepth/2);

        rotate([0, 0, 90]) 
            translate([(innerDepth/2), -(thickness/2), innerHeight+(flenge_height/2)])
                Latch(innerDepth/2);
        
        rotate([0, 0, 0])
            translate([(innerWidth/2), (thickness/2), innerHeight+(flenge_height/2)])
                rotate([180, 0, 0])
                    Latch(innerWidth/2);

        rotate([0, 0, 0])
            translate([(innerWidth/2), innerDepth-(thickness/2), innerHeight+(flenge_height/2)])
                rotate([180, 0, 180])
                    Latch(innerWidth/2);
        
    }
}


