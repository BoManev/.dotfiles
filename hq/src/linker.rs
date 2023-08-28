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
        fs::copy(&target_file, &backup_file)?;
        fs::remove_file(&target_file)?;
    }
    std::os::unix::fs::symlink(&source_path, &target_file)?;

    Ok(())
}
