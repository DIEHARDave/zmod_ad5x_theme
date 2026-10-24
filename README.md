# zmod_theme

A Mainsail theme for printers running [Zmod](https://github.com/ghzserg/zmod), installed as a plugin and kept up to date through the update manager.

| File | What it is |
| :--- | :--- |
| `theme/sidebar-logo.svg` | Logo at the top of the sidebar (Zmod's) |
| `theme/sidebar-background.png` | Sidebar background |
| `theme/main-background.png` | Page background |
| `theme/custom.css` | Zmod's dialog button fix; Zmod also checks for this file on boot |

Mainsail loads these from the hidden `.theme` folder in the config files and uses them straight away.

## Install

Add this to `mod_data/user.moonraker.conf`:

```ini
[update_manager zmod_theme]
type: git_repo
channel: stable
path: /root/printer_data/config/mod_data/plugins/zmod_theme
origin: https://github.com/DIEHARDave/zmod_theme.git
is_system_service: False
primary_branch: main
```

Then run `ENABLE_PLUGIN name=zmod_theme` in the console and reload Mainsail with Ctrl+F5. Zmod restarts Klipper's firmware after enabling a plugin, so don't enable it during a print.

## Uninstall

Run `DISABLE_PLUGIN name=zmod_theme`. Your previous theme comes back, or Zmod's default if you didn't have one.

## Your existing theme

The installer never deletes a theme. Zmod keeps the theme in `mod_data/.theme`. If that folder exists, it is moved to `mod_data/zmod_theme_backup/` before the plugin's theme goes in, and `DISABLE_PLUGIN` moves it back.

If you install again later and find a theme folder that isn't the plugin's, the first backup stays the one that gets restored. The newer folder is set aside next to it with the date added to its name.

## Files

| Path | What it is |
| :--- | :--- |
| `config/.theme` | Zmod's link to `mod_data/.theme`; left as it is. |
| `config/mod_data/.theme` | Link to this plugin's `theme/` folder. |
| `config/mod_data/zmod_theme_backup/` | The theme that was there before, if any. |

## License

GPL-3.0, see [LICENSE](LICENSE).
