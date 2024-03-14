pipeline{
agent any
environment{
 PATH="$MAVEN_PATH/bin:$PATH"
}
stages{
stage('Git-Clone'){
 steps{
 git credentialsId: 'Git-Hub', url: 'https://github.com/tirumalareddysanampudi/mvnproj.git'
 }
}
stage('maven build'){
steps{
 sh "mvn clean validate "
}
}
stage('maven-compile'){
steps{
 sh "mvn compile"
}
}
stage('Maven package'){
        steps{
         sh "mvn package"
        }
    }
    # stage('deploy'){
    # steps{
    #   sh """
    #    sudo su -
    #    cp /root/.jenkins/workspace/Pipeline-Git-checkout/target/myproj.war  /opt/tomcat9/webapps/
    #   """
    # }
    # }
}
}
