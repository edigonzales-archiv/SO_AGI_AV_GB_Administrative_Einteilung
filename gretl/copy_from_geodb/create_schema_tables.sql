-- DROP SCHEMA av_nfgeometer;

CREATE SCHEMA av_nfgeometer;

COMMENT ON SCHEMA av_nfgeometer IS 'Schema fuer das Verwalten von Information zu den Nachführungsgeometern. Z.B. Anschrift.';


-- Drop table

-- DROP TABLE av_nfgeometer.nfgeometer
CREATE TABLE av_nfgeometer.nfgeometer (
  ogc_fid int4 NOT NULL,
  "name" varchar NULL,
  vorname varchar NULL,
  firma varchar NULL,
  firma_zusatz varchar NULL,
  strasse varchar NULL,
  hausnummer varchar NULL,
  plz int4 NULL,
  ortschaft varchar NULL,
  telefon varchar NULL,
  fax varchar NULL,
  web varchar NULL,
  email varchar NULL,
  uid int4 NULL,
  egid int4 NULL,
  edid int4 NULL,
  CONSTRAINT nfgeometer_pkey PRIMARY KEY (ogc_fid)
)
WITH (
  OIDS=FALSE
) ;


-- Drop table

-- DROP TABLE av_nfgeometer.geometer_gemeinde
CREATE TABLE av_nfgeometer.geometer_gemeinde (
  ogc_fid serial NOT NULL,
  gem_bfs int4 NULL,
  nfgeometer_id int4 NULL,
  CONSTRAINT geometer_gemeinde_gem_bfs_key UNIQUE (gem_bfs),
  CONSTRAINT geometer_gemeinde_pkey PRIMARY KEY (ogc_fid),
  CONSTRAINT nfgeometer_id_fkey FOREIGN KEY (nfgeometer_id) REFERENCES av_nfgeometer.nfgeometer(ogc_fid) MATCH FULL
)
WITH (
  OIDS=FALSE
) ;




-- DROP SCHEMA av_grundbuch;

CREATE SCHEMA av_grundbuch ;

COMMENT ON SCHEMA av_grundbuch IS 'Schema fuer das Verwalten von Information zum Grundbuch. Z.B. Grundbuchkreise.';


-- Drop table

-- DROP TABLE av_grundbuch.grundbuch_art

CREATE TABLE av_grundbuch.grundbuch_art (
  ogc_fid serial NOT NULL,
  art varchar NOT NULL,
  art_txt varchar NULL,
  CONSTRAINT grundbuch_art_pkey PRIMARY KEY (art)
)
WITH (
  OIDS=FALSE
) ;

-- Drop table

-- DROP TABLE av_grundbuch.grundbuchamt

CREATE TABLE av_grundbuch.grundbuchamt (
  ogc_fid int4 NOT NULL,
  amtschreiberei varchar NULL,
  amt varchar NULL,
  strasse varchar NULL,
  hausnummer varchar NULL,
  plz int4 NULL,
  ortschaft varchar NULL,
  telefon varchar NULL,
  web varchar NULL,
  email varchar NULL,
  uid varchar NULL,
  CONSTRAINT grundbuchamt_pkey PRIMARY KEY (ogc_fid)
)
WITH (
  OIDS=FALSE
) ;

-- Drop table

-- DROP TABLE av_grundbuch.grundbuchkreis_herkunft

CREATE TABLE av_grundbuch.grundbuchkreis_herkunft (
  ogc_fid serial NOT NULL,
  art varchar NOT NULL,
  art_txt varchar NULL,
  CONSTRAINT grundbuchkreis_herkunft_art_txt_unique UNIQUE (art_txt),
  CONSTRAINT grundbuchkreis_herkunft_pkey PRIMARY KEY (art)
)
WITH (
  OIDS=FALSE
) ;

-- Drop table

-- DROP TABLE av_grundbuch.grundbuchkreise

CREATE TABLE av_grundbuch.grundbuchkreise (
  ogc_fid serial NOT NULL,
  grundbuch varchar NULL,
  gemeinde varchar NULL,
  gem_bfs int4 NULL,
  gb_art varchar NULL,
  gb_kreis_herkunft varchar NULL,
  nbident varchar NULL,
  bemerkungen varchar NULL,
  wkb_geometry geometry NULL,
  gb_gemnr int4 NULL,
  grundbuchamt_id int4 NULL,
  kreis_nr int4 NULL,
  CONSTRAINT grundbuchkreise_pkey PRIMARY KEY (ogc_fid),
  CONSTRAINT grundbuchkreise_gb_kreis_herkunft_fkey FOREIGN KEY (gb_kreis_herkunft) REFERENCES av_grundbuch.grundbuchkreis_herkunft(art_txt),
  CONSTRAINT grundbuchkreise_grundbuchamt_fkey FOREIGN KEY (grundbuchamt_id) REFERENCES av_grundbuch.grundbuchamt(ogc_fid)
)
WITH (
  OIDS=FALSE
) ;
CREATE INDEX grundbuchkreise_gb_gemnr_idx ON av_grundbuch.grundbuchkreise USING btree (gb_gemnr) ;
CREATE INDEX grundbuchkreise_gem_bfs_idx ON av_grundbuch.grundbuchkreise USING btree (gem_bfs) ;
CREATE INDEX grundbuchkreise_grundbuch_idx ON av_grundbuch.grundbuchkreise USING btree (grundbuch) ;
CREATE INDEX idx_grundbuchkreise_wkb_geometry ON av_grundbuch.grundbuchkreise USING gist (wkb_geometry) ;
