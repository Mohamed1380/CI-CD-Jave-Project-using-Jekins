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

        stage ("Quality Gate Status"){
            steps {
                
               script {
                    waitForQualityGate abortPipeline: false, credentialsId: 'sonar-secret'
               }
            }
        }

        stage ("Upload files to Nexus Repo"){
            steps {
                script {

                    def pom = readMavenPom file: 'pom.xml'
                    nexusArtifactUploader artifacts: 
                    [
                        [
                            artifactId: 'springboot', 
                            classifier: '', 
                            file: 'target/Myapp.jar', 
                            type: 'jar'
                        ]
                    ], 
                    credentialsId: 'nexus-secret', 
                    groupId: 'com.example', 
                    nexusUrl: '44.205.15.173:8081', 
                    nexusVersion: 'nexus3', 
                    protocol: 'http', 
                    repository: 'javaapp-release', 
                    version: ${pom.version}
                }
            }
        }
    }

}