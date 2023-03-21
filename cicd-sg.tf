resource "aws_security_group" "cicd-sg" {
  name        = "cicd"
  description = "Allow apache inbound traffic"
  vpc_id      = "vpc-040237ed50ae417f6"
    ingress {
    description      = "TLS from user"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    }

  ingress {
    description      = "TLS from ssh"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
 ingress {
    description      = "TLS from jenkins"
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
 }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
      Name        = "cicd-sg"
    }

}


resource "aws_instance" "cicd" {
  ami                         = "ami-06489866022e12a14"
  instance_type               = "t2.micro"
  vpc_security_group_ids            = [aws_security_group.cicd-sg.id]
 user_data                   = file("scripts/cicd-user.sh")
key_name = aws_key_pair.deployer.id

  tags ={
      Name        = "cicd"

    }
}