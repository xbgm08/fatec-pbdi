-- Exibir os nomes dos youtubers que começaram a partir de 2010 e têm, pelo menos, 60 milhões de inscritos,
-- usando um parâmetro nomeado e outro pela ordem
-- DO $$
-- DECLARE
-- 	-- 1. Declaração
-- 	v_ano INT := 2010;
-- 	v_inscritos INT := 60000000;
-- 	cur_ano_inscritos CURSOR (ano INT, inscritos INT) 
-- 		FOR SELECT youtuber FROM tb_top_youtubers
-- 		WHERE started >= ano AND subscribers >= inscritos;
-- 	v_youtuber VARCHAR(200);
-- BEGIN
-- 	-- 2. Abertura
-- 	-- Exemplo pela ordem
-- 	-- OPEN cur_ano_inscritos (v_ano, v_inscritos);

-- 	-- Exemplo com parêmetros nomeados
-- 	OPEN cur_ano_inscritos(inscritos := v_inscritos, ano := v_ano);
-- 	LOOP
-- 		-- 3. Recuperação de dados
-- 		FETCH cur_ano_inscritos INTO v_youtuber;
		
-- 		EXIT WHEN NOT FOUND;
		
-- 		RAISE NOTICE 'Nome: %', v_youtuber;
-- 	END LOOP;
-- 	-- 4. Fechamento do cursor
-- 	CLOSE cur_ano_inscritos;
-- END;
-- $$ LANGUAGE plpgsql;

-- Fazer um cursor vinculado para exibir o nome de cada youtuber e seu número de inscrições
-- DO $$
-- DECLARE
-- 	-- 1. Declaração
-- 	cur_nomes_e_inscritos_youtubers CURSOR FOR
--  		SELECT youtuber, subscribers FROM tb_top_youtubers;
-- 	v_youtuber RECORD;
-- 	resultado TEXT DEFAULT '';
-- BEGIN
-- 	-- 2. Abertura
-- 	OPEN cur_nomes_e_inscritos_youtubers;
-- 	-- 3. Recuperação de dados
-- 	FETCH cur_nomes_e_inscritos_youtubers INTO v_youtuber;
	
-- 	-- Com WHILE
-- 	WHILE FOUND LOOP
-- 		EXIT WHEN NOT FOUND;		
-- 		resultado := resultado || v_youtuber.youtuber || ': ' || v_youtuber.subscribers || ', ';
-- 		FETCH cur_nomes_e_inscritos_youtubers INTO v_youtuber;
-- 	END LOOP;
-- 	-- 4. Fechamento do cursor
-- 	CLOSE cur_nomes_e_inscritos_youtubers;

-- 	RAISE NOTICE '%', resultado;
-- END;
-- $$


-- DO $$
-- DECLARE
-- 	-- 1. Declaração
-- 	cur_nomes_e_inscritos_youtubers CURSOR FOR
--  		SELECT youtuber, subscribers FROM tb_top_youtubers;
-- 	v_youtuber RECORD;
-- BEGIN
-- 	-- 2. Abertura
-- 	OPEN cur_nomes_youtubers;
-- 	LOOP
-- 		-- 3. Recuperação de dados
-- 		FETCH cur_nomes_e_inscritos_youtubers INTO v_youtuber;
		
-- 		EXIT WHEN NOT FOUND;
		
-- 		RAISE NOTICE 'Nome: % - Inscritos: %', v_youtuber.youtuber, v_youtuber.subscribers;
-- 	END LOOP;
-- 	-- 4. Fechamento do cursor
-- 	CLOSE cur_nomes_e_inscritos_youtubers;
-- END;
-- $$

-- Exibir nomes dos youtubers que começaram a partir de um ano específico. 
-- Desafio: fazer com query dinâmica. O cursor tem que ser não vinculado
-- DO $$
-- DECLARE
-- 	-- 1. Declaração
-- 	cur_nomes_youtubers REFCURSOR;
-- 	v_youtuber VARCHAR(200);
-- 	v_ano INT := 2018;
-- 	v_nome_tabela VARCHAR (200) := 'tb_top_youtubers';
-- BEGIN
-- 	-- 2. Abertura
-- 	OPEN cur_nomes_youtubers FOR EXECUTE
-- 		formart(
-- 			'
-- 				SELECT youtuber FROM %s 
-- 				WHERE started >= $1
-- 			',
-- 			v_nome_tabela,
-- 		) USING v_ano;
-- 	LOOP
-- 		-- 3. Recuperação de dados
-- 		FETCH cur_nomes_youtubers INTO v_youtuber;
		
-- 		EXIT WHEN NOT FOUND;
		
-- 		RAISE NOTICE '%', v_youtuber;
-- 	END LOOP;
-- 	-- 4. Fechamento do cursor
-- 	CLOSE cur_nomes_youtubers;
-- 	RAISE NOTICE 'Acabou.'
-- END;
-- $$


-- DO $$
-- DECLARE
-- 	-- 1. Declaração do cursor não vinculado
-- 	cur_nomes_youtubers REFCURSOR;
-- 	v_youtuber VARCHAR(200);
-- BEGIN
-- 	-- 2. Abertura do cursor
-- 	OPEN cur_nomes_youtubers FOR 
-- 		SELECT youtuber FROM tb_top_youtubers;

-- 	LOOP
-- 		-- 3. Recuperação dos dados de interesse
-- 		FETCH cur_nomes_youtubers INTO v_youtuber;
		
-- 		EXIT WHEN NOT FOUND;
		
-- 		RAISE NOTICE '%', v_youtuber;
-- 	END LOOP;
-- 	-- 4. Fechamento do cursor
-- 	CLOSE cur_nomes_youtubers;
-- END;
-- $$

-- SELECT * FROM tb_top_youtubers;

-- CREATE TABLE tb_top_youtubers (
-- 	cod_top_youtubers SERIAL PRIMARY KEY,
-- 	rank INT,
-- 	youtuber VARCHAR (200),
-- 	subscribers INT,
-- 	video_views VARCHAR (200),
-- 	video_count INT,
-- 	category VARCHAR (200),
-- 	started INT
-- );