pipeline {
    agent any 
    // TODO: use jenkinsn agent that has nodejs 8 or 9 

    stages {
        stage('build') {
           steps {
                nodejs('node-v9'){
                    sh '''
                        npm install 
                        npm run build 
                    '''
                }
           } 

           post {
                always {
                    archiveArtifacts artifacts: 'dist/'
                }
           }
        }

        stage('configure & deploy') {
            steps{
                sshagent(credentials: ['vuejs-key']){

                    sh '''
                        tar -C dist -czvf artifact.tar.gz .
                    '''
                    dir('ansible') {
                        sh '''
                            ansible-playbook -i inventory.txt config-server.yml
                        '''
                    }
                }
            }
        }

        // stage('smoke test') {
        //    steps {
        //         // TODO: test the dns of ec2 if it responding 
        //    } 
        // }
    }
}