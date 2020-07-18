.mode columns
.headers on
.nullvalue NULL

select Nome from Cliente 
where 
Identificacao in
(
    select idCliente from PassagemAerea 
    where NBilheteEletronico in
    (
        select idPassagemAerea from DataDeVoo where idVoo in (
            select idVoo from Voo where idVoo in (
                select idVoo from VooAviao where idAviao = 181
                )
            )
    )
);