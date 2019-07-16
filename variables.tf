variable "namespace" {
  description = "Namespace (e.g. `cp` or `glimte`)"
  type        = string
  default     = ""
}

variable "account" {
  description = "account (e.g. `prod`, `dev`, `staging`)"
  type        = string
  default     = ""
}

variable "environment" {
  type    = string
  default = ""
}

variable "name" {
  description = "Name  (e.g. `app` or `cluster`)"
  type        = string
}

variable "delimiter" {
  type        = string
  default     = "-"
  description = "Delimiter to be used between `namespace`, `account`, `name` and `attributes`"
}

variable "attributes" {
  type        = list(string)
  default     = []
  description = "Additional attributes (e.g. `logs`)"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Additional tags (e.g. map('BusinessUnit`,`XYZ`)"
}

#Module related variables

variable "enable_ebs_volume" {
  default     = false
  description = "if true, will enable and attach an extra EBS Volume"
}

variable "instance_type" {
  default     = "t2.micro"
  description = "The Instance type to launch (Defaults to free tier)"
}

variable "subnet_ids" {
  default     = []
  description = "The subnets to associate with the aws_instance"
}

variable "vpc_id" {
  default = ""
}
variable "enable_r53_dns" {
  default = false
  description = "whether or not to use route53 to host dns settings for elastic cluster, used among nodes for discovery"
}

variable "cluster_dns_domain" {
  default     = "es.internal"
  description = "String(optional, \"\"): R53 master name to use for setting elastic DNS records. No records are created when not set"
}

variable "cluster_dns_hostname" {
  default     = "cluster"
  description = "The A-record for the elastic cluster"
}

variable "instance_count" {
  default     = 1
  description = "Number of  Instances to create (defaults to 1)"
}

variable "enable_dynamic_public_ip" {
  description = "bool (optional), instructs to override subnet default settings for public ip (dhcp and NOT elastic ip)"
  default     = false
}

variable "enable_eip" {
  default     = false
  description = "If set to true, it enables and attaches an elastic ip to the instance"
}

variable "volume_type" {
  description = "String(optional, \"gp2\"): EBS volume type to use"
  default     = "gp2"
}

variable "volume_size" {
  description = "Int(required): EBS volume size (in GB) to use"
  default     = 0
}

variable "volume_iops" {
  description = "Int(required if volume_type=\"io1\"): Amount of provisioned IOPS for the EBS volume"
  default     = 0
}

variable "volume_path" {
  description = "String(optional, \"/var/lib/elasticsearch/data\"): Mount path of the EBS volume"
  default     = "/var/tmp"
}

variable "vpc_security_group_ids" {
  description = "A list of security group IDs to associate with"
  type        = list(string)
}

variable "password_admin" {
  description = "A hashed password to associate with admin account, defaults to admin"
  type = string
  default = "$2a$12$VcCDgh2NDk07JGN0rjGbM.Ad41qVR/YFJcgHp0UGns5JDymv..TOG"
}

variable "password_kibanaserver" {
  description = "A hashed password to associate with admin account, defaults to kibanaserver"
  type = string
  default = "$2a$12$4AcgAt3xwOWadA5s5blL6ev39OXDNhmOesEoo33eZtrq2N0YrU3H."
}

variable "es_node_type" {
  description = "The type of node to install (Required, valid inputs are 'single', 'cluster', 'coordinator' or 'none')"
  default = "none"
}

variable "es_cluster_name" {
  description = "The name to use for your cluster, defaults to elasticsearch"
  default = "elasticsearch"
}

variable "enable_kibana" {
  description = "Instructs to install kibana, if es_node_type is set to 'cluster' elastic will act as coordinating node only "
  default = false
}
variable "ssh_keypair" {
  description = "(required)the name of the keypair to asociate with the ec2 instance" 
}
variable "enable_logstash" {
  description = "Instructs to install Logstash, if connecting to a cluster set es_node_type as 'coordinator' node only"
  default = false
}
variable "instance_profile" {
  description = "the instance profile to attach to the ec2 instance (Optional, Defaults to null)"
  default = null
}