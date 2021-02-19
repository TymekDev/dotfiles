:set colorcolumn=
" Match 51st column on 1st line. \%51v is zerowidth match therefore, '.' is
" required to not match a newline character.
:call matchadd('ColorColumn', '\%51v.\%1l')
" Match 73rd column that is not preceeded by a match of '^#.*', i.e. lines not
" starting with '#'
:call matchadd('Error', '\(^#.*\)\@<!\%73v.')
