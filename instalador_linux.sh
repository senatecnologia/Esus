JBOSS_DIR=/opt/e-SUS/jboss-as-7.2.0.Final
SCRIPT_DIR=$(dirname $0)

#############################################################################################################
#						Checking necessary conditions				
#############################################################################################################
# Check privileges
if [ `id -u` -ne 0 ]; then
	echo "É preciso rodar esse script como super usuário."
	exit 1
fi

mkdir /opt/e-SUS
echo "Criando diretório para a aplicação."

 cp -r $SCRIPT_DIR/jboss-as-7.2.0.Final/ /opt/e-SUS

 cp $SCRIPT_DIR/linux-jboss-7.2.0-fullinstall.zip $JBOSS_DIR

 unzip -o $JBOSS_DIR/linux-jboss-7.2.0-fullinstall.zip -d $JBOSS_DIR

#echo "Instalando o banco de dados."
 sh $JBOSS_DIR/postgres-complete-install.sh
echo "Preparando o banco de dados."
bash $JBOSS_DIR/postgres-import-dump.sh
mv $JBOSS_DIR/desinstalador* $JBOSS_DIR/../
mv $JBOSS_DIR/backup-postgres.sh $JBOSS_DIR/../
rm $JBOSS_DIR/postgres*
rm $JBOSS_DIR/migrate-h2-to-postgres.sh
#rm $JBOSS_DIR/dump.backup

JAVA_PATH=$(readlink -f /usr/bin/javac | sed "s:bin/javac::")

if [ -z "$JAVA_PATH" ]; then
	echo "Instalação para o Java não encontrada"
	echo "Caminho para a instalação do java: "
	read java_dir
	JAVA_PATH=$java_dir
fi

cat /etc/java.conf
JAVA_HOME=$JAVA_PATH

 chmod +x /opt/e-SUS/jboss-as-7.2.0.Final/bin/*.sh

echo "Instalação Finalizada"
