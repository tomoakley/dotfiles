return {
  "nvim-orgmode/orgmode",
  config = function()
    return {
        org_agenda_files = {'~/Library/Mobile Documents/iCloud~com~appsonthemove~beorg/Documents/org/*'},
        org_default_notes_file = '~/Library/Mobile Documents/iCloud~com~appsonthemove~beorg/Documents/org/inbox.org',
        org_capture_templates = {
          T = {
            description = 'Todo',
            template = '* TODO %a\n %u',
            target = '~/Library/Mobile Documents/iCloud~com~appsonthemove~beorg/Documents/org/inbox.org'
          }
        }
    }
  end
}
