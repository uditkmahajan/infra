# data "aws_vpc" "peer_vpc" {
#   provider = aws.peer
#   default  = true
# }

resource "aws_vpc_peering_connection" "vpc_peer" {
  peer_owner_id = "${var.accountID}"
  peer_vpc_id   = "${var.peer_vpc_id}"
  vpc_id        = "${var.vpc_id}"
  peer_region   = "${var.peer_region}"
  auto_accept = false
  accepter {
    allow_remote_vpc_dns_resolution = true
  }
  requester {
    allow_remote_vpc_dns_resolution = true
  }
}