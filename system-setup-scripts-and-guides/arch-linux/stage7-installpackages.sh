#!/usr/bin/env sh

# Terminate script on error
set -e

# Empty array.
a=()

###########################################################


#
# Essentials
#
a+=( base-devel     )
a+=( git            )
a+=( tmux           )


#
# Core CLI and minimalist GUI applications
#
a+=( gvim              ) # CLI text editor
a+=( ranger            ) # CLI file manager
a+=( lynx              ) # CLI web browser
a+=( feh               ) # minimalist image viewer
a+=( zathura           ) # minimalist document viewer
a+=( zathura-pdf-mupdf ) # zathura mupdf plugin in order to view PDFs!
a+=( lazygit           ) # CLI git helper
#
# (NOTE: 'gvim' is installed since 'vim' annoyingly lacks clipboard support.)
#


#
# Core Full Graphical Applications
#
a+=( code      ) # text editor
a+=( chromium  ) # web browser
a+=( keepassxc ) # password manager
a+=( vlc       ) # media player


#
# Core Development Tools
#
a+=( ctags      ) # code indexing
a+=( gdb        ) # GNU debugger
a+=( lldb       ) # LLVM debugger
a+=( valgrind   ) # memory debugger (e.g. for mysterious segfaults)
a+=( strace     ) # for debugging interactions between a process and the kernel
a+=( python     ) # Python language tooling
a+=( python-pip ) # Python pip package manager


#
# Additional Development Tools
#
a+=( ruby   ) # Ruby language tooling
a+=( nodejs ) # Node Javascript language runtime
a+=( npm    ) # Node package manager


#
# Offline Documentation
#
a+=( arch-wiki-docs ) # the entire Arch wiki


###########################################################


#
# Fonts
#
a+=( adobe-source-code-pro-fonts )


###########################################################


#
# Common CLI Utilities
#
a+=( wget       ) # simple web content retriever
a+=( netcat     ) # network utility
a+=( lsof       ) # lists all open files
a+=( tree       ) # recursive directory lister
a+=( zip        ) # zip archive utility for compressing
a+=( unzip      ) # zip archive utility for uncompressing
a+=( xclip      ) # clipboard cli interface, useful for tmux
a+=( htop       ) # a much more useful process monitor
a+=( dos2unix   ) # converts between unix-style and dos-style line breaks
a+=( dosfstools ) # dos filesystems
a+=( ntfs-3g    ) # ntfs filesystem
a+=( dnsutils   ) # DNS utilities (such as dig)


#
# Other Useful Utilities
#
a+=( scrot             ) # makes screenshots
a+=( nmap              ) # maps the network, e.g. ping/port scans
a+=( sshfs             ) # for mounting remote directories over SSH
a+=( weechat           ) # irc client
a+=( rtorrent          ) # bittorrent client
a+=( p7zip             ) # 7zip POSIX port
a+=( texlive-most      ) # latex distribution   (WARNING: Large install.)
a+=( biber             ) # latex reference management
a+=( texstudio         ) # latex IDE
a+=( libreoffice-still ) # libreoffice, stable branch   (WARNING: Large install.)
a+=( obs-studio        ) # screen recording


#
# Might also be useful
#
a+=( screenfetch ) # prints basic system info in a pretty form


###########################################################


#
# Domain Specific: Security
#
#a+=( bless    ) # GUI hex editor (TODO: Seems to be in the AUR now.)
a+=( steghide ) # steganography program to hide or extract info in image/audio files
a+=( yara     ) # (TODO: idk how to describe this one lol)


###########################################################

# Start installation of all specified packages!
pacman -Sy "${a[@]}"
