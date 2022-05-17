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
                sh '''
                    # Keep the output clean
                    set +x

                    # Patch the Doxyfile as requested, make sure we do generate HTML (just in case)
                    sed -e 's/^INPUT\\([ \\t]\\+\\)=.*$/INPUT\\1= src/;
                        s/^GENERATE_\\(LATEX\\|RTF\\|MAN\\|XML\\|DOCBOOK\\)\\([ \\t]\\+\\)=.*$/GENERATE_\\1\\2= NO/;
                        s/^GENERATE_HTML\\([ \\t]\\+\\)=.*$/GENERATE_HTML\\1= YES/' Doxyfile -i

                    # Debug:
                    cat Doxyfile | cut -d '#' -f1 | grep -vE ^$ | uniq
                '''

            }
        }

        stage('run doxygen') {
            steps {
                // run doxygen using config file
                sh "doxygen Doxyfile"
            }
        }

        stage('pack generated output') {
            steps {
                // run doxygen using config file
                sh "cd html; tar cvvf - . | gzip -9 > ../doc.tar.gz"
            }
        }
    }

    post {
        always {
            archiveArtifacts artifacts: "doc.tar.gz", fingerprint: true
        }
    }
}

// vim: sw=4 ts=4 et nu relativenumber
