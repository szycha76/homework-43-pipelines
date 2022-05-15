/*
 * This is automatically generated Jenkinsfile for taskC
 */

pipeline {
    agent any

    stages {
        stage('clone repoA') {
            steps {
                // clone repoA
                git 'https://github.com/szycha76/homework-43-repoA'
            }
        }

        stage('generate doxygen config file') {
            steps {
                // generate doxygen config
                sh "doxygen -g"
            }
        }

        stage('adjust config file') {
            steps {
                // set folder "src" as INPUT
                sh 'sed -e "s/^INPUT[ \\t].*$/INPUT = src/" Doxyfile -i'

                // set only HTML output
                sh 'sed -e "s/^GENERATE_\\(LATEX\\|RTF\\|MAN\\|XML\\|DOCBOOK\\)\\([ \\t]\\)=.*$/GENERATE_\\1\\2= NO/" Doxyfile -i'

            }
        }

        stage('run doxygen') {
            steps {
                // run doxygen using config file
                sh "doxygen Doxyfile"
            }
        }
    }
}
