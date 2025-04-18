pipeline {
    agent any

    environment {
        AZURE_CREDENTIALS_ID = 'azure-service-principal'
        RESOURCE_GROUP = 'rg-jenkins'
        APP_SERVICE_NAME = 'webapijenkinaditya827813'
    }

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/jnaditya108/react-app-final.git'
            }
        }

        stage('Terraform Init') {
            steps {
                dir('terraform') {
                    bat 'terraform init'
                }
            }
        }

        stage('Terraform Plan & Apply') {
            steps {
                dir('terraform') {
                    bat 'terraform plan -out=tfplan'
                    bat 'terraform apply -auto-approve tfplan'
                }
            }
        }

        stage('Build React App') {
            steps {
                dir('my-react-app') {
                    bat 'npm install'
                    bat 'npm run build'
                }
            }
        }

        stage('Deploy to Azure') {
            steps {
                withCredentials([azureServicePrincipal(credentialsId: AZURE_CREDENTIALS_ID)]) {
                    bat '''
                        az login --service-principal -u %AZURE_CLIENT_ID% -p %AZURE_CLIENT_SECRET% --tenant %AZURE_TENANT_ID%
                        powershell -Command Compress-Archive -Path ./my-react-app/build/* -DestinationPath ./my-react-app/build.zip -Force
                        az webapp deploy --resource-group %RESOURCE_GROUP% --name %APP_SERVICE_NAME% --src-path ./my-react-app/build.zip --type zip
                    '''
                }
            }
        }
    }

    post {
        success {
            echo 'Deployment Successful!'
        }
        failure {
            echo 'Deployment Failed!'
        }
    }
}
