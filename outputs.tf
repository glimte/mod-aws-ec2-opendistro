output "label_id" {
  value = module.null_label.id
}

output "private_ip" {
  value = aws_instance.default.*.private_ip
}

output "id" {
  value = aws_instance.default.*.id
}
