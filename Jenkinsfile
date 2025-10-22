pipeline {
    agent any

    environment {
        IMAGE_NAME = "myapp"   
		IMAGE_TAG = "latest"
        CONTAINER_NAME = "myapp_container"
    }

    stages {
        stage('Checkout Code') {
            steps {
                echo "Checking out code..."
                checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/MadanDhungel/django-todo-cicd.git']])
            }
        }

        stage('Build Docker Image') {
            steps {
                echo "Building Docker image..."
                script {
                    sh "docker build -t ${IMAGE_NAME}:${IMAGE_TAG} ."
                }
            }
        }

        stage('Run Container') {
            steps {
                echo "Deploying container..."
                script {
                    // Stop old container if running
                    sh """
                    if [ \$(docker ps -aq -f name=${CONTAINER_NAME}) ]; then
    					docker rm -f ${CONTAINER_NAME}
		    		fi
					docker run -d --name ${CONTAINER_NAME} -p 8000:8000 ${IMAGE_NAME}:${IMAGE_TAG}
                    """
                }
            }
        }

        stage('Verify Deployment') {
            steps {
                echo "Verifying the app is running..."
                script {
                    sh "docker ps | grep ${CONTAINER_NAME}"
                }
            }
        }
    }

    post {
        success {
            echo "✅ Build and deployment successful!"
        }
        failure {
            echo "❌ Build or deployment failed!"
        }
    }
}
