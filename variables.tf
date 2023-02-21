variable "parent"{
    type = string
}

variable "key_name"{
    type = string
}

variable "key_description"{
    type = string
    default = "Key for a tag in GCP."
}

variable "values_list" {
    type = list(string)
}