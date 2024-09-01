##############################################################################
#                      GENERAL                                               #
##############################################################################

application = "hexburger"
environment = "dev"
aws_region  = "us-east-1"

##############################################################################
#                      NETWORK                                               #
##############################################################################

vpc_cidr_block = "10.200.0.0/24"
public_zone = {
  public_1a = {
    cidr_block        = "10.200.0.0/26"
    availability_zone = "a"
  },
  public_1c = {
    cidr_block        = "10.200.0.64/26"
    availability_zone = "c"
  }
}
private_zone = {
  private_1a = {
    cidr_block        = "10.200.0.128/26"
    availability_zone = "a"
  },
  private_1c = {
    cidr_block        = "10.200.0.192/26"
    availability_zone = "c"
  }
}
