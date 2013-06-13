DESCRIPTION
===========

A cookbook that installs and configures prezto, with some default settings

https://github.com/sorin-ionescu/prezto

## Requirements:

### Platform:

Tested on Ubuntu 12.04, but should work on most Debian and Red Hat derivatives and other *nix platforms.

### Cookbooks:

Depends on git and zsh. Suggested to use with users and user

If you are using chef-solo, add solo-search

## Attributes:

- _prezto[:theme]_ sets the prezto theme. (Default: "nicoulaj")
- _prezto[:repo]_ sets the repository to pull prezto from (Default: "https://github.com/sorin-ionescu/prezto.git")
- _prezto[:prezto_modules]_ sets the modules to load (Default: %w('environment' 'terminal' 'editor' 'history' 'directory' 'spectrum' 'utility' 'completion' 'prompt' 'command-not-found' 'dpkg'))
- _prezto[:editor]_ sets the key mapping style  settings (Default: "emacs")
- _prezto[:dotexpansion]_ sets the dotexpansion (Default: "yes")
- _prezto[:autotitle]_ sets the tab and window titles (Default: "yes")

## Usage

Any user data bag item with a shell set to zsh will have this recipe applied.
Per-user themes are set by including an +prezto-theme+ entry in a user data bag item.

The default recipe clones a copy of the git repository in each home directory once.
The "shared" recipe clones a single copy, links from each home directory
and syncs it each time chef runs.

## Credits

This cookbook is a fork of the oh-my-zsh cookbook by Heavy Water Software, and again a fork of another chef-prezto implementation.
Some parts are still left, but most has been changed.

Please fork, and do a pull request.
