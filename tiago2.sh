#!/usr/bin/env bash

# Print the current working directory
pwd

# Set the workspace path automatically
W_PATH="$(pwd)"

# Reset PYTHONPATH to include only necessary paths
export PYTHONPATH="${W_PATH}/install/lib/python3.8/site-packages:/opt/ros/humble/lib/python3.8/site-packages"

# Source ROS 2 humble
source /opt/ros/humble/setup.bash

# Source Gazebo environment
source /usr/share/gazebo/setup.sh

# Source the workspace setup if available
SIM_SETUP="${W_PATH}/install/setup.bash"
if [ -f "${SIM_SETUP}" ]; then
    source "${SIM_SETUP}"
else
    echo "Error: ${SIM_SETUP} not found."
    exit 1
fi

# Export paths
export GAZEBO_RESOURCE_PATH=${W_PATH}/src/mars_rover/leo_rover_simulation/leo_description:${GAZEBO_RESOURCE_PATH}
export GAZEBO_MODEL_PATH=${W_PATH}/src/mars_rover/leo_rover_simulation/leo_description/models:${W_PATH}/src/tiago_robot/tiago_description/urdf:${W_PATH}/src/tiago_simulation:${GAZEBO_MODEL_PATH}
export GAZEBO_PLUGIN_PATH="${W_PATH}/install/lib:${GAZEBO_PLUGIN_PATH}"
export GAZEBO_MODEL_DATABASE_URI=""

# Launch
ros2 launch cogar_simulation spawn_tiago_in_space.launch.py is_public_sim:=True world_name:=space_terrain_env
# ros2 launch cogar_simulation spawn_tiago_in_space.launch.py is_public_sim:=True world_name:=hospital_flat
