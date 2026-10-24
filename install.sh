#!/bin/sh
# zmod_ad5x_theme installer. Run by Zmod's ENABLE_PLUGIN; safe to run again.
#
# Mainsail loads its theme from config/.theme, which Zmod keeps as a link to
# mod_data/.theme. That folder becomes a link to this plugin's theme/, so
# updates arrive through the update manager. Whatever was in it before is
# moved to mod_data/zmod_ad5x_theme_backup and put back by uninstall.sh.

MOD_DATA="/opt/config/mod_data"
THEME="${MOD_DATA}/.theme"
TARGET="plugins/zmod_ad5x_theme/theme"
BACKUP_DIR="${MOD_DATA}/zmod_ad5x_theme_backup"

# Zmod's printer settings; AD5X is 1 only on the AD5X.
. /opt/config/mod/.shell/0.sh
if [ "${AD5X}" != 1 ]; then
    echo "zmod_ad5x_theme: this theme is for the AD5X only; nothing changed."
    echo "zmod_ad5x_theme: run DISABLE_PLUGIN name=zmod_ad5x_theme to remove it."
    exit 1
fi

if [ "$(readlink "$THEME")" = "$TARGET" ]; then
    echo "zmod_ad5x_theme: already installed"
else
    mkdir -p "$BACKUP_DIR"
    if [ -e "$THEME" ] || [ -L "$THEME" ]; then
        if [ -e "${BACKUP_DIR}/.theme" ] || [ -L "${BACKUP_DIR}/.theme" ]; then
            # The older backup is the theme from before the first install;
            # keep it as the one to restore and set this one aside with a date.
            aside="${BACKUP_DIR}/.theme.$(date +%Y%m%d_%H%M%S)"
            mv "$THEME" "$aside"
            echo "zmod_ad5x_theme: existing theme moved to $aside"
        else
            mv "$THEME" "${BACKUP_DIR}/.theme"
            echo "zmod_ad5x_theme: existing theme backed up to ${BACKUP_DIR}/.theme"
        fi
    fi
    # Relative, so it resolves both on the printer and inside Zmod's chroot.
    ln -sfn "$TARGET" "$THEME"
    echo "zmod_ad5x_theme: installed"
fi

# Zmod sets this link on boot; set it now so the theme shows without one.
[ "$(readlink /opt/config/.theme)" = "mod_data/.theme" ] || ln -sfn mod_data/.theme /opt/config/.theme

echo "zmod_ad5x_theme: reload Mainsail in your browser (Ctrl+F5)"
