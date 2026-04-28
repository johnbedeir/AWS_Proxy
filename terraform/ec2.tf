resource "aws_instance" "backend" {
  ami                         = data.aws_ami.amazon_linux_2023.id
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.private.id
  vpc_security_group_ids      = [aws_security_group.backend.id]
  associate_public_ip_address = false
  user_data                   = base64encode(file("${path.module}/templates/backend_user_data.sh"))

  user_data_replace_on_change = true

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 1
  }

  root_block_device {
    # AL2023 AMI root snapshot requires >= 30 GiB
    volume_size           = 30
    volume_type           = "gp3"
    delete_on_termination = true
  }

  tags = {
    Name = "${var.project_name}-backend"
  }
}

resource "aws_instance" "proxy" {
  ami                         = data.aws_ami.amazon_linux_2023.id
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.public.id
  vpc_security_group_ids      = [aws_security_group.proxy.id]
  associate_public_ip_address = true
  key_name                    = var.key_name

  user_data = base64encode(templatefile("${path.module}/templates/proxy_user_data.sh.tftpl", {
    backend_private_ip = aws_instance.backend.private_ip
  }))

  user_data_replace_on_change = true

  depends_on = [aws_instance.backend]

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 1
  }

  root_block_device {
    volume_size           = 30
    volume_type           = "gp3"
    delete_on_termination = true
  }

  tags = {
    Name = "${var.project_name}-proxy"
  }
}
