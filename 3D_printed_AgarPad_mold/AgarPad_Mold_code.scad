/* this is the design for an agar pad mold used in Lopez-Pagan et al., 2024
    Draft design by Julien Luneau on 20 March 2023
    
    All units are in millimeter
    For all objects in the following code: H=heigth, L=length, W=width
*/

// general parameters
MM=1; // set unit to 1 millimeter
$fn=120; // set the numbers of edges used for the circular shape of the mold
SR=0.5*MM; // smoothing Radius

// main slide dimensions (Length, Width, Thickness)
sD=(50/2)*MM; // Radius of the coverlip
siD=(32/2)*MM; // Radius of the microscope centerpiece holding the mold to the platform
soT=1.5*MM; // Height of the overhangs (main object)
smT=4*MM; // Height of the main mold, top and center component of the object

// dimension of holes for pads
hL=12*MM;
hW=12*MM;
// indent around holes for pads
iH=0.75*MM; //thickness of the trench floor around holes
iW=5*MM;
// space between holes
shW=2*MM;
shL=2*MM;
shL2=1*MM; // to make sure the 50mm slide fits confortably

//Trenches between holes on the bottom side to prevent communication
tL=2*siD; // trench Length
tW=0.2*MM; // trench Width
tT=0.3*MM; // trench Height
tO=0.5*MM; // trench offset from center

//Trenches around the pad for oxygen on the topside
t_out = 4*MM;

// main frame
module Base() {
// main slide
    difference() {
    minkowski(){
translate([0,0,0]) cylinder(r=sD-SR, h=soT-0.1);
        cylinder(r=SR,h=0.1);
        }
        //trenches underneath to prevent cross-contamination between pads
        translate([0,tO,0]) cube([tL,tW,tT], center = true);
        translate([tO,0,0]) cube([tW,tL,tT], center = true);
        translate([0,-tO,0]) cube([tL,tW,tT], center = true);
        translate([-tO,0,0]) cube([tW,tL,tT], center = true);
    }
}


// Making holes
module Hole() {
    // bottom smaller hole
    minkowski(){
        translate ([iW/2-SR,iW/2-SR,0]) cube([hL-2*SR-iW,hW-2*SR-iW,iH*2-0.1]);
        cylinder(r=SR,h=0.1);
        }
    // pad walls openings
    minkowski(){ // x absciss
        translate ([shW/2+(hL-iW/4)/4,-shW/4,iH]) cube([iW/2,hL-2*SR,smT-0.1]);
        cylinder(r=SR,h=0.1);
        }
    minkowski(){ // y absciss
        translate ([-shW/4,shW/2+(hL-iW/4)/4,iH]) cube([hW-2*SR,iW/2,smT-0.1]);
        cylinder(r=SR,h=0.1);
        } 
    // outer trench for oxygen
    difference(){
        translate ([-shW/4-SR/2,-shW/4-SR/2,iH])
        minkowski(){
            cube([hL-SR,hW-SR,smT-0.1]);
            cylinder(r=SR,h=0.1);
            }
        translate ([shW/2,shW/2,iH])
        minkowski(){
            cube([hL-t_out,hW-t_out,smT-0.1]);
            cylinder(r=SR,h=0.1);
            }
        }
    }

// grouping holes    
module AllHoles(){
    for(Xs = [-shL2/2-hL : shL+hL : shL/2+shL2+hL])
        for (Ys = [-shL2/2-hW : shW+hW : shW/2+shL2+hW])
     translate ([Xs,Ys,0]) Hole(){}  
}


difference() {
    Base();
    AllHoles();
}
