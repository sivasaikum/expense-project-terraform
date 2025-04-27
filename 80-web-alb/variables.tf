variable "project" {
    default = "expense"

}

variable "environment" {
    default = "dev"
}

variable "common_tags" {
    default = {
        project = "expense"
        environment = "dev"
        terraform = "true"
    }
}

variable "zone_id" {
    default = "Z07970201GQ9NLKSTIP76"
}

variable "domain_name" {
    default = "jobsearchindia.online"
}