pipeline {
    agent any

    environment {
        PATH = "/usr/local/bin:$PATH" // Adjust path if needed for node/npm
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Install Dependencies') {
            steps {
                sh 'node -v'     // Verify Node.js version
                sh 'npm -v'      // Verify npm version
                sh 'npm install' // Install Angular dependencies
            }
        }

        stage('Build') {
            steps {
                sh 'npm run build -- --configuration production'
            }
        }

        stage('Archive Artifacts') {
            steps {
                archiveArtifacts artifacts: 'dist/**', fingerprint: true
            }
        }
    }

    post {
        success {
            echo '✅ Angular build completed successfully!'
        }
        failure {
            echo '❌ Build failed.'
        }
    }
}
