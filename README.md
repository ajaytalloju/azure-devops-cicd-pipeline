
[![Python Application test with GitHub Actions](https://github.com/ajaytalloju/azure-devops-cicd-pipeline/actions/workflows/pythonapp.yml/badge.svg)](https://github.com/ajaytalloju/azure-devops-cicd-pipeline/actions/workflows/pythonapp.yml)

[![Build Status](https://dev.azure.com/odluser286298/azure-devops-cicd-pipeline/_apis/build/status%2Fajaytalloju.azure-devops-cicd-pipeline?branchName=main)](https://dev.azure.com/odluser286298/azure-devops-cicd-pipeline/_build/latest?definitionId=1&branchName=main)

# Overview

In this project you will deploy Flask-based machine learning application that predicts housing prices using a pre-trained scikit-learn model. The application leverages Azure DevOps principles to implement Continuous Integration (CI) and Continuous Delivery (CD).

Source code control with GitHub.  
Continuous Integration (CI) using GitHub Actions for linting, testing, and installation.  
Continuous Delivery (CD) with Azure Pipelines for automated deployment.  
Deployment to Azure App Service (PaaS) running a Flask-based ML API.  

## Project Plan

* Link to Trello Board: [Trello Board](https://trello.com/invite/b/68a98088f34b1b0dd009487e/ATTI270cf3de6531b6073ab898cd74c2e4f91706B70D/azure-devops-project-2-ci-cd-pipeline)
* Link to spreadsheet of project plan: [Project plan](https://docs.google.com/spreadsheets/d/1xD8k5tAZsOyudxcCCzJGMHDJgEwFAX-DFNKFdtgRHn4/edit?usp=sharing)

## Instructions

* Architectural Diagram

![CI Diagram](images/CI%20diagram.png)  
![CD Diagram](images/CD%20diagram.png)

### 1. Configuring Github

Login to Azure cloud shell  
Generate ssh key

```bash
ssh-keygen -t rsa
```

Copy the key and paste it in Github > Settings> SSH and GPG keys
```bash
cat .ssh/id.rsa.pub
```

Test ssh connection to github

```bash
ssh -T git@github.com
```
![SSH connection](images/successful%20ssh%20connection%20from%20cloud%20shell.png)

### 2. Setup environment

Clone the Repository

```bash
git clone git@github.com:ajaytalloju/azure-devops-cicd-pipeline.git
```

![Project cloned into Azure Cloud Shell](images/git%20repo%20clone.png)

Create virtual environment

```bash
cd azure-devops-cicd-pipeline
make setup
```

Activate venv

```bash
source ~/.azure-devops-cicd-pipeline/bin/activate
```

Install dependencies and run linting, testing

```bash
make all
```

![Successful Tests](images/make%20all%20success.png)

* Output of a test run

![Test Run](images/app.py%20test%20run.png)

* Test prediction

![Test prediction](images/successful%20prediction%20test.png)

### 3. Creating Azure webapp

```bash
az webapp up -n ajay-flask-ml-webapp -g Azuredevops --sku B1
```

Check URL of webapp

```bash
az webapp show -n ajay-flask-ml-webapp -g Azuredevops --query defaultHostName
```

![Webapp Info](images/get%20webapp%20URL.png)

* Check prediction from webapp

```bash
sh make_predict_azure_app.sh
```

![Webapp prediction](images/successful%20prediction%20webapp.png)

* Check logs of webapp

```bash
az webapp log tail -n ajay-flask-ml-webapp -g Azuredevops
```

![Log](images/Streamline%20log%20of%20webapp.png)

* Check web interface of application

![Web interface](images/App%20running%20web%20interface.png)

### 4. Setup CI/CD pipeline

* Setup CI using Github Actions

![CI](images/CI%20success%20using%20github%20actions.png)

* Setup Azure Pipelines

Login to Azure Devops Organization  
Create a project with Github as source code repository  
A push will run the pipeline automatically  

![Azure Pipeline](images/Successful%20Azure%20pipeline%203.png)

[Note the official documentation should be referred to and double checked as you setup CI/CD](https://docs.microsoft.com/en-us/azure/devops/pipelines/ecosystems/python-webapp?view=azure-devops).

### 5. Load Test

* Check performance test using locust

```bash
pip install locust
locust -f locustfile.py --host=https://ajay-flask-ml-webapp.azurewebsites.net
```
![Locust Log](images/load%20test%20using%20locust%20chart.png)

## Enhancements

* Kubernetes Deployment: Containerize with Docker and deploy using Azure Kubernetes Service (AKS) for scalability.
* Monitoring: Integrate Azure Monitor or Application Insights to track performance and errors.

## Demo
[Link](https://youtu.be/UtmLsmbKdus)