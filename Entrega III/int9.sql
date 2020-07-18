.mode columns
.headers on
.nullvalue NULL

Select SUM(Combustivel)
From Voo
Where Voo.idVoo in (
    select VooAviao.idVoo from VooAviao where VooAviao.idAviao in 
    (
        select Aviao.idAviao from Aviao where Lotacao > 50
    )
)
AND Voo.idRota in (
    select Rota.idRota from Rota where partida = 151
);