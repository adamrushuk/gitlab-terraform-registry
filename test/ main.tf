module "my_module_name" {
  # source = "gitlab.com/<namespace>/<module_name>/<module_system>"
  #   source = "localhost:8082/root/test-file/local"
  source = "localhost/root/test-file/local"
  #   version = "0.0.3"

  text     = "Hello World"
  filename = "hello"
}

output "filesize_in_bytes" {
  value = module.my_module_name.bytes
}
