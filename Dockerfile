FROM python:3.9-alpine3.13
LABEL maintainer='nmwzd.com'
ENV PYTHONUNBUFFERED 1



COPY ./requirements.txt /tmp/requirements.txt
COPY ./requirements.dev.txt /tmp/requirements.dev.txt
COPY ./app /app
WORKDIR /app
EXPOSE 8000
#create a invironment in the docker image
#upgrade the python in the docker image
#install the requirements for the project in the requirements file
#we remove the directory with the file requiremnets
#
ARG DEV=false
RUN python -m venv /py && \    
    /py/bin/pip install --upgrade pip && \
    /py/bin/pip install -r /tmp/requirements.txt && \
    if [ $DEV = "true" ]; \
        then /py/bin/pip install -r /tmp/requirements.dev.txt ; \
    fi && \
    rm -rf /tmp && \
    adduser \
        --disabled-password \
        --no-create-home \
        django-user 
ENV PATH="/py/bin:$PATH"

USER django-user
#CMD [ "python", "./your-daemon-or-script.py" ]