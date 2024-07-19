variable "session_number" {
  type        = string
  description = "Session number."
}

variable "tag_key" {
  type        = string
  description = "Tag key."
}

variable "tag_value" {
  type        = string
  description = "Tag value."
}

variable "traffic_mirror_filter_id" {
  type        = string
  description = "Traffic mirror filter id."
}

variable "traffic_mirror_target_id" {
  type        = string
  description = "Traffic mirror target id."
}

variable "virtual_network_id" {
  type        = string
  description = "Virtual network id."
}

variable "lambda_architecture" {
  type        = list(any)
  description = "Architecture for your Lambda function. Valid values are x86_64 and arm64. Default is x86_64"
  default     = ["x86_64"]
}
