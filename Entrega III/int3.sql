.mode columns
.headers on
.nullvalue NULL

select idVoo, Designacao from Voo, Rota where Voo.idRota = Rota.idRota and Rota.idRota = 175;