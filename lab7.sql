--ZAD1

select

nazwisko,

placa_pod

from pracownicy

order by placa_pod desc

fetch first 3 rows only;



--ZAD2

select

nazwisko,

placa_pod

from pracownicy

order by placa_pod desc

offset 5 rows

fetch first 5 rows only;



--ZAD3

with

srednie_place as (

select

avg(placa_pod) as srednia,

id_zesp

from pracownicy

group by id_zesp

)

select

z.nazwisko,

z.placa_pod,

(z.placa_pod - s.srednia) as ROZNICA

from pracownicy z inner join srednie_place s

on z.id_zesp = s.id_zesp

where z.placa_pod - s.srednia > 0

order by nazwisko;



--ZAD4

with lata as (

select

extract(year from zatrudniony) as rok,

count(*) as liczba

from pracownicy

group by rok

)

select *

from lata

order by liczba desc;



--ZAD5

with lata as (

select

extract(year from zatrudniony) as rok,

count(*) as liczba

from pracownicy

group by rok

)

select *

from lata

where liczba = (select max(liczba) from lata); --!!przydatne na potem!!!



--ZAD6

with

asystenci as (

select

nazwisko,

id_zesp,

etat

from pracownicy

where etat like ('ASYSTENT')

),

piotrowo as (

select

nazwa,

id_zesp,

adres

from zespoly

where adres like ('PIOTROWO%')

)

select

a.nazwisko,

a.etat,

p.nazwa,

p.adres

from asystenci a inner join piotrowo p

on a.id_zesp = p.id_zesp;



--ZAD7

with

suma as (

select

id_zesp,

sum(placa_pod) as suma_plac

from pracownicy

group by id_zesp

)

select

z.nazwa,

s.suma_plac

from suma s inner join zespoly z

on z.id_zesp = s.id_zesp

where s.suma_plac = (select max(suma_plac) from suma);



--ZAD8

with recursive
podwladni (id_prac, id_szefa, nazwisko, poziom) AS
-- definicja korzenia hierarchii
(SELECT id_prac, id_szefa, nazwisko, 1
FROM pracownicy
WHERE nazwisko = 'BRZEZINSKI'
UNION ALL
-- rekurencyjna definicja niższych poziomów
SELECT p.id_prac, p.id_szefa, p.nazwisko, poziom+1
FROM podwladni s JOIN pracownicy p ON s.id_prac = p.id_szefa)
-- wskazanie sposobu przeszukiwania hierarchii i sortowania rekordów-dzieci
SEARCH DEPTH FIRST BY nazwisko SET porzadek_potomkow
SELECT nazwisko, poziom
FROM podwladni
ORDER BY porzadek_potomkow;

--ZAD9

WITH RECURSIVE podwladni (id_prac, id_szefa, nazwisko, poziom) AS (
  -- definicja korzenia
  SELECT id_prac, id_szefa, nazwisko, 1
  FROM pracownicy
  WHERE nazwisko = 'BRZEZINSKI'
  UNION ALL
  -- rekurencja
  SELECT p.id_prac, p.id_szefa, p.nazwisko, s.poziom + 1
  FROM podwladni s
  JOIN pracownicy p ON s.id_prac = p.id_szefa
)
SEARCH DEPTH FIRST BY nazwisko SET porzadek_potomkow
SELECT repeat('  ', poziom - 1) || nazwisko AS nazwisko_z_wcieciem, poziom
FROM podwladni
ORDER BY porzadek_potomkow;



--ZAD 10
with digits(digit,word) as (VALUES 
        (0,'zero'),(1,'jeden'),(2,'dwa'),
        (3,'trzy'),(4,'cztery'),(5,'pięc'),
        (6,'sześć'),(7,'siedem'),(8,'osiem'),(9,'dziewięć'))
select 
    p.nazwisko || ' zarobki w tysiacach: ' || d.word
from digits d inner join pracownicy p
on floor((p.placa_pod + coalesce(p.placa_dod,0)) / 1000) = d.digit
order by nazwisko;




