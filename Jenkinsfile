pipeline{
    agent any
    environment {
        registrycredentialsId = "ecr:us-east-2:aws-jenkins"
        appRegistry = "777994939886.dkr.ecr.us-east-2.amazonaws.com/myappimg" 
        myappRegistry = "https://777994939886.dkr.ecr.us-east-2.amazonaws.com"
    }
    stages{
        stage('Fetch code'){
            steps{
                git branch:'master', url: 'https://github.com/youngmind01/Docker-pipeline.git'
            }
        }
        stage('Maven test'){
            steps{
                sh 'mvn test'
            }
        }
        stage('Checkstyle Analysis'){
            steps{
                sh ' mvn checkstyle:checkstyle'
            }
        }
        stage('SonarQube analysis'){
            steps{
                script{
                    withSonarQubeEnv(credentialsId: 'sonar-api-key'){
                         sh 'mvn clean package sonar:sonar '
                    }
                   
                }
            }
        }
        stage('Build'){
            steps{
                sh 'mvn clean install'
            }
        }
        stage('Build App Image'){
            steps{
                script{
                    dockerImage = docker.build( appRegistry + ":$BUILD_NUMBER", ".")
                }
            }
        }
        stage('Push to Nexus'){
            steps{
                script{
                    nexusArtifactUploader artifacts: 
                    [[artifactId: 'my-app', 
                    classifier: '', 
                    file: 'target/my-app-1.0.jar', 
                    type: 'jar']], 

                            credentialsId: 'nexus-auth', 
                            groupId: 'com.mycompany.app',
                            nexusUrl: '192.168.56.11:8081', 
                            nexusVersion: 'nexus3', 
                            protocol: 'http', 
                            repository: 'myapp', 
                            version: '1.0'
                }
            }
        }
        stage('Upload App Image to ECR'){
            steps{
                script{
                    docker.withRegistry( myappRegistry, registrycredentialsId ) {
                    dockerImage.push("$BUILD_NUMBER")
                    dockerImage.push('latest')
                }
            }
        }
    }
  }
}