variable "regiao" {
  type    = string
  default = "us-east-1"
}

variable "key_name" {
  nullable = false
}

variable "path_key" {
  nullable = false
}

variable "image_id" {
  type    = string
  default = "ami-0e2c8caa4b6378d8c"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}