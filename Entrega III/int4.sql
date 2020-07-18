.mode columns
.headers on
.nullvalue NULL

select Nome from Cliente, passagemAerea, DataDeVoo, Voo 
where 
Cliente.Identificacao = PassagemAerea.idCliente and NBilheteEletronico = DataDeVoo.idPassagemAerea and DataDeVoo.idVoo = Voo.idVoo and Designacao = "IA-300";