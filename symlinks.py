import os, errno

home = os.path.expanduser('~')
here = os.path.abspath('.')

# Files to copy, comma-separated if the symlink will not be dotted version
# of file.
bases = ['bashrc', 'bash_aliases', 'bash_profile', 'screenrc', 'vim/vimrc', 'vim/gvimrc', 
    'vim/vimrc.vim,', 'vim', 'dir_colors', 'ipython', 'Vagrantfile,', 'zshrc',
    'gitconfig']

def force_symlink(file1, file2):
    try:
        os.symlink(file1, file2)
    except OSError, e:
        if e.errno == errno.EEXIST:
            print 'Overwriting...', 
            os.remove(file2)
            os.symlink(file1, file2)

def sym_names(f_path):
    """Returns tuple of existing filename (fname) and filename of symlink.
    'fname' -> '.fname'; 'fname,' -> 'fname'; 'fname,foo' -> 'foo'
    """
    pf = f_path.split('/') 
    f = pf.pop() 
    pf = '/'.join(pf) 
    base_f = f.split(',')
    orig = '/'.join([pf, base_f[0]]).lstrip('/')
    if f == base_f[0]:
        return (orig, '.' + base_f[0])
    elif not base_f[1]:
        return (orig, base_f[0])
    else: 
        return (orig, base_f[1])

bases = [sym_names(b) for b in bases]
files = [(os.path.join(here, src), os.path.join(home, dst)) for src, dst in bases]

for fs in files:
    orig_p, dest_p = fs
    orig, dest = map(os.path.basename, fs)

    if not os.path.exists(orig_p):
        print "File %s doesn't exist!" % orig_p
    else:
        src, d = orig_p, os.path.join(home, dest)
        force_symlink(src, d)
        print '%s @-> %s' % (d, src)
