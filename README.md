[![CircleCI](https://circleci.com/gh/kbaafi/ml-microservice-kubernetes.svg?style=svg)](https://circleci.com/gh/kbaafi/ml-microservice-kubernetes)

# Operationalizing a Machine Learning Microservice API

---

## Overview

The purpose of this project is to apply Devops practises to the operationalization of machine learning models. More specifically we are focused on exposing a machine learning algorithm online through a Flask based web service.

Using a pre-trained, `sklearn` model that has been trained to predict housing prices in Boston. To find out more about the data source used for this project, please check out the following link: [the data source site](https://www.kaggle.com/c/boston-housing). This project goes through the post development work needed to host web apis such as making and linting, building a Docker image and testing it, deploying to Kubernetes, and performing predictions via the web.

---

## 1. Setting up the environment

* Review the `Makefile`
* Create a virtualenv and activate it
* Run `make install` to install the necessary dependencies

## 2. Testing with CircleCI

There are two options for testing with CircleCI, online and local

* For local run `make run-circleci-local`
* For online, connect the git repository containing this application to your account on CircleCI and build directly on CircleCI. If the tests pass, then the docker image can be built

## 3. Preparing the Docker image

For an example of this see the `Dockerfile`

* Choose a base image. In our case : python:3.7.3-stretch
* Setup the copy commands from localhost to docker
* Setup installations of dependencies
* Expose port 80
* Configure startup commands

To build the image, run `sudo docker build <home_folder> -t <docker_tag>`

To run the container, run `sudo docker run -p <port_on_local>:80 <docker_tag>`

See `run_docker.sh`

## 4. Testing the Docker image

* Run `curl` to test the api
* Check `make_predictions.sh`: edit to match `<port_on_local>`
* If tests succeed, the image is ready to be uploaded to a container registry, in our case **DockerHub**
* Upload the docker image to dockerhub using `upload_docker.sh`

    Alternatively, DockerHub can be configured to rebuild the docker image from the github repository after each push.....Cool right?

## 5. Deploying on Kubernetes

Our Kubernetes deployment strategy is based on yaml configuration files which store all the details of our deployment. See the folder `.kubernetes`. Our application is isolated from the rest of Kubernetes using **Namespaces**. See `namespace.yaml`, `service.yaml`, and `deployment.yaml`

Run `run_kubernetes.sh` to download the image, and setup the application on Kubernetes

The last commannd in `run_kubernetes.sh` return a result such as shown below:

| NAME  |  TYPE |  CLUSTER-IP |  EXTERNAL-IP |  PORT(S) |
|---|---|---|---|---|
|  boston-house-prices |  NodePort |  10.97.76.57 |  [None] |  8000:31910/TCP |

The endpoint for your application will be **10.97.76.57:31910**

Now we can make predictions from Kubernetes

## 6. Making predictions

* Run `make_prediction_knetes.sh` to make a prediction from the Kubernetes cluster

# Prediction Outputs

* Outputs to running the api on a standalone docker container  can be found at **output_txt_files/docker_out.txt**
* Outputs to running the api on the Kubernetes cluster can be found at **output_txt_files/kubernetes_out.txt**
