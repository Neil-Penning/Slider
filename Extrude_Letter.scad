// Define parameters
square_size = [20, 20];
square_height = 9;
text_size = 20; // Font size for the character 'A'
text_height = 2;

// Parameter to pass the character
char_to_cutout = "A"; // Default character

union() {
    // Create the main cube
    cube([square_size[0], square_size[1], square_height], center = true);
    
    // Subtract the character in the center
    translate([0, 0, square_height/2])
    linear_extrude(height = text_height) // Extrude slightly to ensure complete cutout
    text(char_to_cutout, size = text_size, valign = "center", halign = "center", font = "ComicShannsMono Nerd Font:style=Regular");
}
