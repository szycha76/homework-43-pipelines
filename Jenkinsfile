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
                    # taskC: capture warnings in a file (doxygen.log)
                    sed -e 's/^INPUT\\([ \\t]\\+\\)=.*$/INPUT\\1= src/;
                        s/^GENERATE_\\(LATEX\\|RTF\\|MAN\\|XML\\|DOCBOOK\\)\\([ \\t]\\+\\)=.*$/GENERATE_\\1\\2= NO/;
                        s/^GENERATE_HTML\\([ \\t]\\+\\)=.*$/GENERATE_HTML\\1= YES/;
                        s/^WARN_LOGFILE\\([ \\t]\\+\\)=.*$/WARN_LOGFILE\\1= doxygen.log/' Doxyfile -i

                    # Debug:
                    cat Doxyfile | cut -d '#' -f1 | grep -vE ^$ | uniq
                '''

            }
        }

        stage('run doxygen') {
            steps {
                // run doxygen using config file
                sh '''
                    rm -rf latex html
                    doxygen Doxyfile
                '''
            }
        }

        stage('pack generated output') {
            steps {
                // run doxygen using config file
                sh "cd html; tar cvvf - . | gzip -9 > ../doc.tar.gz"
            }
        }

        stage('clone repoC') {
            steps {
                sh '''
                    # Perhaps we could do some 'git checkout, git reset --hard...' with bigger repos instead of just:
                    rm -rf .log-parser
                    git clone https://github.com/szycha76/homework-43-repoC .log-parser
                '''
            }
        }

        stage('run the log parser') {
            steps {
                sh '''
                    python3 .log-parser/parser.py doxygen.log
                '''
            }
        }
    }

    post {
        always {
            archiveArtifacts artifacts: "doc.tar.gz,doxygen.log", fingerprint: true
        }
    }
}

// vim: sw=4 ts=4 et nu relativenumber
