output "proxy_public_ip" {
  description = "Open this in a browser (HTTP) — traffic is proxied to the private backend."
  value       = aws_instance.proxy.public_ip
}

output "proxy_public_dns" {
  description = "Public DNS of the NGINX proxy instance."
  value       = aws_instance.proxy.public_dns
}

output "backend_private_ip" {
  description = "Private IP of the backend (no direct public access)."
  value       = aws_instance.backend.private_ip
}

output "validation_hint" {
  description = "Quick checks that match PROJECT.md validation."
  value       = <<-EOT
    Success: curl http://${aws_instance.proxy.public_ip} returns "Hello from private backend".
    Backend should NOT answer on port 3000 from the internet — only the proxy subnet path is allowed by security groups.
  EOT
}
