node('linux') {

    stage('Create') {
    git credentialsId: 'Github-Token', url: 'https://github.com/mamry/final_hit.git' 
    withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'AWS-Password', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
    // some block
   
             }
   } 
    
     stage('Deploy') {
                  sshagent(['midKeyID']) {
                  // some block
                
                   }     
    }
    
     stage('Test') {
                  sshagent(['midKeyID']) {
                  // some block
                     
                   }
    } 
  
}
