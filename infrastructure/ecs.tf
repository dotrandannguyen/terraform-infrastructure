resource "aws_ecs_cluster" "main" {
  name = "${var.project_name}-cluster"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

resource "aws_ecs_task_definition" "app" {
  family                   = "${var.project_name}-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = 256
  memory                   = 512
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn

  # Dùng image cơ bản trong lần đầu (tránh lỗi chưa có image). Sau này CI/CD sẽ update.
  container_definitions = jsonencode([{
    name      = "backend"
    image     = "nginxdemos/hello:latest" # Dummy image để vượt qua bước tạo
    essential = true
    portMappings = [{
      containerPort = 3000
      hostPort      = 3000
      protocol      = "tcp"
    }]
    logConfiguration = {
      logDriver = "awslogs"
      options = {
        "awslogs-group"         = "/ecs/${var.project_name}-backend"
        "awslogs-region"        = var.aws_region
        "awslogs-stream-prefix" = "ecs"
      }
    }
  }])
}

resource "aws_ecs_service" "app" {
  name            = "${var.project_name}-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.app.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  # Bỏ qua thay đổi về task_definition khi apply (CI/CD quản lý bản mới nhất)
  lifecycle {
    ignore_changes = [task_definition]
  }

  network_configuration {
    security_groups  = [aws_security_group.ecs_sg.id]
    subnets          = [for subnet in aws_subnet.public : subnet.id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.app.arn
    container_name   = "backend"
    container_port   = 3000
  }
}
