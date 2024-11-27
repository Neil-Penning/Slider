use <./Extrude_Letter.scad>;
use <./Hexagon_Frame.scad>;


bottom_height=4;
theta_frame(
        bottom_thickness=bottom_height,
        hexagon_or = 60,
        inner_fillet_radius=15,
        wall_thickness = 6,
        magnet_locations = 40
        );
chars = [
    "U",
    "V",
    "W",
    "X",
    "Y",
    "Z",
    "G" 
];
h = hexagon_points(40);
translate([0,0,bottom_height]) {
    for (i = [0:5]) {
        translate([
                h[i][0], 
                h[i][1], 
                0
        ])
            button(chars[i]);
    }
    //button("0");
}
