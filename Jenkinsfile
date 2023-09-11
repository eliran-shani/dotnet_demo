#!groovy

def checkParameter(param) {
    echo "${param}"
}

def notify(param) {
    echo "${param}"
}

pipeline {
    agent any
    options {
        timeout(time: 2, unit: 'HOURS')
        timestamps ()
        disableConcurrentBuilds()
    }
    parameters {
        string(name: 'username', defaultValue: 'elirans', description: '')
        booleanParam(name: 'RUN_AUTOMATION', defaultValue: true, description: '')
        choice(name: 'DEPLOY_ENV', choices: ['staging', 'preprod', 'production'], description: '')
        password(name: 'PASSWORD', defaultValue: 'SECRET', description: 'A secret password')
    }
    stages {
        stage('Deploy') {
            steps {
                script {
                    deploy("${params.DEPLOY_ENV}")
                }
            }
        }
    }
    post {
        success {
            notify("success")
        }
        failure {
            notify("failed")
        }
    }
}