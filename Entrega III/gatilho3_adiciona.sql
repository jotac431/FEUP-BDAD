Create Trigger CriarVoo
Before Insert on Voo
For Each Row
When not exists (select * from Rota where idRota= New.idRota)
Begin
Insert into Rota values (New.idRota, null, null);
End;