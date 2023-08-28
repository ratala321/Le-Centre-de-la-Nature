pipeline {
  agent any
  stages {
    stage('Checkout Code') {
      steps {
        git(url: 'https://github.com/ratala321/premier_test3d_godot', branch: 'develop')
      }
    }

    stage('Log') {
      parallel {
        stage('Log') {
          steps {
            sh 'ls -la'
          }
        }

        stage('Tests') {
          steps {
            sh '''godotMono -s --path "$PWD" addons/gut/gut_cmdln.gd -gtest=res://tests/test_Basique.gd -glog=1 -gexit
'''
          }
        }

      }
    }

  }
}