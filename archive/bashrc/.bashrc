case $- in
    *i*) ;;
      *) return;;
esac

for i in ~/.dotfiles/bashrc/*.sh; do
	. "$i"
done; unset i
export PATH=/usr/local/cuda-11.7/bin:$PATH
export LD_LIBRARY_PATH=/usr/local/cuda-11.7/lib64:$LD_LIBRARY_PATH
