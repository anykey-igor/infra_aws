#----------------------------------------------------
# Create security group HTTP with prefix list for ALB
#----------------------------------------------------
resource "aws_security_group" "sg_alb_http_pl_easteu" {
  name        = "${lower(var.project)}-sg-alb-http-pl-easteu-${lower(var.orchestration)}-${lower(var.environment)}"
  description = "${lower(var.project)}-sg-alb-http-pl-easteu-${lower(var.orchestration)}-${lower(var.environment)}"
  vpc_id      = var.vpc_id
  ingress {
    prefix_list_ids = ["pl-number"] #
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
  }
  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
  }
  tags = merge(
    {
      Name = "${lower(var.project)}-sg-alb-http-pl-easteu-${lower(var.orchestration)}-${lower(var.environment)}"
    },
    var.tags
  )
}

## Create security group-2 for ALB
resource "aws_security_group" "sg_alb_http_pl_asia" {
  name        = "${lower(var.project)}-sg-alb-http-pl-asia-${lower(var.orchestration)}-${lower(var.environment)}"
  description = "${lower(var.project)}-sg-alb-http-pl-asia-${lower(var.orchestration)}-${lower(var.environment)}"
  vpc_id      = var.vpc_id
  ingress {
    prefix_list_ids = ["pl-number"]
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
  }
  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
  }
  tags = merge(
    {
      Name = "${lower(var.project)}-sg-alb-http-pl-asia-${lower(var.orchestration)}-${lower(var.environment)}"
    },
    var.tags
  )
}

#----------------------------------------------------
# Create security group HTTPS with prefix list for ALB
#----------------------------------------------------
resource "aws_security_group" "sg_alb_https_pl_easteu" {
  name        = "${lower(var.project)}-sg-alb-https-pl-easteu-${lower(var.orchestration)}-${lower(var.environment)}"
  description = "${lower(var.project)}-sg-alb-https-pl-easteu-${lower(var.orchestration)}-${lower(var.environment)}"
  vpc_id      = var.vpc_id
  ingress {
    prefix_list_ids = ["pl-number"]
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
  }
  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
  }
  tags = merge(
    {
      Name = "${lower(var.project)}-sg-alb-https-pl-easteu-${lower(var.orchestration)}-${lower(var.environment)}"
    },
    var.tags
  )
}

# Create security group with prefix list asia for ALB
resource "aws_security_group" "sg_alb_https_pl_asia" {
  name        = "${lower(var.project)}-sg-alb-https-pl-asia-${lower(var.orchestration)}-${lower(var.environment)}"
  description = "${lower(var.project)}-sg-alb-https-pl-asia-${lower(var.orchestration)}-${lower(var.environment)}"
  vpc_id      = var.vpc_id
  ingress {
    prefix_list_ids = ["pl-number"]
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
  }
  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
  }
  tags = merge(
    {
      Name = "${lower(var.project)}-sg-alb-https-pl-asia-${lower(var.orchestration)}-${lower(var.environment)}"
    },
    var.tags
  )
}

#--------------------------------------------------------------------------------------------------------------------#
# Create security group for ECS with ALB
#--------------------------------------------------------------------------------------------------------------------#
resource "aws_security_group" "sg_ecs_service" {
  name        = "${lower(var.project)}-sg-service-${lower(var.orchestration)}-${lower(var.environment)}"
  description = "${lower(var.project)}-sg-service-${lower(var.orchestration)}-${lower(var.environment)}"
  vpc_id = var.vpc_id
  ingress {
    from_port = 8080
    to_port   = 8080
    protocol = "tcp"
    security_groups = [
      aws_security_group.sg_alb_http_pl_asia.id,
      aws_security_group.sg_alb_http_pl_easteu.id,
      aws_security_group.sg_alb_https_pl_asia.id,
      aws_security_group.sg_alb_https_pl_easteu.id
    ]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = merge(
    {
      Name = "${lower(var.project)}-sg-service-${lower(var.orchestration)}-${lower(var.environment)}"
    },
    var.tags
  )
}

#--------------------------------------------------------------------------------------------------------------------#
# Create security group for DataBase with ECS
#--------------------------------------------------------------------------------------------------------------------#
resource "aws_security_group" "sg_ecs_db" {
  name        = "${lower(var.project)}-sg-ecs-db-${lower(var.orchestration)}-${lower(var.environment)}"
  description = "${lower(var.project)}-sg-ecs-db-${lower(var.orchestration)}-${lower(var.environment)}"
  vpc_id      = var.vpc_id
  ingress {
    cidr_blocks     = var.private_subnet_cidr
    security_groups = [aws_security_group.sg_ecs_service.id]
    from_port       = var.port
    to_port         = var.port
    protocol        = "tcp"
  }
  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
  }
  tags = merge(
    {
      Name = "${lower(var.project)}-sg-ecs-db-${lower(var.orchestration)}-${lower(var.environment)}"
    },
    var.tags
  )
}