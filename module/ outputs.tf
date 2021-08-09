output "bytes" {
  value = length(local_file.file.content)
}
