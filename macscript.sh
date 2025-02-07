#!/bin/bash
FLAG_FILE=~/Documents/dependencies_have_been_installed_DO_NOT_DELETE
LINUX_FLAG_FILE=~/Documents/updates_and_dependencies_have_been_installed_DO_NOT_DELETE
if [ "$(id -u)" -ne 0 ]; then echo "Please run as root." >&2; exit 1; fi
# Function to display submenu 1
function palera1n {
if [[ $(uname) == "Linux" ]]; then
    if [ -f "$LINUX_FLAG_FILE" ]; then
        echo "Flag file found. Skipping code that should only run once."
    else
        echo "Flag file not found. Running code that should only run once."
    sudo mkdir /usr/bin/
    sudo apt update
    sudo apt upgrade -y
    sudo apt install curl wget usbmuxd jq -y
    #sudo curl -L -k https://github.com/palera1n/palera1n/releases/download/v2.0.0-beta.6.2/palera1n-linux-$(uname -m) -o /usr/bin/palera1n
    sudo chmod +x /usr/bin/palera1n
    url=$(curl -s 'https://api.github.com/repos/palera1n/palera1n/releases' | jq --arg uname "$(uname -m)" -r '.[0].assets[] | select(.name == "palera1n-linux-\($uname)") | .browser_download_url')
    sudo curl -L -k "$url" -o /usr/bin/palera1n
    # Create the flag file
    sudo touch "$LINUX_FLAG_FILE"
    fi
    #url=$(curl -s 'https://api.github.com/repos/palera1n/palera1n/releases' | jq --arg uname "$(uname -m)" -r '.[0].assets[] | select(.name == "palera1n-linux-\($uname)") | .browser_download_url')
    #sudo curl -L -k "$url" -o /usr/bin/palera1n
    #echo "$url"
    PS3='Please enter your choice: '
    echo "Please note that the palera1n team or me is not liable for any damage you may cause to your device, use at your own risk, you should take a backup of the device before jailbreaking"
    options=("Setup FakeFS" "Rootful" "Setup BindFS" "BindFS" "Rootless" "Safe Mode" "DFU Helper" "Enter Recovery Mode" "Exit Recovery Mode" "Quit")
    select opt in "${options[@]}"
    do
        case $opt in
            "Setup FakeFS")
                /usr/bin/palera1n -f -c -V
                ;;
            "Rootful")
                /usr/bin/palera1n -f -V
                ;;    
            "Setup BindFS")
                /usr/bin/palera1n -B -f -V
                ;;
            "BindFS")
                /usr/bin/palera1n -B -V
                ;;
            "Rootless")
                /usr/bin/palera1n -V
                ;;
            "Safe Mode")
                /usr/bin/palera1n -s -V
                ;;
            "DFU Helper") 
                /usr/bin/palera1n -D 
                ;;
            "Enter Recovery Mode")
                /usr/bin/palera1n -E
                ;;
            "Exit Recovery Mode")
               /usr/bin/palera1n -n
               ;;
            "Restore RootFS (Rootful)")
               /usr/bin/palera1n --force-revert -f
               ;;
            "Restore RootFS (Rootless)")
               /usr/bin/palera1n --force-revert
               ;;     
            "Quit")
                exit
                ;;
            *) echo "invalid option $REPLY";;
        esac
    done
elif [[ $(uname) == "Darwin" ]]; then
    if [ -f "$FLAG_FILE" ]; then
        echo "Flag file found. Skipping code that should only run once."
    else
        echo "Flag file not found. Running code that should only run once."
        echo "Installing pip dependencies..."
    if [[ $(echo "$macos_version >= 12.2.1" | bc -l) -eq 0 ]]; then
        sudo python -m ensurepip
        sudo python -m pip install setuptools xattr==0.6.4
    fi   

    # Create the flag file
    touch "$FLAG_FILE"
    fi
    sudo mkdir -p /usr/local/bin
    echo "Downloading palera1n"        
    sudo curl -L -k https://github.com/palera1n/palera1n/releases/download/v2.0.0-beta.6.2/palera1n-macos-universal -o /usr/local/bin/palera1n
    sudo chmod +x /usr/local/bin/palera1n
    PS3='Please enter your choice: '
    echo "Please note that the palera1n team or me is not liable for any damage you may cause to your device, use at your own risk, you should take a backup of the device before jailbreaking"
    options=("Setup FakeFS" "Rootful" "Setup BindFS" "BindFS" "Rootless" "Safe Mode" "DFU Helper" "Enter Recovery Mode" "Exit Recovery Mode" "Restore RootFS (Rootful)" "Restore RootFS (Rootless)" "Quit")
    select opt in "${options[@]}"
    do
        case $opt in
            "Setup FakeFS")
                /usr/local/bin/palera1n -f -c -V
                ;;
            "Rootful")
                /usr/local/bin/palera1n -f -V
                ;;    
            "Setup BindFS")
                /usr/local/bin/palera1n -B -f -V
                ;;
            "BindFS")
                /usr/local/bin/palera1n -V -f -B
                ;;
            "Rootless")
                /usr/local/bin/palera1n -V
                ;;
            "Safe Mode")
                /usr/local/bin/palera1n -s -V
                ;;
            "DFU Helper") 
                /usr/local/bin/palera1n -D 
                ;;
            "Enter Recovery Mode")
                /usr/local/bin/palera1n -E
                ;;
            "Exit Recovery Mode")
               /usr/local/bin/palera1n -n
               ;;
            "Restore RootFS (Rootful)")
               /usr/local/bin/palera1n --force-revert -f
               ;;
            "Restore RootFS (Rootless)")
              /usr/local/bin/palera1n --force-revert
              ;;
            "Quit")
                exit
                ;;
            *) echo "invalid option $REPLY";;
        esac
    done
    else
    echo "Unknown Operation system, Exiting..."
    exit
    fi
