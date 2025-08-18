1. Find your default tty login service (usually `getty@tty1.service`):

   ```bash
   sudo systemctl edit getty@tty1
   ```

2. Add this override (replace `yourusername` with your actual user):

   ```ini
   [Service]
   ExecStart=
   ExecStart=-/sbin/agetty --autologin yourusername --noclear %I $TERM
   ```

3. Save and exit, then reload systemd:

   ```bash
   sudo systemctl daemon-reexec
   ```

4. Now when you boot, you’ll be automatically logged in as your user on tty1.

5. To automatically start X/i3, add this to the end of your `~/.bash_profile` (or `~/.zprofile` if you use zsh):

   ```bash
   if [[ -z $DISPLAY ]] && [[ $(tty) == /dev/tty1 ]]; then
       exec startx
   fi
   ```

   Make sure your `~/.xinitrc` contains:

   ```bash
   exec i3
   ```
