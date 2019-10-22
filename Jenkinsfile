node('docker-jnlp') {
	environment { 
        def customImage = ''
		registry = "bagalvitthal"
		registryCredential = 'dockerhub-id'
    }
	properties([[$class: 'JiraProjectProperty'], parameters([choice(choices: ['16.04', '18.04'], description: 'These are distro version for ubuntu', name: 'Version')])])
        stage('Checkout'){
		git url: 'https://github.com/vitt-bagal/docker-public-test'
		}
		stage('Pull Docker Image & add user it '){
			echo 'Starting to build docker image'
			sh 'service docker start'
			customImage = docker.build("bagalvitthal/ubuntu:${params.Version}","--build-arg Distro=${params.Version} .")
			def customCont = customImage.run { 
				script {
					sh '''
					apt-get update -y
					useradd test -ms /bin/bash
					echo -e "test\ntest" | passwd test # changing password of test user to test
					apt-get install -y wget sudo 
					'''
				}
			}
			sh "docker commit customCont bagalvitthal/ubuntu:${params.Version}"
			sh 'docker images'
			sh 'docker ps'
		}
		
		stage('Pull Docker Image & add user it '){
			echo 'Pushing docker image'	
			customImage.push()

		}
	}
