provider "google" {
    project = "siva-sai-447213"
    region = "us-central1"
    
}
resource "google_compute_network" "network-a" {
    name = "network-a"
    auto_create_subnetworks = false
}
resource "google_compute_subnetwork" "subnet-a" {
    name = "subnet-a"
    ip_cidr_range = "10.1.0.0/24"
    region = "us-central1"
    network = google_compute_network.network-a.id
}
variable "vm_count" {
        type = number
        default = 4
    }
    resource "google_compute_instance"  "vm-1" {
    count =  var.vm_count
    name = "gcp-vm-${count.index}"
    zone = "us-central1-a"
    machine_type = "e2-medium"

    boot_disk{
        initialize_params {
            image = "debian-cloud/debian-11"
            size = 15
            type = "pd-standard"
        }
    }
    # attach-network
    network_interface{
        subnetwork = google_compute_subnetwork.subnet-a.id
        access_config {}
    }
}
