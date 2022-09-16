pipeline {
    agent any
    stages {
        stage('Build') {  
            }
            steps {
                awsCodeBuild(projectName: 'sprint6-cr-theSmittys-codebuild', 
                credentialsType: 'keys', 
                region:  'us-east-2', 
                sourceControlType: 'jenkins')
               echo 'This is the build stage.'
            }
        }

        stage('Testing') {
            steps {

               echo 'This is the test stage.'
            }
        }

        stage('E2E Testing') {
            steps {

               echo 'This is the E2E Testing stage.'
            }
        }

        stage('Deploy') {
            steps {

               echo 'This is the deploy stage.'
            }
        }
    }
}