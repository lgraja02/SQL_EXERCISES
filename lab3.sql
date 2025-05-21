--zad1
select nazwisko, 
    LEFT(etat,2)||id_prac as kod 
from pracownicy

--zad2
select nazwisko,
    translate(nazwisko, 'KLM','XXX') as WOJNA_LITER
from pracownicy;

--zad3
SELECT nazwisko
FROM pracownicy
where POSITION('L' in substr(nazwisko,1,length(nazwisko)/2))>0;

--zad4
SELECT nazwisko, ROUND((placa_pod*15/100)+placa_pod,0) as PODWYZKA
from pracownicy


--zad5
--SKIP BO NIE WIADOMO O CO CHODZI W PYTANIU

--zad6
SELECT nazwisko, zatrudniony, 
    (DATE '2000-01-01' - zatrudniony)/365 as STAZ_W_2000
from pracownicy;

--zad7
SELECT nazwisko, TO_CHAR(zatrudniony, 'FMMonth, dd, yyyy')  as DATA_ZATRUDNIENIA
from pracownicy
where id_zesp = 20;

--zad8
select TO_CHAR(CURRENT_DATE, 'FMDay') as DZIS;

--zad9
SELECT nazwa, adres,
    case 
        when adres like 'MIELZYNSKIEGO%' then 'STARE MIASTO'
        when adres like 'STRZELECKA%' then 'STARE MIASTO'
        when adres like 'PIOTROWO%' then 'NOWE MIASTO'
        when adres like 'WLODKOWICA%' then 'GRUNWALD'
    end as DZIELNICA
from zespoly;

--zad10
SELECT nazwisko, placa_pod,
    case 
        when placa_pod > 480 then ' Powyżej 480'
        when placa_pod = 480 then ' Dokładnie 480'
        when placa_pod < 480 then ' Poniżej 480'
    end as PRÓG
from pracownicy
order by placa_pod DESC;

--zad11 ????????????? NIE DZIALA TAK JAK POWINNO
SELECT nazwisko, id_zesp, 
    CASE
        WHEN id_zesp = 10 AND placa_pod >= 1070.0 THEN placa_pod
        WHEN id_zesp = 20 AND placa_pod >= 616.6 THEN placa_pod
        WHEN id_zesp = 30 AND placa_pod >= 502 THEN placa_pod
        WHEN id_zesp = 40 AND placa_pod >= 1350 THEN placa_pod
        ELSE NULL
    END AS placa_pod 
FROM pracownicy
WHERE placa_pod IS NOT NULL
ORDER BY id_zesp ASC, placa_pod ASC;

--zad12
select nazwisko, etat,
    CASE 
        when etat in ('PROFESOR', 'DYREKTOR') then (DATE '2000-01-01' - zatrudniony)/365 
    else NULL
    end as STAZ_W_2000,
    
    CASE
        when etat in ('ASYSTENT', 'ASIUNKT') then (DATE '2010-01-01'- zatrudniony)/365 
    else NULL
    end as STAZ_W_2010,

    CASE 
        when etat in ('STAZYSTA', 'SEKRETARKA') then (DATE '2020-01-01' - zatrudniony)/365 
    else NULL
    end as STAZ_W_2020
from pracownicy
order by STAZ_W_2000 ASC, STAZ_W_2010 ASC, STAZ_W_2020 ASC;
