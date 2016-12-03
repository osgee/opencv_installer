# opencv_installer
opencv_installer is a script collected from http://www.pyimagesearch.com/2016/10/24/ubuntu-16-04-how-to-install-opencv/
By using this script, you are admited to take the responsibility of the risk that crash may happen to your system.
And this script is only compatible with Ubuntu 16.04.You have to connect to the Internet for the installation.

# Usage

## Installation

	$ sudo apt update -y
	$ sudo apt install git -y
	$ cd ~
	$ git clone https://github.com/osgee/opencv_installer.git
	$ cd opencv_installer
	$ source opencv_installer.sh

Then follow the instructions to finish the installation.

## Test

	$ workon cv
	$ python
	>>>import cv2
	>>>cv2.__version__
	[output] 3.1.0	
	>>>exit()

If the commands work good, then the installation succeeds, enjoy with opencv!

## Other
you can download opencv.zip and opencv_contrib.zip on http://osgee.com/opencv/opencv.zip 
and http://osgee.com/opencv/opencv_contrib.zip
