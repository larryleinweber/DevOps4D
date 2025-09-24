#!/bin/bash

# Variables
RESOURCE_GROUP="MyResourceGroup5"
LOCATION="eastus"
APP_SERVICE_PLAN="MyAppServicePlan5"
WEBAPP_NAME="DevOps4D"  # Must be globally unique

# Create Resource Group
az group create --name "$RESOURCE_GROUP" --location "$LOCATION"

# Create App Service Plan
az appservice plan create \
  --name "$APP_SERVICE_PLAN" \
  --resource-group "$RESOURCE_GROUP" \
  --location "$LOCATION" \
  --sku B1 \
  --is-linux

# Create Web App
az webapp create \
  --name "$WEBAPP_NAME" \
  --resource-group "$RESOURCE_GROUP" \
  --plan "$APP_SERVICE_PLAN" \
  --runtime "PYTHON|3.11"
