FROM f1tenth/focal-l4t-foxy:f1tenth-stack

SHELL ["/bin/bash", "-c"]

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update --fix-missing && \
    apt-get install -y --no-install-recommends \
    apt-utils \
    python3-pip \
    ninja-build

COPY . /f1tenth_system

WORKDIR /f1tenth_system

RUN rosdep update --rosdistro=foxy && rosdep install -r -y --from-paths . --ignore-src

RUN source /opt/ros/foxy/setup.bash && colcon build --symlink-install --cmake-args -GNinja

ENTRYPOINT ["bash"]
