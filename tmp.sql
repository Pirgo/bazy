-- Dla każdego spedytora/przewoźnika podaj wartość "opłata za
-- przesyłkę" przewożonych przez niego zamówień w latach o
-- 1996 do 1997
select ShipVia, sum(Freight) from Orders
where year(ShippedDate) >= 1996 and year(ShippedDate) <= 1997
group by ShipVia