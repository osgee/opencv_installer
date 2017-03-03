#!/bin/bash
# This script will install opencv on ubuntu 16.04, otherwise, you may have to revise the script!

CURRENT_PATH=$(pwd)
PY_VERSION_2=2
PY_VERSION_3=3
PY_VERSION_2_RELEASE=2.7
PY_VERSION_3_RELEASE=3.5
OPENCV_VERSION=3.1.0
OPENCV_FILE="opencv.zip"
OPENCV_CONTRIB_FILE="opencv_contrib.zip"
DEFAULT_VE_DIR="cv"
VE_DIR=$DEFAULT_VE_DIR
INSTALLER_SCRIPT_DIR="opencv_installer"
GET_PIP_FILE="get-pip.py"
GET_PIP_URL_1=http://osgee.com/opencv/$GET_PIP_FILE
GET_PIP_URL_2=https://bootstrap.pypa.io/$GET_PIP_FILE
GET_PIP_URL_INDEX=1
GET_PIP_URL=$GET_PIP_URL_1
IPPICV_FILE="ippicv_linux_20151201.tgz"
IPPICV_URL_1="https://raw.githubusercontent.com/Itseez/opencv_3rdparty/81a676001ca8075ada498583e4166079e5744668/ippicv/$IPPICV_FILE"
IPPICV_URL_2="http://osgee.com/opencv/$IPPICV_FILE"
IPPICV_URL_INDEX=1
IPPICV_URL=$IPPICV_URL_1
PRE_DOWNLOAD_IPPICV="y"

