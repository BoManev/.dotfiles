use std::fs::{self, File};
use std::io;
use std::path::{Path, PathBuf};

fn concat_files_in_directory(dir_path: &Path, output_file: &Path) -> io::Result<()> {
    let mut output = File::create(output_file)?;

    // Collect all files in the directory and its subdirectories
    let mut files: Vec<PathBuf> = Vec::new();
    collect_files_in_directory(dir_path, &mut files)?;

    // Sort the file paths in ascending order
    files.sort();

    // Concatenate the contents of the files into the output file
    for file_path in files {
        let mut file = File::open(&file_path)?;
        io::copy(&mut file, &mut output)?;
    }

    Ok(())
}

fn collect_files_in_directory(dir_path: &Path, files: &mut Vec<PathBuf>) -> io::Result<()> {
    for entry in fs::read_dir(dir_path)? {
        let entry = entry?;
        let path = entry.path();

        if path.is_file() {
            files.push(path);
        } else if path.is_dir() {
            // Recursively collect files in subdirectories
            collect_files_in_directory(&path, files)?;
        }
    }

    Ok(())
}

fn main() -> io::Result<()> {
    let input_dir = "/home/bo/projects/.dotfiles/i3wm"; // Specify your directory here
    let output_file = "/home/bo/projects/.dotfiles/i3config";

    let input_dir_path = Path::new(input_dir);
    let output_file_path = Path::new(output_file);

    concat_files_in_directory(input_dir_path, output_file_path)?;

    Ok(())
}
