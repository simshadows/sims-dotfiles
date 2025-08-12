# Windows

I can't really be bothered trying to script a Windows system configuration, so we're just going with a step-by-step guide.

## Windows settings

### Turn off "Fast Startup"

I always turn off *Fast Startup*. It's a feature that's meant to speed up reboot by saving the contents of memory on disk on shutdown. I find it can cause issues sometimes (and ALWAYS causes issues on my Ryzen 9950X3D system for some reason, so I'd have to turn on the computer and then reboot before using the computer).

As of 2025-08-08, you can turn it off in Windows 11 by going Control Panel > Hardware and Sound > Power Options, and turn off *Turn on fast startup (recommended)*.

## Installing software

See `choco-install-packages.ps1`.
