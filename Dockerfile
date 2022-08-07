FROM python:3.10
COPY . /rf
WORKDIR /rf
RUN pip install --upgrade pip
RUN pip install robotframework
RUN pip install testarchiver

CMD /bin/bash -c 'while true; do foo; sleep 2; done'