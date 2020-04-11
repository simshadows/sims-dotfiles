# Basic Linux Configuration

I set up my own new Linux systems fairly frequently. Each time, I end up using Google to re-learn the commands needed for certain things, and reconsulting manpages which, while awesome, are too packed with information for such minor repetitive tasks. After maybe the millionth new Linux system, I decided that enough is enough, and thus this document you see here.

**Please note: This cheatsheet generally reflects the Linux distrubutions that I use (Arch and Debian), and so may not be accurate for other systems and Linux distributions, or may even be outdated. As such, please exercise care. If you're unsure, please double-check this information with other sources, using this cheatsheet as a reference for further reading.**

*This cheatsheet's sections are sorted by order of when I need them in the process of setting up a new Linux system.*

## Locale Generation

First edit the `locale.gen` file by uncommenting `en_AU.UTF-8 UTF-8`:

```
vi /etc/locale.gen
```

Then, run the commands:

```
locale-gen
localectl set-locale LANG="en_AU.UTF-8"
```

## Hostname

```
hostnamectl set-hostname <<new_host_name>>
```

## Preventing unauthorized `root` access

#### Ensure `root`'s password is locked

Consult the subsection *Locking a User's Password* for more information.

IMPORTANT: Please make sure `root`'s encrypted password field in `/etc/shadow` is *not blank*. A blank field means anyone can log in as `root` without a password!`

#### Ensure `root` cannot log in by SSH.

To disable `root` login via SSH, ensure `PermitRootLogin` in `/etc/ssh/sshd_config` is set to `no`:

```
PermitRootLogin no
```

## User Management

When starting from a ready-to-use OS image, there is usually an "initial user" (such as `alarm` for Arch Linux ARM). However, you can't change username if the user is logged in (or simply running a process).

Without another user to log into, my preferred method for having my desired username is to make a temporary user to change the initial user's name.

My next preferred method is making a new user with my desired username, then deleting the initial user. However, deleting the initial user may cause referential issues.

I don't like making the `root` user temporarily enabled because of the chance of an accidental critical misconfiguration. On the other hand, misconfiguring a normal user is more likely to be contained.

#### Adding a New User

```
# useradd -m -G wheel -s /bin/bash newuser
```

Creates user `newuser`.

`-m` - Creates the home directory<br>
`-G wheel` - Adds the user to group `wheel`<br>
`-s /bin/bash` - Sets the login shell to `/bin/bash`

#### Adding a New System User

```
# useradd -r -s /sbin/nologin newsystemuser
```

Creates user `newsystemuser`.

`-r` - The new user is a system account (see `man useradd` for specific details)<br>
`-s /sbin/nologin` - Sets the login shell to `/bin/nologin`

The `/sbin/nologin` shell helps reduce user access.

#### Deleting a User

```
# userdel -r olduser
```

Deletes user `olduser`.

`-r` - Removes the user's home directory and mail spool.

IMPORTANT: Ensure you don't lock yourself out by accidentally deleting the last user that has sudo privileges.

#### Changing Username

Run the following commands:

```
# usermod -d /home/newname -m -l newname oldname
# groupmod -n newname oldname
```

The first command renames user `oldname` to `newname`.

`-d /home/newname -m` - Changes the home directory to `/home/newname`, and moves the original home directory to it.<br>
`-l newname` - Changes the username to `newname`.

The second command renames the user's self-group. (This isn't necessary though.)

#### Locking a User's Password

The following command will lock the password of  `user`:

```
# usermod -L user
```

Accounts with locked passwords cannot be logged into normally by a user. An account's password is locked if the encrypted password field in `/etc/shadow` contains an invalid character (typically \* or `!`). Example of `root`'s password locked:

```
root:*:17416:0:99999:7:::
```

IMPORTANT: A blank encrypted password field means *no password is required to log into the account*, though some programs may not permit logging into these accounts. Example of `root` with a blank password:

```
root::17416:0:99999:7:::
```

IMPORTANT: It is worth reiterating again: Please make sure `root`'s password is locked, and not blank!

IMPORTANT: Locking the user's password does not lock the account from login through other means (such as SSH private key authentication).

## Group Management

#### View Group Membership

```
$ groups <<user>>
```

#### Creating a group

```
# groupadd <<group_name>>
```

#### Renaming a group

```
# groupmod -n <<new_group_name>> <<group_name>>
```

`-n <<new_group_name>>` - The group's name will be changed to `<<new_group_name>>`.

#### Adding a User to a Group

```
# gpasswd -a <<user>> <<group>>
```

`-a <<user>>` - Add `<<user>>` to the group.

#### Removing a User from a Group

```
# gpasswd -d <<user>> <<group>>
```

`-d <<user>>` - Remove `<<user>>` from the group.

IMPORTANT: Effects take effect the next time `<<user>>` logs in.

## Manage sudoers

Check/edit the sudoers file with:

```
# visudo
```

IMPORTANT: Check with distro documentation (or sudofile comments) prevent accidentally locking yourself out during system upgrades.

#### `sudo` groups

*TODO*

#### Enabling individual users

*TODO*

## SSH

#### Generate RSA Key

```
ssh-keygen -t rsa -b 4096 -C "<<comment>>"
```

`-t rsa` - The type of key is RSA.<br>
`-b 4096` - 4096-bit key. (This is currently the recommended maximum key size.)
`-C "<<comment>>"` - Adds a comment to the key.

