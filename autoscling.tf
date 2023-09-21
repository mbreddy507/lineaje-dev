resource "aws_appautoscaling_target" "target" {
  service_namespace  = "ecs"
  resource_id        = "service/${aws_ecs_cluster.default.name}/${aws_ecs_service.service-webservice.name}"
  role_arn           = var.service_role
  scalable_dimension = "ecs:service:DesiredCount"
  min_capacity       = var.containers_min
  max_capacity       = var.containers_max
}

resource "aws_appautoscaling_policy" "scale_up" {
  name               = "${var.environment}-${var.service}-scale-up"
  resource_id        = "service/${aws_ecs_cluster.default.name}/${aws_ecs_service.service-webservice.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"

  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = 120
    metric_aggregation_type = "Average"

    step_adjustment {
      metric_interval_lower_bound = 0
      scaling_adjustment          = 1
    }
  }

  depends_on = [
    aws_appautoscaling_target.target
  ]
}

resource "aws_appautoscaling_policy" "scale_down" {
  name               = "${var.environment}-${var.service}-scale-down"
  resource_id        = "service/${aws_ecs_cluster.default.name}/${aws_ecs_service.service-webservice.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"

  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = 120
    metric_aggregation_type = "Average"

    step_adjustment {
      metric_interval_upper_bound = 0
      scaling_adjustment          = -1
    }
  }

  depends_on = [
    aws_appautoscaling_target.target
  ]
}


