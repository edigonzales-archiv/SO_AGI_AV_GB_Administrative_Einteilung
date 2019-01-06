# SO_AGI_AV_GB_Administrative_Einteilung

## Erfassung

### ili2pg
```
java -jar /Users/stefan/apps/ili2pg-3.11.3/ili2pg.jar --defaultSrsCode 2056 --strokeArcs --createGeomIdx --createFk --createFkIdx --createEnumTabs --beautifyEnumDispName --createMetaInfo --createUnique --createNumChecks --nameByTopic --modeldir "http://models.geo.admin.ch;." --models SO_AGI_AV_GB_Administrative_Einteilungen_20180613 --dbhost 192.168.50.8 --dbdatabase pub --dbusr ddluser --dbpwd ddluser --dbschema agi_av_gb_administrative_einteilungen --schemaimport
```

Für die einmalige Migration ist es einfacher, wenn möglichst wenige Constraints gesetzt werden.

Lokal:
```
java -jar /Users/stefan/apps/ili2pg-3.11.3/ili2pg.jar --defaultSrsCode 2056 --sqlEnableNull --strokeArcs --createGeomIdx --createEnumTabs --beautifyEnumDispName --createMetaInfo --createUnique --createNumChecks --nameByTopic --modeldir "http://models.geo.admin.ch;." --models SO_AGI_AV_GB_Administrative_Einteilungen_20180613 --dbhost 192.168.50.8 --dbdatabase pub --dbusr ddluser --dbpwd ddluser --dbschema agi_av_gb_administrative_einteilungen --schemaimport
```

Test-DB:
```
java -jar /Users/stefan/apps/ili2pg-3.11.3/ili2pg.jar --defaultSrsCode 2056 --sqlEnableNull --strokeArcs --createGeomIdx --createEnumTabs --beautifyEnumDispName --createMetaInfo --createUnique --createNumChecks --nameByTopic --modeldir "http://models.geo.admin.ch;." --models SO_AGI_AV_GB_Administrative_Einteilungen_20180613 --dbhost geodb-t.verw.rootso.org --dbdatabase sogis --dbusr hdus --dbpwd hdus --dbschema agi_av_gb_administrative_einteilungen --schemaimport
```

Datenimport:
```
java -jar /Users/stefan/apps/ili2pg-3.11.3/ili2pg.jar --defaultSrsCode 2056 --sqlEnableNull --strokeArcs --createGeomIdx --createEnumTabs --beautifyEnumDispName --createMetaInfo --createUnique --createNumChecks --nameByTopic --modeldir "http://models.geo.admin.ch;." --models SO_AGI_AV_GB_Administrative_Einteilungen_20180613 --dbhost geodb-t.verw.rootso.org --dbdatabase sogis --dbusr hdus --dbpwd hdus --dbschema agi_av_gb_administrative_einteilungen --import agi_av_gb_administrative_einteilungen.xtf
```

Export:
```
java -jar /Users/stefan/apps/ili2pg-3.11.3/ili2pg.jar --defaultSrsCode 2056  --modeldir "http://models.geo.admin.ch;." --models SO_AGI_AV_GB_Administrative_Einteilungen_20180613 --dbhost 192.168.50.8 --dbdatabase pub --dbusr ddluser --dbpwd ddluser --dbschema agi_av_gb_administrative_einteilungen --export agi_av_gb_administrative_einteilungen.xtf
```

```
xmllint --format agi_av_gb_administrative_einteilungen.xtf -o agi_av_gb_administrative_einteilungen.xtf
```

Lokal Pub-Modell:
```
java -jar /Users/stefan/apps/ili2pg-3.11.3/ili2pg.jar --defaultSrsCode 2056 --sqlEnableNull --strokeArcs --createGeomIdx --createEnumTabs --beautifyEnumDispName --createMetaInfo --createUnique --createNumChecks --nameByTopic --modeldir "http://models.geo.admin.ch;." --models SO_AGI_AV_GB_Administrative_Einteilungen_Publikation_20180822 --dbhost 192.168.50.8 --dbdatabase pub --dbusr ddluser --dbpwd ddluser --dbschema agi_av_gb_administrative_einteilungen_pub --import agi_av_gb_administrative_einteilungen_pub.xtf
```



### kettle
Dient zur einmaligen Migration in das Erfassungsmodell. Kettle-Spielerei. Könnte auch mit GRETL gemacht werden. Es zeigt jedoch, dass Geometrien herumgeschoben werden können.

## Publikation

### ili2pg

Lokal:
```
java -jar /Users/stefan/apps/ili2pg-3.11.3/ili2pg.jar --defaultSrsCode 2056 --strokeArcs --createGeomIdx --createFk --createFkIdx --createEnumTabs --beautifyEnumDispName --createMetaInfo --createUnique --createNumChecks --nameByTopic --modeldir "http://models.geo.admin.ch;." --models SO_AGI_AV_GB_Administrative_Einteilungen_Publikation_20180822 --dbhost 192.168.50.8 --dbdatabase pub --dbusr ddluser --dbpwd ddluser --dbschema agi_av_gb_administrative_einteilungen_pub --schemaimport
```

Export:
```
java -jar /Users/stefan/apps/ili2pg-3.11.3/ili2pg.jar --defaultSrsCode 2056 --strokeArcs --createGeomIdx --createFk --createFkIdx --createEnumTabs --beautifyEnumDispName --createMetaInfo --createUnique --createNumChecks --nameByTopic --modeldir "http://models.geo.admin.ch;." --models SO_AGI_AV_GB_Administrative_Einteilungen_Publikation_20180822 --dbhost 192.168.50.8 --dbdatabase pub --dbusr ddluser --dbpwd ddluser --dbschema agi_av_gb_administrative_einteilungen_pub --export agi_av_gb_administrative_einteilungen_pub.xtf
```

```
xmllint --format agi_av_gb_administrative_einteilungen_pub.xtf -o agi_av_gb_administrative_einteilungen_pub.xtf
```

### gretl
Lokales Arbeiten:
```
export DB_URI_SOGIS=jdbc:postgresql://geodb-t.verw.rootso.org/sogis
export DB_USER_SOGIS=hdus
export DB_PWD_SOGIS=******
export DB_URI_PUB=jdbc:postgresql://192.168.50.8/pub
export DB_USER_PUB=ddluser
export DB_PWD_PUB=ddluser
```

```
./start-gretl.sh --docker_image sogis/gretl-runtime:production --job_directory /Users/stefan/Projekte/SO_AGI_AV_GB_Administrative_Einteilung/gretl/pub/ --task_name tasks

./start-gretl.sh --docker_image sogis/gretl-runtime:production --job_directory /Users/stefan/Projekte/SO_AGI_AV_GB_Administrative_Einteilung/gretl/pub/ 
```