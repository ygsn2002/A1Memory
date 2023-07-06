#
#Copyright (C) 2022-2023 OneB1ank
#
#This program is free module: you can redistribute it and/or modify
#it under the terms of the GNU General Public License as published by
#the Free Software Foundation, either version 3 of the License, or
#(at your option) any later version.
#
#This program is distributed in the hope that it will be useful,
#but WITHOUT ANY WARRANTY; without even the implied warranty of
#MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
#GNU General Public License for more details.
#
#You should have received a copy of the GNU General Public License
#along with this program. If not, see <http://www.gnu.org/licenses/>.
#

config_path="/sdcard/Android/HChai/HC_memory"
if [ "$ARCH" != "arm64" ]; then
  abort "Not compatible with this platform: $ARCH"
else
  ui_print "- Your platform can use A1 Memory"
fi

modify() {
    #焕晨提供
    device_config set_sync_disabled_for_tests persistent
    device_config put activity_manager max_cached_processes 2147483647
    device_config put activity_manager max_phantom_processes 2147483647
    settings put global activity_manager_constants max_cached_processes=2147483647
    settings put global activity_manager_constants max_phantom_processes=2147483647

    #虚进程
    settings put global settings_enable_monitor_phantom_procs false
    ui_print "- modify settings."
}

config() {
    [ ! -d "$config_path" ] && mkdir -p "$config_path"
    [ ! -f "$config_path/名单列表.conf" ] && cp "$MODPATH/config/HC_memory/名单列表.conf" "$config_path"
    rm "$MODPATH/config/HC_memory"
    ui_print "- update configuration"
}

modify
config
set_perm_recursive "$MODPATH" 0 0 0755 0777

ui_print "- Restart and enjoy A1 Memory immediately"