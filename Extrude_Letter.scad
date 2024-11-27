$fn = 32;
// Define parameters
circle_radius = 15;
circle_height = 10;
text_size = 20; // Font size for the character 'A'
text_height = 2;
fillet_radius = 2; // Fillet radius for side edges

magnet_offset = 0.4;
magnet_radius = (1/4) * (25.4) * 1.01 / 2;
magnet_height = (1/10) * (25.4) * 1.01;

// Parameter to pass the character
module button(char_to_cutout = "A") {
    translate([0,0, circle_height/2])
    difference() {
        union() {
            // Create the main rounded circle, but only round the side edges
            color("purple")
                minkowski() {
                    linear_extrude(height = circle_height-2*fillet_radius, center=true)
                        circle(circle_radius-2*fillet_radius);
                    sphere(fillet_radius);
                }

            // Subtract the character in the center
            color("red")
                translate([0, 0, circle_height/2])
                linear_extrude(height = text_height) // Extrude slightly to ensure complete cutout
                text(
                        char_to_cutout,
                        size = text_size,
                        valign = "center",
                        halign = "center",
                        font = "ComicShannsMono Nerd Font:style=Regular"
                    );
        }
        translate([0,0,-circle_height/2 + magnet_offset])
            linear_extrude(magnet_height)
            circle(magnet_radius);
    }
}
char_to_cutout="A";
button(char_to_cutout);
