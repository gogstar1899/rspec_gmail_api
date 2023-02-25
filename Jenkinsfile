pipeline {
    agent any
    stages {
        stage("Clean up"){
            steps {
                deleteDir()
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
    }
}