FROM jboss/wildfly:11.0.0.Final

# install postgresql support
RUN mkdir -p $JBOSS_HOME/modules/system/layers/base/org/postgresql/main
COPY ./postgresql $JBOSS_HOME/modules/system/layers/base/org/postgresql/main
RUN /bin/sh -c '$JBOSS_HOME/bin/standalone.sh &' \
  && sleep 10 \
  && $JBOSS_HOME/bin/jboss-cli.sh --connect --command="/subsystem=datasources/jdbc-driver=postgresql:add(driver-name=postgresql,driver-module-name=org.postgresql, driver-class-name=org.postgresql.Driver)" \
  && $JBOSS_HOME/bin/jboss-cli.sh --connect --command=:shutdown \
  && rm -rf $JBOSS_HOME/standalone/configuration/standalone_xml_history/ \
  && rm -rf $JBOSS_HOME/standalone/log/*

# copy war file from s3
curl -o  /opt/jboss/wildfly/standalone/deployments/applicationPetstore.war

# copy our configuration
COPY ./standalone.xml /opt/jboss/wildfly/standalone/configuration/standalone.xml

# expose the application port and the management port
EXPOSE 8080 9990

# run the application
ENTRYPOINT [ "/opt/jboss/wildfly/bin/standalone.sh" ]
CMD [ "-b", "0.0.0.0", "-bmanagement", "0.0.0.0" ]
