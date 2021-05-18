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

__-Build a Docker image of the project:__

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

__-Push it to the Docker Hub:__

We are going to save the image in our docker hub so that we can have it available from wherever we want and use it whenever we want:

`docker push josetorres31/eng84_jose_airplane_project:latest
`

If someone wants to use our image, they will only have to pull and execute it in a container as we have done.

`docker pull josetorres31/eng84_jose_airplane_project
`

Amazing job! This is how we have automated our task using docker and dockerfile to run our application.

__-Webhook:__

A webhook (also called a web callback or HTTP push API) is a way for an app to provide other applications with real-time information. A webhook delivers data to other applications as it happens, meaning you get data immediately.

For that we have "Google Script WebApp". So when we will push the image into our repository of docker hub, once it reacher our webhook will trigger the Google Script WebApp we created so that will get triggered and it will send a email into the user that you specify, people who are collaborating in the same project.

Let's start:

1. Go to the `Apps Script` of Google and create a new project.

2. In the script you have to specify the emails:

````
function doPost(request) {
  // get string value of POST data
  var postJSON = request.postData.getDataAsString();
  var payload = JSON.parse(postJSON);
  var tag = payload.push_data.tag; // docker version
  var reponame = payload.repository.repo_name
  var dockerimagename = payload.repository.name;

  if(typeof request !== 'undefined')
  
  // Send an email to x
  MailApp.sendEmail({
    to: "user1@example.com",
    subject: reponame + " on DockerHub has been updated",
    htmlBody: "Hi x,<br /><br />"+
              "The repository " + reponame + " has been updated to version " + tag + ".<br />" +
              "Thanks,<br /><br />" +
              "x"
  })

  // Send an email to x
  MailApp.sendEmail({
    to: "user2@example.com",
    subject: reponame + " on DockerHub has been updated",
    htmlBody: "Hi x,<br /><br />"+
              "The repository " + reponame + " has been updated to version " + tag + ".<br />" +
              "Thanks,<br /><br />" +
              "x"
  })
}
````

3. Save the script and click on `Publish`, Deploy as a web app and it can be accessed from anyone.

4. Copy the link (URL) and go to your repository in the Docker Hub. Go to the section `Webhooks` and create a new one and paste it the URL.

5. To check that is working, commit a new changes that you are doing in the container in the same repository that you added the webhook, and finally push the new image you have created with the commit.

6. Wait a few seconds and you will receive an email informing that there is a new version of the project.

AMAZING JOB, you can create a webhook to inform the version of the project to the people!
