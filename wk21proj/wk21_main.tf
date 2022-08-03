# this is where we are going to use an AWS ECS cluster resource, and my first crack at using a module.

# create the cluster resource
resource "aws_ecs_cluster" "cluster_duck" {
  name = "cluster-duck"

  setting {
    name  = "containerInsights"
    value = "disabled"
  }
}

resource "aws_ecs_cluster_capacity_providers" "cluster_cap" {
  cluster_name = aws_ecs_cluster.cluster_duck.name

  capacity_providers = ["FARGATE", "FARGATE_SPOT"]

  default_capacity_provider_strategy {
    base              = 1
    weight            = 100
    capacity_provider = "FARGATE_SPOT"
  }
}

module "ecs-fargate" {
  source  = "umotif-public/ecs-fargate/aws"
  version = "~> 6.1.0"

  name_prefix        = "ecs-fargate-ducks"
  vpc_id             = aws_vpc.hidden_pond.id
  private_subnet_ids = [aws_subnet.private_subnet_alpha.id, aws_subnet.private_subnet_bravo.id]

  cluster_id = aws_ecs_cluster.cluster_duck.id

  task_container_image   = "centos"
  task_definition_cpu    = 256
  task_definition_memory = 512

  task_container_port             = 80
  task_container_assign_public_ip = true

  load_balanced = false

  target_groups = [
    {
      target_group_name = "tg-fargate-quacked-up"
      container_port    = 80
    }
  ]

  health_check = {
    port = "traffic-port"
    path = "/"
  }

  tags = {
    Environment = "wk21proj"
    Name        = "ECS Fargate Ducks"
  }
}