#iOS Part
if [[ $(dpkg --print-architecture) == "iphoneos-arm" ]]; then #This part is also taken from azaz, thank you!
    cd /var/mobile/Documents
    curl -L -k https://github.com/palera1n/palera1n/releases/download/v2.0.0-beta.6.2/palera1n_2.0.0-beta.6_$(dpkg --print-architecture) -o palera1n.deb
    echo "This may ask for your password, the default password is alpine unless you changed it"
    sudo dpkg -i palera1n.deb
    rm palera1n.deb
elif [[ $(dpkg --print-architecture) == "iphoneos-arm64" ]]; then
    cd /var/mobile/Documents
    curl -L -k https://github.com/palera1n/palera1n/releases/download/v2.0.0-beta.6.2/palera1n_2.0.0-beta.6_$(dpkg --print-architecture) -o palera1n.deb
    echo "This may ask for your password, the default password is alpine unless you changed it"
    sudo dpkg -i palera1n.deb
    rm palera1n.deb
else
 echo "The current operating system has been detected as not being iOS, continuing..."
fi
}

# Function to display checkra1n 2
function checkra1n {
    if [[ $(uname) == "Linux" ]]; then
        if [ -f "$LINUX_FLAG_FILE" ]; then
            echo "Flag file found. Skipping code that should only run once."
            else
            echo "Flag file not found. Running code that should only run once."
            sudo mkdir /usr/bin
            if [[ $(uname -m) == "x86_64" ]]; then
                sudo curl -L -k https://assets.checkra.in/downloads/linux/cli/x86_64/dac9968939ea6e6bfbdedeb41d7e2579c4711dc2c5083f91dced66ca397dc51d/checkra1n -o /usr/bin/checkra1n
            elif [[ $(uname -m) == "arm" ]]; then
                sudo curl -L -k https://assets.checkra.in/downloads/linux/cli/arm/ff05dfb32834c03b88346509aec5ca9916db98de3019adf4201a2a6efe31e9f5/checkra1n -o /usr/bin/checkra1n
            elif [[ $(uname -m) == "arm64" ]]; then
                sudo curl -L -k https://assets.checkra.in/downloads/linux/cli/arm64/43019a573ab1c866fe88edb1f2dd5bb38b0caf135533ee0d6e3ed720256b89d0/checkra1n -o /usr/bin/checkra1n
            elif [[ $(uname -m) == "i486" ]]; then
                sudo curl -L -k https://assets.checkra.in/downloads/linux/cli/i486/77779d897bf06021824de50f08497a76878c6d9e35db7a9c82545506ceae217e/checkra1n -o /usr/bin/checkra1n
            elif [[ $(uname -m) == "armv7l" ]]; then
                sudo curl -L -k https://assets.checkra.in/downloads/linux/cli/arm/ff05dfb32834c03b88346509aec5ca9916db98de3019adf4201a2a6efe31e9f5/checkra1n -o /usr/bin/checkra1n 
            else
                echo "Unsupported operating system"
                exit
            fi
              echo "Please note that the checkra1n team or me is not viable for any damage you might cause to your device"
              echo "In this next screen, you need to enable untested iOS versions if you are on an iOS version higher than 14.5.1"
              while [[ ! "$choice" =~ ^[yYnN]$ ]]
          do
              read -p "Do you want to continue? (Y/n) " choice
          done
              # Handle user input
          case "$choice" in
              y|Y)
                  echo "Continuing..."
                ;;
            n|N)
                echo "Exiting..."
                exit
                ;;
        esac
            sudo chmod +x /usr/bin/checkra1n
            sudo /usr/bin/checkra1n -t -V

            # Create the flag file
            touch "$LINUX_FLAG_FILE"
        fi
    fi
    if [[ $(uname) == "Darwin" ]]; then
        sudo curl -L -k https://assets.checkra.in/downloads/macos/754bb6ec4747b2e700f01307315da8c9c32c8b5816d0fe1e91d1bdfc298fe07b/checkra1n%20beta%200.12.4.dmg -o /usr/local/bin/checkra1n.dmg
        sudo hdiutil attach /usr/local/bin/checkra1n.dmg
        # Prompt user for input
        echo "In this next screen, you need to enable untested iOS versions if you are on an iOS version higher than 14.5.1"
        echo "Please note that the checkra1n team or me is not viable for any damage you might cause to your device"
        read -p "Do you want to continue? (y/n) " choice

        # Loop to handle invalid input
        while [[ ! "$choice" =~ ^[yYnN]$ ]]
        do
            read -p "Please enter y or n: " choice
        done

            # Handle user input
        case "$choice" in
            y|Y)
                echo "Continuing..."
                    sudo /Volumes/checkra1n\ beta\ 0.12.4\ 1/checkra1n.app/Contents/MacOS/checkra1n -V -t 
                ;;
            n|N)
                echo "Exiting..."
                exit
                ;;
        esac
    fi
    sudo hdiutil detach /Volumes/checkra1n\ beta\ 0.12.4\ 1/
}

