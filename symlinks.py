import os, errno, sys

home = os.path.expanduser('~')
here = os.path.abspath('.')

# myos = 'mac' if ('darwin' in sys.platform) else 'linux'

# Sublime Text is an oddball
st_dir = 'Library/Application Support/Sublime Text 2/Packages/User' if ('darwin'
        in sys.platform) else '.config/sublime-text-2'

# Files to copy, comma-separated if the symlink will not be dotted version
# of file.

# /Users/beard/Library/Application Support/Sublime Text 2/Packages/User/Preferences.sublime-settings
bases = ['bashrc', 'bash_aliases', 'bash_profile', 'screenrc', 'vim/vimrc', 'vim/gvimrc', 
    'vim/vimrc.vim,vimrc.vim', 'vim', 'dir_colors', 'ipython', 'Vagrantfile,', 'zshrc',
    'gitconfig', 'pentadactylrc', 'sublime-text-config,' + st_dir]
# 
# def symlink(file1, file2, force=False):
#     try:
#         os.symlink(file1, file2)
#     except OSError, e:
#         if e.errno == errno.EEXIST:
#             if force:
#                 print 'Overwriting...', 
#                 os.remove(file2)
#                 os.symlink(file1, file2)
#             else:
#                 print "Not overwriting", 

def symlink(target, pointer, force=False):
    try:
        os.symlink(target, pointer)
    except OSError, e:
        if e.errno == errno.EEXIST:
            if force:
                print 'Overwriting...', 
                os.remove(pointer)
                os.symlink(target, pointer)
            else:
                print "Not overwriting", 

def sym_names(f_path):
    """Returns tuple of existing filename (fname) and filename of symlink.
    'fname' -> '.fname'; 'fname,' -> 'fname'; 'fname,foo' -> 'foo'
    """
    pair = f_path.split(',')
    dst = pair.pop(0)
    if not pair:
        #prefix the file base name with '.'
        src = '.' + dst.split('/')[-1]
    else:
        src = pair[0] or dst
    return dst, src

def test_sym_names():
    print sym_names('bashrc')
    assert sym_names('bashrc') == ('bashrc', '.bashrc')
    print sym_names('vim/vimrc')
    assert sym_names('vim/vimrc') == ('vim/vimrc', '.vimrc')
    print sym_names('Vagrantfile,')
    assert sym_names('Vagrantfile,') == ('Vagrantfile', 'Vagrantfile')
    print sym_names('Vagrantfile,.vim/Vagrantfile')
    assert sym_names('Vagrantfile,.vim/Vagrantfile') == ('Vagrantfile', '.vim/Vagrantfile')

if __name__=="__main__":
    """Will create symlinks for files listed in `bases` list, based on sym_names algorithm.
    If keyword 'dry' is given, script will (kinda) simulate script without creating symlinks.
    If keyword 'force' is given, script will overwrite existing symlinks.
    """
    dry = len(sys.argv) > 1 and ('dry' in sys.argv[1:])
    force = len(sys.argv) > 1 and ('force' in sys.argv[1:])
    bases = [sym_names(b) for b in bases]
    files = [(os.path.join(here, src), os.path.join(home, dst)) for src, dst in bases]

    for fs in files:
        src, link = fs
        if not os.path.exists(src):
            print "File %s doesn't exist!" % src
        else:
            if not dry: symlink(src, link, force=force)
            print '%s @-> %s' % (link, src)
