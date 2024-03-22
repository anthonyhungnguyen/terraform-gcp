# Create dataproc cluster
resource "google_dataproc_cluster" "default" {
  name                          = "my-dataproc-cluster"
  region                        = var.region
  graceful_decommission_timeout = "120s"
  labels = {
    dataproc = "testing"
  }

  cluster_config {
    staging_bucket = var.staging_bucket
    endpoint_config {
      enable_http_port_access = "true" # Enable component gateway
    }

    gce_cluster_config {
      tags = ["dataproc"]
    }

    master_config {
      num_instances = 1
      machine_type  = var.instance_type
      disk_config {
        boot_disk_type    = "pd-ssd"
        boot_disk_size_gb = 30
      }

    }
    worker_config {
      num_instances = 2
      machine_type  = var.instance_type
      disk_config {
        boot_disk_size_gb = 30
        num_local_ssds    = 0
      }
    }
    preemptible_worker_config {
      num_instances = 0
    }

    software_config {
      image_version = "2.2-debian12"
      optional_components = [
        "DOCKER",
        "JUPYTER",
      ]
      override_properties = {
        "dataproc:dataproc.allow.zero.workers" = "true"
      }
    }
    # You can define multiple initialization_action blocks
    initialization_action {
      script      = "gs://dataproc-initialization-actions/stackdriver/stackdriver.sh"
      timeout_sec = 500
    }
  }
}
