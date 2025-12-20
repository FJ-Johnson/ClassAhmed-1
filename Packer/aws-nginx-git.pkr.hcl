packer {
    
required_plugins {
    amazon = {
        source = "github.com/hashicorp/amazon"
        version = ">= 1.2.0"
        
      }
     }
} 

#---------------------------------
#source PROCEESS OF BUILDING AMI
#---------------------------------

source "amazon-ebs" "nginx-git" {
    region = "eu-west-1"
    instance_type = "t3.micro"
    ssh_username = "ec2-user"
    source_ami = "ami-0ebfed9ccce07b642"
    ami_name = "nginx-git-by-packer V3"
    ami_virtualization_type ="hvm"
}


#-----------------------------------------------
#source PROCEESS OF BUILDING JAVA + PYTHON AMIs
#-----------------------------------------------

source "amazon-ebs" "java-git" {
    region = "eu-west-1"
    instance_type = "t3.micro"
    ssh_username = "ec2-user"
    source_ami = "ami-0ebfed9ccce07b642"
    ami_name = "java-git-by-packer V3"
    ami_virtualization_type ="hvm"
}



source "amazon-ebs" "python-git" {
    region = "eu-west-1"
    instance_type = "t3.micro"
    ssh_username = "ec2-user"
    source_ami = "ami-0ebfed9ccce07b642"
    ami_name = "python-git-by-packer V3"
    ami_virtualization_type ="hvm"
}



#----------------------------------
#build  source + provisioning to do
#-----------------------------------

build {
    name = "nginx-git-ami-build"
    sources = [
        "source.amazon-ebs.nginx-git"
    ]

    provisioner "shell" {
        inline = [
            "sudo yum update -y",
            "sudo yum install nginx -y",
            "sudo systemctl enable nginx",
            "sudo systemctl start nginx",
            "echo '<h1> Hello from FJohnson - Built by Packer </h1>' | sudo tee /usr/share/nginx/html/index.html",
            "sudo yum install git -y"

        ]
    }

post-processor "shell-local" {
        inline = ["echo 'AMI BUILT' "]
    }
}


build { 
     name = "java-git-ami-build"
     sources = [
        "source.amazon-ebs.java-git"
]

provisioner "shell" {
    inline = [
        "sudo yum update -y",
        "sudo yum install java-17-amazon-corretto -y"
     ]
   }


post-processor "shell-local" {
        inline = ["echo 'AMI BUILT' "]
    }
}

build { 
     name = "python-git-ami-build"
     sources = [
        "source.amazon-ebs.python-git"
     ]

provisioner "shell" {
    inline = [
        "sudo yum update -y",
        "sudo yum install python3 -y"
     ]
    }
   
    post-processor "shell-local" {
        inline = ["echo 'AMI BUILT' "]
    }
}
















