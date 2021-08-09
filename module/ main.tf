terraform {
  required_version = ">= 0.13.5"
}

resource "local_file" "file" {
  content = var.text
  filename = "${path.module}/${var.filename}.txt"
  directory_permission = "0755"
  file_permission = "0644"
}
