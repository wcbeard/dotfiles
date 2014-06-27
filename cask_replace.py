from __future__ import print_function
import os
import subprocess

search = lambda x: subprocess.check_output('brew cask search {}'.format(x), shell=True)
apps = [a[:-4].replace(' ', '-') for a in os.listdir('/Applications/') if a.endswith('.app')]
print('Searching...')
res_ = {a: search(a) for a in apps}
print('Done.')

res = {k: v for k, v in res_.items() if not v.startswith('No cask found for')}

# Installed
installed = subprocess.check_output('brew cask list', shell=True).splitlines()
installed_s = set(installed)

# Partials/exacts
p_ = '==> Partial matches'
e_ = '==> Exact match'
tolist = lambda x: x.splitlines()[1:]

partials = {k: tolist(v) for k, v in res_.items() if v.startswith(p_)}
exacts = {k: tolist(v) for k, v in res_.items() if v.startswith(e_)}
new_exacts = {k: v for k, v in exacts.items() if not set(v) & installed_s}

# Print results
print('\nPotential app replacements:')
for k in sorted(new_exacts):
    print('{}:'.format(k))
    for v in new_exacts[k]:
        print('\t{}'.format(v))
