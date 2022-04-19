param basename string = 'sjr-web'
param acrname string = 'sjrwebacr01'
param location string = resourceGroup().location

resource acr 'Microsoft.ContainerRegistry/registries@2021-12-01-preview' = {
  name: acrname
  location: location
  sku: {
    name: 'Basic'
  }
}

resource asp 'Microsoft.Web/serverfarms@2021-03-01' = {
  name: '${basename}-asp01'
  location: location
  kind: 'linux'
  sku: {
    name: 'F1'
  }
}
