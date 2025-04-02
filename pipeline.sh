pipeline {
    agent any
    parameters {
        choice(name: 'ENV', choices: ['dev', 'qa', 'prod'], description: 'Select the environment to deploy')
    }
    tools {
        jdk 'jdk17'
        maven 'maven'
    }
    environment {
        APP_NAME = 'my-app'
        IMAGE_REPO = 'my-docker-repo'
    }
    stages {
        stage('git checkout') {
            steps {
                git 'https://github.com/tirumalareddysanampudi/mvnproj.git'
            }
        }
        stage('Build') {
            steps {
                script {
                    def tag = "${params.ENV}-${env.BUILD_NUMBER}"
                    sh "docker build -t ${IMAGE_REPO}:${tag} ."
                }
            }
        }
    }
}
