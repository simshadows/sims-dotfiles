# Debian - Podman Server

# Step 1: Debian installer image

Go through the full Debian installer as usual. It's a very quick and simple process.

Some specific things you need to do:
- In the software selection screen, unselect everything. (We want a minimal base to keep the server lightweight and minimize the attack surface.)

*Note: My commands and scripts assume that you created a user named `simshadows` during this installation process. If you wish to set up a different username, just change the username in the scripts.*

# Step 2: Post-installation steps

Boot up the system, log in as root, and run these commands:

```bash
apt update
apt upgrade
apt dist-upgrade
apt install sudo git podman
usermod -a -G sudo simshadows
```

Double-check that nftables is set up and check what it has set up:

```bash
nft --version
cat /etc/nftables.conf
systemctl status nftables.service
```

If nftables isn't running, you may need to explicitly enable:

```bash
systemctl enable --now nftables.service
```

Log out:

```bash
logout
```

Log back in as `simshadows`, then run these commands:

```bash
mkdir ~/git-core
cd ~/git-core
git clone https://github.com/simshadows/sims-dotfiles.git dotfiles
cd dotfiles/system-setup-scripts-and-guides/debian-linux-podman-server
```

# Step 3: Set up the containers

This depends on how you manage your containers.

At the moment, I have a private repository with podman kubernetes pod manifests, config files, and scripts that create directories and run the manifests.

I plan on eventually making these files public, but I'll need to audit these files for what's appropriate to expose publicly.
