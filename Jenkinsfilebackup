pipeline {
    
    agent any
    
    environment {
        AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
        AWS_DEFAULT_REGION="us-east-1"
        IMAGE_REPO_NAME="demo"
        IMAGE_TAG="latest"
        AWS_ACCOUNT_ID = "458087513482"
        REPOSITORY_URI = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${IMAGE_REPO_NAME}"
        }

stages {
        stage('Checkout') {
            steps {
git branch: 'development', url: 'https://github.com/mbreddy507/lineaje-dev.git'
}
}

stage('Logging into AWS ECR') {
 steps {
 script {
 sh "aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 458087513482.dkr.ecr.us-east-1.amazonaws.com"
 }
 }
 }

stage('Building image') {
 steps{
 script {
 dockerImage = docker.build "${IMAGE_REPO_NAME}:${IMAGE_TAG}"
 }
 }
 }

stage('Pushing to ECR') {
 steps{ 
 script {
 sh "docker tag ${IMAGE_REPO_NAME}:${IMAGE_TAG} ${REPOSITORY_URI}:$IMAGE_TAG"
 sh "docker push ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${IMAGE_REPO_NAME}:${IMAGE_TAG}"
 }
 }
 }

stage('Plan') {
            when {
                not {
                    equals expected: true, actual: params.destroy
                }
            }
            
            steps {
                sh 'terraform init -input=false'
                sh 'terraform plan -input=false'
                }
        }

stage('Apply') {
            when {
                not {
                    equals expected: true, actual: params.destroy
                }
            }
            
            steps {
                sh "terraform apply -auto-approve"
            }
        }
        
stage('Destroy') {
            when {
                equals expected: true, actual: params.destroy
            }
        
     steps {
           sh "terraform destroy --auto-approve"
        }
    }

  }
    
}
