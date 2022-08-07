FROM python:3.10
COPY . /rf
WORKDIR /rf
RUN pip install --upgrade pip
RUN pip install -r requirements.txt