function configure {
	if [ -e ~/$OPENCV_FILE ]; then
		echo "$OPENCV_FILE Exits, Would You Like to Use Chached File ($OPENCV_FILE)? (y/n) [y]"
		read USE_CHACHED_OPENCV_FILE
		if [ "$USE_CHACHED_OPENCV_FILE" == "y" ] || [ "$USE_CHACHED_OPENCV_FILE" == "" ]; then
			# Will Use Cached File
			echo "Will Use Cached File ($OPENCV_FILE)"
		else
			sudo rm -f ~/$OPENCV_FILE
			echo "Removed Cached File ($OPENCV_FILE)"
		fi
	fi

	if [ -d ~/opencv-$OPENCV_VERSION ]; then
		echo "Unzipped $OPENCV_FILE Directory Exits, Would You Like to Remove the Directory (opencv-$OPENCV_VERSION/)? (y/n) [y]"
		read REMOVE_UNZIPPED_OPENCV_DIR
		if [ "$REMOVE_UNZIPPED_OPENCV_DIR" == "y" ] || [ "$REMOVE_UNZIPPED_OPENCV_DIR" == "" ]; then
			# Delete Unzipped OpenCV Directory 
			sudo rm -rf ~/opencv-$OPENCV_VERSION
			echo "Removed Unzipped OpenCV Directory (opencv-$OPENCV_VERSION)"
		else
			echo "Kept Unzipped OpenCV Directory (opencv-$OPENCV_VERSION)"
		fi
	fi

	if [ -e ~/$OPENCV_CONTRIB_FILE ]; then
		echo "$OPENCV_CONTRIB_FILE Exits, Would You Like to Use Chached File ($OPENCV_CONTRIB_FILE)? (y/n) [y]"
		read USE_CHACHED_OPENCV_CONTRIB_FILE
		if [ "$USE_CHACHED_OPENCV_CONTRIB_FILE" == "y" ] || [ "$USE_CHACHED_OPENCV_CONTRIB_FILE" == "" ]; then
			# Will Use Cached File
			echo "Will Use Cached File ($OPENCV_CONTRIB_FILE)"
		else
			sudo rm -f ~/$OPENCV_CONTRIB_FILE
			echo "Removed Cached File ($OPENCV_CONTRIB_FILE)"
		fi
	fi

	if [ -d ~/opencv_contrib-$OPENCV_VERSION ]; then
		echo "Unzipped $OPENCV_CONTRIB_FILE Directory Exits, Would You Like to Remove the Directory (opencv_contrib-$OPENCV_VERSION/)? (y/n) [y]"
		read REMOVE_UNZIPPED_OPENCV_CONTRIB_DIR
		if [ "$REMOVE_UNZIPPED_OPENCV_CONTRIB_DIR" == "y" ] || [ "$REMOVE_UNZIPPED_OPENCV_CONTRIB_DIR" == "" ]; then
			# Delete Unzipped OpenCV Contribution Directory 
			sudo rm -rf ~/opencv_contrib-$OPENCV_VERSION
			echo "Removed Unzipped OpenCV Contribution Directory (opencv_contrib-$OPENCV_VERSION)"
		else
			echo "Kept Unzipped OpenCV Contribution Directory (opencv_contrib-$OPENCV_VERSION)"
		fi
	fi

	if [ -e ~/.virtualenvs ]; then
		echo "Would You Like to Use Default Virtualenvs Directory Name ($DEFAULT_VE_DIR)? (y/n) [y]"
		read USE_DEFAULT_VE
		if [ "$USE_DEFAULT_VE" == "y" ] || [ "$USE_DEFAULT_VE" == "" ]; then
			if [ -e ~/.virtualenvs/$DEFAULT_VE_DIR ]; then
				echo "Default Virtualenvs Directory ($DEFAULT_VE_DIR) Exits, Would You Like to Remove Virtualenvs Directory ($DEFAULT_VE_DIR)? (y/n) [y]"
				read REMOVE_DEFAULT_VE
				if [ "$REMOVE_DEFAULT_VE" == "y" ] || [ "$REMOVE_DEFAULT_VE" == "" ]; then
					# Remove Default VE
					sudo rm -rf ~/.virtualenvs/$DEFAULT_VE_DIR
					echo "Removed Virtualenvs ($DEFAULT_VE_DIR)"
					echo "Will Use Default Virtualenvs Directory Name ($DEFAULT_VE_DIR)"
				else
					echo "Please Input a Virtualenvs Directory Name: "
					read INPUT_VE_DIR
					if [ -e ~/.virtualenvs/$INPUT_VE_DIR ]; then
						echo "Inputed Virtualenvs ($INPUT_VE_DIR) Exits, Would You Like to Remove Virtualenvs Directory ($INPUT_VE_DIR)? (y/n) [y]"
						read REMOVE_INPUT_VE
						if [ "$REMOVE_INPUT_VE" == "y" ] || [ "$REMOVE_INPUT_VE" == "" ]; then
							# Remove Existed VE
							sudo rm -rf ~/.virtualenvs/$INPUT_VE_DIR
							echo "Removed Virtualenvs ($INPUT_VE_DIR)"
						else
							echo "Please Run Script Again to Change a Virtualenvs Directory Name (Exept $INPUT_VE_DIR)"
							exit
						fi
					fi
					VE_DIR=$INPUT_VE_DIR
					echo "Will Use Virtualenvs ($VE_DIR)"
				fi
			fi
		else
			echo "Please Input a Virtualenvs Directory Name: "
			read INPUT_VE_DIR
			if [ -e ~/.virtualenvs/$INPUT_VE_DIR ]; then
				echo "Inputed Virtualenvs ($INPUT_VE_DIR) Exits, Would You Like to Remove Virtualenvs Directory ($INPUT_VE_DIR)? (y/n) [y]"
				read REMOVE_INPUT_VE
				if [ "$REMOVE_INPUT_VE" == "y" ] || [ "$REMOVE_INPUT_VE" == "" ]; then
					# Remove Existed VE
					sudo rm -rf ~/.virtualenvs/$INPUT_VE_DIR
					echo "Removed Virtualenvs ($INPUT_VE_DIR)"
				else
					echo "Please Run Script Again to Change a Virtualenvs Directory Name (Exept $INPUT_VE_DIR)"
					exit
				fi
			fi
			VE_DIR=$INPUT_VE_DIR
			echo "Will Use Virtualenvs ($VE_DIR)"
		fi
	else
		echo "Would You Like to Use Default Virtualenvs Directory Name ($DEFAULT_VE_DIR)? (y/n) [y]"
		read USE_DEFAULT_VE
		if [ "$USE_DEFAULT_VE" == "y" ] || [ "$USE_DEFAULT_VE" == "" ]; then	
			echo "Will Use the Default Virtualenvs Directory Name ($VE_DIR)"
		else
			echo "Please Input a Virtualenvs Directory Name: "
			read INPUT_VE_DIR
			VE_DIR=$INPUT_VE_DIR
			echo "Will Use Virtualenvs ($VE_DIR)"
		fi

	fi


	echo "Would You Like to Choose a Pypi Repository? (y/n) [y]"
	read CHOOSE_REPO

	if [ "$CHOOSE_REPO" == "y" ] || [ "$CHOOSE_REPO" == "" ]; then
		source ./pypi_repo_chooser.sh
	fi

	echo "Choose a Server to Download $GET_PIP_FILE: (1-2) [1]"
	echo "[1]$GET_PIP_URL_1"
	echo "[2]$GET_PIP_URL_2"

	read GET_PIP_URL_INDEX

	if [ "$GET_PIP_URL_INDEX" == 1 ]; then
		GET_PIP_URL=$GET_PIP_URL_1
	elif [ "$GET_PIP_URL_INDEX" == 2 ]; then
		GET_PIP_URL=$GET_PIP_URL_2
	else
		echo "Use Default $GET_PIP_FILE URL"
	fi

	if [ -e ~/$IPPICV_FILE ]; then
		echo "$IPPICV_FILE Exits, Would You Like to Use Chached File ($IPPICV_FILE)? (y/n) [y]"
		read USE_CHACHED_IPPICV_FILE
		if [ "$USE_CHACHED_IPPICV_FILE" == "y" ] || [ "$USE_CHACHED_IPPICV_FILE" == "" ]; then
			# Will Use Cached File
			echo "Will Use Cached File ($IPPICV_FILE)"
		else
			sudo rm -f ~/$IPPICV_FILE
			echo "Removed Cached File ($IPPICV_FILE)"
		fi
	else
		echo "Would You Like to Download ippicv_linux_20151201.tgz in Advance (Suggested)? (y/n) [y]"
		read PRE_DOWNLOAD_IPPICV

		if [ "$PRE_DOWNLOAD_IPPICV" == "y" ] || [ "$PRE_DOWNLOAD_IPPICV" == "" ]; then
			PRE_DOWNLOAD_IPPICV="y"
			echo "Please Choose a Source for Downloading ippicv_linux_20151201.tgz?(1-2) [1]"
			echo "[1]$IPPICV_URL_1"
			echo "[2]$IPPICV_URL_2"
			read IPPICV_URL_INDEX

			if [ "$IPPICV_URL_INDEX" == 1 ]; then
				IPPICV_URL=$IPPICV_URL_1
				echo "Will Use URL ($IPPICV_URL)"
			elif [ "$IPPICV_URL_INDEX" == 2 ]; then
				IPPICV_URL=$IPPICV_URL_2
				echo "Will Use URL ($IPPICV_URL)"
			else
				echo "Use Default $IPPICV_URL URL"
			fi
		fi
	fi	


}

