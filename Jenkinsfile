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
                git branch:'docker', url: 'https://github.com/youngmind01/Docker-pipeline.git'
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
    }
}