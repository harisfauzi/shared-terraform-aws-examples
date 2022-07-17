subnet_cidr_block = {
  networkaccount = {
    vpc                 = "10.224.0.0/20"
    public_a            = "10.224.0.0/25"
    public_b            = "10.224.0.128/25"
    public_summary      = "10.224.0.0/24"
    private_a           = "10.224.2.0/24"
    private_b           = "10.224.3.0/24"
    private_summary     = "10.224.2.0/23"
    isolated_a          = "10.224.4.0/25"
    isolated_b          = "10.224.4.128/25"
    isolated_summary    = "10.224.4.0/24"
    privatelink_a       = "10.224.5.0/25"
    privatelink_b       = "10.224.5.128/25"
    privatelink_summary = "10.224.5.0/24"
  }
}
