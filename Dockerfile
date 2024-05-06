FROM --platform=linux/arm64 arm64v8/amazoncorretto:21 as builder

ARG JAR_FILE=target/*.jar
WORKDIR /builder_dir
COPY ${JAR_FILE} app.jar
HEALTHCHECK NONE
RUN java -Djarmode=layertools -jar app.jar extract

FROM --platform=linux/arm64 arm64v8/amazoncorretto:21
VOLUME /tmp

ARG BUILDER_DIR=builder_dir
ARG SBA_USER=sbauser
COPY --from=builder /${BUILDER_DIR}/dependencies/ /home/${SBA_USER}/
COPY --from=builder /${BUILDER_DIR}/spring-boot-loader/ /home/${SBA_USER}/
COPY --from=builder /${BUILDER_DIR}/snapshot-dependencies/ /home/${SBA_USER}/
COPY --from=builder /${BUILDER_DIR}/application/ /home/${SBA_USER}/

RUN yum -y install shadow-utils.x86_64 && yum clean all
RUN groupadd ${SBA_USER} && adduser ${SBA_USER} -m -g ${SBA_USER} && gpasswd -a ${SBA_USER} ${SBA_USER}
RUN chown -R ${SBA_USER}:0 /home/ && chmod -R g+rwX /home/

USER ${SBA_USER}

WORKDIR /home/$SBA_USER
EXPOSE 8080
HEALTHCHECK NONE
ENTRYPOINT ["java", "org.springframework.boot.loader.launch.JarLauncher"]
