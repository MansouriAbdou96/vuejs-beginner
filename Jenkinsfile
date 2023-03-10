pipeline {
    agent any 

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

        stage('create Infra') {
            steps {
                withCredentials([[
                  $class: 'AmazonWebServicesCredentialsBinding',
                  credentialsId: 'my-aws-creds',
                  accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                  secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
                ]]) {
                    sh '''
                        aws configure set aws_session_token '$AWS_SESSION_TOKEN' 
                    '''
                    dir('terraform') {
                        sh '''
                            terraform init 
                            terraform validate 
                            terraform apply -var "buildID=${BUILD_ID}" -auto-approve 

                            terraform output -raw vuejs-ip >> ../ansible/inventory.txt
                        '''
                    }
                }
                
            }

            post {
                always {
                    archiveArtifacts artifacts: 'ansible/inventory.txt'
                    archiveArtifacts artifacts: 'terraform/terraform.tfstate'
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

        stage('smoke test') {
           steps {
                dir('terraform'){
                    sh '''
                    export URL=$(terraform output -raw vuejs-dns)
                    # Set maximum number of retries
                    MAX_RETRIES=10
                    RETRY_COUNT=0
                    # Wait for API to be ready
                    while true; do
                        if curl -I "${URL}" | grep "HTTP/1.1 2.."; then
                            break
                        fi
                        RETRY_COUNT=$((RETRY_COUNT + 1))
                        if [ ${RETRY_COUNT} -eq ${MAX_RETRIES} ]; then
                            echo "Website URL is not ready after ${MAX_RETRIES} retries."
                            exit 1
                        fi
                        # Wait for 5 seconds before retrying
                        sleep 5
                    done
                '''
                }
                
           } 
        }
    }
}