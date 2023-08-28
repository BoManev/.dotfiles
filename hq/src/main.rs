mod builder;
mod linker;
pub use builder::*;
pub use linker::*;

use std::{io, path::Path};
fn main() -> io::Result<()> {
    let input_dir = "/home/bo/projects/.dotfiles/i3wm/config";
    let output_file = "/home/bo/projects/.dotfiles/i3wm/i3config";

    let input_dir_path = Path::new(input_dir);
    let output_file_path = Path::new(output_file);

    concat_builder(input_dir_path, output_file_path)?;

    let source_file = "/home/bo/projects/.dotfiles/x11/.XCompose";
    let target_path = "/home/bo/";
    file_link(source_file, target_path)?;

    let source_file = "/home/bo/projects/.dotfiles/x11/.xinitrc";
    file_link(source_file, target_path)?;

    let source_file = "/home/bo/projects/.dotfiles/x11/.Xmodmap";
    file_link(source_file, target_path)?;

    let source_file = "/home/bo/projects/.dotfiles/x11/.Xresources";
    file_link(source_file, target_path)?;

    let source_file = "/home/bo/projects/.dotfiles/bashrc/.bashrc";
    file_link(source_file, target_path)?;

    let source_file = "/home/bo/projects/.dotfiles/.gitconfig";
    file_link(source_file, target_path)?;

    let source_file = "/home/bo/projects/.dotfiles/vscode/settings.json";
    let target_path = "/home/bo/.config/Code/User/";
    file_link(source_file, target_path)?;

    let source_file = "/home/bo/projects/.dotfiles/vscode/keybindings.json";
    file_link(source_file, target_path)?;

    let source_file = "/home/bo/projects/.dotfiles/config.fish";
    let target_path = "/home/bo/.config/fish/";
    file_link(source_file, target_path)?;

    //    let source_file = "/home/bo/projects/.dotfiles/nvim";
    //    let target_path = "/home/bo/.config/nvim";
    //     file_link(source_file, target_path)?;

    Ok(())
}
