.mode columns
.headers on
.nullvalue NULL

Select Acima.avgTarifa - Abaixo.avgTarifa
From (
    select avg(Tarifa) as avgTarifa from PassagemAerea where NBilheteEletronico in 
        (
            select idPassagemAerea from DataDeVoo where DataDeVoo.idVoo in (
                select Voo.idVoo from Voo where DuracaodeVoo> 6
                )
        )
    ) as Acima,
(
    select avg(Tarifa) as avgTarifa from PassagemAerea where NBilheteEletronico in 
    (
        select idPassagemAerea from DataDeVoo where DataDeVoo.idVoo in 
        (
            select Voo.idVoo from Voo where DuracaodeVoo < 6
        )
    )
) as Abaixo;