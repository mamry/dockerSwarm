node('linux') {

    stage('Create') {
    git credentialsId: 'Github-Token', url: 'https://github.com/mamry/final-2.git' 
    withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'AWS-Password', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
    // some block
                
   sh 'aws cloudformation create-stack --stack-name final-production --region us-east-1 --template-body file://docker-swarm.json --capabilities CAPABILITY_IAM --parameters ParameterKey=KeyName,ParameterValue=midKey ParameterKey=YourIp,ParameterValue=$(curl ifconfig.me)/32'
   sh 'aws cloudformation wait stack-create-complete --stack-name final-production --region us-east-1'
    sh 'aws ec2 describe-instances --region us-east-1'
   env.myip = sh returnStdout: true, script: 'aws ec2 describe-instances --region us-east-1 --instance-ids --filters "Name=tag:Name,Values=swarm initiator" --query "Reservations[*].Instances[*].PublicIpAddress" --output text'
        sshagent(['midKeyID']) {
    // some block
            sh 'ssh -o StrictHostKeyChecking=no ubuntu@${myip} uptime'
        }

      }
   } 
    
     stage('Deploy') {
                  sshagent(['midKeyID']) {
                  // some block
                      sh 'ssh ubuntu@${myip} docker bulid -t redis1:1.0 .'
                   }     
             sshagent(['midKeyID']) {
                  // some block
                      sh 'ssh -o StrictHostKeyChecking=no ubuntu@${myip} dockerservice create --replicas 6 --name redis-cluster --update-delay 15s redis1:1.0.'
                   }    
    }
    
     stage('Test') {
                  sshagent(['midKeyID']) {
                  // some block
                      sh 'ssh ubuntu@${myip} redis-cli -c set hello world'
                      sh 'ssh ubuntu@${myip} redis-cli -c get hello'
                     
                   }
    } 
    
    stage('Delete') {
        withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'AWS-Password', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
    // some block
            sh 'aws cloudformation delete-stack --stack-name final-production --region us-east-1'
         sh 'aws cloudformation wait stack-delete-complete --stack-name final-production --region us-east-1'
        }        
    }
  
}
