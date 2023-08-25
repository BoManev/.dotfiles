use std::fs;
use std::path::{Path, PathBuf};

pub fn link_with_bak(source_file: &str, target_path: &str) -> Result<(), std::io::Error> {
    let target_path = Path::new(target_path);
    if !target_path.exists() || !target_path.is_dir() {
        panic!("Target directory does not exist!");
    }
    let target_file = target_path.join(Path::new(&source_file).file_name().unwrap());

    if target_file.exists() {
        if let Ok(existing_link) = fs::read_link(&target_file) {
            if existing_link == PathBuf::from(source_file) {
                println!("{source_file} is already symlinked. No changes made.");
                return Ok(());
            }
        }

        let backup_file = Path::new(source_file).with_extension("bak");
        fs::copy(&target_file, &backup_file)?;
        fs::remove_file(&target_file)?;
    }

    if target_file.exists() {
        let backup_file = Path::new(source_file).with_extension("bak");
        fs::copy(&target_file, &backup_file)?;

        fs::remove_file(&target_file)?;
    }

    std::os::unix::fs::symlink(&source_file, &target_file)?;

    Ok(())
}
