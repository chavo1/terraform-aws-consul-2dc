# This repo contains deployment of Consul cluster in AWS with Terraform. 
## Deployment uses [this](https://github.com/chavo1/aws-consul-terraform) module and could be done as follow:
- 1 DCs with servers and client.
- 2 DCs in [Multiple Datacenters](https://www.consul.io/docs/guides/datacenters.html) with servers and client.
 - | To spin up the second DC and client agents we use [Terraform Local Backend](https://www.terraform.io/docs/backends/types/local.html#example-reference) - we just reference the data. 
 - | For the count of the Consul servers in second DC we reference the private IPs of the primary DC. If you need different count just hardcode it in main.tf on "consul_server_dc2" directory - for example:

 ``` 
 count = "${length(data.terraform_remote_state.server.private_ip)}"
 change it with:
 count = 5
 ```

## Joining of the consul agents is done with:
- Cloud Auto-joining more info [HERE](https://www.consul.io/docs/agent/cloud-auto-join.html) and examples [HERE](https://github.com/hashicorp-modules/consul-auto-join-instance-role-aws)
  - | [iam_instance_profile](https://www.terraform.io/docs/providers/aws/r/instance.html#iam_instance_profile)
- [-retry-join](https://www.consul.io/docs/agent/options.html#_retry_join)
## Prerequisites
- Please install the following component:
  - | [Terraform](https://www.terraform.io/)
- You must also have an AWS account. 
- Clone the repo:
```
git clone git clone https://github.com/chavo1/terraform-aws-consul-2dc.git
cd consul terraform-aws-consul-2dc/consul_server_dc1
```
- Create terraform.tfvars file with needed credential and variables:
```
access_key = "< Your AWS Access_key >"
secret_key = "< Your AWS Secret_key >"
key_name = ""
region = "us-east-1"
instance_type = ""
server_count = 3
client_count = 1

dcname = {
    dc1 = "sofia"
  }

subnet = [
    "Your AWS subnet"
]
```
### We can start with deploying process
```
terraform init
terraform plan
terraform apply
```
### The deploying process must be done in each directory - staring as follow 

```
consul_server_dc1
consul_server_dc2
etc..
```

### Do not forget to destroy the environment after the test
 - In backward order
```
terraform destroy
```
### This will give us a separate ["terraform.tfstate"](https://www.terraform.io/docs/state/) 
