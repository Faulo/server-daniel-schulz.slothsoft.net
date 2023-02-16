pipeline {
    agent any
	environment {
		PHP_VERSION = powershell(script:'composer config platform.php', returnStdout: true).trim()
		PHP = "C:\\Webserver\\php-${env.PHP_VERSION}\\php.exe"
		VHOST = powershell(script:'composer config name', returnStdout: true).trim().replace("cursedcreations/", "C:\\Webserver\\htdocs\\vhosts\\")
	}
    stages {
        stage('Build') { 
            steps {
				bat "$PHP composer.phar update --no-interaction --no-progress"
            }
        }
        stage('Test') { 
            steps {
				bat "$PHP vendor/phpunit/phpunit/phpunit --log-junit phpunit.results.xml"
				junit 'phpunit.results.xml'
			}
        }
        stage('Deployment') {
			when {
				branch 'main'
			}
            steps {
				dir("$VHOST") {
					checkout scm
					bat "git checkout --force origin/$BRANCH_NAME"
					bat "$PHP composer.phar update --no-interaction --no-progress --no-dev"
				}
			}
        }
    }
}