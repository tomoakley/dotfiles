# Autogenerated config.py
# Documentation:
#   qute://help/configuring.html
#   qute://help/settings.html

# Uncomment this to still load settings configured via autoconfig.yml
# config.load_autoconfig()

import os
os.environ['PATH'] = os.pathsep + '/usr/local/bin'
os.environ['NODE_PATH'] = os.pathsep + '/usr/local/lib/node_modules'

# Enable JavaScript.
# Type: Bool
config.set('content.javascript.enabled', True, 'file://*')

# Enable JavaScript.
# Type: Bool
config.set('content.javascript.enabled', True, 'chrome://*/*')

# Enable JavaScript.
# Type: Bool
config.set('content.javascript.enabled', True, 'qute://*/*')

# Where to show the downloaded files.
# Type: VerticalPosition
# Valid values:
#   - top
#   - bottom
c.downloads.position = 'top'

# Editor (and arguments) to use for the `open-editor` command. The
# following placeholders are defined: * `{file}`: Filename of the file
# to be edited. * `{line}`: Line in which the caret is found in the
# text. * `{column}`: Column in which the caret is found in the text. *
# `{line0}`: Same as `{line}`, but starting from index 0. * `{column0}`:
# Same as `{column}`, but starting from index 0.
# Type: ShellCommand
c.editor.command = ['vim', '-f', '{file}', '-c', 'normal {line}G{column0}l']

# Padding (in pixels) around text for tabs.
# Type: Padding
c.tabs.padding = {'bottom': 10, 'left': 5, 'right': 5, 'top': 10}

# Position of the tab bar.
# Type: Position
# Valid values:
#   - top
#   - bottom
#   - left
#   - right
c.tabs.position = 'left'

# When to show the tab bar.
# Type: String
# Valid values:
#   - always: Always show the tab bar.
#   - never: Always hide the tab bar.
#   - multiple: Hide the tab bar if only one tab is open.
#   - switching: Show the tab bar when switching tabs.
c.tabs.show = 'always'

# Width (in pixels) of the progress indicator (0 to disable).
# Type: Int
c.tabs.indicator.width = 0

# Text color of the completion widget. May be a single color to use for
# all columns or a list of three colors, one for each column.
# Type: List of QtColor, or QtColor
c.colors.completion.fg = '#93a1a1'

# Background color of the completion widget for odd rows.
# Type: QssColor
c.colors.completion.odd.bg = '#002b36'

# Background color of the completion widget for even rows.
# Type: QssColor
c.colors.completion.even.bg = '#002b36'

# Foreground color of completion widget category headers.
# Type: QtColor
c.colors.completion.category.fg = '#b58900'

# Background color of the completion widget category headers.
# Type: QssColor
c.colors.completion.category.bg = '#002b36'

# Top border color of the completion widget category headers.
# Type: QssColor
c.colors.completion.category.border.top = '#002b36'

# Bottom border color of the completion widget category headers.
# Type: QssColor
c.colors.completion.category.border.bottom = '#002b36'

# Foreground color of the selected completion item.
# Type: QtColor
c.colors.completion.item.selected.fg = '#073642'

# Background color of the selected completion item.
# Type: QssColor
c.colors.completion.item.selected.bg = '#b58900'

# Top border color of the selected completion item.
# Type: QssColor
c.colors.completion.item.selected.border.top = '#b58900'

# Bottom border color of the selected completion item.
# Type: QssColor
c.colors.completion.item.selected.border.bottom = '#b58900'

# Foreground color of the matched text in the selected completion item.
# Type: QtColor
c.colors.completion.item.selected.match.fg = '#dc322f'

# Foreground color of the matched text in the completion.
# Type: QtColor
c.colors.completion.match.fg = '#859900'

# Color of the scrollbar handle in the completion view.
# Type: QssColor
c.colors.completion.scrollbar.fg = '#93a1a1'

# Color of the scrollbar in the completion view.
# Type: QssColor
c.colors.completion.scrollbar.bg = '#002b36'

# Background color for the download bar.
# Type: QssColor
c.colors.downloads.bar.bg = '#002b36'

# Color gradient start for download text.
# Type: QtColor
c.colors.downloads.start.fg = '#002b36'

# Color gradient start for download backgrounds.
# Type: QtColor
c.colors.downloads.start.bg = '#268bd2'

# Color gradient end for download text.
# Type: QtColor
c.colors.downloads.stop.fg = '#002b36'

# Color gradient stop for download backgrounds.
# Type: QtColor
c.colors.downloads.stop.bg = '#2aa198'

