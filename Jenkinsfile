pipeline {
    agent any
    
    parameters {
        choice(name: 'ENV', choices: ['dev', 'qa', 'prod'], description: 'Select the environment to deploy')
        choice(name: 'REGION', choices: ['us-east-1', 'us-west-2', 'eu-central-1'], description: 'Select the AWS region')
    }
    
    environment {
        APP_NAME = 'my-app'
        IMAGE_REPO = 'my-docker-repo'
    }
    
    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/tirumalareddysanampudi/mvnproj.git'
            }
        }
        
        stage('Build') {
            steps {
                script {
                    try {
                        def tag = "${params.ENV}-${env.BUILD_NUMBER}"
                        sh "docker build -t ${IMAGE_REPO}:${tag} ."
                    } catch (Exception e) {
                        echo "Build failed: ${e.message}"
                        error("Stopping pipeline due to build failure.")
                    }
                }
            }
        }
        
        stage('Test') {
            steps {
                script {
                    try {
                        sh "echo Running tests in ${params.ENV} environment"
                    } catch (Exception e) {
                        echo "Test execution failed: ${e.message}"
                    }
                }
            }
        }
        
        stage('Push Image') {
            steps {
                script {
                    try {
                        def tag = "${params.ENV}-${env.BUILD_NUMBER}"
                        sh "docker tag ${IMAGE_REPO}:${tag} ${IMAGE_REPO}:${params.ENV}-latest"
                        sh "docker push ${IMAGE_REPO}:${params.ENV}-latest"
                    } catch (Exception e) {
                        echo "Image push failed: ${e.message}"
                        error("Stopping pipeline due to image push failure.")
                    }
                }
            }
        }
        
        stage('Deploy') {
            steps {
                script {
                    try {
                        sh "echo Deploying to ${params.ENV} in region ${params.REGION}"
                    } catch (Exception e) {
                        echo "Deployment failed: ${e.message}"
                        error("Stopping pipeline due to deployment failure.")
                    }
                }
            }
        }
        
        stage('Approval for Prod') {
            when {
                expression { params.ENV == 'prod' }
            }
            steps {
                script {
                    timeout(time: 2, unit: 'HOURS') {
                        input message: 'Approve production deployment?', ok: 'Deploy'
                    }
                }
            }
        }
        
        stage('Deploy to Prod') {
            when {
                expression { params.ENV == 'prod' }
            }
            steps {
                script {
                    try {
                        sh "echo Deploying to Production in region ${params.REGION}"
                    } catch (Exception e) {
                        echo "Production deployment failed: ${e.message}"
                        error("Stopping pipeline due to production deployment failure.")
                    }
                }
            }
        }
    }
    
    post {
        success {
            echo "Pipeline execution completed successfully."
        }
        failure {
            echo "Pipeline execution failed. Check logs for details."
        }
        always {
            echo "Cleaning up resources."
        }
    }
}
