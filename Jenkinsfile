pipeline {
    agent any
    stages {
        stage('Build') {  
         
            steps {
                awsCodeBuild(projectName: 'sprint6-cr-theSmittys-codebuild', 
                credentialsType: 'keys', 
                region:  'us-east-2', 
                sourceControlType: 'jenkins')
               echo 'This is the buildd stage.'
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
               sh 'aws deploy create-deployment --application-name sprint6-cr-theSmittys-app --s3-location bucket=sprint6-cr-thesmittys-codebuild-input,bundleType=zip,key=sprint6-cr-theSmittys-codebuild --deployment-group-name sprint6-cr-theSmittys-DG --region us-east-2'
               echo 'This is the deploy stage.'
            }
        }
    }
}