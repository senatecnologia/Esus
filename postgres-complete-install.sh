JBOSS_DIR=/opt/e-SUS/jboss-as-7.2.0.Final
 chmod +x $JBOSS_DIR/postgresql-9.3.6-2-linux-x64.run
/opt/e-SUS/jboss-as-7.2.0.Final/postgresql-9.3.6-2-linux-x64.run --optionfile /opt/e-SUS/jboss-as-7.2.0.Final/postgres-install-params
 service e-SUS-AB-PostgreSQL stop
 pkill -u postgres
cp $JBOSS_DIR/postgresql.conf $JBOSS_DIR/PostgreSQL/9.3/data/
 service e-SUS-AB-PostgreSQL start