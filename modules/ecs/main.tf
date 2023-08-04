#----------------------------------------------------
# Create IAM role
#----------------------------------------------------
resource "aws_iam_role" "ecsTaskExecutionRole" {
  name                 = "${lower(var.project)}-ecsTaskExecutionRole-${lower(var.orchestration)}-${lower(var.environment)}"
  assume_role_policy   = data.aws_iam_policy_document.assume_role_policy.json
  permissions_boundary = "arn:aws:iam::ACCOUNT_ID:policy/eo_role_boundary" # Predefined
}

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "ecsTaskExecutionRole_policy" {
  role       = aws_iam_role.ecsTaskExecutionRole.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

#######################################################################################

data "aws_iam_policy_document" "ecs_service_elb" {
  statement {
    effect = "Allow"
    actions = [
      "ec2:Describe*"
    ]
    resources = [
      "*"
    ]
  }
  statement {
    effect = "Allow"
    actions = [
      "elasticloadbalancing:DeregisterInstancesFromLoadBalancer",
      "elasticloadbalancing:DeregisterTargets",
      "elasticloadbalancing:Describe*",
      "elasticloadbalancing:RegisterInstancesWithLoadBalancer",
      "elasticloadbalancing:RegisterTargets"
    ]
    resources = [
      #var.elb.arn
      var.aws_alb_target_group_arn
    ]
  }
}

data "aws_iam_policy_document" "ecs_service_standard" {
  statement {
    effect = "Allow"
    actions = [
      "ec2:DescribeTags",
      "ecs:DeregisterContainerInstance",
      "ecs:DiscoverPollEndpoint",
      "ecs:Poll",
      "ecs:RegisterContainerInstance",
      "ecs:StartTelemetrySession",
      "ecs:UpdateContainerInstancesState",
      "ecs:Submit*",
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = [
      "*"
    ]
  }
}

data "aws_iam_policy_document" "ecs_service_scaling" {
  statement {
    effect = "Allow"
    actions = [
      "application-autoscaling:*",
      "ecs:DescribeServices",
      "ecs:UpdateService",
      "cloudwatch:DescribeAlarms",
      "cloudwatch:PutMetricAlarm",
      "cloudwatch:DeleteAlarms",
      "cloudwatch:DescribeAlarmHistory",
      "cloudwatch:DescribeAlarms",
      "cloudwatch:DescribeAlarmsForMetric",
      "cloudwatch:GetMetricStatistics",
      "cloudwatch:ListMetrics",
      "cloudwatch:PutMetricAlarm",
      "cloudwatch:DisableAlarmActions",
      "cloudwatch:EnableAlarmActions",
      "iam:CreateServiceLinkedRole",
      "sns:CreateTopic",
      "sns:Subscribe",
      "sns:Get*",
      "sns:List*"
    ]
    resources = [
      "*"
    ]
  }
}

resource "aws_iam_policy" "ecs_service_elb" {
  name        = "dev-to-elb"
  path        = "/"
  description = "Allow access to the service elb"

  policy = data.aws_iam_policy_document.ecs_service_elb.json
}

resource "aws_iam_policy" "ecs_service_standard" {
  name        = "dev-to-standard"
  path        = "/"
  description = "Allow standard ecs actions"

  policy = data.aws_iam_policy_document.ecs_service_standard.json
}

resource "aws_iam_policy" "ecs_service_scaling" {
  name        = "dev-to-scaling"
  path        = "/"
  description = "Allow ecs service scaling"

  policy = data.aws_iam_policy_document.ecs_service_scaling.json
}

resource "aws_iam_role_policy_attachment" "ecs_service_elb" {
  role       = aws_iam_role.ecsTaskExecutionRole.name #aws_iam_role.ecs_service.name
  policy_arn = aws_iam_policy.ecs_service_elb.arn
}

resource "aws_iam_role_policy_attachment" "ecs_service_standard" {
  role       = aws_iam_role.ecsTaskExecutionRole.name #aws_iam_role.ecs_service.name
  policy_arn = aws_iam_policy.ecs_service_standard.arn
}

resource "aws_iam_role_policy_attachment" "ecs_service_scaling" {
  role       = aws_iam_role.ecsTaskExecutionRole.name #aws_iam_role.ecs_service.name
  policy_arn = aws_iam_policy.ecs_service_scaling.arn
}

###################################################################

#----------------------------------------------------
# Create ECS cluster
#----------------------------------------------------
resource "aws_ecs_cluster" "cluster" {
  name = "${lower(var.project)}-cluster-${lower(var.orchestration)}-${lower(var.environment)}"
}

#----------------------------------------------------
# Create task definition
#----------------------------------------------------
resource "aws_ecs_task_definition" "task" {
  family = "${lower(var.project)}-task-${lower(var.orchestration)}-${lower(var.environment)}"
  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 512
  memory                   = 1024 # If the requires_compatibilities is FARGATE this field is required
  execution_role_arn       = aws_iam_role.ecsTaskExecutionRole.arn
  task_role_arn            = aws_iam_role.ecsTaskExecutionRole.arn
  container_definitions    = <<DEFINITION
  [
    {
      "name": "${lower(var.project)}-task-${lower(var.orchestration)}-${lower(var.environment)}",
      "image": "43491324121423.dkr.ecr.eu-central-1.amazonaws.com/app-backend-ecr-tf-dev:latest",
      "essential": true,
      "logConfiguration": {
        "logDriver": "awslogs",
        "options": {
          "awslogs-create-group": "true",
          "awslogs-group": "app",
          "awslogs-region": "eu-central-1",
          "awslogs-stream-prefix": "backend"
        }
      },
      "environment": [],
      "mountPoints": [],
      "volumesFrom": [],
      "portMappings": [
        {
          "protocol": "tcp",
          "containerPort": 8080,
          "hostPort": 8080
        }
      ],
      "cpu": 512,
      "memory": 1024,
      "networkMode": "awsvpc"
    }
  ]
  DEFINITION
  tags = {}
}

#----------------------------------------------------
# Create service
#----------------------------------------------------
resource "aws_ecs_service" "service" {
  name                 = "${lower(var.project)}-service-${lower(var.orchestration)}-${lower(var.environment)}"
  launch_type          = "FARGATE"
  cluster              = aws_ecs_cluster.cluster.id
  task_definition      = aws_ecs_task_definition.task.arn
  scheduling_strategy  = "REPLICA"
  force_new_deployment = true
  desired_count        = 1
  load_balancer {
    target_group_arn = var.aws_alb_target_group_arn
    container_name   = aws_ecs_task_definition.task.family
    container_port   = 8080
  }
  lifecycle {
    ignore_changes = [desired_count] # Allow external changes to happen without Terraform conflicts, particularly scaling
  }
  network_configuration {
    subnets          = var.subnets
    assign_public_ip = true # works with Fargate launch type only, default is false
    security_groups  = var.sg_ecs
  }
}

#################################################################################################
resource "aws_appautoscaling_target" "service_to_target" {
  max_capacity = var.max_capacity_service_task
  min_capacity = var.min_capacity_service_task
  resource_id = "service/${aws_ecs_cluster.cluster.name}/${aws_ecs_service.service.name}" #${var.ecs_cluster.name}/${var.ecs_service.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace = "ecs"
}

resource "aws_appautoscaling_policy" "scale_to_memory" {
  name               = "scale-to-memory"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.service_to_target.resource_id
  scalable_dimension = aws_appautoscaling_target.service_to_target.scalable_dimension
  service_namespace  = aws_appautoscaling_target.service_to_target.service_namespace
  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageMemoryUtilization"
    }
    target_value       = 80
  }
}

resource "aws_appautoscaling_policy" "scale_to_cpu" {
  name = "scale-to-cpu"
  policy_type = "TargetTrackingScaling"
  resource_id = aws_appautoscaling_target.service_to_target.resource_id
  scalable_dimension = aws_appautoscaling_target.service_to_target.scalable_dimension
  service_namespace = aws_appautoscaling_target.service_to_target.service_namespace
  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }
    target_value = 60
  }
}