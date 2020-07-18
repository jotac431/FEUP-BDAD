.mode columns
.headers on
.nullvalue NULL

Select count(*) from PassagemAerea
where NBilheteEletronico in 
(
select idPassagemAerea from DataDeVoo join Voo using (idVoo) 
where Voo.idVoo = 197);