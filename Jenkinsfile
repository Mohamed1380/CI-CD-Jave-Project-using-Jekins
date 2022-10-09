pipeline {
    agent any

    stages {

        stage ("Git Checkout"){
            steps {
                git 'https://github.com/Mohamed1380/CI-CD-Jave-Project-using-Jekins.git'

            }
        }

        stage ("Unit Test"){
            steps {
                sh 'mvn test'

            }
        }
    }

}