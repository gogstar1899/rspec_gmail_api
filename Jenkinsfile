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
            sh "bundle install"
            sh "bundle exec rspec ."
            junit 'rspec.*xml'
            archive (includes: 'pkg/*.gem')
            publishHTML (target: [
              allowMissing: false,
              alwaysLinkToLastBuild: false,
              keepAll: true,
              reportDir: 'reports',
              reportFiles: 'overview.html', 'send-mail.html', 'mail-box.html', 'gmail-labels.html',
              reportName: "Reporting Result"
            ])
          }
        }
      }
    }
}