# Foreground color for downloads with errors.
# Type: QtColor
c.colors.downloads.error.fg = '#dc322f'

# Font color for hints.
# Type: QssColor
c.colors.hints.fg = '#002b36'

# Background color for hints. Note that you can use a `rgba(...)` value
# for transparency.
# Type: QssColor
c.colors.hints.bg = '#b58900'

# Font color for the matched part of hints.
# Type: QtColor
c.colors.hints.match.fg = '#93a1a1'

# Text color for the keyhint widget.
# Type: QssColor
c.colors.keyhint.fg = '#93a1a1'

# Highlight color for keys to complete the current keychain.
# Type: QssColor
c.colors.keyhint.suffix.fg = '#93a1a1'

# Background color of the keyhint widget.
# Type: QssColor
c.colors.keyhint.bg = '#002b36'

# Foreground color of an error message.
# Type: QssColor
c.colors.messages.error.fg = '#002b36'

# Background color of an error message.
# Type: QssColor
c.colors.messages.error.bg = '#dc322f'

# Border color of an error message.
# Type: QssColor
c.colors.messages.error.border = '#dc322f'

# Foreground color of a warning message.
# Type: QssColor
c.colors.messages.warning.fg = '#002b36'

# Background color of a warning message.
# Type: QssColor
c.colors.messages.warning.bg = '#6c71c4'

# Border color of a warning message.
# Type: QssColor
c.colors.messages.warning.border = '#6c71c4'

# Foreground color of an info message.
# Type: QssColor
c.colors.messages.info.fg = '#93a1a1'

# Background color of an info message.
# Type: QssColor
c.colors.messages.info.bg = '#002b36'

# Border color of an info message.
# Type: QssColor
c.colors.messages.info.border = '#002b36'

# Foreground color for prompts.
# Type: QssColor
c.colors.prompts.fg = '#93a1a1'

# Border used around UI elements in prompts.
# Type: String
c.colors.prompts.border = '#002b36'

# Background color for prompts.
# Type: QssColor
c.colors.prompts.bg = '#002b36'

# Background color for the selected item in filename prompts.
# Type: QssColor
c.colors.prompts.selected.bg = '#b58900'

# Foreground color of the statusbar.
# Type: QssColor
c.colors.statusbar.normal.fg = '#859900'

# Background color of the statusbar.
# Type: QssColor
c.colors.statusbar.normal.bg = '#002b36'

# Foreground color of the statusbar in insert mode.
# Type: QssColor
c.colors.statusbar.insert.fg = '#002b36'

# Background color of the statusbar in insert mode.
# Type: QssColor
c.colors.statusbar.insert.bg = '#268bd2'

# Foreground color of the statusbar in passthrough mode.
# Type: QssColor
c.colors.statusbar.passthrough.fg = '#002b36'

# Background color of the statusbar in passthrough mode.
# Type: QssColor
c.colors.statusbar.passthrough.bg = '#2aa198'

# Foreground color of the statusbar in private browsing mode.
# Type: QssColor
c.colors.statusbar.private.fg = '#002b36'

# Background color of the statusbar in private browsing mode.
# Type: QssColor
c.colors.statusbar.private.bg = '#657b83'

# Foreground color of the statusbar in command mode.
# Type: QssColor
c.colors.statusbar.command.fg = '#93a1a1'

# Background color of the statusbar in command mode.
# Type: QssColor
c.colors.statusbar.command.bg = '#002b36'

# Foreground color of the statusbar in private browsing + command mode.
# Type: QssColor
c.colors.statusbar.command.private.fg = '#93a1a1'

# Background color of the statusbar in private browsing + command mode.
# Type: QssColor
c.colors.statusbar.command.private.bg = '#002b36'

# Foreground color of the statusbar in caret mode.
# Type: QssColor
c.colors.statusbar.caret.fg = '#002b36'

# Background color of the statusbar in caret mode.
# Type: QssColor
c.colors.statusbar.caret.bg = '#6c71c4'

# Foreground color of the statusbar in caret mode with a selection.
# Type: QssColor
c.colors.statusbar.caret.selection.fg = '#002b36'

# Background color of the statusbar in caret mode with a selection.
# Type: QssColor
c.colors.statusbar.caret.selection.bg = '#268bd2'

# Background color of the progress bar.
# Type: QssColor
c.colors.statusbar.progress.bg = '#268bd2'

