pipeline{
    agent{
        label "TERRAFORM"
    }
    stages{
        stage("vcs"){
            steps{
                git url: 'https://github.com/srikanthvelma/Terraform.git',
                    branch: 'main'
            }
        }
        stage('terraform'){
            steps{
                sh 'cd ~/Terraform/azure/tf_vm'
                sh 'terraform init'
                sh './azure/tf_vm terraform apply -auto-approve'
            }
        }
    }
}
