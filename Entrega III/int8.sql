.mode columns
.headers on
.nullvalue NULL

SELECT A1.idAviao, A1.Fabricante, A1.Modelo, A2.idAviao, A2.Fabricante, A2.Modelo
FROM Aviao A1 join Aviao A2 using (Fabricante)
WHERE A1.idAviao < A2.idAviao;