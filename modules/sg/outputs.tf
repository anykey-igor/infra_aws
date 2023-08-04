output "sg_alb_http_pl_easteu_id" {
  value = aws_security_group.sg_alb_http_pl_easteu.id
}
output "sg_alb_http_pl_asia_id" {
  value = aws_security_group.sg_alb_http_pl_asia.id
}
output "sg_alb_https_pl_easteu_id" {
  value = aws_security_group.sg_alb_https_pl_easteu.id
}
output "sg_alb_https_pl_asia_id" {
  value = aws_security_group.sg_alb_https_pl_asia.id
}
output "sg_ecs_service" {
  value = aws_security_group.sg_ecs_service.id
}
output "sg_database_ecs_id" {
  value = aws_security_group.sg_ecs_db.id
}