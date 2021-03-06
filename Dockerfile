FROM java:openjdk-8-jdk-alpine

# Add OpenSSH
RUN apk update && apk add openssh

# add platform-registry source
ADD pom.xml mvnw /code/
ADD src /code/src
ADD .mvn /code/.mvn
RUN chmod +x /code/mvnw

# package the application and delete all lib
RUN cd /code/ && \
    ./mvnw package && \
    mv /code/target/*.war /platform-registry.war && \
    rm -Rf /root/.m2/wrapper/ && \
    rm -Rf /root/.m2/repository/

RUN sh -c 'touch /platform-registry.war'
EXPOSE 8761
VOLUME /tmp

ENV SPRING_PROFILES_ACTIVE=prod,native
ENV GIT_URI=https://github.com/morehai/platform-registry/
ENV GIT_SEARCH_PATHS=central-config

CMD ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/platform-registry.war","--spring.cloud.config.server.git.uri=${GIT_URI}","--spring.cloud.config.server.git.search-paths=${GIT_SEARCH_PATHS}"]
