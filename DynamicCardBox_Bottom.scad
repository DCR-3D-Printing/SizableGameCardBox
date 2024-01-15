use <LatchObj.scad>

module box(innerWidth=60, innerHeight=80, thickness=3, roundCornerRadius=2) {
    
    innerDepthh=section_debth_sum[section_count]+((section_count-1)*(thickness/2));

    innerWidth=innerWidth+(thickness*2);
    innerDepth=innerDepthh+(thickness*2);

    flenge_height=15.5;
    innerHeight=innerHeight-flenge_height;

    union() {
        
        // Bottom box
        difference() {    
            translate([roundCornerRadius, roundCornerRadius, 0]) {
                minkowski()
                {
                  cube([innerWidth-(roundCornerRadius*2), innerDepth-(roundCornerRadius*2), (innerHeight-1)]);
                  cylinder($fn=24, r=roundCornerRadius, h=1);
                }
            }
            translate([thickness, thickness, 2]) {
                cube([innerWidth-(2*thickness), innerDepth-(2*thickness), innerHeight+10]);
            }
        }
     
        // Top flenge
        difference() {
            translate([roundCornerRadius+(thickness/2), roundCornerRadius+(thickness/2), innerHeight]) {
                color("red") minkowski()
                {
                  cube([innerWidth-(roundCornerRadius*2)-(thickness), innerDepth-(roundCornerRadius*2)-(thickness), (flenge_height-1)]);
                  cylinder($fn=24, r=roundCornerRadius, h=1);
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
     
        let ($innerWidth=innerWidth-(2*thickness), $innerHeight=innerHeight+flenge_height-thickness, $thickness=thickness) {
            for ( i=[0:1:$children-1], $sectionIndex=i) {
                children(i);
            }
        }
  
    }

}




module boxSections(innerDepths) {

    // Make sure the boxSection is called inside a box
    if (parent_module(1) == "box") {

        if (section_count > 1) {
            for (i= [0:1:section_count-2]) {
                if (section_debth_concat[i+1] > ($thickness/2)) {
                    boxSection(section_debth_sum[i] + (($thickness/2)*i));
                }
            }
        }
        
    } else {
        echo("ERROR: boxSection must be called within a box object.");
    }
}


module boxSection(innerDepth=30) {

    // Make sure the boxSection is called inside a box
    if ((parent_module(1) == "box") || (parent_module(1) == "boxSections")) {
        
        //          X          Y                                            Z
        translate([$thickness, (innerDepth+$thickness)+($sectionIndex*($thickness/2)), $thickness])
            cube([$innerWidth, $thickness/2, $innerHeight]);
        
    } else {
        echo("ERROR: boxSection must be called within a box object.");
    }
}