function apt-procursus {
        if [[ $(uname) == "Darwin" ]]; then
            read -p "Do you want to bootstrap procursus and install apt? (y/n)" awnser
        if [[ $awnser =~ ^[yY]$ ]]; then
            echo "Bootstrapping procursus and installing apt, please wait..."
        if [[ $(uname -m) == "arm64" ]]; then
            curl -L https://apt.procurs.us/bootstraps/big_sur/bootstrap-darwin-arm64.tar.zst -o bootstrap.tar.zst
        else
            curl -L https://apt.procurs.us/bootstraps/big_sur/bootstrap-darwin-amd64.tar.zst -o bootstrap.tar.zst
        fi
        curl -LO https://cameronkatri.com/zstd
        chmod +x zstd
        ./zstd -d bootstrap.tar.zst
        sudo rm -rfv /opt/procursus
        sudo tar -xpkf bootstrap.tar -C /
        sudo mv zstd /opt/procursus/bin/zstd
        printf 'export PATH="/opt/procursus/bin:/opt/procursus/sbin:/opt/procursus/games:$PATH"\nexport CPATH="$CPATH:/opt/procursus/include"\nexport LIBRARY_PATH="$LIBRARY_PATH:/opt/procursus/lib"\n' | sudo tee -a /etc/zshenv /etc/profile 
        export PATH="/opt/procursus/bin:/opt/procursus/sbin:/opt/procursus/games:$PATH"
        export CPATH="$CPATH:/opt/procursus/include"
        export LIBRARY_PATH="$LIBRARY_PATH:/opt/procursus/lib"
        echo >> ~/.zprofile #this fix for apt on macos was taken from azaz, thank you!
        echo PATH="/opt/procursus/bin:/opt/procursus/sbin:/opt/procursus/games:$PATH" >> ~/.zprofile
        echo CPATH="$CPATH:/opt/procursus/include" >> ~/.zprofile
        echo PATH="/opt/procursus/bin:/opt/procursus/sbin:/opt/procursus/games:$PATH" >> ~/.zprofile
        echo CPATH="$CPATH:/opt/procursus/include" >> ~/.zprofile
        echo LIBRARY_PATH="$LIBRARY_PATH:/opt/procursus/lib" >> ~/.zprofile
        echo export PATH >> ~/.zprofile
        echo export CPATH >> ~/.zprofile
        echo export LIBRARY_PATH >> ~/.zprofile
        source ~/.zprofile
        #update and install sileo
        sudo apt update
        sudo apt full-upgrade -y --allow-downgrades
        sudo apt install sileo -y
        rm bootstrap.tar.zst bootstrap.tar
        echo "Installation Complete! Be sure to restart your terminal!"
            fi
        fi
}

if [[ $(uname) == "Darwin" ]]; then
    echo "Pick what you want to do"
PS3='Please enter your choice: '
options=("palera1n" "checkra1n" "Install APT on macOS" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "palera1n")
            palera1n
            ;;
        "checkra1n")
            checkra1n
            ;;
        "Install APT on macOS")
            apt-procursus
            ;;
        "Quit")
            exit
            ;;
        *) echo "Invalid option";;
    esac
done
else
# Main menu
echo "Pick what you want to do"
PS3='Please enter your choice: '
options=("palera1n" "checkra1n" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "palera1n")
            palera1n
            ;;
        "checkra1n")
            checkra1n
            ;;
        "Quit")
            break
            ;;
        *) echo "Invalid option";;
    esac
done
fi