cmd_net/ipv4/netfilter/nf_nat.o := /opt/arm-2011.09/bin/arm-none-linux-gnueabi-ld -EL    -r -o net/ipv4/netfilter/nf_nat.o net/ipv4/netfilter/nf_nat_core.o net/ipv4/netfilter/nf_nat_helper.o net/ipv4/netfilter/nf_nat_proto_unknown.o net/ipv4/netfilter/nf_nat_proto_common.o net/ipv4/netfilter/nf_nat_proto_tcp.o net/ipv4/netfilter/nf_nat_proto_udp.o net/ipv4/netfilter/nf_nat_proto_icmp.o ; scripts/mod/modpost net/ipv4/netfilter/nf_nat.o
