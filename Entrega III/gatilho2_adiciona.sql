CREATE TRIGGER [apaga Voo]
        BEFORE DELETE
            ON Voo
      FOR EACH ROW
BEGIN
    SELECT CASE WHEN 
    (
        SELECT count( * ) 
            FROM PassagemAerea
                WHERE NBilheteEletronico IN 
                    (
                        SELECT idPassagemAerea
                            FROM DataDeVoo JOIN Voo USING (idVoo) WHERE 
                            Voo.idVoo = Old.idVoo) > 0
    )
    THEN RAISE(ABORT, "Não foi possível remover este Voo pois existem Passagens Aereas vendidas para o mesmo") END;
END;