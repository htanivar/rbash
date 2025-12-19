# git plugin

The git plugin provides many [aliases](#aliases) and a few useful [functions](#functions).

To use it, add `git` to the plugins array in your zshrc file:

```zsh
plugins=(... git)
```

## Aliases

| Alias                  | Command                                                                                                                         | Purpose                                                                 |
| :--------------------- | :------------------------------------------------------------------------------------------------------------------------------ | :---------------------------------------------------------------------- |
| `grt`                  | `cd "$(git rev-parse --show-toplevel \|\| echo .)"`                                                                             | Change to the root directory of the git repository                      |
| `ggpnp`                | `ggl && ggp`                                                                                                                    | Pull and then push the current branch                                   |
| `ggpur`                | `ggu`                                                                                                                           | Pull with rebase (same as `ggu`)                                        |
| `g`                    | `git`                                                                                                                           | Shortcut for git command                                                |
| `ga`                   | `git add`                                                                                                                       | Add files to the staging area                                           |
| `gaa`                  | `git add --all`                                                                                                                 | Add all files to the staging area                                       |
| `gapa`                 | `git add --patch`                                                                                                               | Interactively choose patches to add                                     |
| `gau`                  | `git add --update`                                                                                                              | Add updated files to the staging area                                   |
| `gav`                  | `git add --verbose`                                                                                                             | Add files with verbose output                                           |
| `gwip`                 | `git add -A; git rm $(git ls-files --deleted) 2> /dev/null; git commit --no-verify --no-gpg-sign --message "--wip-- [skip ci]"` | Create a work-in-progress commit                                        |
| `gam`                  | `git am`                                                                                                                        | Apply a series of patches from a mailbox                                |
| `gama`                 | `git am --abort`                                                                                                                | Abort the current patch application                                     |
| `gamc`                 | `git am --continue`                                                                                                             | Continue the current patch application                                  |
| `gamscp`               | `git am --show-current-patch`                                                                                                   | Show the current patch being applied                                    |
| `gams`                 | `git am --skip`                                                                                                                 | Skip the current patch                                                  |
| `gap`                  | `git apply`                                                                                                                     | Apply a patch to files                                                  |
| `gapt`                 | `git apply --3way`                                                                                                              | Apply a patch with 3-way merge                                          |
| `gbs`                  | `git bisect`                                                                                                                    | Use binary search to find the commit that introduced a bug              |
| `gbsb`                 | `git bisect bad`                                                                                                                | Mark the current commit as bad                                          |
| `gbsg`                 | `git bisect good`                                                                                                               | Mark the current commit as good                                         |
| `gbsn`                 | `git bisect new`                                                                                                                | Mark the current commit as new                                          |
| `gbso`                 | `git bisect old`                                                                                                                | Mark the current commit as old                                          |
| `gbsr`                 | `git bisect reset`                                                                                                              | Reset bisect state                                                      |
| `gbss`                 | `git bisect start`                                                                                                              | Start bisect session                                                    |
| `gbl`                  | `git blame -w`                                                                                                                  | Show what revision and author last modified each line ignoring whitespace|
| `gb`                   | `git branch`                                                                                                                    | List, create, or delete branches                                        |
| `gba`                  | `git branch --all`                                                                                                              | List all branches (local and remote)                                    |
| `gbd`                  | `git branch --delete`                                                                                                           | Delete a branch                                                         |
| `gbD`                  | `git branch --delete --force`                                                                                                   | Force delete a branch                                                   |
| `gbgd`                 | `LANG=C git branch --no-color -vv \| grep ": gone\]" \| cut -c 3- \| awk '"'"'{print $1}'"'"' \| xargs git branch -d`           | Delete local branches that are gone from the remote                     |
| `gbgD`                 | `LANG=C git branch --no-color -vv \| grep ": gone\]" \| cut -c 3- \| awk '"'"'{print $1}'"'"' \| xargs git branch -D`           | Force delete local branches that are gone from the remote               |
| `gbm`                  | `git branch --move`                                                                                                             | Move/rename a branch                                                    |
| `gbnm`                 | `git branch --no-merged`                                                                                                        | List branches that have not been merged                                 |
| `gbr`                  | `git branch --remote`                                                                                                           | List remote branches                                                    |
| `ggsup`                | `git branch --set-upstream-to=origin/$(git_current_branch)`                                                                     | Set upstream branch to origin's current branch                          |
| `gbg`                  | `LANG=C git branch -vv \| grep ": gone\]"`                                                                                      | Show local branches that are gone from the remote                       |
| `gco`                  | `git checkout`                                                                                                                  | Switch branches or restore working tree files                           |
| `gcor`                 | `git checkout --recurse-submodules`                                                                                             | Checkout with submodule recursion                                       |
| `gcb`                  | `git checkout -b`                                                                                                               | Create and switch to a new branch                                       |
| `gcB`                  | `git checkout -B`                                                                                                               | Create/reset and switch to a branch                                     |
| `gcd`                  | `git checkout $(git_develop_branch)`                                                                                            | Switch to the development branch                                        |
| `gcm`                  | `git checkout $(git_main_branch)`                                                                                               | Switch to the main branch                                               |
| `gcp`                  | `git cherry-pick`                                                                                                               | Apply the changes introduced by some existing commits                   |
| `gcpa`                 | `git cherry-pick --abort`                                                                                                       | Abort the current cherry-pick operation                                 |
- `gcpc`                 | `git cherry-pick --continue`                                                                                                    | Continue the current cherry-pick operation                              |
| `gclean`               | `git clean --interactive -d`                                                                                                    | Interactively clean untracked files and directories                     |
| `gcl`                  | `git clone --recurse-submodules`                                                                                                | Clone a repository with submodules                                      |
| `gclf`                 | `git clone --recursive --shallow-submodules --filter=blob:none --also-filter-submodules`                                        | Clone with advanced filtering and shallow submodules                    |
| `gccd`                 | `git clone --recurse-submodules "$@" && cd "$(basename $\_ .git)"`                                                              | Clone and change to the repository directory                            |
| `gcam`                 | `git commit --all --message`                                                                                                    | Commit all staged changes with a message                                |
| `gcas`                 | `git commit --all --signoff`                                                                                                    | Commit all staged changes with signoff                                  |
| `gcasm`                | `git commit --all --signoff --message`                                                                                          | Commit all staged changes with signoff and message                      |
| `gcmsg`                | `git commit --message`                                                                                                          | Commit staged changes with a message                                    |
| `gcsm`                 | `git commit --signoff --message`                                                                                                | Commit staged changes with signoff and message                          |
| `gc`                   | `git commit --verbose`                                                                                                          | Commit staged changes with verbose diff                                 |
| `gca`                  | `git commit --verbose --all`                                                                                                    | Commit all changes with verbose diff                                    |
| `gca!`                 | `git commit --verbose --all --amend`                                                                                            | Amend all changes with verbose diff                                     |
| `gcan!`                | `git commit --verbose --all --no-edit --amend`                                                                                  | Amend all changes without editing the message                           |
| `gcans!`               | `git commit --verbose --all --signoff --no-edit --amend`                                                                        | Amend all changes with signoff and no edit                              |
| `gcann!`               | `git commit --verbose --all --date=now --no-edit --amend`                                                                       | Amend all changes with current date and no edit                         |
| `gc!`                  | `git commit --verbose --amend`                                                                                                  | Amend the last commit with verbose diff                                 |
| `gcn`                  | `git commit --verbose --no-edit`                                                                                                | Commit staged changes with verbose diff and no edit                     |
| `gcn!`                 | `git commit --verbose --no-edit --amend`                                                                                        | Amend the last commit with verbose diff and no edit                     |
| `gcs`                  | `git commit -S`                                                                                                                 | Commit with GPG signature                                               |
| `gcss`                 | `git commit -S -s`                                                                                                              | Commit with GPG signature and signoff                                   |
| `gcssm`                | `git commit -S -s -m`                                                                                                           | Commit with GPG signature, signoff, and message                         |
| `gcf`                  | `git config --list`                                                                                                             | List all git configuration settings                                     |
| `gcfu`                 | `git commit --fixup`                                                                                                            | Create a fixup commit for a previous commit                             |
| `gdct`                 | `git describe --tags $(git rev-list --tags --max-count=1)`                                                                      | Show the latest tag in the repository                                   |
| `gd`                   | `git diff`                                                                                                                      | Show changes between commits, commit and working tree, etc              |
| `gdca`                 | `git diff --cached`                                                                                                             | Show changes staged for commit                                          |
| `gdcw`                 | `git diff --cached --word-diff`                                                                                                 | Show word-level changes staged for commit                               |
| `gds`                  | `git diff --staged`                                                                                                             | Show staged changes (same as `gdca`)                                    |
| `gdw`                  | `git diff --word-diff`                                                                                                          | Show word-level changes in the working tree                             |
| `gdv`                  | `git diff -w "$@" \| view -`                                                                                                    | View diff in a pager ignoring whitespace                                |
| `gdup`                 | `git diff @{upstream}`                                                                                                          | Show changes between current branch and its upstream                    |
| `gdnolock`             | `git diff $@ ":(exclude)package-lock.json" ":(exclude)\*.lock"`                                                                 | Show diff excluding lock files                                          |
| `gdt`                  | `git diff-tree --no-commit-id --name-only -r`                                                                                   | Show files changed in a commit                                          |
| `gf`                   | `git fetch`                                                                                                                     | Download objects and refs from another repository                       |
| `gfa`                  | `git fetch --all --tags --prune`                                                                                                | Fetch all remotes, tags, and prune obsolete references                  |
| `gfo`                  | `git fetch origin`                                                                                                              | Fetch from origin remote                                                |
| `gg`                   | `git gui citool`                                                                                                                | Launch git GUI commit tool                                              |
| `gga`                  | `git gui citool --amend`                                                                                                        | Launch git GUI commit tool for amending                                 |
| `ghh`                  | `git help`                                                                                                                      | Display git help                                                        |
| `glgg`                 | `git log --graph`                                                                                                               | Show commit history as a graph                                          |
| `glgga`                | `git log --graph --decorate --all`                                                                                              | Show commit history as a graph with all refs                            |
| `glgm`                 | `git log --graph --max-count=10`                                                                                                | Show last 10 commits as a graph                                         |
| `glod`                 | `git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset'`                        | Show formatted log with graph and date                                  |
| `glods`                | `git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset' --date=short`           | Show formatted log with graph and short date                            |
| `glol`                 | `git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset'`                        | Show formatted log with graph and relative date                         |
| `glola`                | `git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset' --all`                  | Show formatted log with graph, relative date, and all refs              |
| `glols`                | `git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset' --stat`                 | Show formatted log with graph, relative date, and stats                 |
| `glo`                  | `git log --oneline --decorate`                                                                                                  | Show one-line log with ref decorations                                  |
| `glog`                 | `git log --oneline --decorate --graph`                                                                                          | Show one-line log with graph and decorations                            |
| `gloga`                | `git log --oneline --decorate --graph --all`                                                                                    | Show one-line log with graph, decorations, and all refs                 |
| `glp`                  | `git log --pretty=<format>`                                                                                                     | Show log with custom format                                             |
| `glg`                  | `git log --stat`                                                                                                                | Show log with stats                                                     |
| `glgp`                 | `git log --stat --patch`                                                                                                        | Show log with stats and patches                                         |
| `gignored`             | `git ls-files -v \| grep "^[[:lower:]]"`                                                                                        | List ignored files                                                      |
| `gfg`                  | `git ls-files \| grep`                                                                                                          | Search for files in the repository                                      |
| `gm`                   | `git merge`                                                                                                                     | Merge branches                                                          |
| `gma`                  | `git merge --abort`                                                                                                             | Abort the current merge                                                 |
| `gmc`                  | `git merge --continue`                                                                                                          | Continue the current merge                                              |
| `gms`                  | `git merge --squash`                                                                                                            | Squash merge                                                            |
| `gmff`                 | `git merge --ff-only`                                                                                                           | Merge only if fast-forward is possible                                  |
| `gmom`                 | `git merge origin/$(git_main_branch)`                                                                                           | Merge the main branch from origin                                       |
| `gmum`                 | `git merge upstream/$(git_main_branch)`                                                                                         | Merge the main branch from upstream                                     |
| `gmtl`                 | `git mergetool --no-prompt`                                                                                                     | Launch merge tool without prompting                                     |
| `gmtlvim`              | `git mergetool --no-prompt --tool=vimdiff`                                                                                      | Launch vimdiff as merge tool without prompting                          |
| `gl`                   | `git pull`                                                                                                                      | Pull from the current remote                                            |
| `gpr`                  | `git pull --rebase`                                                                                                             | Pull with rebase                                                        |
| `gprv`                 | `git pull --rebase -v`                                                                                                          | Pull with rebase and verbose output                                     |
| `gpra`                 | `git pull --rebase --autostash`                                                                                                 | Pull with rebase and autostash                                          |
| `gprav`                | `git pull --rebase --autostash -v`                                                                                              | Pull with rebase, autostash, and verbose output                         |
| `gprom`                | `git pull --rebase origin $(git_main_branch)`                                                                                   | Pull and rebase onto origin's main branch                               |
| `gpromi`               | `git pull --rebase=interactive origin $(git_main_branch)`                                                                       | Pull and interactive rebase onto origin's main branch                   |
| `gprum`                | `git pull --rebase upstream $(git_main_branch)`                                                                                 | Pull and rebase onto upstream's main branch                             |
| `gprumi`               | `git pull --rebase=interactive upstream $(git_main_branch)`                                                                     | Pull and interactive rebase onto upstream's main branch                 |
| `ggpull`               | `git pull origin "$(git_current_branch)"`                                                                                       | Pull the current branch from origin                                     |
| `ggl`                  | `git pull origin $(current_branch)`                                                                                             | Pull the current branch from origin (same as ggpull)                    |
| `gluc`                 | `git pull upstream $(git_current_branch)`                                                                                       | Pull the current branch from upstream                                   |
| `glum`                 | `git pull upstream $(git_main_branch)`                                                                                          | Pull the main branch from upstream                                      |
| `gp`                   | `git push`                                                                                                                      | Push to the current remote                                              |
| `gpd`                  | `git push --dry-run`                                                                                                            | Push dry-run                                                            |
| `gpf!`                 | `git push --force`                                                                                                              | Force push                                                              |
| `ggf`                  | `git push --force origin $(current_branch)`                                                                                     | Force push the current branch to origin                                 |
| `gpf`                  | On Git >= 2.30: `git push --force-with-lease --force-if-includes`                                                               | Force push with lease (safer)                                           |
| `gpf`                  | On Git < 2.30: `git push --force-with-lease`                                                                                    | Force push with lease (older Git)                                       |
| `ggfl`                 | `git push --force-with-lease origin $(current_branch)`                                                                          | Force push with lease to origin                                         |
| `gpsup`                | `git push --set-upstream origin $(git_current_branch)`                                                                          | Push and set upstream to origin                                         |
| `gpsupf`               | On Git >= 2.30: `git push --set-upstream origin $(git_current_branch) --force-with-lease --force-if-includes`                   | Push with upstream and force with lease                                 |
| `gpsupf`               | On Git < 2.30: `git push --set-upstream origin $(git_current_branch) --force-with-lease`                                        | Push with upstream and force with lease (older Git)                     |
| `gpv`                  | `git push --verbose`                                                                                                            | Push with verbose output                                                |
| `gpoat`                | `git push origin --all && git push origin --tags`                                                                               | Push all branches and tags to origin                                    |
| `gpod`                 | `git push origin --delete`                                                                                                      | Delete a remote branch on origin                                        |
| `ggpush`               | `git push origin "$(git_current_branch)"`                                                                                       | Push the current branch to origin                                       |
| `ggp`                  | `git push origin $(current_branch)`                                                                                             | Push the current branch to origin (same as ggpush)                      |
| `gpu`                  | `git push upstream`                                                                                                             | Push to upstream remote                                                 |
| `grb`                  | `git rebase`                                                                                                                    | Rebase commits                                                          |
| `grba`                 | `git rebase --abort`                                                                                                            | Abort a rebase                                                          |
| `grbc`                 | `git rebase --continue`                                                                                                         | Continue a rebase                                                       |
| `grbi`                 | `git rebase --interactive`                                                                                                      | Interactive rebase                                                      |
| `grbo`                 | `git rebase --onto`                                                                                                             | Rebase onto a specific base                                             |
| `grbs`                 | `git rebase --skip`                                                                                                             | Skip a commit during rebase                                             |
| `grbd`                 | `git rebase $(git_develop_branch)`                                                                                              | Rebase onto the development branch                                      |
| `grbm`                 | `git rebase $(git_main_branch)`                                                                                                 | Rebase onto the main branch                                             |
| `grbom`                | `git rebase origin/$(git_main_branch)`                                                                                          | Rebase onto origin's main branch                                        |
| `grbum`                | `git rebase upstream/$(git_main_branch)`                                                                                        | Rebase onto upstream's main branch                                      |
| `grf`                  | `git reflog`                                                                                                                    | Show reference logs                                                     |
| `gr`                   | `git remote`                                                                                                                    | Manage remote repositories                                              |
| `grv`                  | `git remote --verbose`                                                                                                          | Show remote URLs                                                        |
| `gra`                  | `git remote add`                                                                                                                | Add a remote repository                                                 |
| `grrm`                 | `git remote remove`                                                                                                             | Remove a remote repository                                              |
| `grmv`                 | `git remote rename`                                                                                                             | Rename a remote repository                                              |
| `grset`                | `git remote set-url`                                                                                                            | Change the URL of a remote repository                                   |
| `grup`                 | `git remote update`                                                                                                             | Fetch updates from all remotes                                          |
| `grh`                  | `git reset`                                                                                                                     | Reset current HEAD to the specified state                               |
| `gru`                  | `git reset --`                                                                                                                  | Reset paths in the working tree                                         |
| `grhh`                 | `git reset --hard`                                                                                                              | Reset working tree and index (discard changes)                          |
| `grhk`                 | `git reset --keep`                                                                                                              | Reset index and keep uncommitted changes in working tree                |
| `grhs`                 | `git reset --soft`                                                                                                              | Reset HEAD but keep changes staged                                      |
| `gpristine`            | `git reset --hard && git clean --force -dfx`                                                                                    | Reset and clean everything (including ignored files)                    |
| `gwipe`                | `git reset --hard && git clean --force -df`                                                                                     | Reset and clean untracked files and directories                         |
| `groh`                 | `git reset origin/$(git_current_branch) --hard`                                                                                 | Reset to origin's current branch (discard local changes)                |
| `grs`                  | `git restore`                                                                                                                   | Restore working tree files                                              |
| `grss`                 | `git restore --source`                                                                                                          | Restore from a specific source                                          |
| `grst`                 | `git restore --staged`                                                                                                          | Unstage files                                                           |
| `gunwip`               | `git rev-list --max-count=1 --format="%s" HEAD \| grep -q "--wip--" && git reset HEAD~1`                                        | Undo the last wip commit                                                |
| `grev`                 | `git revert`                                                                                                                    | Revert some existing commits                                            |
| `grm`                  | `git rm`                                                                                                                        | Remove files from the working tree and index                            |
| `grmc`                 | `git rm --cached`                                                                                                               | Remove files from index only (keep in working tree)                     |
| `gcount`               | `git shortlog --summary -n`                                                                                                     | Show commit counts per author                                           |
| `gsh`                  | `git show`                                                                                                                      | Show various types of objects                                           |
| `gsps`                 | `git show --pretty=short --show-signature`                                                                                      | Show commit with signature verification                                 |
| `gstall`               | `git stash --all`                                                                                                               | Stash all files (including ignored and untracked)                       |
| `gstu`                 | `git stash --include-untracked`                                                                                                 | Stash including untracked files                                         |
| `gstaa`                | `git stash apply`                                                                                                               | Apply a stash                                                           |
| `gstc`                 | `git stash clear`                                                                                                               | Clear all stashes                                                       |
| `gstd`                 | `git stash drop`                                                                                                                | Drop a stash                                                            |
| `gstl`                 | `git stash list`                                                                                                                | List stashes                                                            |
| `gstp`                 | `git stash pop`                                                                                                                 | Apply and drop a stash                                                  |
| `gsta`                 | On Git >= 2.13: `git stash push`                                                                                                | Create a stash                                                          |
| `gsta`                 | On Git < 2.13: `git stash save`                                                                                                 | Create a stash (older Git)                                              |
| `gsts`                 | `git stash show --patch`                                                                                                        | Show stash changes as a patch                                           |
| `gst`                  | `git status`                                                                                                                    | Show the working tree status                                            |
| `gss`                  | `git status --short`                                                                                                            | Show short status                                                       |
| `gsb`                  | `git status --short -b`                                                                                                         | Show short status with branch info                                      |
| `gsi`                  | `git submodule init`                                                                                                            | Initialize submodules                                                   |
| `gsu`                  | `git submodule update`                                                                                                          | Update submodules                                                       |
| `gsd`                  | `git svn dcommit`                                                                                                               | Commit to a Subversion repository                                       |
| `git-svn-dcommit-push` | `git svn dcommit && git push github $(git_main_branch):svntrunk`                                                                | Commit to SVN and push to GitHub                                        |
| `gsr`                  | `git svn rebase`                                                                                                                | Rebase with Subversion                                                  |
| `gsw`                  | `git switch`                                                                                                                    | Switch branches                                                         |
| `gswc`                 | `git switch -c`                                                                                                                 | Create and switch to a new branch                                       |
| `gswd`                 | `git switch $(git_develop_branch)`                                                                                              | Switch to the development branch                                        |
| `gswm`                 | `git switch $(git_main_branch)`                                                                                                 | Switch to the main branch                                               |
| `gta`                  | `git tag --annotate`                                                                                                            | Create an annotated tag                                                 |
| `gts`                  | `git tag -s`                                                                                                                    | Create a signed tag                                                     |
| `gtv`                  | `git tag \| sort -V`                                                                                                            | List tags sorted by version                                             |
| `gignore`              | `git update-index --assume-unchanged`                                                                                           | Tell Git to ignore changes to a file                                    |
| `gunignore`            | `git update-index --no-assume-unchanged`                                                                                        | Stop ignoring changes to a file                                         |
| `gwch`                 | `git whatchanged -p --abbrev-commit --pretty=medium`                                                                            | Show what changed with patches                                          |
| `gwt`                  | `git worktree`                                                                                                                  | Manage multiple working trees                                           |
| `gwtls`                | `git worktree list`                                                                                                             | List worktrees                                                          |
| `gwtmv`                | `git worktree move`                                                                                                             | Move a worktree                                                         |
| `gwtrm`                | `git worktree remove`                                                                                                           | Remove a worktree                                                       |
| `gk`                   | `gitk --all --branches &!`                                                                                                      | Launch gitk with all branches                                           |
| `gke`                  | `gitk --all $(git log --walk-reflogs --pretty=%h) &!`                                                                           | Launch gitk with reflog history                                         |
| `gtl`                  | `gtl(){ git tag --sort=-v:refname -n --list ${1}\* }; noglob gtl`                                                               | List tags matching a pattern                                            |

### Main branch preference

Following the recent push for removing racially-charged words from our technical vocabulary, the git plugin
favors using a branch name other than `master`. In this case, we favor the shorter, neutral and descriptive
term `main`. This means that any aliases and functions that previously used `master`, will use `main` if that
branch exists. We do this via the function `git_main_branch`.

### Deprecated aliases

These are aliases that have been removed, renamed, or otherwise modified in a way that may, or may not,
receive further support.

| Alias    | Command                                                   | Modification                                              |
| :------- | :-------------------------------------------------------- | :-------------------------------------------------------- |
| `gap`    | `git add --patch`                                         | New alias: `gapa`.                                        |
| `gcl`    | `git config --list`                                       | New alias: `gcf`.                                         |
| `gdc`    | `git diff --cached`                                       | New alias: `gdca`.                                        |
| `gdt`    | `git difftool`                                            | No replacement.                                           |
| `ggpull` | `git pull origin $(current_branch)`                       | New alias: `ggl`. (`ggpull` still exists for now though.) |
| `ggpur`  | `git pull --rebase origin $(current_branch)`              | New alias: `ggu`. (`ggpur` still exists for now though.)  |
| `ggpush` | `git push origin $(current_branch)`                       | New alias: `ggp`. (`ggpush` still exists for now though.) |
| `gk`     | `gitk --all --branches`                                   | Now aliased to `gitk --all --branches`.                   |
| `glg`    | `git log --stat --max-count=10`                           | Now aliased to `git log --stat --color`.                  |
| `glgg`   | `git log --graph --max-count=10`                          | Now aliased to `git log --graph --color`.                 |
| `gwc`    | `git whatchanged -p --abbrev-commit --pretty = medium`    | New alias: `gwch`.                                        |
| `gup`    | `git pull --rebase`                                       | now alias `gpr`                                           |
| `gupv`   | `git pull --rebase -v`                                    | now alias `gprv`                                          |
| `gupa`   | `git pull --rebase --autostash`                           | now alias `gpra`                                          |
| `gupav`  | `git pull --rebase --autostash -v`                        | now alias `gprav`                                         |
| `gupom`  | `git pull --rebase origin $(git_main_branch)`             | now alias `gprom`                                         |
| `gupomi` | `git pull --rebase=interactive origin $(git_main_branch)` | now alias `gpromi`                                        |

## Functions

### Current

| Command                  | Description                                                                                                     |
| :----------------------- | :-------------------------------------------------------------------------------------------------------------- |
| `current_branch`         | Returns the name of the current branch.                                                                         |
| `git_current_user_email` | Returns the `user.email` config value. (Lives in `lib/git.zsh`.)                                                |
| `git_current_user_name`  | Returns the `user.name` config value. (Lives in `lib/git.zsh`.)                                                 |
| `git_develop_branch`     | Returns the name of the “development” branch: `dev`, `devel`, `development` if they exist, `develop` otherwise. |
| `git_main_branch`        | Returns the name of the main branch: `main` if it exists, `master` otherwise.                                   |
| `grename <old> <new>`    | Renames branch `<old>` to `<new>`, including on the origin remote.                                              |
| `gbda`                   | Deletes all merged branches                                                                                     |
| `gbds`                   | Deletes all squash-merged branches (**Note: performance degrades with number of branches**)                     |

### Work in Progress (WIP)

These features allow you to pause developing one branch and switch to another one (_"Work in Progress"_, or
“wip”). When you want to go back to work, just “unwip” it.

| Command            | Description                                     |
| :----------------- | :---------------------------------------------- |
| `gwip`             | Commit wip branch                               |
| `gunwip`           | Uncommit wip branch                             |
| `gunwipall`        | Uncommit all recent `--wip--` commits           |
| `work_in_progress` | Echoes a warning if the current branch is a wip |

Note that `gwip` and `gunwip` are aliases, but are also documented here to group all related WIP features.

### Deprecated functions

| Command              | Description                             | Reason                                                           |
| :------------------- | :-------------------------------------- | :--------------------------------------------------------------- |
| `current_repository` | Return the names of the current remotes | Didn't work properly. Use `git remote -v` instead (`grv` alias). |
