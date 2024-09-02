pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        stage('Terraform Init') {
            steps {
                sh 'cd /root/terraform/ && terraform init'
            }
        }
        stage('Terraform Apply') {
            steps {
                sh 'cd /root/terraform/ && terraform apply -auto-approve'
            }
        }
    }
}