function post_clean {
	if [ -e ~/$OPENCV_FILE ]; then
		echo "Would You Like to Remove ($OPENCV_FILE)? (y/n) [n]"
		read REMOVE_CHACHED_OPENCV_FILE
		if [ "$REMOVE_CHACHED_OPENCV_FILE" == "y" ]; then
			# Will Remove Cached File
			sudo rm -f ~/$OPENCV_FILE
			echo "Removed Cached File ($OPENCV_FILE)"
		else
			echo "Kept Cached File ($OPENCV_FILE)"
		fi
	fi

	if [ -d ~/opencv-$OPENCV_VERSION ]; then
		echo "Would You Like to Remove the Directory (opencv-$OPENCV_VERSION/)? (y/n) [y]"
		read REMOVE_UNZIPPED_OPENCV_DIR
		if [ "$REMOVE_UNZIPPED_OPENCV_DIR" == "y" ] || [ "$REMOVE_UNZIPPED_OPENCV_DIR" == "" ]; then
			# Delete Unzipped OpenCV Directory 
			sudo rm -rf ~/opencv-$OPENCV_VERSION
			echo "Removed Unzipped OpenCV Directory (opencv-$OPENCV_VERSION)"
		else
			echo "Kept Unzipped OpenCV Directory (opencv-$OPENCV_VERSION)"
		fi
	fi

	if [ -e ~/$OPENCV_CONTRIB_FILE ]; then
		echo "Would You Like to Remove Chached File ($OPENCV_CONTRIB_FILE)? (y/n) [n]"
		read REMOVE_CHACHED_OPENCV_CONTRIB_FILE
		if [ "$REMOVE_CHACHED_OPENCV_CONTRIB_FILE" == "y" ]; then
			# Remove Cached File
			sudo rm -f ~/$OPENCV_CONTRIB_FILE
			echo "Removed Cached File ($OPENCV_CONTRIB_FILE)"
		else
			echo "Kept Cached File ($OPENCV_CONTRIB_FILE)"
		fi
	fi

	if [ -d ~/opencv_contrib-$OPENCV_VERSION ]; then
		echo "Would You Like to Remove the Directory (opencv_contrib-$OPENCV_VERSION/)? (y/n) [y]"
		read REMOVE_UNZIPPED_OPENCV_CONTRIB_DIR
		if [ "$REMOVE_UNZIPPED_OPENCV_CONTRIB_DIR" == "y" ] || [ "$REMOVE_UNZIPPED_OPENCV_CONTRIB_DIR" == "" ]; then
			# Remove Unzipped OpenCV Contribution Directory 
			sudo rm -rf ~/opencv_contrib-$OPENCV_VERSION
			echo "Removed Unzipped OpenCV Contribution Directory (opencv_contrib-$OPENCV_VERSION)"
		else
			echo "Kept Unzipped OpenCV Contribution Directory (opencv_contrib-$OPENCV_VERSION)"
		fi
	fi
	
	if [ -e ~/$IPPICV_FILE ]; then
		echo "Would You Like to Remove Chached File ($OPENCV_CONTRIB_FILE)? (y/n) [n]"
		read REMOVE_CHACHED_IPPICV_FILE
			if [ "$REMOVE_CHACHED_IPPICV_FILE" == "y" ]; then
				# Remove Cached File
				sudo rm -f ~/$IPPICV_FILE
				echo "Removed Cached File ($IPPICV_FILE)"
			else
				echo "Kept Cached File ($IPPICV_FILE)"
		fi
	fi

	if [ -d ~/$INSTALLER_SCRIPT_DIR ]; then
		echo "Would You Like to Remove Installer Directory ($INSTALLER_SCRIPT_DIR)? (y/n) [n]"
		read REMOVE_INSTALLER
		if [ "$REMOVE_INSTALLER" == "y" ]; then
			# Remove nstaller Directory
			sudo rm -rf ~/$INSTALLER_SCRIPT_DIR
			echo "Removed Installer Directory  ($INSTALLER_SCRIPT_DIR)"
		else
			echo "Kept Installer Directory  ($INSTALLER_SCRIPT_DIR)"
		fi
	
	fi

}

