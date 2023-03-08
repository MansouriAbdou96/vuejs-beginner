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
        }

        stage('scan') {
           steps {
                nodejs('node-v9'){
                    sh '''
                        npm install
                        npm audit fix --audit-level=critical --force
                        npm audit --audit-level=critical
                    '''
                } 
           } 
        }

        // stage('configure server') {
        //     steps{
        //         sshagent(credentials: ['vuejs-key']){
        //             dir('ansible') {
        //                 sh '''
        //                     ansible-playbook -i inventory.txt config-server.yml
        //                 '''
        //             }
        //         }
        //     }
        // }

        // stage('deploy') {
        //    steps {

        //         sh '''
        //             npm install 
        //             npm run build 

        //             scp -r /dist ec2-user@ec2-xx-xx-xxx-xxx.compute-1.amazonaws.com:/var/www/myapp/
        //         '''

        //         // TODO: move the dist folder to /var/www/ 
        //         // TODO: restart nginx 
        //    } 
        // }

        // stage('smoke test') {
        //    steps {
        //         // TODO: test the dns of ec2 if it responding 
        //    } 
        // }
    }
}