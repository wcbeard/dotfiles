import os
from subprocess import check_call

if 0:
    get_config = 1


def scrub_output_pre_save(model, **kwargs):
    """scrub output before saving notebooks
    https://github.com/ipython/ipython/pull/6896#issue-48344492
    """
    # only run on notebooks
    if model['type'] != 'notebook':
        return
    # only run on nbformat v4
    if model['content']['nbformat'] != 4:
        return

    model['content']['metadata'].pop('signature', None)
    for cell in model['content']['cells']:
        if cell['cell_type'] != 'code':
            continue
        cell['outputs'] = []
        cell['execution_count'] = None


def post_save(model, os_path, contents_manager):
    """post-save hook for converting notebooks to .py scripts
    http://stackoverflow.com/questions/18734739/using-ipython-notebooks-under-version-control
    """
    if model['type'] != 'notebook':
        return  # only do this for notebooks
    d, fname = os.path.split(os_path)
    check_call(['ipython', 'nbconvert', '--to', 'script', fname], cwd=d)


# https://github.com/ipython/ipython/blob/783495006ca584b7af779fa765bbbafb491e1101/IPython/html/services/contents/filemanager.py
# def _post_save_script(model, os_path, contents_manager, **kwargs):
#     """convert notebooks to Python script after save with nbconvert
#     replaces `ipython notebook --script`
#     """
#     from IPython.nbconvert.exporters.script import ScriptExporter

#     if model['type'] != 'notebook':
#         return

#     global _script_exporter
#     _script_exporter = ScriptExporter(parent=contents_manager)
#     log = contents_manager.log

#     base, ext = os.path.splitext(os_path)
#     script, resources = _script_exporter.from_filename(os_path)
#     script_fname = base + resources.get('output_extension', '.txt')
#     log.info("Saving script /%s", to_api_path(script_fname, contents_manager.root_dir))
#     with io.open(script_fname, 'w', encoding='utf-8') as f:
#         f.write(script)


c = get_config()
c.FileContentsManager.pre_save_hook = scrub_output_pre_save
c.FileContentsManager.post_save_hook = post_save

