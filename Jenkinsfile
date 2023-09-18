pipeline {
	agent {
		docker {
			image 'ratala/godot-ci-dotnet:godot-4.1.1'
			args '-u root:sudo' 
		}
	}
	stages {
		stage('Configuration') {
			steps {
				sh '''
					useradd -m jenkins
					cd /home/jenkins
					chmod +rwx ~
					'''
			}
		}

		stage('Checkout Code') {
			steps {
				git(url: 'git@github.com:ratala321/premier_test_3d_privee.git', branch: 'master', credentialsId: 'github-premier-jenkins')
			}
		}

		stage('Log') {
			steps {
				sh 'ls -la'
			}
		}

		stage('Editeur') {
			steps {
				sh 'godot -e --headless --quit project.godot'
			}
		}

		stage('Tests') {
			steps {
				sh 'godot -s --headless --path .  addons/gut/gut_cmdln.gd -gtest=res://tests/test_basique.gd -glog=1 -gexit'
			}
		}


	}
}
