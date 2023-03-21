pipeline {
    agent none
    stages {
        stage('BuiLd and Test C# code') {
            agent {
                docker {
                    image 'mcr.microsoft.com/dotnet/sdk:6.0'
                    reuseNode true
                }
            }
            stages {
                stage('Build') {
                    steps {
                        sh 'dotnet build'
                    }
                }
                stage("Test") {
                    steps {
                        sh 'dotnet test'
                    }
                }
            }
        }
        stage("Build, Lint and Test TS code") {
            agent {
                docker {
                    image 'node:17-bullseye'
                    reuseNode true
                }
            }
            stages {
                stage('NPM Install') {
                    steps {
                        sh 'npm install'
                    }
                }
                stage('Build') {
                    steps {
                        sh 'npm run build'
                    }
                }
                stage('Test') {
                    steps {
                        sh 'npm t'
                    }
                }
                stage('Lint') {
                    steps {
                        sh 'npm run lint'
                    }
                }
            }
        }
    }
}