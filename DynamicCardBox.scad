use <LatchObj.scad>

/* [Global] */

/* [Card Box] */
inner_width=60; // [10:200]
inner_height=80; // [20:250]

inner_depth=30;

rounded=false;

/* [Hidden] */

section_01_inner_depth=10;
section_02_inner_depth=10;
section_03_inner_depth=0;
section_04_inner_depth=0;
section_05_inner_depth=0;
section_06_inner_depth=0;
section_07_inner_depth=0;
section_08_inner_depth=0;
section_09_inner_depth=0;
section_10_inner_depth=0;

thickness=3;
rounded_radius=2;
section_debth_concat = concat(
    section_01_inner_depth, 
    section_02_inner_depth, 
    section_03_inner_depth, 
    section_04_inner_depth, 
    section_05_inner_depth, 
    section_06_inner_depth, 
    section_07_inner_depth, 
    section_08_inner_depth, 
    section_09_inner_depth, 
    section_10_inner_depth
);

section_count = [ for (f=0, a=0, b=0; a < len(section_debth_concat); f=(section_debth_concat[a]==0?1:0), b=b+(section_debth_concat[a]==0?0:((f==0)?1:0)), a= a+1) b][len(section_debth_concat)-1];

section_debth_sum = [ for (a=0, b=section_debth_concat[0]; a < section_count+1; a= a+1, b=b+(section_debth_concat[a]==undef?0:section_debth_concat[a])) b];


translate([0,-3,0]) box(inner_width, inner_height, thickness, rounded_radius) {
    
    boxSections(section_debth_sum);
    
}


module box(innerWidth=60, innerHeight=80, thickness=3, roundCornerRadius=2) {
    
    echo(section_count);
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