pipeline{
    agent{
        label "TERRAFORM"
    }
    stages{
        stage("vcs"){
            steps{
                git url: https://github.com/srikanthvelma/Terraform.git,
                    branch: 'main'
            }
        }
        stage('terraform'){
            steps{
                sh 'cd ~/Terraform/azure/tf_vm'
                sh 'terraform apply -auto-approve'
            }
        }
    }
}