# Default foreground color of the URL in the statusbar.
# Type: QssColor
c.colors.statusbar.url.fg = '#93a1a1'

# Foreground color of the URL in the statusbar on error.
# Type: QssColor
c.colors.statusbar.url.error.fg = '#dc322f'

# Foreground color of the URL in the statusbar for hovered links.
# Type: QssColor
c.colors.statusbar.url.hover.fg = '#93a1a1'

# Foreground color of the URL in the statusbar on successful load
# (http).
# Type: QssColor
c.colors.statusbar.url.success.http.fg = '#2aa198'

# Foreground color of the URL in the statusbar on successful load
# (https).
# Type: QssColor
c.colors.statusbar.url.success.https.fg = '#859900'

# Foreground color of the URL in the statusbar when there's a warning.
# Type: QssColor
c.colors.statusbar.url.warn.fg = '#6c71c4'

# Background color of the tab bar.
# Type: QssColor
c.colors.tabs.bar.bg = '#002b36'

# Color gradient start for the tab indicator.
# Type: QtColor
c.colors.tabs.indicator.start = '#268bd2'

# Color gradient end for the tab indicator.
# Type: QtColor
c.colors.tabs.indicator.stop = '#2aa198'

# Color for the tab indicator on errors.
# Type: QtColor
c.colors.tabs.indicator.error = '#dc322f'

# Foreground color of unselected odd tabs.
# Type: QtColor
c.colors.tabs.odd.fg = '#93a1a1'

# Background color of unselected odd tabs.
# Type: QtColor
c.colors.tabs.odd.bg = '#002b36'

# Foreground color of unselected even tabs.
# Type: QtColor
c.colors.tabs.even.fg = '#93a1a1'

# Background color of unselected even tabs.
# Type: QtColor
c.colors.tabs.even.bg = '#002b36'

# Foreground color of selected odd tabs.
# Type: QtColor
c.colors.tabs.selected.odd.fg = '#002b36'

# Background color of selected odd tabs.
# Type: QtColor
c.colors.tabs.selected.odd.bg = '#93a1a1'

# Foreground color of selected even tabs.
# Type: QtColor
c.colors.tabs.selected.even.fg = '#002b36'

# Background color of selected even tabs.
# Type: QtColor
c.colors.tabs.selected.even.bg = '#93a1a1'

# Foreground color of pinned unselected odd tabs.
# Type: QtColor
c.colors.tabs.pinned.odd.fg = '#fdf6e3'

# Background color of pinned unselected odd tabs.
# Type: QtColor
c.colors.tabs.pinned.odd.bg = '#2aa198'

# Foreground color of pinned unselected even tabs.
# Type: QtColor
c.colors.tabs.pinned.even.fg = '#fdf6e3'

# Background color of pinned unselected even tabs.
# Type: QtColor
c.colors.tabs.pinned.even.bg = '#2aa198'

# Foreground color of pinned selected odd tabs.
# Type: QtColor
c.colors.tabs.pinned.selected.odd.fg = '#fdf6e3'

# Background color of pinned selected odd tabs.
# Type: QtColor
c.colors.tabs.pinned.selected.odd.bg = '#859900'

# Foreground color of pinned selected even tabs.
# Type: QtColor
c.colors.tabs.pinned.selected.even.fg = '#fdf6e3'

# Background color of pinned selected even tabs.
# Type: QtColor
c.colors.tabs.pinned.selected.even.bg = '#859900'

# Default monospace fonts. Whenever "monospace" is used in a font
# setting, it's replaced with the fonts listed here.
# Type: Font
c.fonts.monospace = '"Fira Code", "Inconsolata-g", "xos4 Terminus", Terminus, Monospace, "DejaVu Sans Mono", Monaco, "Bitstream Vera Sans Mono", "Andale Mono", "Courier New", Courier, "Liberation Mono", monospace, Fixed, Consolas, Terminal'

# Font used in the completion widget.
# Type: Font
c.fonts.completion.entry = '14pt monospace'

# Font used in the completion categories.
# Type: Font
c.fonts.completion.category = 'bold 14pt monospace'

# Font used for the hints.
# Type: Font
c.fonts.hints = 'bold 14pt monospace'

# Font used in the statusbar.
# Type: Font
c.fonts.statusbar = '14pt monospace'

# Font used in the tab bar.
# Type: QtFont
c.fonts.tabs = '14pt monospace'

# Bindings for normal mode
config.bind('<Ctrl+t>', 'config-cycle tabs.show never always')

# Add Nord theme
config.source('nord-qutebrowser.py')
