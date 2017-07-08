# PlistUtil
A Perl module to edit, convert Plist file to JSON and vice versa.

Prerequisites:-

This module uses JSON module. Use following commands to install JSON module.

1.If you have Homebrew installed in your machine.
  brew install cpanm
    or 
2.sudo cpanm install JSON

This module uses 'plutil' command(built-in in OSX) to convert plist to JSON and viceversa.
Linux user have alternate for plutil called plistutil.
Install 'plistutil' from you package manager and replace 'plutil' to 'plistutil' in this module.

Ubuntu users can install using the command: sudo apt-get install libplist-utils
