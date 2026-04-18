pipeline {
    agent any

    triggers {
        githubPush()
    }

    environment {
        AWS_ACCESS_KEY_ID     = credentials('aws-access-key')
        AWS_SECRET_ACCESS_KEY = credentials('aws-secret-key')
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/imrazza/secure-cicd-aws-project.git'
            }
        }

        stage('Security Scan') {
            steps {
                sh 'trivy config . --exit-code 1 --severity HIGH,CRITICAL'
            }
        }

        stage('Terraform Init') {
            steps {
                sh 'terraform init'
            }
        }

        stage('Terraform Plan') {
            steps {
                sh 'terraform plan'
            }
        }

        stage('Terraform Apply') {
            steps {
                sh 'terraform apply -auto-approve'
            }
        }
    }

    post {
        success {
            echo 'Infrastructure deployed securely!'
        }
        failure {
            echo 'Pipeline failed — security issues found!'
        }
    }
}
