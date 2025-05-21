--ZAD1
INSERT INTO pracownicy(id_prac, nazwisko)
VALUES ((SELECT max(id_prac) + 1 FROM pracownicy), 'WOLNY'); 

select 
    p.nazwisko,
    p.id_zesp,
    z.nazwa
from pracownicy p left outer join zespoly z 
on p.id_zesp = z.id_zesp
order by p.nazwisko;

--ZAD2
SELECT
    z.nazwa,
    z.id_zesp,
    CASE 
        WHEN p.nazwisko is not null THEN p.nazwisko  
        ELSE 'brak pracowników'
    END as PRACOWNIK
from zespoly z left outer join pracownicy p
on z.id_zesp = p.id_zesp
order by z.nazwa, p.nazwisko 

--ZAD3
SELECT
    case 
        when z.nazwa is not null then z.nazwa
        else 'brak zespolu'
    end as ZESPOL,
    case 
        when p.nazwisko is not null then p.nazwisko
        else 'brak pracowników'
    end as PRACOWNIK
from zespoly z full outer join pracownicy p
on z.id_zesp = p.id_zesp
order by z.nazwa, p.nazwisko;

DELETE FROM pracownicy
WHERE nazwisko = 'WOLNY'; 

--ZAD4
SELECT
    z.nazwa as ZESPOL,
    count(p.id_zesp) as LICZBA,
    sum(p.placa_pod) as SUMA_PLAC
from zespoly z left outer join pracownicy p 
on z.id_zesp = p.id_zesp
group by z.nazwa
order by z.nazwa;

--ZAD5
SELECT
    z.nazwa as NAZWA 
from zespoly z left outer join pracownicy p 
on z.id_zesp = p.id_zesp
group by z.nazwa
having count(p.id_zesp) = 0

--ZAD6
SELECT
    p.nazwisko as PRACOWNIK,
    p.id_prac as ID_PRAC,
    z.nazwisko as SZEF,
    z.id_prac as ID_SZEFA
from pracownicy p left outer join pracownicy z
on p.id_szefa = z.id_prac
order by p.nazwisko;

--ZAD7
SELECT
    p.nazwisko as PRACOWNIK,
    count(z.id_prac) as LICZBA_PODDANYCH
from pracownicy p left outer join pracownicy z 
on p.id_prac = z.id_szefa
group by p.nazwisko
order by p.nazwisko;

--ZAD8
SELECT
    p.nazwisko,
    p.etat,
    p.placa_pod,
    z.nazwa,
    x.nazwisko
from pracownicy p left outer join pracownicy x 
on p.id_szefa = x.id_prac
left outer join zespoly z
on p.id_zesp = z.id_zesp
order by p.nazwisko; 
 
 --ZAD9
 SELECT
    p.nazwisko,
    z.nazwa
 from pracownicy p cross join zespoly z 
 order by p.nazwisko, z.nazwa;

--ZAD10
SELECT
    count(*) as "COUNT(*)"
from etaty e cross join pracownicy p cross join zespoly z

--ZAD11
SELECT
    etat
from pracownicy
where (extract(year from zatrudniony) ='1993')
INTERSECT
select
    etat
from pracownicy
where (extract(year from zatrudniony) = '1992');

--ZAD12
SELECT
    id_zesp
from zespoly
except 
SELECT
    p.id_zesp
from pracownicy p inner join zespoly z
on p.id_zesp = z.id_zesp;

--ZAD13
SELECT
    id_zesp, nazwa
from zespoly
except 
SELECT
    p.id_zesp, z.nazwa
from pracownicy p inner join zespoly z
on p.id_zesp = z.id_zesp;

--ZAD14
SELECT
    nazwisko, placa_pod,
    'PONIŻEJ 480 ZŁOTYCH' AS PRÓG
FROM pracownicy
where placa_pod < 480

    UNION

SELECT
    nazwisko, placa_pod,
    'DOKLADNIE 480 ZŁOTYCH' AS PRÓG
FROM pracownicy
where placa_pod = 480

    UNION   

SELECT
    nazwisko, placa_pod,
    'POWYZEJ 480 ZŁOTYCH' AS PRÓG
FROM pracownicy
where placa_pod > 480
order by placa_pod;