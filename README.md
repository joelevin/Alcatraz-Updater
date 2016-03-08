# Alcatraz-Updater
Updates Alcatraz plugins to be compatible with new releases of Xcode.

Often when Xcode is upated, it also bumps the UUID of the binary.  Your Alcatraz plugins rely on that UUID to be recognized by Xcode.  Maintainers of the plugin should update these UUIDs so their plugins are compatible with the latest release of Xcode, but sometimes they are slow or have abandoned the plugin.  You could find and modify the UUID yourself, but this script automates the process for each plugin in your plugins directory.
