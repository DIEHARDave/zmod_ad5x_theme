#!/bin/sh
# Run by Zmod's DISABLE_PLUGIN. Puts back the theme that install.sh backed
# up, or Zmod's default theme if there wasn't one.

MOD_DATA="/opt/config/mod_data"
THEME="${MOD_DATA}/.theme"
TARGET="plugins/zmod_theme/theme"
BACKUP_DIR="${MOD_DATA}/zmod_theme_backup"

[ "$(readlink "$THEME")" = "$TARGET" ] && rm -f "$THEME"

if [ -e "$THEME" ] || [ -L "$THEME" ]; then
    # Something other than this plugin's link is in place; don't overwrite it.
    echo "zmod_theme: $THEME was replaced after install; kept it."
    [ -e "${BACKUP_DIR}/.theme" ] && echo "zmod_theme: the old one is still in ${BACKUP_DIR}/.theme"
elif [ -e "${BACKUP_DIR}/.theme" ] || [ -L "${BACKUP_DIR}/.theme" ]; then
    mv "${BACKUP_DIR}/.theme" "$THEME"
    echo "zmod_theme: restored the previous theme"
else
    # Zmod would copy its default back on the next boot; do it now.
    cp -a /opt/config/mod/.shell/.theme "$MOD_DATA/"
    echo "zmod_theme: restored Zmod's default theme"
fi

# Leaves the folder if it still holds a set-aside theme.
rmdir "$BACKUP_DIR" 2> /dev/null

echo "zmod_theme: removed. Reload Mainsail in your browser (Ctrl+F5)"
