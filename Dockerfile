FROM ros:humble

SHELL ["/bin/bash", "-c"]

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update --fix-missing && \
    apt-get install -y --no-install-recommends \
    apt-utils \
    python3-pip \
    ninja-build \
    ros-humble-asio-cmake-module 

COPY . /f1tenth_system

WORKDIR /f1tenth_system

RUN rosdep update --rosdistro=humble && rosdep install -r -y --from-paths . --ignore-src

RUN source /opt/ros/humble/setup.bash && colcon build --symlink-install --cmake-args -GNinja
