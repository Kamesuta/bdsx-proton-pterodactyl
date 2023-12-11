#!/bin/bash

# Make sure we're in the correct dir
cd /home/container/

# Create Directories and Enviroment Variables for Proton
export STEAM_COMPAT_CLIENT_INSTALL_PATH="/home/container/.steam/steam"
export STEAM_COMPAT_DATA_PATH="/home/container/.steam/steam/steamapps/compatdata/0"
mkdir -p $STEAM_COMPAT_DATA_PATH

# Register Alias to replace wine with proton
mkdir -p /home/container/.steam/alias
echo -e "#!/bin/bash\n\nproton run \$@" > /home/container/.steam/alias/wine
chmod +x /home/container/.steam/alias/wine
export PATH="/home/container/.steam/alias:$PATH"

# Replace Startup Variables
MODIFIED_STARTUP=`eval echo $(echo ${STARTUP} | sed -e 's/{{/${/g' -e 's/}}/}/g')`
echo ":/home/container/$ ${MODIFIED_STARTUP}"

# Run the Server
${MODIFIED_STARTUP}
