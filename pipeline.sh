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
}
}
