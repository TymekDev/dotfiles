# Note: this script does not have any error handling whatsoever. You are
#       supposed to provide correct arguments, that is source file path
#       and destination directory.

# Expanding the paths, it helps when "~" or "." was given
file_name=$(basename "$1")
src_file_path="$(cd `dirname $1`; pwd)/$file_name"
dest_file_path="$(cd $2; pwd)/$file_name"

# For storing which files were created by this script
log_file=${3:-install_config.log}

echo -n "$file_name install: "

# If file exists then skip it
if [ -f "$dest_file_path" ]; then
    echo "skipped (file already exists $dest_file_path)"
else 
    # Catch the (error) output of the command 
    error=$(ln -s $src_file_path $dest_file_path 2>&1)

    # Check the exit status of the last command (ln)
    if [ $? -eq 0 ]; then
        echo "symlink created ($src_file_path -> $dest_file_path)"
        echo "[$(date '+%Y-%m-%d %H:%M:%S')] $dest_file_path" >> $log_file
    else
        echo "failed to create symlink: $error"
    fi
fi
