pipeline {
    agent none

    stages {
        stage('Build and Test C# Code') {
            environment {
                DOTNET_CLI_HOME = "/tmp/dotnet_cli_home"
                XDG_DATA_HOME = "/tmp"
            }
            agent {
                docker {
                    image 'mcr.microsoft.com/dotnet/sdk:6.0'
                    reuseNode true
                }
            }
            stages {
                stage('Build C# Code') {
                    steps {
                        sh 'dotnet build'
                    }
                }
                stage('Test C# Code') {
                    steps {
                        sh 'dotnet test'
                    }
                }
            }
        }
        stage('Build, Lint and Test Typescript Code ') {
            agent {
                docker {
                    image 'node:17-bullseye'
                    reuseNode true
                }
            }
            stages {
                stage('Build Typescript Code') {
                    steps {
                        dir('DotnetTemplate.Web') {
                            sh 'npm install && npm run build'
                        }
                    }
                }
                stage('Lint Typescript Code') {
                    steps {
                        dir('DotnetTemplate.Web') {
                            sh 'npm run lint'
                        }
                    }
                }
                stage('Test Typescript Code') {
                    steps {
                        dir('DotnetTemplate.Web') {
                            sh 'npm run test'
                        }
                    }
                }
            }
        }
    }
}