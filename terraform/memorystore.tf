# Create the ElastiCache (Redis) instance
resource "aws_elasticache_cluster" "redis_cart" {
  cluster_id           = "redis-cart"
  engine               = "redis"
  node_type            = "cache.t2.micro"
  num_cache_nodes      = 1
  port                 = 6379
  parameter_group_name = "default.redis7.4"
  subnet_group_name    = "your_subnet_group_name"  # Update with your subnet group name
  vpc_security_group_ids = ["your_security_group_id"]  # Update with your security group ID
  availability_zones   = ["your_az"]  # Update with your availability zone
}

# Edit contents of Kustomization.yaml file to target new ElastiCache (Redis) instance
resource "null_resource" "kustomization_update" {
  provisioner "local-exec" {
    interpreter = ["bash", "-exc"]
    command     = "sed -i 's/REDIS_CONNECTION_STRING/${aws_elasticache_cluster.redis_cart.cache_nodes.0.address}:${aws_elasticache_cluster.redis_cart.port}/g' ../kustomize/components/memorystore/kustomization.yaml"
  }

  depends_on = [
    aws_elasticache_cluster.redis_cart
  ]
}
