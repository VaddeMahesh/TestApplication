pipeline {
    agent any

    environment {
        // Optional: Ensure node and npm are in PATH, adjust if needed
        PATH = "/usr/local/bin:$PATH"
    }

    stages {
        stage('Checkout') {
            steps {
                echo 'Checking out source code...'
                checkout scm
            }
        }

        stage('Install Dependencies') {
            steps {
                echo 'Installing node modules...'
                sh 'node -v'     // Shows Node.js version
                sh 'npm -v'      // Shows npm version
                sh 'npm install' // Installs Angular app dependencies
            }
        }

        stage('Build Angular App') {
            steps {
                echo 'Building Angular project...'
                sh 'npm run build -- --configuration production'
            }
        }

        stage('Archive Artifacts') {
            steps {
                echo 'Archiving dist folder...'
                archiveArtifacts artifacts: 'dist/**', fingerprint: true
            }
        }
    }

    post {
        success {
            echo '✅ Build succeeded!'
        }
        failure {
            echo '❌ Build failed!'
        }
    }
}
