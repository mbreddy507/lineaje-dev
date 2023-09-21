### General Variables ###

variable "namespace" {
  description = "Namespace for resource names"
  default     = "lineaje"
  type        = string
}

variable "domain_name" {
  type        = string
  description = "The domain name for the website."
  default     = "lineajebuchidemor53.com"
}

variable "r53_zone_id" {
  type        = string
  description = "The zone ID of the domain you are deploying to, you can get it from R53 DNS Dashboard"
  default     = "Z08828902HUF197JM8ME"
}

### EC2 Values ###
variable "instance_type" {
  type        = string
  description = "Define the EC2 Instance type for the ecs cluster"
  default     = "t3.micro"
}

### ECS ###
variable "container_image" {
  type        = string
  description = "Define what docker image will be deployed to the ECS task"
  default     = "458087513482.dkr.ecr.us-east-1.amazonaws.com/demo:latest"
}
variable "environment" {
  type        = string
  description = "Environment for deployment (like dev or staging)"
  default     = "dev"
}

variable "service" {
  type        = string
  description = "Service."
  default     = "serv1"
}

variable "clustername" {
  type        = string
  description = "Service."
  default     = "ecs-folderit-cluster"
}
variable "containers_min" {
    type= number
    default=1
}
variable "containers_max" {
    type= number
    default=1
}
variable "service_role"{
    type= string
    default= "arn:aws:iam::458087513482:role/ecs-service-autoscale-role"
}

variable "service_name" {
  description = "A Docker image-compatible name for the service"
  type        = string
  default     = "demo"
}

variable "container_port" {
  description = "Port of the container"
  type        = number
  default     = 5001
}

variable "scenario" {
  description = "Scenario name for tags"
  default     = "scenario-ecs-ec2"
  type        = string
}
