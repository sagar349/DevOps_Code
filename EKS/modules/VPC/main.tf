resource "aws_vpc" "name" {
    cidr_block = var.vpc_cidr
    enable_dns_support = true
    enable_dns_hostnames = true

    tags = {
        Name = "$(var.vpc_name)-vpc"
        "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    }
  
}

resource "aws_subnet" "private" {
    count = length(var.subnet_cidr_blocks)
    vpc_id = aws_vpc.name.id
    cidr_block = var.subnet_cidr_blocks[count.index]
    availability_zone = var.availability_zones[count.index]
    tags = {
        Name = "${var.vpc_name}-subnet-${count.index + 1}"
        "kubernetes.io/cluster/${var.cluster_name}" = "shared"
        "kubernetes.io/role/elb" = "1"
    }
  
}

resource "aws_subnet" "public" {
    count = length(var.public_subnet_cidr_blocks)
    vpc_id = aws_vpc.name.id
    cidr_block = var.public_subnet_cidr_blocks[count.index]
    availability_zone = var.availability_zones[count.index]
    map_customer_owned_ip_on_launch = true

    tags = {
        Name = "${var.vpc_name}-public-subnet-${count.index + 1}"
        "kubernetes.io/cluster/${var.cluster_name}" = "shared"
        "kubernetes.io/role/elb" = "1"
    }
  
}

resource "aws_internet_gateway" "main" {
    vpc_id = aws_vpc.main.id

    tags = {
        Name = "${var.cluster_name}-igw"
    }
}

resource "aws_route_table" "public" {
    vpc_id = aws_vpc.main.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.main.id
    }
    tags = {
        Name = "${var.cluster_name}-public"
    }   
  
}

resource "aws_route_table_association" "public" {
    count = length(var.public_subnet_cidr_blocks)
    subnet_id = aws_subnet.public[count.index].id
    route_table_id = aws_route_table.public.id
  
}

resource "aws_route_table" "private" {
    vpc_id = aws_vpc.main.id

    tags = {
        Name = "${var.cluster_name}-private"
    }
  
}

resource "aws_nat_gateway" "main" {
    count = length(var.public_subnet_cidr_blocks)
    allocation_id = aws_eip.main[count.index].id
    subnet_id = aws_subnet.public[count.index].id

    tags = {
        Name = "${var.cluster_name}-nat-${count.index + 1}"
    }
  
}

resource "aws_route_table" "private" {
    count = length(var.private_subnet_cidr_blocks)
    vpc_id = aws_vpc.main.id

    route ={
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.main[count.index].id
    }

    tags = {
        Name = "${var.cluster_name}-private-${count.index + 1}"
    }
}

resource "aws_route_table_association" "private" {
    count = length(var.private_subnet_cidr_blocks)
    subnet_id = aws_subnet.private[count.index].id
    route_table_id = aws_route_table.private[count.index].id
  
}