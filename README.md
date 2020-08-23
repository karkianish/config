# config
This repo contains scripts to set up new windows 10 machine to match my personal preference.

`set-executionpolicy remotesigned -scope currentuser`

`iwr -useb get.scoop.sh | iex`

`scoop install git-with-openssh`

-- must be cloned to the path repos/config because its hard coded in the script to look there
`git clone "https://github.com/karkianish/config.git" "$env:userprofile/repos/config"`

`$env:userprofile/repos/config/configure`

There are still a few things that needs to be completed manually:
- install visual studio community
- install adobe reader
- connect with github via ssh
