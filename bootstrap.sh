#! /bin/bash

ARCHIVE_URL="https://github.com/killarny/ubuntu-env/archive/master.tar.gz"
TMP_DIR="/tmp/killarny-ubuntu-env-bootstrapper"
DEPS="bc git python source-highlight"

echo
echo Bootstrapping home environment.
echo - Location: $HOME
echo

# check for programs we will need
if ! hash $DEPS 2>/dev/null; then
    >&2 echo Need to install one or more of these programs: $DEPS
    echo
    echo Installing dependencies..
    sudo apt-get install -qqy $DEPS
fi

# check for micro editor
if ! snap list micro; then
	echo
	echo Installing micro editor..
	sudo snap install micro --classic
fi

mkdir $TMP_DIR
cd $TMP_DIR
wget -qO- $ARCHIVE_URL |tar zx
cd ubuntu-env-master

# include Anthony Scopatz's excellent collection of nano highlight files
#  (sourced from: https://github.com/scopatz/nanorc)
if [ ! -d common/.nano/ ]
then
    mkdir common/.nano/
fi
cd common/.nano/
wget -qO- https://github.com/scopatz/nanorc/archive/master.tar.gz |tar zx
# remove files that aren't related to nanorc
find nanorc-master/ -not -path "nanorc-master/" |grep -ve ".nanorc$" |xargs rm
mv nanorc-master/* ./
rm -rf nanorc-master
cd -

# install user configs
if [ "$EUID" -ne 0 ]; then  # skip if running as root, we install root stuff later
    echo Installing user configs.
    cp -iR ./common/. $HOME
    cp -iR ./user/. $HOME
fi

# install root user configs
echo Installing root configs.
sudo cp -iR ./common/. /root/
sudo cp -iR ./root/. /root/

echo Cleaning up..
cd $HOME
rm -rf $TMP_DIR
echo ..done!
echo Login again, or open a new terminal to activate changes.
