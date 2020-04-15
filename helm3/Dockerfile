FROM golang:1.13

ENV HOME=/config
ENV IN_DOCKER=1

USER root

RUN apt-get update && apt-get install -y apt-transport-https
RUN apt-get install -y docker docker.io

RUN curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - \
    && echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | tee -a /etc/apt/sources.list.d/kubernetes.list \
    && apt-get update \
    && apt-get install -y kubectl \
    && apt-get install -y openssl

ADD ./kube /config/.kube

# install helm
RUN curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 > get_helm.sh \
    && bash ./get_helm.sh


# install migrate 2to3 plus
# https://github.com/helm/helm-2to3
RUN helm plugin install https://github.com/helm/helm-2to3.git