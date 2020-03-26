resource "aws_security_group" "app_sg" {
  name                  = "app_sg"
  description           = "custom app rules"
  vpc_id                = var.vpc_id

  ingress {
    from_port           = 3389
    to_port             = 3389
    protocol            = "tcp"
    cidr_blocks         = var.cidr_app_sg
  }
  ingress {
    from_port           = 80
    to_port             = 80
    protocol            = "tcp"
    cidr_blocks         = ["0.0.0.0/0"]
  }

  ingress {
    from_port           = 443
    to_port             = 443
    protocol            = "tcp"
    cidr_blocks         = ["0.0.0.0/0"]
  }

  egress   {
    from_port           = 0
    to_port             = 0
    protocol            = "-1"
    cidr_blocks         = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "db_sg" {
  name                  = "db_sg"
  description           = "custom db rules"
  vpc_id                = var.vpc_id

  ingress {
    from_port           = 5432
    to_port             = 5432
    protocol            = "tcp"
    security_groups     = [aws_security_group.app_sg.id]
  }

  egress   {
    from_port           = 0
    to_port             = 0
    protocol            = "-1"
    security_groups     = [aws_security_group.app_sg.id]
  }
}

resource "aws_instance" "ec2" {
    ami                     = var.ami
    count                   = var.instance_count
    instance_type           = var.instance_type
    key_name                = var.key_name
    subnet_id               = var.subnet_id
    vpc_security_group_ids  = [aws_security_group.app_sg.id]
    tags                    = var.tags
}   

resource "aws_rds_cluster" "dbcluster" {    
    cluster_identifier        = var.cluster_identifier
    engine                    = var.engine
    engine_mode               = var.engine_mode
    engine_version            = var.engine_version
    database_name             = var.db_name
    master_username           = var.db_user
    master_password           = var.db_password
    db_subnet_group_name      = aws_db_subnet_group.rds_subnet_group.id
    vpc_security_group_ids    = [aws_security_group.db_sg.id]
    db_cluster_parameter_group_name = aws_rds_cluster_parameter_group.aurorapg10.id
    scaling_configuration {
        max_capacity             = var.max_capacity
        min_capacity             = var.min_capacity
    }
}

resource "aws_db_subnet_group" "rds_subnet_group" {
    name        = "aurora_serverless"
    subnet_ids  = ["var.subnets"]
}

resource "aws_db_parameter_group" "aurorapg10" {
  name        = "aurorapg10"
  family      = "aurora-postgresql10"
}

resource "aws_rds_cluster_parameter_group" "aurorapg10" {
  name        = "aurorapg10"
  family      = "aurora-postgresql10"
}