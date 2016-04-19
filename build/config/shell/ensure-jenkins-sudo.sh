if grep -Fxq "jenkins ALL=NOPASSWD: ALL" /etc/sudoers
then
    echo "Our jenkins user is already"
else
    echo "" >> /etc/sudoers
    echo "jenkins ALL=NOPASSWD: ALL" >> /etc/sudoers
fi