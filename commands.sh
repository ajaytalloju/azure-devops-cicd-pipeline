#!/usr/bin/env bash

#To generate ssh key
ssh-keygen -t rsa
cat .ssh/id.rsa.pub
ssh -T git@github.com

#Setup environment and test prediction
git clone git@github.com:ajaytalloju/azure-devops-cicd-pipeline.git
cd azure-devops-cicd-pipeline/
make setup
source ~/.azure-devops-cicd-pipeline/bin/activate
make all
python app.py
sh make_prediction.sh


#Deploy webapp and check prediction
az webapp up -n ajay-flask-ml-webapp -g Azuredevops --sku B1
az webapp show -n ajay-flask-ml-webapp -g Azuredevops --query defaultHostName
sh make_predict_azure_app.sh
