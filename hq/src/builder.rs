use std::fs::{self, File};
use std::io;
use std::path::{Path, PathBuf};

pub fn concat_builder(dir_path: &Path, output_file: &Path) -> io::Result<()> {
    let mut output = File::create(output_file).expect("Failed to create output file");

    let mut files: Vec<PathBuf> = Vec::new();
    collect_files(dir_path, &mut files).expect("Failed to collect files");
    files.sort();

    for file_path in files {
        let mut file = File::open(&file_path).expect("Failed to open target file for read");
        io::copy(&mut file, &mut output).expect("Failed to copy contents to output file");
    }

    Ok(())
}

fn collect_files(dir_path: &Path, files: &mut Vec<PathBuf>) -> io::Result<()> {
    for entry in fs::read_dir(dir_path).expect("Failed to iterate directory") {
        let entry = entry?;
        let path = entry.path();

        if path.is_file() {
            files.push(path);
        } else if path.is_dir() {
            collect_files(&path, files)?;
        }
    }

    Ok(())
}
