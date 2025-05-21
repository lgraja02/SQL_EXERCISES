--ZAD1
SELECT
    nazwisko,
    etat,
    id_zesp
from pracownicy
where id_zesp = (
    SELECT
        id_zesp
    from pracownicy
    where nazwisko like ('BRZEZINSKI')
)
order by nazwisko;

--ZAD2
SELECT
    p.nazwisko,
    p.etat,
    z.nazwa
from pracownicy p inner join zespoly z
on p.id_zesp = z.id_zesp
where p.id_zesp = (
    SELECT
        id_zesp
    from pracownicy
    where nazwisko like ('BRZEZINSKI')
)
order by nazwisko;

--ZAD3
INSERT INTO pracownicy(id_prac, nazwisko, etat, zatrudniony)
VALUES ((SELECT max(id_prac) + 1 FROM pracownicy),
 'WOLNY', 'ASYSTENT', DATE '1968-07-01'); 

 SELECT
    nazwisko,
    etat,
    zatrudniony
 from pracownicy
 where zatrudniony = (
    SELECT
        min(zatrudniony)
    from pracownicy
    where etat like ('PROFESOR')
 ) and etat like('PROFESOR');

 --ZAD4
SELECT
    nazwisko,
    zatrudniony,
    id_zesp
from pracownicy
where (zatrudniony, id_zesp) in (
    SELECT
    max(zatrudniony), id_zesp
    from pracownicy
    group BY id_zesp
    having id_zesp is not null
)
order by zatrudniony;

--ZAD5
select 
    id_zesp,
    nazwa,
    adres
from zespoly
where id_zesp not in (
    SELECT
    z.id_zesp
from pracownicy p inner join zespoly z
on p.id_zesp = z.id_zesp
);
DELETE FROM pracownicy
WHERE nazwisko = 'WOLNY'; 

--ZAD6
select 
    nazwisko
from pracownicy
where etat like ('PROFESOR') and nazwisko not in (
    SELECT
    z.nazwisko 
from pracownicy p inner join pracownicy z 
on p.id_szefa = z.id_prac
where p.etat like ('STAZYSTA')
);

--ZAD7 
SELECT
    id_zesp,
    sum(placa_pod)
from pracownicy
group by id_zesp
having sum(placa_pod) >= all(
    SELECT
        sum(placa_pod)
    from pracownicy
    group by id_zesp
)
--ZAD8 
SELECT
    z.nazwa,
    sum(p.placa_pod)
from pracownicy p inner join zespoly z
on p.id_zesp = z.id_zesp
group by p.id_zesp, z.nazwa
having sum(p.placa_pod) >= all(
    SELECT
        sum(placa_pod)
    from pracownicy
    group by id_zesp
)

--ZAD9
SELECT
    z.nazwa,
    count(p.nazwisko)
from pracownicy p inner join zespoly z
on p.id_zesp = z.id_zesp
group by nazwa
having count(p.nazwisko) > (
    SELECT
        count(*)
    from pracownicy p inner join zespoly z
    on p.id_zesp = z.id_zesp
    where z.nazwa like ('ADMINISTRACJA')
);

--ZAD10
SELECT
    etat
from pracownicy 
group by etat
having count(etat) >= all (
    SELECT
        count(etat)
    from pracownicy
    group by etat
);

--ZAD11
SELECT
    etat,
    string_agg(nazwisko, ', ')
from pracownicy 
group by etat
having count(etat) >= all (
    SELECT
        count(etat)
    from pracownicy
    group by etat
);

--ZAD12
SELECT
    p.nazwisko as PRACOWNIK,
    z.nazwisko as SZEF
from pracownicy p inner join pracownicy z
on p.id_szefa=z.id_prac
where (z.placa_pod - p.placa_pod) <= all (
    SELECT
        z.placa_pod - p.placa_pod  as ROZNICA
    from pracownicy p inner join pracownicy z
    on p.id_szefa = z.id_prac
);

