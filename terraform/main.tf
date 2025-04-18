provider "azurerm" {
  features {}
  subscription_id = "054f2ec0-512e-4743-b678-f72b4ac7435f"
}

resource "azurerm_resource_group" "this" {
  name     = "rg-jenkins"
  location = var.location
}

resource "azurerm_service_plan" "this" {
  name                = "appserviceplan-jenkins"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  os_type             = "Windows"
  sku_name            = "B1"
}

resource "azurerm_linux_web_app" "this" {
  name                = "webapijenkinaditya827813"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  service_plan_id     = azurerm_service_plan.this.id

  site_config {
    application_stack {
      node_version = "18-lts" # Use the Node.js version compatible with your React app
    }
  }

  identity {
    type = "SystemAssigned"
  }
}
