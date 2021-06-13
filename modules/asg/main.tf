resource"aws_launch_configuration" "launch-configuration" {
  name_prefix = "${var.environment}-asg-"
  image_id = var.image_id
  instance_type = var.instance_type
  security_groups = var.security_groups_ids 
  key_name = var.key_name
  
  lifecycle {
    create_before_destroy = true
  }
}
 
resource "aws_autoscaling_group" "autoscalling_group_config" {
  name = "${var.environment}-asg"
  max_size = 5
  min_size = 2
  health_check_grace_period = 300
  health_check_type = "EC2"
  desired_capacity = 2
  force_delete = true
  vpc_zone_identifier = var.private_subnets_id
  
  launch_configuration = aws_launch_configuration.launch-configuration.name
 
  lifecycle {
    create_before_destroy = true
  }
}


resource "time_sleep" "wait_60_seconds" {
  depends_on = [aws_autoscaling_group.autoscalling_group_config]

  create_duration = "60s"
}


resource "aws_autoscaling_policy" "agents-scale-up" {
    name = "agents-scale-up"
    scaling_adjustment = 1
    adjustment_type = "ChangeInCapacity"
    cooldown = 300
    autoscaling_group_name = "${var.environment}-asg"
    depends_on = [time_sleep.wait_60_seconds]
}

resource "aws_autoscaling_policy" "agents-scale-down" {
    name = "agents-scale-down"
    scaling_adjustment = -1
    adjustment_type = "ChangeInCapacity"
    cooldown = 300
    autoscaling_group_name = "${var.environment}-asg"
    depends_on = [time_sleep.wait_60_seconds]
}

resource "aws_cloudwatch_metric_alarm" "cpu-high" {
    alarm_name = "cpu-util-high-agents"
    comparison_operator = "GreaterThanOrEqualToThreshold"
    evaluation_periods = "2"
    metric_name = "CPUUtilization"
    namespace = "System/Linux"
    period = "300"
    statistic = "Average"
    threshold = "45"
    alarm_description = "This metric monitors ec2 cpu for high utilization on agent hosts"
    depends_on = [time_sleep.wait_60_seconds]
    alarm_actions = [
        "${aws_autoscaling_policy.agents-scale-up.arn}"
    ]
    dimensions = {
        AutoScalingGroupName = "${var.environment}-asg"
    }
}

resource "aws_cloudwatch_metric_alarm" "cpu-low" {
    alarm_name = "mem-util-low-agents"
    comparison_operator = "LessThanOrEqualToThreshold"
    evaluation_periods = "2"
    metric_name = "CPUUtilization"
    namespace = "System/Linux"
    period = "300"
    statistic = "Average"
    threshold = "30"
    alarm_description = "This metric monitors ec2 cpu for low utilization on agent hosts"
    depends_on = [time_sleep.wait_60_seconds]
    alarm_actions = [
        "${aws_autoscaling_policy.agents-scale-down.arn}"
    ]
    dimensions = {
        AutoScalingGroupName = "${var.environment}-asg"
    }
}
