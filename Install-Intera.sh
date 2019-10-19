# script to install:
#ROS kinetic
# intera's catkin workspace
#MOVEit

# for more detailed information see: http://sdk.rethinkrobotics.com/intera/Workstation_Setup


#workstation Requirements
# Ubuntu 16.04 LTS and ROS Kinetic
#  - intel i5 or above
#  - 4GB Memory or above
#  - At least 7 GB of free disk space
#  - Ethernet port
#  - If any visualization (RViz) or simulation (Gazebo) is required for your application, a dedicated NVidia graphics card with proprietary NVidia drivers is recommended


catkin_ws="$HOME/ros_ws"
#catkin_ws="$HOME/catkin_ws"


#install ROS kinetic for Ubuntu 16.04

#Setup your sources.list
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu xenial main" > /etc/apt/sources.list.d/ros-latest.list'
#setup yourk keys
sudo apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key 421C365BD9FF1F717815A3895523BAEEB01FA116
#update to latest software lists
sudo apt-get update
#install ROS kinetic Desktop Full
sudo apt-get install ros-kinetic-desktop-full
#initialize rosdep
sudo rosdep init
rosdep update
install rosinstall
sudo apt-get install python-rosinstall


#create development workspace

#ros workspace
mkdir -p "$catkin_ws"/src
#source ROS and build
#ROS Kinetic
#Source ROS Setup
source /opt/ros/kinetic/setup.bash
#build
cd "$catkin_ws"
catkin_make

#INSTALL INTERA SDK DEPENDENCIES
sudo apt-get update
sudo apt-get install git-core python-argparse python-wstool python-vcstools python-rosdep ros-kinetic-control-msgs ros-kinetic-joystick-drivers ros-kinetic-xacro ros-kinetic-tf2-ros ros-kinetic-rviz ros-kinetic-cv-bridge ros-kinetic-actionlib ros-kinetic-actionlib-msgs ros-kinetic-dynamic-reconfigure ros-kinetic-trajectory-msgs ros-kinetic-rospy-message-converter


#Install intera robot sdk

#download the sdk on your workstation
cd "$catkin_ws"/src
wstool init .
git clone https://github.com/RethinkRobotics/sawyer_robot.git
wstool merge sawyer_robot/sawyer_robot.rosinstall
wstool update
#source ROS setup
source /opt/ros/kinetic/setup.bash
#build
cd "$catkin_ws"
catkin_make


#intera.sh ROS Environment Setup

#Copy the intera.sh script
#The intera.sh file already exists in intera_sdk repo, copy the file into your ros workspace.

#Further information and a detailed description is available on the SDK_Shell page (http://sdk.rethinkrobotics.com/intera/SDK_Shell)
cp "$catkin_ws"/src/intera_sdk/intera.sh "$catkin_ws"



#INSTALLING MOVEIT
sudo apt-get update
sudo apt-get install ros-kinetic-moveit

#INSTALLING AND BUILDING SAWYER MOVEIT REPO
#Run catkin_make to make the new Sawyer MoveIt! additions to your ROS workspace

cd "$catkin_ws"
./intera.sh
cd "$catkin_ws"/src
wstool merge https://raw.githubusercontent.com/RethinkRobotics/sawyer_moveit/master/sawyer_moveit.rosinstall
wstool update
cd "$catkin_ws"
catkin_make

#Customize the intera.sh script
#Please edit the intera.sh shell script making the necessary modifications to describe your development PC.

#cd "$catkin_ws"
#gedit intera.sh

#change robot_hostname="021604CP00018.local
#your_ip = "192.168.XXX.XXX" -- see $ifconfig -> result will be contained in the inet addr field
#change ros_version to your ros_version ( kinetic)
#save and close intera.sh

#VERIFY ENVIRONMENT
#A useful command for viewing and validating your ROS environment setup is:
#$ env | grep ROS
#The important fields at this point:
	#ROS_MASTER_URI - This should now contain your robot's hostname.
	#ROS_IP - This should contain your workstation's IP address.
	#ROS_HOSTNAME - If not using the workstation's IP address, the ROS_HOSTNAME field should contain your PC's hostname. Otherwise, this field should not be available.

# setup RVIZ
# rosrun rviz rviz
#Set the Fixed Frame as /base -- Global Options -> Fixed Frame to base
#Info: The ‘Fixed Frame’ provides a static, base reference for your visualization. 
#Any sensor data that comes in to rviz will be transformed into that reference frame so it can be properly displayed in the virtual world.
# add -> Robot Model
# exit rviz
#Now you can visualize your robot on Rivz!

