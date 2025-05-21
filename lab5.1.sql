--ZAD1 
select p.nazwisko, p.etat, p.id_zesp, z.nazwa 
from pracownicy p inner join zespoly z
on p.id_zesp = z.id_zesp
order by p.nazwisko;

--ZAD2
SELECT p.nazwisko, p.etat, p.id_zesp, z.nazwa
from pracownicy p inner join zespoly z
on p.id_zesp = z.id_zesp
where z.adres like ('PIOTROWO 3A')
order by p.nazwisko;

--ZAD3
SELECT p.nazwisko, p.etat, p.placa_pod, e.placa_min, e.placa_max
from pracownicy p inner join etaty e
on e.nazwa = p.etat
order by p.etat, p.nazwisko;

--ZAD4
SELECT p.nazwisko, p.etat, p.placa_pod, e.placa_max, e.placa_max,
    CASE 
        when p.placa_pod BETWEEN e.placa_min AND placa_max then 'OK'
        else 'NO'
    end as CZY_PENSJA_OK
from pracownicy p inner join etaty e
on p.etat = e.nazwa
order by p.etat, p.nazwisko;

--ZAD5
SELECT p.nazwisko, p.etat, p.placa_pod, e.placa_max, e.placa_max
from pracownicy p inner join etaty e
on p.etat = e.nazwa
where
    p.placa_pod not BETWEEN e.placa_min and e.placa_max
order by p.etat, p.nazwisko;

--ZAD6
SELECT p.nazwisko, p.placa_pod, p.etat,
    e.nazwa as KAT_PLAC,
    e.placa_min,
    e.placa_max
from pracownicy p inner join etaty e
on p.placa_pod between e.placa_min and e.placa_max
order by p.nazwisko, e.nazwa;

--ZAD7
SELECT p.nazwisko, p.placa_pod, p.etat,
    e.nazwa as KAT_PLAC, 
    e.placa_min,
    e.placa_max
from pracownicy p inner join etaty e 
on p.placa_pod between e.placa_min and e.placa_max
where 
    e.nazwa LIKE ('SEKRETARKA')
order by p.nazwisko, e.nazwa;

--ZAD 8 
SELECT 
    p.nazwisko as PRACOWNIK,
    p.id_prac,
    z.nazwisko as SZEF,
    z.id_prac
from pracownicy p inner join pracownicy z
on p.id_szefa = z.id_prac
where p.id_szefa is not null
order by p.nazwisko;

--ZAD 9 
SELECT 
    p.nazwisko as PRACOWNIK,
    p.zatrudniony as PRAC_ZATRUDNIONY,
    z.id_prac as SZEF,
    z.zatrudniony as SZEF_ZATRUDNIONY,
    (extract(year from p.zatrudniony) - extract(year from z.zatrudniony)) as LATA
from pracownicy p inner join pracownicy z
on p.id_szefa = z.id_prac
where 
    (extract(year from p.zatrudniony) - extract(year from z.zatrudniony)) <=10
order by LATA, p.nazwisko;

--ZAD10
select
    z.nazwa,
    count(p.etat) as LICZBA,
    avg(p.placa_pod) as SREDNIA_PLACA
from pracownicy p inner join zespoly z
on p.id_zesp = z.id_zesp
group by z.nazwa
order by z.nazwa;

--ZAD11
select
    z.nazwa,
    CASE 
        when count(p.etat) <= 2 then 'mały'
        when count(p.etat) between 3 and 6 then 'średni'
        when count(p.etat) >=7 then 'duży'
    end as ETYKIETA
from pracownicy p inner join zespoly z
on p.id_zesp = z.id_zesp
group by z.nazwa
order by z.nazwa;



