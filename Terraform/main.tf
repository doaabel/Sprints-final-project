resource "aws_instance" "my-machine" {
  # Creates two identical aws ec2 instances
  count = 2     
  
  # Two instances will have the same ami and instance_type
  ami = "ami-067d1e60475437da2"
  instance_type = "t2.micro"
  tags = {
    Name = "my-machine-${count.index}"
  }
  vpc_security_group_ids      = ["${aws_security_group.sg.id}"]
  key_name                    = aws_key_pair.key.key_name
}

resource "tls_private_key" "pk" {
     algorithm = "RSA"
     rsa_bits = 4096
 }

 resource "aws_key_pair" "key" {
   key_name   = "key_pair"
   public_key = tls_private_key.pk.public_key_openssh

   provisioner "local-exec" {
     command = "echo '${tls_private_key.pk.private_key_pem}' > ../Ansible/key_pair.pem"
   }
 }

resource "aws_security_group" "sg" {
  name        = "sg"

  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

    ingress {
    from_port        = 6443
    to_port          = 6443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

    ingress {
    from_port        = 10250
    to_port          = 10250
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

    ingress {
    from_port        = 8472
    to_port          = 8472
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

    ingress {
    from_port        = 8472
    to_port          = 8472
    protocol         = "udp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

    ingress {
    from_port        = 8472
    to_port          = 8472
    protocol         = "udp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

    ingress {
    from_port        = 2379
    to_port          = 2380
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

    ingress {
    from_port        = 30000
    to_port          = 32767
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

    egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

}