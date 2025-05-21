--ZAD1
select * 
from zespoly
ORDER BY nazwa;

--ZAD2
select * 
from pracownicy
order by id_prac;

--ZAD3
select nazwisko, (placa_pod * 12) as ROCZNA_PLACA 
from pracownicy
order by nazwisko;

--ZAD4 
select nazwisko, etat, (placa_pod+coalesce(placa_dod,0)) as miesieczne_zarobki
from pracownicy
order by miesieczne_zarobki DESC;

--ZAD5
select * 
from zespoly
order by nazwa;

--ZAD6
select DISTINCT etat
from pracownicy
order by etat;

--ZAD7
select *
from pracownicy
where etat = 'ASYSTENT'
order by nazwisko;

--ZAD8
select *
from pracownicy
where id_zesp = 30 OR id_zesp = 40
order by placa_pod DESC;

--ZAD9
select nazwisko, id_zesp, placa_pod
from pracownicy
where placa_pod BETWEEN 300 and 800
order by nazwisko;

--ZAD10
select nazwisko, etat, id_zesp
from pracownicy
where nazwisko LIKE '%SKI'
ORDER BY nazwisko

--ZAD11
select id_prac, id_szefa, nazwisko, placa_pod
from pracownicy
where placa_pod > 1000 and id_szefa is not NULL;

--ZAD12
SELECT nazwisko, id_zesp
from pracownicy
where id_zesp = 20 and (nazwisko like 'M%' or nazwisko like '%SKI')
order by nazwisko;

--ZAD13
SELECT nazwisko, etat, (placa_pod/160) as STAWKA 
from pracownicy
where etat != 'STAZYSTA' and etat != 'ADIUNKT' and etat !='ASYSTENT'and (placa_pod not between 400 and 800)
order by STAWKA;


--ZAD14
SELECT nazwisko, etat, placa_pod, placa_dod
from pracownicy 
where (placa_pod + COALESCE(placa_dod, 0))>1000
order by etat ASC, NAZWISKO ASC;

--ZAD15
SELECT (nazwisko || ' PRACUJE OD '|| zatrudniony ||' i zarabia '|| placa_pod) as PROFESOROWIE
from pracownicy
where etat = 'PROFESOR'
order by placa_pod DESC;