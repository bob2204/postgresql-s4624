--
-- Création de la table t_load d'exemple du cours
--
-- 2016-01-04
--

CREATE TABLE public.t_load ( 
     id integer  NOT NULL,                                                                                                                           
     montant integer  NOT NULL, 
     jour date  NOT NULL,           
     codepays character(2)  NULL, 
     CONSTRAINT t_load_codepays_check CHECK ((codepays IN ('FR', 'BE', 'UK', 'US', 'CA', 'JP'))), 
     CONSTRAINT t_load_pkey PRIMARY KEY (id) 
 );

--
-- Fonction remplir()
--

CREATE OR REPLACE FUNCTION remplir(IN nb integer)
  RETURNS TABLE(id integer, montant integer, jour date, codepays character) AS
$BODY$
	DECLARE
		i			int;
		nbjour		int;
		_jour		date;
		_montant	int;
		_codePays	int;
		Pays		char(2);
	BEGIN
	i:= 1;
	WHILE i <= nb LOOP
		nbjour    := floor(random()*4015);
		_jour     := date '1996-01-01' + concat(nbjour,' days')::interval;
		_montant  := floor(1 + (random()*9999));
		_codePays := floor(1+(random()*6));
		
		CASE _codePays
			WHEN 1 THEN Pays := 'FR';
			WHEN 2 THEN Pays := 'BE';
			WHEN 3 THEN Pays := 'UK';
			WHEN 4 THEN Pays := 'US';
			WHEN 5 THEN Pays := 'CA';
			WHEN 6 THEN Pays := 'JP';
		END CASE;
		
		RETURN QUERY SELECT i,_montant,_jour,Pays;
		i := i+1;
	END LOOP;

	RETURN;
END
$BODY$
  LANGUAGE plpgsql VOLATILE;
