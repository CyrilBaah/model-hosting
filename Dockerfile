FROM nvidia/cuda:10.1-cudnn7-devel-ubuntu18.04

# Python environment setup
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# RUN apt-get update -y && apt-get install -y python3-pip python3-dev libsm6 libxext6 libxrender-dev

RUN apt-get update -y && apt-get install -y python3-pip python3-dev libsm6 libxext6 libxrender-dev
RUN pip3 --version

RUN \
	apt-get install -y \
	wget \
	unzip \
	ffmpeg \ 
	git



# Create and set working directory
ENV PROJECT=/home/yolov7
RUN mkdir -p ${PROJECT}
WORKDIR ${PROJECT}

# Packages required for setting up WSGI
RUN apt-get update
RUN apt-get install -y --no-install-recommends gcc libc-dev python3-dev

RUN pip3 install --upgrade pip
RUN pip3 install opencv-python
RUN pip3 install --upgrade pip
RUN pip3 install opencv-python
RUN pip3 install scikit-build

# Copy and install requirements
# RUN pip install --upgrade pip
COPY requirements.txt ${PROJECT}
RUN pip3 install -r ${PROJECT}/requirements.txt

# Copy project to working directory
COPY . ${PROJECT}

# Make scripts executable and run entrypoint
RUN chmod +x ./entrypoint.sh
ENTRYPOINT ["sh", "entrypoint.sh"]