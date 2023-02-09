#!/bin/sh

set -e

echo "Beginning installation of Spaced Out Spotify"
echo "https://github.com/The0n1y5pace4ce/spaced-out-spotify"

# Give time for user to cancel via CTRL+C
sleep 3s

# Check if ~\.spicetify-cli\Themes\spaced-out-spotify directory exists
spicePath=dirname "$(spicetify -c)"
themePath=dirname "$spicePath/Themes/spaced-out-spotify"
if [ ! -d $themePath ]; then
    echo "Creating Fluent theme folder..."
    mkdir -p $themePath
else
    # Remove pre-existing files, only keep the newest files
    rm -rfv "$themePath/*"
fi

# Download latest master
zipUri="https://github.com/Th0n1y5pace4ce/spaced-out-spotify/archive/refs/heads/master.zip"
zipSavePath="$themePath/spaced-out-spotify-master.zip"
echo "Downloading spaced-out-spotify latest master..."
curl --fail --location --progress-bar --output "$zipUri" "$zipSavePath"


# Extract theme from .zip file
echo "Extracting..."
unzip -d "$themePath" -o "$zipSavePath"
mv "$themePath/spaced-out-spotify-master/*" $themePath
rmdir "$themePath/spaced-out-spotify-master"

# Delete .zip file
echo "Deleting zip file..."
rm "$zipSavePath"

# Change Directory to the Theme Folder
cd $themePath

# Apply the theme with spicetify config calls
spicetify config current_theme spaced-out-spotify
echo "+ Configured Spaced Out theme"

spicetify apply
echo "+ Applied Theme"