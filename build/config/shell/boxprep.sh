#!/usr/bin/env bash
#
#
#
echo "Updating apt"
apt-get update -y
echo "Add PHP, Apache and Git bits"
apt-get install apache2 php5 php5-curl git parallel daemon unzip -y
#
#
#
echo "Install Git Key Safe script"
cp /vagrant/build/config/shell/git-key-safe.sh /usr/bin/git-key-safe
chmod 775 /usr/bin/git-key-safe
chmod +x /usr/bin/git-key-safe
#
#
#
echo "Install Jenkins"
dpkg -i /vagrant/build/config/jenkins/installer/jenkins.deb || true
apt-get install -f -y
dpkg -i /vagrant/build/config/jenkins/installer/jenkins.deb
echo "Lets add global jenkins config"
cp /vagrant/build/config/jenkins/global/* /var/lib/jenkins
echo "Ensure Jenkins SSH directory exists"
mkdir -p /var/lib/jenkins/.ssh
echo "Copy in the SSH Config"
cp /vagrant/build/config/jenkins/ssh/config /var/lib/jenkins/.ssh/config
#
#
#
echo "Ensure Jenkins can sudo"
bash /vagrant/build/config/shell/ensure-jenkins-sudo.sh
#
#
#
echo "Ensure Jenkins Jobs directory exists"
mkdir -p /var/lib/jenkins/jobs
echo "Fast Failing Parallel Runner"
cp -r /vagrant/build/config/jenkins/jobs/Execute_QAWorks_Suite /var/lib/jenkins/jobs
#
#
#
echo "Lets add the jenkins CLI plugin installer script"
cp /vagrant/build/config/jenkins-plugin-install/jenkins-plugin-install.sh /usr/bin/jenkins-plugin-install
echo "Let's make the Jenkins plugin nstall script executable"
chmod 777 /usr/bin/jenkins-plugin-install
chmod +x /usr/bin/jenkins-plugin-install
echo "Lets install the new Jenkins Plugins"
/usr/bin/jenkins-plugin-install htmlpublisher
/usr/bin/jenkins-plugin-install parameterized-trigger
/usr/bin/jenkins-plugin-install envinject
/usr/bin/jenkins-plugin-install greenballs
#
#
#
echo "Lets ensure correct user ownership of our jenkins jobs"
chown -R jenkins:jenkins /var/lib/jenkins
service jenkins restart
echo "Jenkins job setup complete"
#
#
#
echo "Changing to opt dir"
cd /opt
echo "Creating Behat directory"
mkdir -p /opt/behat/vendor/behat/behat/src/Behat/Behat/Formatter/
echo "Changing to Behat directory"
cd /opt/behat
echo "Copying in composer.json file from Vagrant directory"
cp /vagrant/build/config/composer/composer.json .
# echo "Downloading remote composer Phar file"
# curl -sS https://getcomposer.org/installer | /usr/bin/php
echo "Copying in the local composer Phar file from the /vagrant directory"
rm -rf composer.phar
cp /vagrant/build/config/composer/phar/composer.phar .
echo "Installing Behat with Composer"
/usr/bin/php composer.phar self-update
/usr/bin/php composer.phar update
/usr/bin/php composer.phar install
#
#
#
cp /vagrant/builild/config/behat/Formatter/JUnitFormatter.php /opt/behat/vendor/behat/behat/src/Behat/Behat/Formatter/JUnitFormatter.php
cp /vagrant/bud/config/behat/Formatter/JUnitAtomicFormatter.php /opt/behat/vendor/behat/behat/src/Behat/Behat/Formatter/JUnitAtomicFormatter.php
echo "Installing Our Custom Behat Mink Extension"
cp /vagrant/build/config/behat/MinkExtension/Extension.php /opt/behat/vendor/behat/mink-extension/src/Behat/MinkExtension/Extension.php
echo "Installing Our Custom Behat Base Node Definition"
cp /vagrant/build/config/behat/Symfony/BaseNode.php /opt/behat/vendor/symfony/config/Definition/BaseNode.php
echo "Installing Our Custom Behat Selenium 2 driver"
cp /vagrant/build/config/behat/Driver/Selenium2Driver.php /opt/behat/vendor/behat/mink-selenium2-driver/src/Behat/Mink/Driver/Selenium2Driver.php
mkdir -p /tmp/testouts/
sudo chmod -R 777 /tmp/testouts/
#
#
#
echo "Install Node, NPM and the junit-viewer"
apt-get install node npm -y
echo "Ensuring /usr/bin/node is symlinked to /usr/bin/nodejs"
ln -s /usr/bin/nodejs /usr/bin/node
npm install junit-viewer -g