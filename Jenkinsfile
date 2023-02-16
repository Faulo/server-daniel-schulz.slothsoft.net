pipeline {
    agent any
	environment {
		PHP_VERSION = powershell(script:'composer config platform.php', returnStdout: true).trim()
		PHP = "C:\\Webserver\\php-${env.PHP_VERSION}\\php.exe"
	}
    stages {
        stage('Build') { 
            steps {
				bat "$PHP composer.phar install --no-interaction --no-progress"
            }
        }
        stage('Test') { 
            steps {
				bat "$PHP vendor/phpunit/phpunit/phpunit --log-junit phpunit.results.xml"
			}
        }
    }
	post {
		cleanup {
			junit 'phpunit.results.xml'
		}
	}
}