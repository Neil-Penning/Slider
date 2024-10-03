$fn = 32;
// Parameters
slider_size = 20;        // mm
sliders_x = 3;           // count
sliders_y = 2;           // count
tolerance = 1;           // mm (for the total space)
base_height = 3;         // mm
wall_height = 5;         // mm
wall_thickness = 5;      // mm
magnet_height = 1/16 * 25.4; // inch to mm conversion
magnet_radius = 3/16 * 25.4 * 1/2 * 1.01; // inch to mm conversion
magnet_offset = 0.5;     // mm
fillet_radius = 2;       // Fillet radius for outer corners

back_magnet_xy_offset = 8;

// Helper function to calculate total width and height
grid_width = sliders_x * slider_size + tolerance;
grid_height = sliders_y * slider_size + tolerance;
magnet_spacing_x = slider_size + tolerance/sliders_x; // Adjust magnet spacing with tolerance
magnet_spacing_y = slider_size + tolerance/sliders_y;

// Magnet Grid Module
module magnet_grid() {
    for (x = [0:sliders_x-1]) {
        for (y = [0:sliders_y-1]) {
            // Position magnets in grid with adjusted spacing and center the whole grid
            translate([x * magnet_spacing_x - (grid_width / 2) + magnet_spacing_x / 2, 
                       y * magnet_spacing_y - (grid_height / 2) + magnet_spacing_y / 2,
                       base_height - magnet_offset - magnet_height])
                cylinder(h=magnet_height, r=magnet_radius);
        }
    }
}

// Main difference block
difference() {
    // Outer structure with walls and filleted corners
    linear_extrude(base_height + wall_height)
        offset(r=fillet_radius)  // Apply fillet to outer corners
            square([grid_width + 2 * wall_thickness - 2*fillet_radius, grid_height + 2 * wall_thickness - 2*fillet_radius], center = true);
    
    // Inner cut-out for the top part (no fillet here)
    translate([0, 0, base_height])
        linear_extrude(1.1 * wall_height)
            square([grid_width, grid_height], center = true);
    
    // Magnet grid recessed in the base
    magnet_grid();

    translate([0,0,magnet_offset]) {
        translate([ -(1/2) * (grid_width), -(1/2) * (grid_height), 0
            ]) cylinder(h=magnet_height, r=magnet_radius);

        translate([ -(1/2) * (grid_width),  (1/2) * (grid_height), 0
            ]) cylinder(h=magnet_height, r=magnet_radius);

        translate([  (1/2) * (grid_width), -(1/2) * (grid_height), 0
            ]) cylinder(h=magnet_height, r=magnet_radius);

        translate([  (1/2) * (grid_width),  (1/2) * (grid_height), 0
            ]) cylinder(h=magnet_height, r=magnet_radius);
    }
}
