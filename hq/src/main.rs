mod builder;
mod linker;
pub use builder::*;
pub use linker::*;

use std::{io, path::Path};
fn main() -> io::Result<()> {
    let input_dir = "/home/bo/projects/.dotfiles/i3wm"; // Specify your directory here
    let output_file = "/home/bo/projects/.dotfiles/i3config";

    let input_dir_path = Path::new(input_dir);
    let output_file_path = Path::new(output_file);

    concat_builder(input_dir_path, output_file_path)?;

    let source_file = "/home/bo/projects/.dotfiles/.XCompose";
    let target_path = "/home/bo";

    link_with_bak(source_file, target_path)?;

    Ok(())
}
