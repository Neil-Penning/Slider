$fn = 128;
// Define parameters
square_size = [20, 20];
square_height = 10;
text_size = 20; // Font size for the character 'A'
text_height = 5;
fillet_radius = 2; // Fillet radius for side edges

// Parameter to pass the character
char_to_cutout = "A"; // Default character

module rounded_square_2d(size, radius) {
    // Create a 2D square with rounded corners (only the 4 sides will be affected)
    minkowski() {
        square([size[0] - radius * 2, size[1] - radius * 2], center = true); // Shrink the square
        circle(r=radius); // Add 2mm fillet to the corners
    }
}

union() {
    $fn = 64;
    // Create the main rounded square, but only round the side edges
    linear_extrude(height = square_height, center=true)
    rounded_square_2d(square_size, fillet_radius);

    $fn = 32;
    // Subtract the character in the center
    translate([0, 0, square_height/2])
    linear_extrude(height = text_height) // Extrude slightly to ensure complete cutout
    text(char_to_cutout, size = text_size, valign = "center", halign = "center", font = "ComicShannsMono Nerd Font:style=Regular");
}
