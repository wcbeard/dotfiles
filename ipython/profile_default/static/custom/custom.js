// leave at least 2 line with only a star on it below, or doc generation fails
/**
 *
 *
 * Placeholder for custom user javascript
 * mainly to be overridden in profile/static/custom/custom.js
 * This will always be an empty file in IPython
 *
 * User could add any javascript in the `profile/static/custom/custom.js` file
 * (and should create it if it does not exist).
 * It will be executed by the ipython notebook at load time.
 *
 * Same thing with `profile/static/custom/custom.css` to inject custom css into the notebook.
 *
 * Example :
 *
 * Create a custom button in toolbar that execute `%qtconsole` in kernel
 * and hence open a qtconsole attached to the same kernel as the current notebook
 *
 *    $([IPython.events]).on('app_initialized.NotebookApp', function(){
 *        IPython.toolbar.add_buttons_group([
 *            {
 *                 'label'   : 'run qtconsole',
 *                 'icon'    : 'icon-terminal', // select your icon from http://fortawesome.github.io/Font-Awesome/icons
 *                 'callback': function () {
 *                     IPython.notebook.kernel.execute('%qtconsole')
 *                 }
 *            }
 *            // add more button here if needed.
 *            ]);
 *    });
 *
 * Example :
 *
 *  Use `jQuery.getScript(url [, success(script, textStatus, jqXHR)] );`
 *  to load custom script into the notebook.
 *
 *    // to load the metadata ui extension example.
 *    $.getScript('/static/notebook/js/celltoolbarpresets/example.js');
 *    // or
 *    // to load the metadata ui extension to control slideshow mode / reveal js for nbconvert
 *    $.getScript('/static/notebook/js/celltoolbarpresets/slideshow.js');
 *
 *
 * @module IPython
 * @namespace IPython
 * @class customjs
 * @static
 */

// $([IPython.events]).on("app_initialized.NotebookApp", function () {
//     $('div#header').hide();
//     $('div#maintoolbar').hide();
// });

$([IPython.events]).on("app_initialized.NotebookApp", function () {
	$('div#header-container').hide();
	$('div#maintoolbar.navbar').hide();
	IPython.keyboard_manager.command_shortcuts.add_shortcut('ctrl-k', function (event) {
		IPython.notebook.move_cell_up();
		return false;
	});

	IPython.keyboard_manager.command_shortcuts.add_shortcut('ctrl-j', function (event) {
		IPython.notebook.move_cell_down();
		return false;
	});

	// Load and turn on TOC
	IPython.load_extensions("toc");
	// $("#toc-wrapper").toggle();
	// $('#toc_button').click();

	// $.getScript("static/components/codemirror/keymap/vim.js")
	// IPython.CodeCell.options_default.cm_config["keyMap"] = "vim"

});


require(["codemirror/keymap/sublime", "notebook/js/cell", "base/js/namespace"],
    function(sublime_keymap, cell, IPython) {
        // setTimeout(function(){ // uncomment line to fake race-condition
        cell.Cell.options_default.cm_config.keyMap = 'sublime';
        var cells = IPython.notebook.get_cells();
        for(var c=0; c< cells.length ; c++){
            cells[c].code_mirror.setOption('keyMap', 'sublime');
        }

        // }, 1000)// uncomment  line to fake race condition
    }
);
