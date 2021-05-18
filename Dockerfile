# We need to use python official image as our base image
# We will use a key word called FROM

FROM python:3
# Here we using python3 official image as our base image

LABEL MAINTAINER = eng84josepython
# Using label is a good practice but optional

COPY eng84-airport-project /usr/src/app
#copying our app folder from our folder to the container where we will run the app

EXPOSE 8000
# Expose is the keyword to use to expose the required port for the base image

# Execute command for the base image
WORKDIR /usr/src/app
RUN python -m pip install -r requirements.txt
WORKDIR /usr/src/app/app

RUN python manage.py makemigrations
RUN python manage.py migrate
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
