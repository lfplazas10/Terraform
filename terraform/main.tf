resource "google_container_cluster" "cloudweekend" {
  name               = "${var.cluster_name}"
  zone               = "${var.gcp_zone}"
  initial_node_count = "${var.initial_node_count}"
  min_master_version = "1.9.7-gke.0"

  additional_zones = "${var.gcp_additional_zones}"

  node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]

    labels {
      foo = "bar"
    }

    tags = ["foo", "bar"]
  }
}

data "kubernetes_service" "cloudweekend" {
  metadata {
    name = "myapp-service"
  }
}

variable "subdomain_suffix" {
  default = ""
}


resource "cloudflare_record" "domain" {
  count  = "${length(var.my_domains)}"
  domain = "cloudweekend.kiwi"
  name   = "${var.my_domains[count.index]}${var.subdomain_suffix}"
  value  = "35.186.195.90"
  type   = "A"
  ttl    = 120
}

resource "null_resource" "get-cluster-credentials" {
  provisioner "local-exec" {
    command = "gcloud container clusters get-credentials ${google_container_cluster.cloudweekend.name} --zone europe-west1-d"
  }
}

resource "kubernetes_service" "myapp-service" {
  depends_on = ["null_resource.get-cluster-credentials"]
  "metadata" {
    name = "myapp-service"
  }
  "spec" {
    port {
      port = 80
      target_port = 80
    }
    selector {
      app = "myapp-pod"
    }
    type = "NodePort"
  }
}

resource "kubernetes_service" "myapp-canary-service" {
  depends_on = ["null_resource.get-cluster-credentials"]
  "metadata" {
    name = "myapp-canary-service"
  }
  "spec" {
    port {
      port = 80
      target_port = 80
    }
    selector {
      app = "myapp-pod"
      track = "canary"
    }
    type = "NodePort"
  }
}