pipeline {
    agent any
    tools {
        jdk 'jdk17'
        maven 'maven'
    }
    stages {
        stage('git checkout') {
            steps {
                git 'https://github.com/tirumalareddysanampudi/mvnproj.git'
            }
        }
    }
}
