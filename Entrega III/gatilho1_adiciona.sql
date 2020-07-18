CREATE TRIGGER create_cliente
        BEFORE INSERT
            ON Cliente
      FOR EACH ROW
BEGIN
    SELECT CASE WHEN new.Telefone < 900000000 THEN RAISE(ABORT, "numero de telefone errado") WHEN new.Telefone > 1000000000 THEN RAISE(ABORT, "numero de telefone errado") WHEN EXISTS (
                   SELECT *
                     FROM Cliente
                    WHERE Identificacao = new.Identificacao
               )
           THEN RAISE(ABORT, "Já existe um cliente com essa identificação") WHEN NEW.Email NOT LIKE '%@%.%' THEN RAISE(ABORT, "Email invalido") END;
END;