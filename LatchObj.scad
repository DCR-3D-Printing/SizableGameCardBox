module Latch(width=10, height=3, reverse=false) {

    ObjPoints = [
      [  0,  height,    0   ],  //0
      [ width,  height,    0   ],  //1
      [ width,  0,    0   ],  //2
      [  0,  0,    0   ],  //3
      [  1,  height-0.5,  0.5 ],  //4
      [  width-1,  height-0.5,  0.5 ],  //5
      [  width-1,  0.5,  0.5 ], //6
      [  1,  0.5,  0.5 ]  //7
    ]; 
      
    ObjFaces = [
      [0,1,2,3],  // back
      [4,5,6,7],  // front
      [0,1,5,4],  // top
      [7,6,2,3],  // bottom
      [0,4,7,3],  // left
      [5,1,2,6]   // right
    ]; 

    if (reverse)
        color("lightblue") difference() rotate([270,0,0]) translate([-width/2, -height/2, 0]) polyhedron( points=ObjPoints, faces=ObjFaces );
    else
        color("blue") rotate([270,0,0]) translate([-width/2, -(height/2), 0]) polyhedron( points=ObjPoints, faces=ObjFaces);
        //rotate([270,0,0]) translate([-(width/2), -(height/2), 0]) polyhedron( points=ObjPoints, faces=ObjFaces);

}
