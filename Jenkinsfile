pipeline {

    environment {
        AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
    }

   agent  any
    stages {
        stage('checkout') {
            steps {
                 script{
                        dir("terraform")
                        {
                            git "https://github.com/YuvanJaswik/Terraform-Jenkins.git"
                        }
                    }
                }
            }
        }
    stage ('destroy') {
            steps {
                sh "pwd;cd terraform/ ; terraform destroy"
            }
        }
    }
