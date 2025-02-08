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
                // Save the plan to a file so that apply matches exactly the plan
                sh 'terraform plan -out=tfplan'
            }
        }
        stage('Terraform Apply') {
            steps {
                echo "Applying Terraform changes..."
                // Apply the plan that was generated in the previous stage
                sh 'terraform apply tfplan'
            }
        }
    }
}