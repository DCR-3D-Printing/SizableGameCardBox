use <LatchObj.scad>

// Input Variables
// -------------------------------

    /* [Global] */

    /* [Card Box] */

        // The total width used by the cards
        inner_width             =   60; // [10:200]

        // The total height used by the cards
        inner_height            =   80; // [50:250]

        section_font_size       =   6;  // [2:10]
        
//        rounded                 =   true;
        
        overlap_percent         =   20; // [20:10:80]
        latch_type              =   0; // [0:Both Side, 1:Width Side Only, 2:Depth Side Only]    

    /* [Cover] */
        
        // If your cards are a bit blunt, using this option will remove the full thikness in the cover part.
        cover_loose_fit                =  false;
    
        cover_label              =   "";
        cover_label_font_family  =   "Trebuchet MS:style=Regular"; // ["Trebuchet MS:style=Regular":Trebuchet, "Sukhumvit Set:style=Text":Sukhumvit, "Silom:style=Regular":Silom]
        cover_label_font_size    =   6; // [6:18]
        cover_label_angle        =   0; // [0:15:90]
    
            //"Trebuchet MS:style=Regular"
        //"Sukhumvit Set:style=Text"
        //"Silom:style=Regular"
    
    /* [Section 1] */
    
        // Section depth
        section_01_inner_depth  =   40;
        // Section label, empty for none
        section_01_label        =   "";

    /* [Section 2] */
    
        // Section depth
        section_02_inner_depth  =   0;
        // Section label, empty for none
        section_02_label        =   "";

    /* [Section 3] */
    
        // Section depth
        section_03_inner_depth  =   0;
        // Section label, empty for none
        section_03_label        =   "";
        
    /* [Section 4] */
    
        // Section depth
        section_04_inner_depth  =   0;
        // Section label, empty for none
        section_04_label        =   "";
        
    /* [Section 5] */
    
        // Section depth
        section_05_inner_depth  =   0;
        // Section label, empty for none
        section_05_label        =   "";
        
    /* [Section 6] */
    
        // Section depth
        section_06_inner_depth  =   0;
        // Section label, empty for none
        section_06_label        =   "";
        
    /* [Section 7] */
    
        // Section depth
        section_07_inner_depth  =   0;
        // Section label, empty for none
        section_07_label        =   "";
        
    /* [Section 8] */
    
        // Section depth
        section_08_inner_depth  =   0;
        // Section label, empty for none
        section_08_label        =   "";
        
    /* [Section 9] */
    
        // Section depth
        section_09_inner_depth  =   0;
        // Section label, empty for none
        section_09_label        =   "";
        
    /* [Section 10] */
    
        // Section depth
        section_10_inner_depth  =   0;
        // Section label, empty for none
        section_10_label        =   "";
    
// -------------------------------
/* [Hidden] */

// Config
    enable_preview_rendering    =   true;

// Constance, should not be modify
// -------------------------------
    damper_gap              =   0.2;
    cover_inner_height      =   10;
    thickness               =   3;
    rounded_radius          =   2;
    latch_height            =   3;
    latch_border_space      =   6;
// -------------------------------

// Calculated variables
// -------------------------------
    inner_depth             =   30;                 // The total debth used by the cards (default 30 for preview, real value 
                                                    // calculated with sum of section_XX_inner_depth.
    overlap_height           =   (overlap_percent/100*inner_height);
    
    section_count           =   get_section_count();
    section_debth_concat    =   get_section_debth_concat();
    section_debth_sum       =   get_section_debth_sum();
// -------------------------------


