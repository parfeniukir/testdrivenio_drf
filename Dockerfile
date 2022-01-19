# pull official base image
FROM python:3.9.7

# set working directory
WORKDIR /app

# set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# install system dependencies
RUN apt-get update \
  && apt-get -y install netcat gcc postgresql \
  && apt-get clean

# install dependencies
RUN pip install --upgrade pipenv
COPY Pipfile Pipfile.lock /app/
RUN pipenv install --system

# copy entrypoint.sh
COPY ./entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh

# add app
COPY . /app/

# run entrypoint.sh
ENTRYPOINT ["/app/entrypoint.sh"]