pipeline {
  agent {
    docker {
      image 'docker:27'
      // รันเป็น root + mount docker.sock + เซ็ต HOME/DOCKER_CONFIG ให้เขียนได้
      args '-u root -v /var/run/docker.sock:/var/run/docker.sock -e HOME=/var/jenkins_home -e DOCKER_CONFIG=/var/jenkins_home/.docker'
    }
  }

  environment {
    HOME = "/var/jenkins_home"
    DOCKER_CONFIG = "/var/jenkins_home/.docker"
  }

  stages {
    stage('Checkout') {
      steps {
        git branch: 'main', url: 'https://github.com/kornphongP/jenkins-demo.git'
      }
    }

    stage('Docker Health') {
      steps {
        sh '''
          set -e
          mkdir -p "$DOCKER_CONFIG"
          echo "HOME=$HOME"
          ls -ld "$HOME" "$DOCKER_CONFIG" || true
          docker version
          docker pull busybox:latest
        '''
      }
    }

    stage('Build Image') {
      steps {
        sh 'docker build -t jenkins-demo-app:latest .'
      }
    }

    stage('Run Container') {
      steps {
        sh '''
          docker rm -f demo-app || true
          docker run -d -p 5000:5000 --name demo-app jenkins-demo-app:latest
        '''
      }
    }
  }
}