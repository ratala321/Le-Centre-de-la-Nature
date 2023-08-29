pipeline {
  agent any
  stages {
    stage('Checkout Code') {
      steps {
        git(url: 'https://github.com/ratala321/premier_test_3d_privee', branch: 'develop')
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
          agent any
          environment {
            godotMono = '/usr/local/bin/Godot_v4.1.1-stable_mono_linux_x86_64/executable_Godot_v4.1.1'
          }
          steps {
            sh '''"$godotMono" -s --headless --path "$PWD"
  addons/gut/gut_cmdln.gd -gtest=res://tests/test_Basique.gd -glog=1 -gexit
'''
          }
        }

      }
    }

  }
  environment {
    godotMono = '/home/ec2-user/Godot_v4.1.1-stable_mono_linux_x86_64/Godot_v4.1.1-stable_mono_linux.x86_64'
  }
}