if (enable_preview_rendering && $preview) {    

    translate([50, -3, 0])
        rotate([10,0,120])
            boxBottom(inner_width, inner_height, thickness, rounded_radius) {
                boxSections(section_debth_sum);
            }
    
    translate([0, 10+inner_width, 0])
        rotate([25,0,80])
            boxCover(inner_width, thickness, rounded_radius, cover_label, cover_label_font_size, cover_label_font_family);
        
} else {
    
    translate([0, -3, 0])
        boxBottom(inner_width, inner_height, thickness, rounded_radius) {
            boxSections(section_debth_sum);
        }
    
    translate([20+inner_width,-3,0])
        boxCover(inner_width, thickness, rounded_radius, cover_label, cover_label_font_size, cover_label_font_family);
        
}


// Sections functions

function get_section_count() = (
    (section_01_inner_depth <= 0) ? 0 : 
    (section_02_inner_depth <= 0) ? 1 :
    (section_03_inner_depth <= 0) ? 2 :
    (section_04_inner_depth <= 0) ? 3 :
    (section_05_inner_depth <= 0) ? 4 :
    (section_06_inner_depth <= 0) ? 5 :
    (section_07_inner_depth <= 0) ? 6 :
    (section_08_inner_depth <= 0) ? 7 :
    (section_09_inner_depth <= 0) ? 8 :
    (section_10_inner_depth <= 0) ? 9 : 10
);

function get_section_debth_sum() = (
[ for (a=0, b=section_debth_concat[0]; a < section_count+1; a= a+1, b=b+(section_debth_concat[a]==undef?0:section_debth_concat[a])) b ]
);

function get_section_debth_concat() = (
    concat(
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
    )
);



// Box bottom modules


module writeSectionLabels() {
    
    if (section_01_inner_depth > 0)
        translate([(inner_width/2)+thickness, (section_01_inner_depth/2)+thickness, 1]) linear_extrude(3) text(section_01_label, size=section_font_size, $fn=24, halign="center", valign="center");

    if (section_02_inner_depth > 0)
        translate([(inner_width/2)+thickness, (section_02_inner_depth/2)+thickness+section_debth_sum[0]+((thickness/2)*1), 1]) linear_extrude(5) text(section_02_label, size=section_font_size, halign="center", valign="center");
    
    if (section_03_inner_depth > 0)
        translate([(inner_width/2)+thickness, (section_03_inner_depth/2)+thickness+section_debth_sum[1]+((thickness/2)*2), 1]) linear_extrude(5) text(section_03_label, size=section_font_size, halign="center", valign="center");
    
    if (section_04_inner_depth > 0)
        translate([(inner_width/2)+thickness, (section_04_inner_depth/2)+thickness+section_debth_sum[2]+((thickness/2)*3), 1]) linear_extrude(5) text(section_04_label, size=section_font_size, halign="center", valign="center");
    
    if (section_05_inner_depth > 0)
        translate([(inner_width/2)+thickness, (section_05_inner_depth/2)+thickness+section_debth_sum[3]+((thickness/2)*4), 1]) linear_extrude(5) text(section_05_label, size=section_font_size, halign="center", valign="center");
    
    if (section_06_inner_depth > 0)
        translate([(inner_width/2)+thickness, (section_06_inner_depth/2)+thickness+section_debth_sum[4]+((thickness/2)*5), 1]) linear_extrude(5) text(section_06_label, size=section_font_size, halign="center", valign="center");
    
    if (section_07_inner_depth > 0)
        translate([(inner_width/2)+thickness, (section_07_inner_depth/2)+thickness+section_debth_sum[5]+((thickness/2)*6), 1]) linear_extrude(5) text(section_07_label, size=section_font_size, halign="center", valign="center");

    if (section_08_inner_depth > 0)
        translate([(inner_width/2)+thickness, (section_08_inner_depth/2)+thickness+section_debth_sum[6]+((thickness/2)*7), 1]) linear_extrude(5) text(section_08_label, size=section_font_size, halign="center", valign="center");

    if (section_09_inner_depth > 0)
        translate([(inner_width/2)+thickness, (section_09_inner_depth/2)+thickness+section_debth_sum[7]+((thickness/2)*8), 1]) linear_extrude(5) text(section_09_label, size=section_font_size, halign="center", valign="center");
    
