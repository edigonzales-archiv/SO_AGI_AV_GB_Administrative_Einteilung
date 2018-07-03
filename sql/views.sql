CREATE OR REPLACE VIEW av_grundbuch.grundbuchkreise_grundbuchamt_v AS
 SELECT kreis.ogc_fid, kreis.grundbuch, kreis.gemeinde AS politische_gemeinde, 
    kreis.gem_bfs, kreis.nbident, kreis.wkb_geometry, kreis.gb_art, 
    kreis.gb_gemnr, amt.amtschreiberei, amt.amt, amt.strasse, amt.hausnummer, 
    amt.plz, amt.ortschaft, amt.telefon, amt.web, amt.email
   FROM av_grundbuch.grundbuchkreise kreis, av_grundbuch.grundbuchamt amt
  WHERE amt.ogc_fid = kreis.grundbuchamt_id;


CREATE OR REPLACE VIEW av_grundbuch.nummerierungsbereiche_nbgeometrie_v AS
 SELECT a.t_id, a.nbgeometrie_von, a.geometrie, a.t_datasetname, b.nbnummer
   FROM av_avdpool_ng.nummerierngsbrche_nbgeometrie a, 
    av_avdpool_ng.nummerierngsbrche_nummerierungsbereich b
  WHERE a.nbgeometrie_von::text = b.t_id::text;


