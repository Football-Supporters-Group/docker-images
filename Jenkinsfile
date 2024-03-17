#!groovy
pipeline {

    agent {
        label "docker"
    }
    tools {
        dockerTool 'docker-agent'
    }

    environment {
        DOCKER_USER = credentials('docker-user')
        DOCKER_ACCESS_TOKEN = credentials('docker-access-token')
    }


    options {
        buildDiscarder logRotator(artifactDaysToKeepStr: '', artifactNumToKeepStr: '5', daysToKeepStr: '', numToKeepStr: '5')
    }

    parameters {
        booleanParam(defaultValue: true, description: 'Execute pipeline?', name: 'shouldBuild')
        booleanParam(defaultValue: false, description: 'Execute pipeline?', name: 'overrideBuild')
    }

    stages {
        stage('Build Docker Image') {
            steps {
                sh '''
                    find jenkins-* -maxdepth 1 -type d \\( ! -name . \\) -exec bash -c "cp ./scripts ./{}/scripts -r && \\
                        cd {} && pwd && \\
                        docker build -t $DOCKER_USER/{}:latest ." \\;
                    '''
            }
        }

        stage('Deploy Docker Image to Dockerhub') {
            steps {
                input message: 'Proceed with Release Deployment to Docker?', submitter: 'wolginm'
                sh '''
                    cat $DOCKER_ACCESS_TOKEN | docker login --username $DOCKER_USER --password-stdin
                    find jenkins-* -maxdepth 1 -type d \\( ! -name . \\) -exec bash -c \
                        "cd {} && \
                        pwd && \
                        docker push \
                             $DOCKER_USER/{}:latest && \
                             docker image tag $DOCKER_USER/{}:latest $DOCKER_USER/{}:$BUILD_NUMBER && \
                             docker push $DOCKER_USER/{}:$BUILD_NUMBER" \\;
                    docker logout
                        '''
            }
        }
    }
}