    if (section_10_inner_depth > 0)
        translate([(inner_width/2)+thickness, (section_10_inner_depth/2)+thickness+section_debth_sum[8]+((thickness/2)*9), 1]) linear_extrude(5) text(section_10_label, size=section_font_size, halign="center", valign="center");
    
//    if (section_01_inner_depth > 0)
//        linear_extrude(5) text(section_01_label, size=6, halign="center", valign="center");
    
}

module boxBottom(innerWidth=60, innerHeight=80, thickness=3, roundCornerRadius=2) {

    innerWidth  =   innerWidth+(thickness*2);
    innerHeight =   innerHeight-overlap_height-cover_inner_height;
    innerDepth  =   (section_debth_sum[section_count]+((section_count-1)*(thickness/2)))+(thickness*2);

    union() {
        
        // Bottom box
        // -------------------
        difference() {    
            translate([roundCornerRadius, roundCornerRadius, 0]) {
                minkowski()
                {
                  cube([innerWidth-(roundCornerRadius*2), innerDepth-(roundCornerRadius*2), (2+innerHeight-1)]); // -1 because cylinder use h=1
                  cylinder($fn=24, r=roundCornerRadius, h=1);
                }
            }
            
            translate([thickness, thickness, 2]) {
                cube([innerWidth-(2*thickness), innerDepth-(2*thickness), innerHeight+10]);
            }

            color("red") writeSectionLabels();
            
        }
     
        // Top overlap
        // -------------------
        difference() {
            translate([roundCornerRadius+(thickness/2), roundCornerRadius+(thickness/2), innerHeight]) {
                minkowski()
                {
                  cube([innerWidth-(roundCornerRadius*2)-(thickness), innerDepth-(roundCornerRadius*2)-(thickness), (2+overlap_height-1)]);
                  cylinder($fn=24, r=roundCornerRadius, h=1);
                }
            }
            translate([thickness, thickness, innerHeight-5]) {
                cube([innerWidth-(2*thickness), innerDepth-(2*thickness), overlap_height+10]);
            }
        }
        
        // Draw latches
        // -------------------
        
        if ((latch_type == 0) || (latch_type == 2)) {
            // Depth Side
            rotate([0, 0, 90])
                translate([(innerDepth/2), -innerWidth+(thickness/2), innerHeight+(latch_height/2)+latch_border_space]) 
                    rotate([180, 0, 0])
                        Latch(innerDepth/2);

            rotate([0, 0, 90]) 
                translate([(innerDepth/2), -(thickness/2), innerHeight+(latch_height/2)+latch_border_space])
                    Latch(innerDepth/2);
        }
        
        if ((latch_type == 0) || (latch_type == 1)) {
            // Width Side
            rotate([0, 0, 0])
                translate([(innerWidth/2), (thickness/2), innerHeight+(latch_height/2)+latch_border_space])
                    rotate([180, 0, 0])
                        Latch(innerWidth/2);

            rotate([0, 0, 0])
                translate([(innerWidth/2), innerDepth-(thickness/2), innerHeight+(latch_height/2)+latch_border_space])
                    rotate([180, 0, 180])
                        Latch(innerWidth/2);
        }
            
        let ($innerWidth=innerWidth-(2*thickness), $innerHeight=innerHeight+overlap_height-thickness, $thickness=thickness) {
            for ( i=[0:1:$children-1], $sectionIndex=i) {
                children(i);
            }
        }
    }
}




module boxSections(innerDepths) {

    // Make sure the boxSection is called inside a box
    if (parent_module(1) == "boxBottom") {

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
    if ((parent_module(1) == "boxBottom") || (parent_module(1) == "boxSections")) {
        
        //          X          Y                                            Z
        color("yellow") translate([$thickness, (innerDepth+$thickness)+($sectionIndex*($thickness/2)), $thickness])
            cube([$innerWidth, $thickness/2, $innerHeight]);
        
    } else {
        echo("ERROR: boxSection must be called within a box object.");
    }
}


//
// Box top modules

module boxCover(innerWidth=60, thickness=3, roundCornerRadius=2, label="7 Familles", label_size=8, label_font="Trebuchet MS:style=Regular") {

