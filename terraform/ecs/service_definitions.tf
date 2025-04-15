# ECS Service for app 1
resource "aws_ecs_service" "app1" {
  name            = "app-1-service"
  cluster         = aws_ecs_cluster.ecs_cluster.id
  task_definition = aws_ecs_task_definition.app1.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets         = var.subnets
    security_groups = [aws_security_group.ecs_task_sg.id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = var.app1_target_group_arn
    container_name   = "app1"           # <-- Correct from your task def
    container_port   = 5000
  }
  depends_on = [aws_lb_listener.app1_listener]
}

# ECS Service for app 2
resource "aws_ecs_service" "app2" {
  name            = "app-2-service"
  cluster         = aws_ecs_cluster.ecs_cluster.id
  task_definition = aws_ecs_task_definition.app2.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets         = var.subnets
    security_groups = [aws_security_group.ecs_task_sg.id]
    assign_public_ip = true
  }

  # Uncomment this if app2 has ALB:
  # load_balancer {
  #   target_group_arn = var.app2_target_group_arn
  #   container_name   = "app2-container"   # From task def
  #   container_port   = 5000
  # }
}
