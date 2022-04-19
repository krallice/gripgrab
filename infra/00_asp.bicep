param basename string = 'sjr-web'
param acrname string = 'sjrwebacr01'
param location string = resourceGroup().location

param dockerRegistryHost string = 'sjrwebacr01.azurecr.io'
param dockerUsername string = 'sjrwebacr01'
@secure()
param dockerPassword string
param dockerImage string = 'gripgrab:latest'

resource acr 'Microsoft.ContainerRegistry/registries@2021-12-01-preview' = {
  name: acrname
  location: location
  sku: {
    name: 'Basic'
  }
  properties: {
    adminUserEnabled: true
  }
}

resource asp 'Microsoft.Web/serverfarms@2020-06-01' = {
  name: '${basename}-asp01'
  kind: 'linux'
  location: location
  sku: {
    name: 'F1'
  }
  properties: {
    reserved: true
  }
}

resource gripgrab 'Microsoft.Web/sites@2016-08-01' = {
  name: '${basename}-gripgrab'
  location: location
  properties: {
    siteConfig: {
      appSettings: [
        {          
          name: 'WEBSITES_ENABLE_APP_SERVICE_STORAGE'          
          value: 'false'        
        }        
        {          
          name: 'DOCKER_REGISTRY_SERVER_URL'          
          value: 'https://${dockerRegistryHost}'        
        }        
        {          
          name: 'DOCKER_REGISTRY_SERVER_USERNAME'          
          value: dockerUsername        
        }        
        {          
          name: 'DOCKER_REGISTRY_SERVER_PASSWORD'          
          value: dockerPassword        
        }
      ]
      linuxFxVersion: 'DOCKER|${dockerRegistryHost}/${dockerImage}'
    }
    serverFarmId: asp.id
  }
}
