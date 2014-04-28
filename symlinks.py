import os
from os.path import basename, abspath, join
# import errno
import sys
import argparse
import shutil
import glob
from ConfigParser import SafeConfigParser
import operator
import re


home = lambda *x: os.path.join(os.path.expanduser('~'), *x)
expandhome = lambda x: re.sub(r'^~', home(), x)
files = lambda *x: os.path.join(abspath('files'), *x)
here = lambda *x: os.path.join(abspath('.'), *x)
unhome = lambda x: x.replace(home(), '~')
herehome = lambda src, dst: (here(src), home(dst))
basenames = lambda fs: set(map(os.path.basename, fs))
# myos = 'mac' if ('darwin' in sys.platform) else 'linux'
mac = 'darwin' in sys.platform

# Sublime Text is an oddball
st_dirs = (glob.glob(expandhome('~/Library/Application Support/Sublime*')) +
           ['.config/sublime-text-2'])
st_dir_ = st_dirs[0]
st_dir = lambda *x: os.path.join(st_dir_, *x)

# /Users/beard/Library/Application Support/Sublime Text 2
# /Packages/User/Preferences.sublime-settings

# Files to copy, comma-separated if the symlink will not be dotted version
# of file in the home directory.


def copy_dirs():
    dct = {}
    if mac:
        dct.update({src: join(home('Library/Services/'), basename(src))
                   for src in glob.glob(here('services/*'))})
    return dct

# sym_bases = [
    # 'bashrc', 'bash_aliases', 'bash_profile', 'screenrc', 'vim/vimrc',
    # 'vim/gvimrc', 'vim/vimrc.vim,vimrc.vim', 'vim', 'dir_colors',
    # 'ipython', 'Vagrantfile,', 'zshrc', 'gitconfig',
    # 'gitignore,global_gitignore.txt', 'pentadactylrc',
    # 'sublime-text-config,' + st_dir,
    # 'ghci']
#


def merge(*dcts):
    return dict(reduce(operator.or_, (d.viewitems() for d in dcts)))


def copyfile(src, dst, force=False, sym=True, dry=False):
    "Copy or symlink file"
    copyfunc = shutil.copytree if os.path.isdir(src) else shutil.copyfile
    writefunc = os.symlink if sym else copyfunc
    if dry:
        writefunc = lambda *a, **kw: None
    if os.path.lexists(dst):
        if not force:
            symrepr = unhome(os.path.realpath(dst))
            st = ("Not overwriting [{}{}]".format(unhome(dst),
                  ' @-> ' + symrepr if (symrepr != unhome(dst)) else ''
            ))
            print st,
        else:
            print 'Overwriting...',
            os.remove(dst)
            writefunc(src, dst)
    else:
        writefunc(src, dst)
    print '%s %s %s' % (unhome(dst), '@->' if sym else '<-', unhome(src))


def sym_names(f_path):
    """Returns tuple of existing filename (fname) and filename of symlink.
    'fname' -> '.fname'; 'fname,' -> 'fname'; 'fname,foo' -> 'foo'
    """
    pair = f_path.split(',')
    dst = pair.pop(0)
    if not pair:
        # prefix the file base name with '.'
        src = '.' + dst.split('/')[-1]
    else:
        src = pair[0] or dst
    return dst, src


def perform_writes(src, dst, copy=False, dry=None, force=None, ignores=None):
    dry = args.dry_run if dry is None else dry
    force = args.force if force is None else force
    ignores = args.ignore_files if ignores is None else ignores

    if basenames([src, dst]) & set(ignores):
        return 0  # Skip ignores

    if not os.path.lexists(src):
        print "File %s doesn't exist!" % src
    else:
        copyfile(src, dst, force=force, dry=dry, sym=not copy)
    return 1


def test_sym_names():
    # print sym_names('bashrc')
    assert sym_names('bashrc') == ('bashrc', '.bashrc')
    # print sym_names('vim/vimrc')
    assert sym_names('vim/vimrc') == ('vim/vimrc', '.vimrc')
    # print sym_names('Vagrantfile,')
    assert sym_names('Vagrantfile,') == ('Vagrantfile', 'Vagrantfile')
    # print sym_names('Vagrantfile,.vim/Vagrantfile')
    assert sym_names('Vagrantfile,.vim/Vagrantfile') == (
        'Vagrantfile', '.vim/Vagrantfile')
    print "Tests passed!"


if __name__ == "__main__":
    desc = """Create symlinks for files listed in `sym_bases` list, based
    on sym_names algorithm.  If `dry` option is passed, script will (kinda)
    simulate script without creating symlinks.  If `force` option is passed,
    script will overwrite existing symlinks.

    Current list: %s
    """ % ''
    # """ % sym_bases

    parser = (argparse.ArgumentParser(description=desc,
              formatter_class=argparse.ArgumentDefaultsHelpFormatter)
              )
    parser.add_argument('-d', '--dry-run', action='store_true', default=False,
                        help='Simulates script without any writes.')

    parser.add_argument('-f', '--force', action='store_true', default=False,
                        help='Overwrites existing files.')

    parser.add_argument('-t', '--test', action='store_true', default=False,
                        help='Run tests function.')

    parser.add_argument('-i', '--ignore-files', type=str, nargs='*',
                        default='',
                        help='Columns to give values to.')

    args = parser.parse_args()

    # Ensure valid args.ignore_files
    # all_bases = {os.path.basename(base) for commsep in sym_bases
    # for base in commsep.split(',')  # TODO: copy_dirs
    #              if base}

    config = SafeConfigParser()
    config.read('syms.conf')

    dotsdir_ = config.get('dirs', 'dotsdir')
    dotsdir = lambda x: os.path.join(dotsdir_, x)

    # dotfiles
    dotfiles = {dst: '~/.{}'.format(basename(dst)) for dst in
                glob.glob(dotsdir('*'))}

    # symlink dirs
    symdirs = {abspath(dst): src for dst, src in config.items('symdirs')}

    # Sublime text files
    stfiles = {abspath(files(dst)): st_dir(src)
               for dst, src in config.items('st')}

    # other
    other_files = {abspath(files(dst)): src for
                   dst, src in config.items('dstsrc')}

    sym_args = {abspath(d): expandhome(s) for d, s in
                merge(dotfiles, symdirs, stfiles, other_files).items()}
    all_bases = basenames(sym_args)

    extra_ignores = basenames(args.ignore_files) - all_bases

    assert not extra_ignores, (
        "Invalid `ignore_file` argument passed: %s" % ', '.join(extra_ignores))

    if args.test:
        test_sym_names()
    if args.dry_run:
        print 'Dry run...'

    # sym_args = [herehome(*sym_names(base)) for base in sym_bases]
    print sym_args
    # syms = [perform_writes(src, dst, copy=False) for dst, src in sym_args]
    syms = [perform_writes(src, dst, copy=False)
            for src, dst in sym_args.items()]
    # copies = [perform_writes(src, dst, copy=True)
    #           for src, dst in copy_dirs().items()]
