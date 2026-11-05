# Living Room Home

An Apple TV-style home screen for an LG 43UR7550PSC (webOS 25). It has a large title section that follows the selected
app, a glass dock of favourite apps, a row of inputs and system tiles, tilt-on-focus, hold-OK-to-rearrange
(saved on the TV), a Control Center and an About screen for the TV.

It runs as a normal webOS app called **Home**. webOS doesn't let a third-party app replace the TV's own home
screen, so pin it to the front of the app bar.

## What's in the repo

| Path | What it is |
|---|---|
| `src/app.html` | The source. Edit this file. |
| `build.sh` | Wraps the source into `webos/index.html` |
| `webos/` | The webOS app: `appinfo.json`, icons, `index.html` |
| `dist/com.methika.tvhome_1.0.0_all.ipk` | Ready-to-install package |

## Install on the TV

You need the TV and a computer (Windows, macOS or Linux) on the same Wi-Fi network, plus Node.js 18 or newer
on the computer.

### 1. Put the TV in Developer Mode

1. Create a free LG developer account at https://webostv.developer.lge.com (Sign in › Create account).
2. On the TV, open **LG Content Store** (Apps), search for **Developer Mode** and install it.
3. Open **Developer Mode** on the TV and sign in with that LG developer account.
4. Turn **Dev Mode Status** on. The TV restarts.
5. Open **Developer Mode** again and turn **Key Server** on. Write down the **IP address** and the
   **passphrase** it shows (6 characters, for example `A1B2C3`).

### 2. Set up the computer

Install the LG webOS command-line tools:

```bash
npm install -g @webos-tools/cli
```

On a Mac, if that fails with `EACCES: permission denied`, your Node.js was installed for all users and npm
can't write to `/usr/local` without admin rights. Point npm at a folder in your home directory instead, then
run the install again:

```bash
mkdir -p ~/.npm-global && npm config set prefix ~/.npm-global
```

```bash
echo 'export PATH="$HOME/.npm-global/bin:$PATH"' >> ~/.zshrc && source ~/.zshrc
```

```bash
npm install -g @webos-tools/cli
```

Get the project:

```bash
git clone https://github.com/BitrockMethika/lg-tv-home.git
```

```bash
cd lg-tv-home
```

### 3. Connect the computer to the TV

Add the TV. When asked, choose **add**, name it `tv`, enter the TV's IP address, keep port `9922` and user
`prisoner`, and leave the password empty:

```bash
ares-setup-device
```

Download the TV's key. Enter the passphrase from the Developer Mode app when asked:

```bash
ares-novacom --device tv --getkey
```

Check the connection. It should list the TV's details:

```bash
ares-device --device tv --system-info
```

### 4. Install and open the app

```bash
ares-install --device tv dist/com.methika.tvhome_1.0.0_all.ipk
```

```bash
ares-launch --device tv com.methika.tvhome
```

On the TV, press the Home button, find **Home** in the app bar, and move it to the front (hold OK on it
and choose Move, or use Edit at the end of the bar).

### Keep it working

Developer Mode expires after 1,000 hours. Open the **Developer Mode** app on the TV and choose
**Extend** before it runs out. If it expires, the app is removed; repeat step 4 to put it back.

## Using it with the Magic Remote

| Button | Action |
|---|---|
| Arrows | Move between apps |
| OK | Open the app |
| Hold OK (or press and hold with the pointer) | Rearrange: arrows move the app, OK drops it |
| Red | Control Center: inputs, TV information, edit, Reduce Transparency, Settings |
| Back | Close a panel, or go back to the dock |

If scrolling feels slow, turn on **Reduce Transparency** in Control Center. It switches off the background blur.

## Changing the apps

The app list is `APPS` near the top of the script in `src/app.html`. Each entry has the webOS app `id` and a
`match` pattern used to find the app by name if the id is different on your TV. Apps that can't be found
show a "Not installed" badge.

To see the ids of the apps installed on your TV:

```bash
ares-install --device tv --list
```

After editing, rebuild, repackage and reinstall:

```bash
./build.sh
```

```bash
ares-package webos -o dist
```

```bash
ares-install --device tv dist/com.methika.tvhome_1.0.0_all.ipk
```

## Preview on a computer

Open `webos/index.html` in Chrome. Use the arrow keys, Enter, hold Enter, C for Control Center and Esc for back.
On a computer, opening an app shows a message naming the app instead of launching it.

## Notes

- App tiles use plain text wordmarks in each service's colours, not the official logos.
- The TV information screen shows model, webOS version, power-on hours and storage. When running on the TV,
  model and version are read live; the rest were copied from the TV's settings on 5 Nov 2026.
