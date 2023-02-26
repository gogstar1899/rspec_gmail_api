pipeline {
    agent any
    stages {
        stage("Clean up"){
            steps {
                deleteDir()
            }
        }
        stage("Clone Repo"){
            steps {
                sh "git clone https://github.com/gogstar1899/rspec_gmail_api.git"
            }
        }
        stage("Build"){
          steps {
              dir("rspec_gmail_api") {
                sh "gem install bundler"
                sh "bundle install"
                sh "bundle exec rspec ."
              }
          }
        }
        post {
          always {
            junit 'rspec/*.xml'
      }
   } 
    }
}