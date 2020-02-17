#!/bin/sh

echo "Verificando variáveis de sistema: "
echo "   HOSTNAMELINK: "$HOSTNAMELINK
echo "   DBNAME: "$DBNAME
echo "   DBUSERNAME: "$DBUSERNAME
echo "   DBPASSWORD: "$DBPASSWORD

PORT=5433
export PGPASSWORD=$DBPASSWORD
echo ""
echo "Carregando dados da aplicação ..."

echo "      ...executando o script SQL para CARGA DO DOMÍNIO DE DADOS..."

#pg_restore -h $HOSTNAMELINK -p $PORT -U $DBUSERNAME --no-password -d $DBNAME /opt/e-SUS/jboss-as-7.2.0.Final/dump.backup

docker exec -it db_postgre pg_restore -h localhost -p 5433 -U postgres --no-password -d esus /opt/e-SUS/jboss-as-7.2.0.Final/dump.backup
