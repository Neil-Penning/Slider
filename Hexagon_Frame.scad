$fn = 128;
magnet_offset = 0.4;
magnet_radius = (1/4) * (25.4) * 1.02 / 2;
magnet_height = (1/10) * (25.4) * 1.01;

function hexagon_points(outer_radius=100)
    = [
        [outer_radius * cos(000), outer_radius * sin(000)],
        [outer_radius * cos(060), outer_radius * sin(060)],
        [outer_radius * cos(120), outer_radius * sin(120)],
        [outer_radius * cos(180), outer_radius * sin(180)],
        [outer_radius * cos(240), outer_radius * sin(240)],
        [outer_radius * cos(300), outer_radius * sin(300)]
    ];
module hexagon(outer_radius=100, fillet_radius=10) {
        minkowski() {
            polygon(
                hexagon_points(outer_radius - fillet_radius)
            );
            circle(fillet_radius);
        }
}

module theta_frame(
        entire_height=8,
        bottom_thickness=3,
        hexagon_or = 70,
        outer_fillet_radius=20,
        inner_fillet_radius=20,
        wall_thickness=10,
        magnet_locations=35
        ) {
    union() {
    stopper_fillet_radius=2;
    stopper_length = 22;
    translate([0, 0, bottom_thickness]) {
        translate([0,magnet_locations/2 -2,0])
        linear_extrude(entire_height-bottom_thickness) {
            minkowski() {
                square([stopper_length-2*stopper_fillet_radius, wall_thickness-2*stopper_fillet_radius], center=true);
                circle(stopper_fillet_radius);
            }
        }
        translate([0,-(magnet_locations/2 -2),0])
        linear_extrude(entire_height-bottom_thickness) {
            minkowski() {
                square([stopper_length-2*stopper_fillet_radius, wall_thickness-2*stopper_fillet_radius], center=true);
                circle(stopper_fillet_radius);
            }
        }
    }
    difference() {
        linear_extrude(entire_height)
            hexagon(hexagon_or, outer_fillet_radius);
        translate([0,0,bottom_thickness])
            linear_extrude(entire_height)
            hexagon(hexagon_or-wall_thickness, inner_fillet_radius);
        translate([0,0,bottom_thickness-magnet_offset-magnet_height]) {
            linear_extrude(magnet_height) {
                circle(magnet_radius);
                magnet_hexagon = hexagon_points(magnet_locations);
                for (i = [0:5]) {
                    translate(
                        [
                            magnet_hexagon[i][0],
                            magnet_hexagon[i][1],
                            0
                        ]
                    )
                    circle(magnet_radius);
                }
            }
        }
    }
    }
}
