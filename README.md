# SO_AGI_AV_GB_Administrative_Einteilung

## ili2pg
java -jar /Users/stefan/apps/ili2pg-3.11.3/ili2pg.jar --defaultSrsCode 2056 --strokeArcs --createGeomIdx --createFk --createFkIdx --createEnumTabs --beautifyEnumDispName --createMetaInfo --createUnique --createNumChecks --nameByTopic --modeldir "http://models.geo.admin.ch;." --models SO_AGI_AV_GB_Administrative_Einteilungen_20180613 --dbhost geodb-dev.cgjofbdf5rqg.eu-central-1.rds.amazonaws.com --dbdatabase sogis --dbusr stefan --dbpwd ziegler15 --dbschema av_gb_administrative_einteilungen_2 --schemaimport
