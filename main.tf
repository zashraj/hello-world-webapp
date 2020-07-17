provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "web" {
  ami           = "ami-02d55cb47e83a99a0"
  instance_type = "t2.micro"

  tags = {
    Name = "HelloWorld"
  }
}

resource "aws_ecs_cluster" "sample" {
  name = "sample-cluster"
}
  
resource "aws_cloudwatch_log_group" "hello_world" {
  name              = "hello_world"
  retention_in_days = 1
}

resource "aws_ecs_task_definition" "hello_world" {
  family = "hello_world"

  container_definitions = <<EOF
[
  {
    "name": "hello_world",
    "image": "zashraj/mysamlewebapp",
    "cpu": 0,
    "memory": 128,
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-region": "ap-south-1",
        "awslogs-group": "hello_world",
        "awslogs-stream-prefix": "hello-world"
      }
    }
  }
]
EOF
}

resource "aws_ecs_service" "hello_world" {
  name            = "hello_world"
  cluster         = aws_ecs_cluster.sample.arn
  task_definition = aws_ecs_task_definition.hello_world.arn

  desired_count = 1

  deployment_maximum_percent         = 100
  deployment_minimum_healthy_percent = 0
}
