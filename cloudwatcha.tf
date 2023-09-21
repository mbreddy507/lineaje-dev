resource "aws_cloudwatch_metric_alarm" "api_service_cpu_high" {
  alarm_name          = "${var.environment}-${var.service}-cpu-utilisation-above-3"
  alarm_description   = "This alarm monitors ${var.environment}-${var.service} cpu utilisation for scaling up"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = "10"
  statistic           = "Average"
  threshold           = "3"
  # tags                = var.common_tags

  dimensions = {
    ClusterName = var.clustername
    ServiceName = aws_ecs_service.service-webservice.name
  }

  alarm_actions = [
    aws_appautoscaling_policy.scale_up.arn
  ]
}

resource "aws_cloudwatch_metric_alarm" "api_service_cpu_low" {
  alarm_name          = "${var.environment}-${var.service}-cpu-utilisation-below-3"
  alarm_description   = "This alarm monitors ${var.environment}-${var.service} cpu utilisation for scaling down"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = "10"
  statistic           = "Average"
  threshold           = "3"
  # tags                = var.common_tags

  dimensions = {
    ClusterName = var.clustername
    ServiceName = aws_ecs_service.service-webservice.name
  }

  alarm_actions = [
    aws_appautoscaling_policy.scale_down.arn
  ]
}


