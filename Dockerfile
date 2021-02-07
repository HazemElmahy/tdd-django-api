FROM python:3.9-alpine
LABEL maintainer=" Hazem Elmahy"

ENV PYTHONUNBUFFERED 1

COPY ./requirements.txt /requirements.txt

RUN apk add --update --no-cache postgresql-client
RUN apk add --update --no-cache --virtual .tmp-build-deps \
    gcc libc-dev linux-headers postgresql-dev
#  "no cahce" to not store the registry index on the docker file to 
# minize the number of extra package included in the docker container
# extra depencies on the system can cause side effects and 
# can create security vulnerabilities

#"virtual" sets up an alias that we can use to remove them

RUN pip install -r /requirements.txt
RUN apk del .tmp-build-deps

RUN mkdir /app
WORKDIR /app
COPY ./app /app

# not using root for security
RUN adduser -D user
USER user