function install_opencv {

	sudo apt-get update -y

	sudo apt-get upgrade -y

	sudo apt-get install build-essential cmake pkg-config -y

	sudo apt-get install libjpeg8-dev libtiff5-dev libjasper-dev libpng12-dev -y 

	sudo apt-get install libavcodec-dev libavformat-dev libswscale-dev libv4l-dev -y 

	sudo apt-get install libxvidcore-dev libx264-dev -y 

	sudo apt-get install libgtk-3-dev -y 

	sudo apt-get install libatlas-base-dev gfortran -y 

	if [ "$1" == "$PY_VERSION_2" ]; then
		sudo apt-get install python$PY_VERSION_2_RELEASE'-dev' -y
	else
		sudo apt-get install python$PY_VERSION_3_RELEASE'-dev' -y
	fi

	cd ~

	if [ -e $OPENCV_FILE ]; then
		echo $OPENCV_FILE Chached, Skip Downloading!
	else
		wget -O $OPENCV_FILE https://codeload.github.com/opencv/opencv/zip/$OPENCV_VERSION
	fi

	unzip $OPENCV_FILE

	if [ -e $OPENCV_CONTRIB_FILE ]; then
		echo $OPENCV_CONTRIB_FILE Chached, Skip Downloading!
	else
		wget -O $OPENCV_CONTRIB_FILE https://codeload.github.com/opencv/opencv_contrib/zip/$OPENCV_VERSION
	fi

	unzip $OPENCV_CONTRIB_FILE

	if [ "$PRE_DOWNLOAD_IPPICV" == "y" ]; then
		if [ ! -e ~/$IPPICV_FILE ]; then
			wget $IPPICV_URL -O ~/$IPPICV_FILE
		fi
		mkdir -p ~/opencv-$OPENCV_VERSION/3rdparty/ippicv/downloads/linux-808b791a6eac9ed78d32a7666804320e/
		cp  ~/$IPPICV_FILE ~/opencv-$OPENCV_VERSION/3rdparty/ippicv/downloads/linux-808b791a6eac9ed78d32a7666804320e/
	fi

	if [ -e ~/$GET_PIP_FILE ]; then
		sudo rm -rf ~/$GET_PIP_FILE
	fi

	if [ -e ~/.cache/pip ]; then
		sudo rm -rf ~/.cache/pip
	fi


	wget -O $GET_PIP_FILE $GET_PIP_URL

	sudo python $GET_PIP_FILE

	sudo pip install virtualenv virtualenvwrapper

	sudo rm -rf ~/$GET_PIP_FILE ~/.cache/pip

	if grep -q "virtualenvwrapper.sh" ".bashrc";
	then
		echo "Path Have Been Set!"
	else
		echo -e "\n# virtualenv and virtualenvwrapper" >> ~/.bashrc
		echo "export WORKON_HOME=$HOME/.virtualenvs" >> ~/.bashrc
		echo "source /usr/local/bin/virtualenvwrapper.sh" >> ~/.bashrc
		source ~/.bashrc
	fi

	if [ "$1" == "$PY_VERSION_2" ]; then
		mkvirtualenv $VE_DIR -p python$PY_VERSION_2
	else
		mkvirtualenv $VE_DIR -p python$PY_VERSION_3
	fi
	

	workon $VE_DIR

	pip install numpy

	cd ~/opencv-$OPENCV_VERSION/

	mkdir build

	cd build

	cmake -D CMAKE_BUILD_TYPE=RELEASE \
	    -D CMAKE_INSTALL_PREFIX=/usr/local \
	    -D INSTALL_PYTHON_EXAMPLES=ON \
	    -D INSTALL_C_EXAMPLES=OFF \
	    -D OPENCV_EXTRA_MODULES_PATH=~/opencv_contrib-$OPENCV_VERSION/modules \
	    -D PYTHON_EXECUTABLE=~/.virtualenvs/$VE_DIR/bin/python \
	    -D BUILD_EXAMPLES=ON ..

	make -j4

	make clean

	make

	sudo make install

	sudo ldconfig

	cd ~

	source ~/.bashrc


	if [ "$1" == "$PY_VERSION_2" ]; then

		ls -l /usr/local/lib/python$PY_VERSION_2_RELEASE/site-packages/ |grep cv2

		cd /usr/local/lib/python$PY_VERSION_2_RELEASE/site-packages/

		sudo mv cv2.cpython-*-x86_64-linux-gnu.so cv2.so

		cd ~/.virtualenvs/$VE_DIR/lib/python$PY_VERSION_2_RELEASE/site-packages/

		ln -s /usr/local/lib/python$PY_VERSION_2_RELEASE/site-packages/cv2.so cv2.so

	else

		ls -l /usr/local/lib/python$PY_VERSION_3_RELEASE/site-packages/ |grep cv2

		cd /usr/local/lib/python$PY_VERSION_3_RELEASE/site-packages/

		sudo mv cv2.cpython-*-x86_64-linux-gnu.so cv2.so

		cd ~/.virtualenvs/$VE_DIR/lib/python$PY_VERSION_3_RELEASE/site-packages/

		ln -s /usr/local/lib/python$PY_VERSION_3_RELEASE/site-packages/cv2.so cv2.so
	fi

	echo "Detailed Steps on http://www.pyimagesearch.com/2016/10/24/ubuntu-16-04-how-to-install-opencv/"

	cd ~
	
}