    innerWidth=innerWidth+(thickness*2);
    innerDepth=(section_debth_sum[section_count]+((section_count-1)*(thickness/2)))+(thickness*2);
    innerHeight=cover_inner_height;

    // Top Box
    // -------------------
    difference() {
        
        translate([roundCornerRadius, roundCornerRadius, 0]) {
            minkowski()
            {
              cube([innerWidth-(roundCornerRadius*2), innerDepth-(roundCornerRadius*2), (2+innerHeight-1)]); // -1 because cylinder use h=1
              cylinder($fn=24, r=roundCornerRadius, h=1);
            }
        }
        
        if (cover_loose_fit) {
            translate([roundCornerRadius+(thickness/2), roundCornerRadius+(thickness/2), innerHeight-8]) {
                minkowski()
                {
                  cube([innerWidth-(roundCornerRadius*2)-(thickness), innerDepth-(roundCornerRadius*2)-(thickness), (innerHeight+10)]);
                  cylinder($fn=24, r=roundCornerRadius+damper_gap, h=1);
                }
            }
        }
        else {
            translate([thickness, thickness, 2]) {
                cube([innerWidth-(2*thickness), innerDepth-(2*thickness), innerHeight+10]);
            }
        }

        
        // Top box text
        translate([innerWidth/2, (innerDepth/2), -0.2])        
            linear_extrude(thickness/2)
                rotate([0, 180, cover_label_angle]) text(str(label), label_size, valign="center", halign="center", spacing = 1, font=label_font);

    }
    
    
    // Top overlap
    // -------------------
    difference() {
        
        translate([roundCornerRadius, roundCornerRadius, innerHeight]) {
            minkowski()
            {
              cube([innerWidth-(roundCornerRadius*2), innerDepth-(roundCornerRadius*2), (2+overlap_height-1)]);
              cylinder($fn=24, r=roundCornerRadius, h=1);
            }
        }

        translate([roundCornerRadius+(thickness/2), roundCornerRadius+(thickness/2), innerHeight-5]) {
            minkowski()
            {
              cube([innerWidth-(roundCornerRadius*2)-(thickness), innerDepth-(roundCornerRadius*2)-(thickness), (overlap_height+10)]);
              cylinder($fn=24, r=roundCornerRadius+damper_gap, h=1);
            }
        }
        // Draw latches
        // -------------------
        if ((latch_type == 0) || (latch_type == 2)) {
            rotate([0, 0, 90])
                translate([(innerDepth/2), -innerWidth+(thickness/2)-damper_gap, 2+innerHeight+overlap_height-(latch_height/2)-latch_border_space])  //
                    rotate([180, 0, 0])
                            Latch(innerDepth/2);
            rotate([0, 0, 90]) 
                translate([(innerDepth/2), -(thickness/2)+damper_gap, 2+innerHeight+overlap_height-(latch_height/2)-latch_border_space])
                    Latch(innerDepth/2);
        }

        if ((latch_type == 0) || (latch_type == 1)) {
            rotate([0, 0, 0])
                translate([(innerWidth/2), (thickness/2)-damper_gap, 2+innerHeight+overlap_height-(latch_height/2)-latch_border_space])
                    rotate([180, 0, 0])
                        Latch(innerWidth/2);

            rotate([0, 0, 0])
                translate([(innerWidth/2), innerDepth-(thickness/2)+damper_gap, 2+innerHeight+overlap_height-(latch_height/2)-latch_border_space]) //
                    rotate([180, 0, 180])
                        Latch(innerWidth/2);
        }
    }
    
}
// 8

//color("red") translate([0,0,(-0.5)+72]) square([500, 1], center=false);