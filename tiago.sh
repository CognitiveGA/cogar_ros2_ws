#!/bin/bash

# Print the current working directory
pwd

# Set the workspace path automatically
L_PATH="$(pwd)"

# Reset PYTHONPATH to include only necessary paths
export PYTHONPATH="${L_PATH}/install/lib/python3.8/site-packages:/opt/ros/humble/lib/python3.8/site-packages"

# Source ROS 2 humble
source /opt/ros/humble/setup.bash

# Source Gazebo environment
source /usr/share/gazebo/setup.sh

# Source the workspace setup if available
SIM_SETUP="${L_PATH}/install/setup.bash"
if [ -f "${SIM_SETUP}" ]; then
    source "${SIM_SETUP}"
else
    echo "Error: ${SIM_SETUP} not found."
    exit 1
fi

# Export Gazebo model and plugin paths
export GAZEBO_MODEL_PATH="${L_PATH}/src/tiago_robot/tiago_description/urdf:${L_PATH}/src:${L_PATH}/src/tiago_simulation"
export GAZEBO_PLUGIN_PATH="${L_PATH}/install/lib:${GAZEBO_PLUGIN_PATH}"

# Launch the simulation
ros2 launch tiago_gazebo tiago_gazebo.launch.py is_public_sim:=True

