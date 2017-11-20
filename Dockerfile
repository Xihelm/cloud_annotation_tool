FROM ubuntu:trusty

RUN apt-get update && apt-get install -yq \
	software-properties-common
RUN add-apt-repository -y \
	ppa:v-launchpad-jochen-sprickerhof-de/pcl
RUN apt-get update && apt-get install -yq \
	libqt4-dev qt4-qmake libvtk5-dev libpcl-1.7-all-dev cmake mesa-utils

LABEL com.nvidia.volumes.needed="nvidia_driver"
ENV PATH /usr/local/nvidia/bin:${PATH}
ENV LD_LIBRARY_PATH /usr/local/nvidia/lib:/usr/local/nvidia/lib64:${LD_LIBRARY_PATH}

WORKDIR /app
COPY . .
WORKDIR /app/build

RUN cmake .. && make -j VERBOSE=1

ENV QT_X11_NO_MITSHM=1

CMD ./cloud_annotation_tool
