CREATE OR REPLACE VIEW av_grundbuch.grundbuchkreise_grundbuchamt_v AS
 SELECT kreis.ogc_fid, kreis.grundbuch, kreis.gemeinde AS politische_gemeinde, 
    kreis.gem_bfs, kreis.nbident, kreis.wkb_geometry, kreis.gb_art, 
    kreis.gb_gemnr, amt.amtschreiberei, amt.amt, amt.strasse, amt.hausnummer, 
    amt.plz, amt.ortschaft, amt.telefon, amt.web, amt.email
   FROM av_grundbuch.grundbuchkreise kreis, av_grundbuch.grundbuchamt amt
  WHERE amt.ogc_fid = kreis.grundbuchamt_id;


  CREATE OR REPLACE VIEW av_grundbuch.nummerierungsbereiche_nbgeometrie_v AS
 SELECT a.ogc_fid, a.tid, a.nbgeometrie_von, a.geometrie, a.gem_bfs, a.los, 
    a.lieferdatum, b.nbnummer
   FROM av_avdpool_ng.nummerierungsbereiche_nbgeometrie a, 
    av_avdpool_ng.nummerierungsbereiche_nummerierungsbereich b
  WHERE a.nbgeometrie_von::text = b.tid::text;


CREATE OR REPLACE VIEW av_nfgeometer.datenabgabe_info_v AS
 SELECT b.ogc_fid, b.gem_bfs, btrim(c.gmde_name::text) AS gem_name, 
    to_char(d.lieferdatum::timestamp with time zone, 'DD.MM.YYYY'::text) AS lieferdatum, 
    ((((btrim(a.vorname::text) || ' '::text) || btrim(a.name::text)) || ' ('::text) || a.firma::text) || ')'::text AS nfgeometer, 
    a.vorname, a.name, 
    ((((((('geoweb.rootso.org/map/grundbuchplan-nf?startExtent='::text || round(st_xmin(c.wkb_geometry::box3d))) || ','::text) || round(st_ymin(c.wkb_geometry::box3d))) || ','::text) || round(st_xmax(c.wkb_geometry::box3d))) || ','::text) || round(st_ymax(c.wkb_geometry::box3d))) || '&visibleLayers=Amtliche%20Vermessung%20(schwarz-weiss),Strassenkarte'::text AS pdf, 
    ('geoweb.rootso.org/av_datenabgabe/av_daten/itf_ch/ch_'::text || b.gem_bfs) || '00.zip'::text AS itfch, 
    ('geoweb.rootso.org/av_datenabgabe/av_daten/itf_so/'::text || b.gem_bfs) || '00.zip'::text AS itfso, 
    ('geoweb.rootso.org/av_datenabgabe/av_daten/dxf_geobau/'::text || b.gem_bfs) || '.zip'::text AS dxf, 
    ('geoweb.rootso.org/av_datenabgabe/av_daten/mopublic/shp/lv95/d/'::text || b.gem_bfs) || '.zip'::text AS shp, 
    btrim(a.firma::text) AS firma, btrim(a.firma_zusatz::text) AS firma_zusatz, 
    btrim(a.strasse::text) AS strasse, btrim(a.hausnummer::text) AS hausnr, 
    a.plz, btrim(a.ortschaft::text) AS ortschaft, 
    btrim(a.telefon::text) AS telefon, btrim(a.fax::text) AS fax, 
    btrim(a.email::text) AS email, btrim(a.web::text) AS web
   FROM av_nfgeometer.nfgeometer a, av_nfgeometer.geometer_gemeinde b, 
    geo_gemeinden_v c, 
    ( SELECT DISTINCT ON (gemeindegrenzen_gemeinde.gem_bfs) gemeindegrenzen_gemeinde.gem_bfs, 
            gemeindegrenzen_gemeinde.lieferdatum
           FROM av_avdpool_ng.gemeindegrenzen_gemeinde
          ORDER BY gemeindegrenzen_gemeinde.gem_bfs) d
  WHERE a.ogc_fid = b.nfgeometer_id AND b.gem_bfs = c.gem_bfs AND d.gem_bfs = b.gem_bfs;


CREATE OR REPLACE VIEW av_nfgeometer.qgis_printcomposer_info_v AS
 SELECT c.ogc_fid, b.gem_bfs, c.wkb_geometry, 
        CASE
            WHEN d.anz = 1 THEN 'Gemeinde '::text || btrim(c.gemeinde::text)
            ELSE ((('Gemeinde '::text || btrim(c.gemeinde::text)) || ' ('::text) || btrim(c.grundbuch::text)) || ')'::text
        END AS gemeinde, 
    to_char(e.lieferdatum::timestamp with time zone, 'DD.MM.YYYY'::text) AS lieferdatum, 
    (btrim(a.vorname::text) || ' '::text) || btrim(a.name::text) AS nfgeometer, 
    ((((((((btrim(a.firma::text) || ', '::text) || 
        CASE
            WHEN a.firma_zusatz IS NOT NULL THEN btrim(a.firma_zusatz::text) || ', '::text
            ELSE ''::text
        END) || btrim(a.strasse::text)) || ' '::text) || btrim(a.hausnummer::text)) || ', '::text) || a.plz) || ' '::text) || btrim(a.ortschaft::text) AS anschrift, 
    (((((('Tel.: '::text || btrim(a.telefon::text)) || ', Fax: '::text) || btrim(a.fax::text)) || ', E-Mail: '::text) || btrim(a.email::text)) || ', Web: '::text) || btrim(a.web::text) AS kontakt, 
    c.gemeinde AS gemeinde_name, c.grundbuch AS grundbuch_name, a.firma, 
    (btrim(a.strasse::text) || ' '::text) || btrim(a.hausnummer::text) AS strasse_nummer, 
    (a.plz || ' '::text) || btrim(a.ortschaft::text) AS plz_ortschaft, 
    'Tel.: '::text || a.telefon::text AS tel, 
    'Fax: '::text || a.fax::text AS fax, 
    'E-Mail: '::text || a.email::text AS email, 
    'Web: '::text || a.web::text AS web
   FROM av_nfgeometer.nfgeometer a, av_nfgeometer.geometer_gemeinde b, 
    av_grundbuch.grundbuchkreise c, 
    ( SELECT count(*) AS anz, grundbuchkreise.gem_bfs
           FROM av_grundbuch.grundbuchkreise
          GROUP BY grundbuchkreise.gem_bfs) d, 
    ( SELECT DISTINCT ON (gemeindegrenzen_gemeinde.gem_bfs) gemeindegrenzen_gemeinde.gem_bfs, 
            gemeindegrenzen_gemeinde.lieferdatum
           FROM av_avdpool_ng.gemeindegrenzen_gemeinde
          ORDER BY gemeindegrenzen_gemeinde.gem_bfs) e
  WHERE a.ogc_fid = b.nfgeometer_id AND b.gem_bfs = c.gem_bfs AND d.gem_bfs = b.gem_bfs AND c.gem_bfs = d.gem_bfs AND b.gem_bfs = e.gem_bfs;
