FROM ubuntu:16.04
RUN apt-get update && apt-get install -y openssh-server
RUN mkdir /var/run/sshd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN mkdir /root/.ssh 
RUN echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDEZkFb59eO+XfM5Zsa6FM1tiw7ZbSlN06HHJ+rCf+29rqRo0Rjj0w7PwGhgonRt+LnQyLoMcOWA5sNOq9I0/SlMg/eyrCcXiMg11Q2PzV8se8bOn/755N562GPJjVc3KsgF/ppEhjiJekm+Nqt3VYYOAWv4oQKPoLM15ULVYGAsUJT7HkKE3qVVeI5ESPq8wEryOv6izGeGehGQ+eXdtrqLx7jdXToaxmDS9AFu8EYhmsCgrPaz3UOj6Qg8s7sqmN2zr01iSGz6K8metRE1JuTCmg5alwBN8HPBXA24oFIFtWVtpdJ9XLoOaIrZfSwzy2v5PMQVC7rVM01HT9uEldl musa@ubuntu" >> /root/.ssh/authorized_keys 
RUN chmod 600 /root/.ssh/authorized_keys 

RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd 
RUN sed -ie 's/Port 22/#Port 22/g' /etc/ssh/sshd_config 
ENV NOTVISIBLE "in users profile" 
RUN echo "export VISIBLE=now" >> /etc/profile 

EXPOSE 22 
CMD ["/usr/sbin/sshd", "-D"]