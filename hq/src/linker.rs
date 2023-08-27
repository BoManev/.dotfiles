use std::fs;
use std::path::Path;

pub fn link_with_bak(source_path: &str, target_path: &str) -> Result<(), std::io::Error> {
    let source = Path::new(source_path);
    let target = Path::new(target_path);

    if !target.exists() || !target.is_dir() {
        panic!("Invalid target directory");
    }

    if target_path.ends_with('/') {
        let target_file = target.join(source.file_name().unwrap());
        if target_file.exists() {
            if let Ok(linked) = fs::read_link(&target_file) {
                if linked == source {
                    println!("{source_path} is already symlinked. No changes");
                    return Ok(());
                }

                let backup_file = source.with_extension("bak");
                fs::copy(&target_file, &backup_file).expect(&format!(
                    "Failed to backup {}",
                    &source.file_name().unwrap().to_string_lossy()
                ));
                fs::remove_file(&target_file).expect(&format!(
                    "Failed to remove {}",
                    &target_file.to_string_lossy()
                ));
            }
        }
        std::os::unix::fs::symlink(&source_path, &target_file)?;
    } else {
        let backup_dir = source.with_extension("bak");
        fs::create_dir(&backup_dir)?;
        for file in fs::read_dir(target_path)? {
            let file = file?;
            let file_name = file.file_name();
            let backup_file = backup_dir.join(file_name);
            fs::rename(&file.path(), &backup_file)?;
        }
        fs::remove_dir(target_path)?;
        println!("remove {target_path}");
        std::os::unix::fs::symlink(&source_path, &target_path)?;
    }

    Ok(())
}
