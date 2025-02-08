pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                // Check out source code from your repository
                checkout scm
            }
        }
        stage('Terraform Init') {
            steps {
                echo "Initializing Terraform..."
                sh 'terraform init'
            }
        }
        stage('Terraform Plan') {
            steps {
                echo "Running Terraform plan..."
                sh 'terraform plan'
            }
        }
        stage('Terraform Apply') {
            steps {
                // Optional: require manual approval before applying changes
                input message: 'Approve Terraform Apply?'
                echo "Applying Terraform changes..."
                sh 'terraform apply -auto-approve'
            }
        }
    }
}