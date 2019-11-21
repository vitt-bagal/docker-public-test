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
			//sh 'service docker start'
			customImage = docker.build("bagalvitthal/ubuntu:${params.Version}","--build-arg Distro=${params.Version} .")
			customCont = customImage.run('--name testContainer') 
			
			sh 'docker exec --tty testContainer /bin/bash -c "bash build.sh"'
			sh "docker commit testContainer bagalvitthal/ubuntu:${params.Version}"
			sh 'docker images'
			sh 'docker ps'
		}
		
		stage('Pull Docker Image & add user it '){
			echo 'Pushing docker image'	
			sh 'docker push bagalvitthal/ubuntu:${params.Version}'
		}
	}
