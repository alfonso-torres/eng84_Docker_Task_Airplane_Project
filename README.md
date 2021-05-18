# Docker Task

![SCHEME](./docker-stages.png)

__Task:__

__1.__ Build a Docker image of your python plane project with Dockerfile.

__2.__ Push it to Docker Hub.

__3.__ Create a Webhook on Dockerhub to send the notification to Shahrukh's email and yourself once the new image is pushed to your dockerhub.

- Share your docker hub image name and github repository for this task.
- Create a video for this task with a demo.

[Link](https://github.com/alfonso-torres/eng84-airport-project) of the python plane project to clone it.

__Solution:__

1. Let's clone the project: `git clone https://github.com/conjectures/eng84-airport-project.git`

2. Now we need to create the `Dockerfile`, where we will define what image we are going to use and what commands we want to run to get the application running in the container.

````Dockerfile
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

# Execute command for the base image to run the app
WORKDIR /usr/src/app
RUN python -m pip install -r requirements.txt
WORKDIR /usr/src/app/app

RUN python manage.py makemigrations
RUN python manage.py migrate
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
````

3. When you have your file ready, we will create our image (Make sure that you have the project and the Dockerfile in the same folder):

`docker build -t josetorres31/eng84_jose_airplane_project .`

4. Perfect, we have our image created with all the dependencies to run our application automatically.

`docker images` -> to check that it was created.

Let's create and run the container with the app running:

`docker run -dit -p 8000:8000 josetorres31/eng84_jose_airplane_project`

5. Go to your browser and enter: `localhost:8000`. Fantastic you have deployed your app in a docker. Amazing job.

_Notes:_

We are going to save the image in our docker hub so that we can have it available from wherever we want and use it whenever we want:

`docker push josetorres31/eng84_jose_airplane_project:latest
`

If someone wants to use our image, they will only have to pull and execute it in a container as we have done.

`docker pull josetorres31/eng84_jose_airplane_project
`

Amazing job! This is how we have automated our task using docker and dockerfile to run our application.