function check {
	SYS_INFO_FILE='release'
	ls /etc|grep $SYS_INFO_FILE > /dev/null
	if [ $? -eq 0 ];
	then	
		source /etc/*$SYS_INFO_FILE
		if [ "$DISTRIB_ID" == "Ubuntu" ];
		then
			if [ "$DISTRIB_RELEASE" == "16.04" ];
			then
				#echo "Pre-installation Check Passes!"
				echo 1
			
			else
				#echo "Uncompatible Release! Force Install? [y]"
				echo 2
			fi
		else
			#echo "Unsupport Distribution! Installation Aborts!"
			echo -1
		fi
	else
		#echo "Can't Check Your Distribution or Release! Installation Aborts!"
		echo -2
	fi
	

}

function test_clean {
	TEST_FILE=opencv_installer_test.py
	LOG_FILE=opencv_installer_result.log
	CHECK_FLAG="OpenCV_"$OPENCV_VERSION
	cd ~
	workon $VE_DIR
	echo "import cv2" >> $TEST_FILE
	echo "print('OpenCV_'+cv2.__version__)" >> $TEST_FILE
	
	python $TEST_FILE 1>$LOG_FILE 2>&1
	if grep -q $CHECK_FLAG $LOG_FILE;
	cat $LOG_FILE
	rm $TEST_FILE
	rm $LOG_FILE
	then
		echo "Install Succeed!"
		echo $CHECK_FLAG
		echo "Enjoy!"
		echo ""
		echo "Usage:"
		echo "\$workon $VE_DIR"
		echo "\$python"
		echo ">>>import cv2"
		echo ">>>cv2.__version__"
		echo ">>>exit()"
		echo ""
		post_clean
	else
		echo "Failed! Please Put an Issue on https://github.com/osgee/opencv_installer/issues"
		echo "And You Can Retry or Revise the Script."
	fi
	
}

function install {

	echo "Type the version of Python that you want to use with OpenCV (2/3)? [3]"

	read PY_VERSION

	if [ "$PY_VERSION" == "$PY_VERSION_2" ] || [ "$PY_VERSION" == "$PY_VERSION_3" ] || [ "$PY_VERSION" == "" ]; then
		if [ "$PY_VERSION" == "" ]; then
			PY_VERSION=$PY_VERSION_3
		fi
		configure
		install_opencv $PY_VERSION
		test_clean
	else
		echo "Wrong input!"
	fi


}

function check_install {

check_result=$(check)

if [ $check_result == 1 ];
then 
	echo "Pre-installation Check Passes!"
	install
elif [ $check_result == 2 ];
then
	echo "Uncompatible Release! Force Install (n/y)? [n]"
	read FORCE_INSTALL
	if [ "$FORCE_INSTALL" == "" ]; 
	then
		FORCE_INSTALL="n"
	fi
	if [ "$FORCE_INSTALL" == "y" ];
	then
		install
	fi
elif [ $check_result == -1 ];
then
	echo "Unsupport Distribution! Installation Aborts!"
elif [ $check_result == -2 ];
then
	echo "Can't Check Your Distribution or Release! Installation Aborts!"
else
	echo "Pre-installation Check Failed!"

fi

}

check_install
cd $CURRENT_PATH

