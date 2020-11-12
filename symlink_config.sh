# Note: this script does not have any error handling whatsoever. You are
#       supposed to provide correct arguments, that is source file path
#       and destination directory.

# Expanding the paths, it helps when "~" or "." was given
file_name=$(basename "$1")
src_file_path="$(cd `dirname $1`; pwd)/$file_name"
dest_file_path="$(mkdir -p $2; cd $2; pwd)/$file_name"

# For storing which files were created by this script
log_file=${3:-symlink_config.log}

echo -n "\e[33m$file_name linking:\e[0m "

# If file exists then skip it
if [ -e "$dest_file_path" ]; then
    echo "\e[94mskipped\e[0m (file already exists $dest_file_path)"
else
    # Catch the (error) output of the command
    error=$(ln -s $src_file_path $dest_file_path 2>&1)

    # Check the exit status of the last command (ln)
    if [ $? -eq 0 ]; then
        echo "\e[92msymlink created\e[0m ($dest_file_path -> $src_file_path)"
        echo "[$(date '+%Y-%m-%d %H:%M:%S')] $dest_file_path" >> $log_file
    else
        echo "\e[91mfailed to create symlink:\e[0m $error"
    fi
fi
