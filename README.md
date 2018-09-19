# SO_AGI_AV_GB_Administrative_Einteilung

## ili2pg
```
java -jar /Users/stefan/apps/ili2pg-3.11.3/ili2pg.jar --defaultSrsCode 2056 --strokeArcs --createGeomIdx --createFk --createFkIdx --createEnumTabs --beautifyEnumDispName --createMetaInfo --createUnique --createNumChecks --nameByTopic --modeldir "http://models.geo.admin.ch;." --models SO_AGI_AV_GB_Administrative_Einteilungen_20180613 --dbhost 192.168.50.8 --dbdatabase pub --dbusr ddluser --dbpwd ddluser --dbschema agi_av_gb_administrative_einteilungen --schemaimport


java -jar /Users/stefan/apps/ili2pg-3.11.3/ili2pg.jar --defaultSrsCode 2056 --sqlEnableNull --strokeArcs --createGeomIdx --createEnumTabs --beautifyEnumDispName --createMetaInfo --createUnique --createNumChecks --nameByTopic --modeldir "http://models.geo.admin.ch;." --models SO_AGI_AV_GB_Administrative_Einteilungen_20180613 --dbhost 192.168.50.8 --dbdatabase pub --dbusr ddluser --dbpwd ddluser --dbschema agi_av_gb_administrative_einteilungen --schemaimport
```

```
java -jar /Users/stefan/apps/ili2pg-3.11.3/ili2pg.jar --defaultSrsCode 2056  --modeldir "http://models.geo.admin.ch;." --models SO_AGI_AV_GB_Administrative_Einteilungen_20180613 --dbhost 192.168.50.8 --dbdatabase pub --dbusr ddluser --dbpwd ddluser --dbschema agi_av_gb_administrative_einteilungen --disableValidation --export fubar.xtf
```

```
xmllint --format fubar.xtf -o fubar.xtf
```


```
java -jar /Users/stefan/apps/ili2pg-3.11.3/ili2pg.jar --defaultSrsCode 2056 --strokeArcs --createGeomIdx --createFk --createFkIdx --createEnumTabs --beautifyEnumDispName --createMetaInfo --createUnique --createNumChecks --nameByTopic  --models SO_ARP_Naturreservate_20180404 --dbhost geodb-dev.cgjofbdf5rqg.eu-central-1.rds.amazonaws.com --dbdatabase sogis --dbusr stefan --dbpwd ziegler15 --dbschema arp_agglo_geom_test --schemaimport --sqlEnableNull
```