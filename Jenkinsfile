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
			echo "Starting to build docker image ubuntu:${params.Version}"
			//sh 'service docker start'
			customImage = docker.build("bagalvitthal/ubuntu:${params.Version}","--build-arg Distro=${params.Version} .")
			customCont = customImage.run('--name testContainer') 
			
			echo "Adding user and subscription to image ubuntu:${params.Version}"
			sh 'docker exec --tty testContainer /bin/bash -c "bash /root/build.sh"'
			sh "docker commit testContainer bagalvitthal/ubuntu:${params.Version}"
			sh 'docker images'
			sh 'docker ps -a'
		}
		
		stage('Verify Image'){
			echo "Verifying docker image ubuntu:${params.Version}"
			customImage.inside { 
				script {
					sh ''' 
 					if getent passwd | cut -d: -f1 | grep test
 					then
						apt-get install -y wget git tar
						if (( $? != 0 ))
			     			then
   			       				exit 1
   			     			else
							exit 0
						fi
					else
						exit 1
					fi
					'''
				}
			}
		}
		
		stage('Push Image'){
			echo "Pushing docker image ubuntu:${params.Version}"	
			//sh "docker push bagalvitthal/ubuntu:${params.Version}"
		}

		stage('Notify and Cleanup'){
			//slackSend channel: '#psl-script-notify', color: 'good', message: 'Pushed Image ecos0003:5000/jenkins_slave_rhel:${params.Version} to Docker Registry', teamDomain: 'psl-loz', token: 'https://hooks.slack.com/services/', tokenCredentialId: 'slk-demo'
			slackSend channel: '#psl-script-notify', color: 'good', message: 'This is test msg', teamDomain: 'psl-loz', token: 'https://hooks.slack.com/services/', tokenCredentialId: 'slk-demo'
			sh "yes | docker system prune"
		}

	}

