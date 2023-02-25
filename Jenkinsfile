# frozen_string_literal: true

pipeline do
  agent any
  stages do
    stage('Clean up') do
      steps do
        deleteDir
      end
    end
    stage('Build') do
      steps do
        dir('rspec_gmail_api') do
          sh 'gem install bundler'
          sh 'bundle install'
          sh 'bundle exec rspec .'
        end
      end
    end
  end
end
