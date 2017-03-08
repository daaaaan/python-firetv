FROM hypriot/rpi-python
MAINTAINER Dan Caws

RUN apt-get update && apt-get install -y \
        libssl-dev \
        libusb-1.0-0 \
	      gcc \
        python-dev \
        swig \
        curl \
        unzip \
        && curl -L -o /tmp/master.zip https://github.com/happyleavesaoc/python-firetv/archive/master.zip \
        && cd /tmp \
        && unzip master.zip \
        && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN pip install --upgrade pip
RUN pip install flask
RUN pip install https://pypi.python.org/packages/source/M/M2Crypto/M2Crypto-0.24.0.tar.gz
RUN pip install /tmp/python-firetv-master[firetv-server]

CMD ["firetv-server", "-c", "config/devices.yaml"]

# docker run -it --rm --name docker-firetv -p 5556:5556 docker-firetv
