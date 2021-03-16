FROM python

RUN apt update \
    && apt upgrade -y \
    && apt install -y \
    groff \
    less

RUN git clone https://github.com/cloudera/cdpcli.git \
    && cd cdpcli \
    && pip install .