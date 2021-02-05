FROM python:3.9-alpine
MAINTAINER Hazem Elmahy

ENV PYTHONUNBUFFERED 1

COPY ./requirments.txt /requirments.txt
RUN pip install -r /requirments.txt

RUN mkdir /app
WORKDIR /app
COPY ./app /app

# not using root for security
# RUN adduser -D user
# USER user
