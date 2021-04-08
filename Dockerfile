FROM fedora

USER root

RUN yum install ansible -y
RUN yum install python-pip -y

RUN pip install openshift

RUN curl -sL -o /tmp/oc.tar.gz https://mirror.openshift.com/pub/openshift-v4/clients/ocp/latest/openshift-client-linux.tar.gz && \
tar -C /tmp -xf /tmp/oc.tar.gz --no-same-owner && \
mv /tmp/oc /usr/local/bin && \
chmod +x /usr/local/bin/oc && \
rm /tmp/*

COPY . /devex

WORKDIR /devex

CMD ["ansible-playbook", \
     "setup/playbooks/Deploy_Advanced_Course.yml", \
     "setup/playbooks/Deploy_Docs.yml"]