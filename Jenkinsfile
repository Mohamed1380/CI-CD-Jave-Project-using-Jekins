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

                    def nexusrepo = pom.version.endsWith("SNAPSHOT") ? "javaapp-snapshot" : "javaapp-release" 

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
                    nexusUrl: '18.213.150.38:8081', 
                    nexusVersion: 'nexus3', 
                    protocol: 'http', 
                    repository: nexusrepo, 
                    version: "${pom.version}"
                }
            }
        }

        stage ("Build Docker Image"){
            steps {
                script {
                    sh 'docker build -t $JOB_NAME:v1.$BUILD_NUMBER .'
                    sh 'docker image tag $JOB_NAME:v1.$BUILD_NUMBER hamo138/$JOB_NAME:v1.$BUILD_NUMBER'
                    sh 'docker image tag $JOB_NAME:v1.$BUILD_NUMBER hamo138/$JOB_NAME:latest'
                }
    
            }

        }

        stage ("Push Docker Image to Dockerhub"){
            steps {
    
                    withCredentials([usernamePassword(credentialsId: 'docker-hub', passwordVariable: 'pass', usernameVariable: 'username')]){
                        sh 'docker login -u ${username} -p ${pass}'
                        sh 'docker push hamo138/$JOB_NAME:v1.$BUILD_NUMBER'
                        sh 'docker push hamo138/$JOB_NAME:latest'
                    }
    
            }

        }
    }

}