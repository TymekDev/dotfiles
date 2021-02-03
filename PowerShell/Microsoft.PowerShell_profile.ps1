# Removing default aliases
Remove-Item Alias:curl
Remove-Item Alias:r


# Unix-like tab completion
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete


# History based arrow completion
Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward

# Git aliases
## git basics
function Get-GitAdd { & git add $args }
New-Alias -Name ga -Value Get-GitAdd -Force -Option AllScope

function Get-GitCommit { & git commit $args }
New-Alias -Name gc -Value Get-GitCommit -Force -Option AllScope

function Get-GitStatus { & git status $args }
New-Alias -Name gs -Value Get-GitStatus -Force -Option AllScope

function Get-GitFetch { & git fetch $args }
New-Alias -Name gf -Value Get-GitFetch -Force -Option AllScope

## git diff
function Get-GitDiff { & git diff --color-words $args }
New-Alias -Name gd -Value Get-GitDiff -Force -Option AllScope

function Get-GitDiff2 { & git diff $args }
New-Alias -Name gd2 -Value Get-GitDiff2 -Force -Option AllScope

function Get-GitDiffStaged { & git diff --color-words --staged $args }
New-Alias -Name gds -Value Get-GitDiffStaged -Force -Option AllScope

function Get-GitDiffStaged2 { & git diff --staged $args }
New-Alias -Name gds2 -Value Get-GitDiffStaged2 -Force -Option AllScope

## git logg
function Get-GitLog { & git logg $args }
New-Alias -Name gg -Value Get-GitLog -Force -Option AllScope

function Get-GitLogSingle { & git loggs $args }
New-Alias -Name ggs -Value Get-GitLogSingle -Force -Option AllScope

function Get-GitLog2 { & git logg2 $args }
New-Alias -Name gg2 -Value Get-GitLog2 -Force -Option AllScope

function Get-GitLogSingle2 { & git loggs2 $args }
New-Alias -Name ggs2 -Value Get-GitLogSingle2 -Force -Option AllScope

## Edit modified files with Vim
function Get-VimEditModified { & vim $(git status | sed -n "s/^[^[:alnum:]]*modified:[^[:alnum:]]*//p") }
New-Alias -Name vimgem -Value Get-VimEditModified
