use std::fs;
use std::path::Path;

pub fn file_link(source_path: &str, target_path: &str) -> Result<(), std::io::Error> {
    let source = Path::new(source_path);
    let target = Path::new(target_path);

    if !source.exists() {
        panic!("Invalid source path");
    }
    if !target.exists() || !target.is_dir() {
        panic!("Invalid target directory");
    }

    let target_file = target.join(source.file_name().unwrap());
    if target_file.exists() {
        if let Ok(linked) = fs::read_link(&target_file) {
            if linked == source {
                println!("{source_path} is already symlinked. No changes");
                return Ok(());
            }
        }
        let backup_file = source.with_extension("bak");
        fs::rename(&target_file, &backup_file)?;
    }
    std::os::unix::fs::symlink(&source_path, &target_file)?;

    Ok(())
}

pub fn dir_link(source_path: &str, target_path: &str) -> Result<(), std::io::Error> {
    let source = Path::new(source_path);
    let target = Path::new(target_path);

    if !source.exists() {
        panic!("Invalid source path");
    }

    if target.exists() {
        if !target.is_dir() {
            panic!("Target is not a valid directroy");
        }

        if let Ok(linked) = fs::read_link(&target_path) {
            if linked == source {
                println!("{source_path} is already symlinked. No changes");
                return Ok(());
            }
        }

        let backup_dir = source.with_extension("bak");
        fs::create_dir(&backup_dir)?;
        for file in fs::read_dir(target_path)? {
            let file = backup_dir.join(file?.file_name());
            fs::rename(&file, &backup_dir)?;
        }

        fs::remove_dir(&target_path)?;
    }
    std::os::unix::fs::symlink(&source_path, &target_path)?;

    Ok(())
}
