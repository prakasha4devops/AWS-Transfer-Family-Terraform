provider "aws" {
  region = "eu-west-2"
}

module "sftp" {
  source = "./modules/sftp"

  name = "nep-interview-sftp"
  users = {
    user1 = {
      HomeDirectory = "/nep-interview-prakash-bucket1/"
      PublicKey     = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDDBmu2q1YK5NZD/G5mejj+x0sCTzCEU0jMYeBR27CZfEOjduI8HYaLK50u6sOg2XAai0tw9GKTZBOKVX8Vq+vkr1KqajWBwu7FhVQbW9KpeGR2K8Zyb7WEwSPKBP/hMoSEGgq7p7eXvlkMQa3qg7bqSohD11PuK+3QApX6rjYZk+8yPkRybvKfz21mUOtyzJ2RuGXMmjyZbxTJSLEKItKL9U4CkzMRPKC0ny8AyMTbh+Hli8Bs63t2UIJsJ5jtwY7KcOqHUuz2gvo7TiUrA/y/9UjZisrT9vZ1ghm+mL/SWjGsTkOt3LbWLu2KImu6SjYvT9kmMjFG15ckhAUfuN5WPK3C2qhgooAE6ew07mlQzkwHoA8nW3ayC/B27Zd6U2NaDDAdi6GywzBQL3tGLd0mOo5ke+aoQ6/GK6C71296DqQzAlAQYNoktPCZZh0Sv9tk3QRV9VXfbFNi9LBGMNGfMjb983+oQzqCydjhZ9Y4ivsxMWojufeE0UhU6kb7dPs= Yushh LTD@yushh-vostro"
      AllowFrom     = ["8.8.8.8"]
      Tags = {
        Name         = "Test user1"
        Organisation = "NEP"
      }
    }
    user2 = {
      HomeDirectory = "/nep-interview-shared-bucket/"
      PublicKey     = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDDBmu2q1YK5NZD/G5mejj+x0sCTzCEU0jMYeBR27CZfEOjduI8HYaLK50u6sOg2XAai0tw9GKTZBOKVX8Vq+vkr1KqajWBwu7FhVQbW9KpeGR2K8Zyb7WEwSPKBP/hMoSEGgq7p7eXvlkMQa3qg7bqSohD11PuK+3QApX6rjYZk+8yPkRybvKfz21mUOtyzJ2RuGXMmjyZbxTJSLEKItKL9U4CkzMRPKC0ny8AyMTbh+Hli8Bs63t2UIJsJ5jtwY7KcOqHUuz2gvo7TiUrA/y/9UjZisrT9vZ1ghm+mL/SWjGsTkOt3LbWLu2KImu6SjYvT9kmMjFG15ckhAUfuN5WPK3C2qhgooAE6ew07mlQzkwHoA8nW3ayC/B27Zd6U2NaDDAdi6GywzBQL3tGLd0mOo5ke+aoQ6/GK6C71296DqQzAlAQYNoktPCZZh0Sv9tk3QRV9VXfbFNi9LBGMNGfMjb983+oQzqCydjhZ9Y4ivsxMWojufeE0UhU6kb7dPs= Yushh LTD@yushh-vostro"
      AllowFrom     = ["1.1.1.1"]
      ReadOnly      = true
    }
  }

}