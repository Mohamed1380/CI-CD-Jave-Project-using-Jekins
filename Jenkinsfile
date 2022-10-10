pipeline {
    agent any

    tools {
        maven 'maven-3.8.6'
    }

    stages {

        stage ("Git Checkout"){
            steps {

                git 'https://github.com/Mohamed1380/CI-CD-Jave-Project-using-Jekins.git'
            }
        }

        stage ("Unit Testing"){
            steps {

                sh 'mvn test'
            }
        }

        stage ("Integration Testing"){
            steps {
                
                sh 'mvn verify -DskipUnitTest'
            }
        }

        stage ("Build"){
            steps {
                
                sh 'mvn clean install'
            }
        }

        stage ("Static Code Analysis"){
            steps {
                script{
                    withSonarQubeEnv(credentialsId: 'sonar-secret') {
                        sh 'mvn clean package sonar:sonar'
                    }

                }
                
            }
        }
    }

}