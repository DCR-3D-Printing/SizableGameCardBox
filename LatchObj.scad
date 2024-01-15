module Latch(width=10, height=3) {

    ObjPoints = [
        // x, y , z
        [0.5, 0, 0.5], //0
        [width-0.5, 0, 0.5], //1
        [width, 0.5, 0], //2
        [0, 0.5, 0], //3
        [0.5, 0, height-0.5], //4
        [width-0.5, 0, height-0.5], //5
        [width, 0.5, height], //6
        [0, 0.5, height] //7
    ]; 
      
    ObjFaces = [
        [0,1,2,3],  // bottom
        [4,5,1,0],  // front
        [7,6,5,4],  // top
        [5,6,2,1],  // right
        [6,7,3,2],  // back
        [7,4,0,3]   // left
    ]; 

    union() {
        color("deeppink") 
            rotate([180,0,0]) 
                translate([-width/2, -0.5, -(height/2)]) 
                    polyhedron( points=ObjPoints, faces=ObjFaces);
        color("blue")
            translate([-width/2,-0.2,-height/2])
                cube([width, 0.2, height]);
    }
}

//Latch();

module separator(width=30, height=40, thickness=1.5)
{
    difference() {
        union() {
            cube([width, height-(width/2), thickness]);
            translate([width/2, height-(width/2), 0]) cylinder(thickness, width/2/2, width/2/2, $fn=48);
        }
        translate([0, height-(width/2), -1]) cylinder(3,width/2/2, width/2/2, $fn=48);
        translate([width, height-(width/2),-1]) cylinder(3,width/2/2, width/2/2, $fn=48);
    }
    

    
}

