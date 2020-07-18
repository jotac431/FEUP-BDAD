.mode columns
.headers on
.nullvalue NULL

Select count(*)
from PassagemAerea, DataDeVoo, Voo
where NBilheteEletronico = DataDeVoo.idPassagemAerea AND DataDeVoo.idVoo = Voo.idVoo AND Designacao = 'Jakusko';