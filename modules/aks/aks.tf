resource "azurerm_kubernetes_cluster" "aks-cluster" {
  name                      = "${var.RGNAME}-cluster"
  location                  = var.LOCATION
  resource_group_name       = var.RGNAME
  dns_prefix                = "${var.RGNAME}-cluster"


  default_node_pool {
    name                    = "default"
    node_count              = 1
    vm_size                 = "Standard_D2_v2"
    vnet_subnet_id          = var.SUBNETS[0]
  }

  identity {
    type                    = "SystemAssigned"
  }

  tags = {
    Environment             = var.RGNAME
  }
}

resource "local_file" "private_key" {
  content  = azurerm_kubernetes_cluster.aks-cluster.kube_config_raw
  filename = "/tmp/kubeconfig"
}

resource "null_resource" "kube-apply" {
  depends_on = [local_file.private_key]

  provisioner "local-exec" {
    command = "/usr/local/bin/kubectl --kubeconfig=/tmp/kubeconfig apply -f ${path.module}/web-server.yml"
  }
}