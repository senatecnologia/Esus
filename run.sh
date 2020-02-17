#!/bin/bash


echo "Vai configurar o nome do HOST de banco de dados"
HOSTNAME="192.168.0.48"
# Verifica o valor da variável de ambiente
if [ -n "$HOSTNAMELINK" ]; then
    HOSTNAME=$HOSTNAMELINK
fi

echo "Verificando variáveis de sistema: "
echo "   HOSTNAME: "$HOSTNAME
echo "   DBNAME: "$DBNAME
echo "   DBUSERNAME: "$DBUSERNAME
echo "   DBPASSWORD: "$DBPASSWORD
echo "   DBSCHEMA: "$DBSCHEMA

sed -i -r "s/HOSTNAME/$HOSTNAME/" /opt/e-SUS/jboss-as-7.2.0.Final/standalone/configuration/standalone.xml
sed -i -r "s/DBNAME/$DBNAME/" /opt/e-SUS/jboss-as-7.2.0.Final/standalone/configuration/standalone.xml
sed -i -r "s/DBUSERNAME/$DBUSERNAME/"/opt/e-SUS/jboss-as-7.2.0.Final/standalone/configuration/standalone.xml
sed -i -r "s/DBPASSWORD/$DBPASSWORD/" /opt/e-SUS/jboss-as-7.2.0.Final/standalone/configuration/standalone.xml
#sed -i -r "s/DBSCHEMA/$DBSCHEMA/" /opt/jboss-as-7.2.0.Final/standalone/configuration/standalone.xml


# Aguardar a configuração do serviço de bancos para iniciar o jboss...
echo "Vai esperar o serviço de Banco de Dados ser configurado ..."
PORT=5433
export PGPASSWORD=$DBPASSWORD
while true; do
   if psql -lqt -h $HOSTNAME -p $PORT -U $DBUSERNAME $DBNAME | cut -d \| -f 1 | grep -qw $DBNAME; then
       
       echo "...Banco de Dados pronto"
       break
   else
       echo "...O BD ainda não foi configurado"
       sleep 5
   fi
done


echo "Vai iniciar o Jboss ..."
sh /opt/e-SUS/jboss-as-7.2.0.Final/bin/init.d/jboss-as-standalone-non-lsb.sh start &
# Aguardar o jboss subir...
sleep 5


echo "...Agora vamos carregar os dados do sistema..."
sh /opt/carregar_dados.sh 

echo -e "\n\n\nPRONTO! O GOG está funcionando! Use: http://localhost:8080/GOG"

while :
do
	sleep 1
done