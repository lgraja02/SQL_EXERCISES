--ZAD1
SELECT 
    min(placa_pod) as MINIMUN,
    max(placa_pod) as MAKSIMUM,
    max(placa_pod) - min(placa_pod) as ROZNICA
from pracownicy;

--ZAD2
SELECT
    etat,
    avg(placa_pod) as SREDNIA
from pracownicy
group by etat
order by SREDNIA DESC;

--ZAD3
SELECT
    COUNT(etat) as PROFESOROWIE
FROM pracownicy
where etat = 'PROFESOR';

--ZAD4
SELECT
    id_zesp,
    sum(placa_pod+coalesce(placa_dod,0)) as SUMARYCZNE_PLACE
FROM pracownicy
group by id_zesp
order by id_zesp asc;

--ZAD5
SELECT
    MAX(SUM_PLACA_POD) as MAKS_SUM_PLACA
from(
    select
        id_zesp,
        sum(placa_pod + coalesce(placa_dod,0)) as SUM_PLACA_POD
    from pracownicy
    group by id_zesp
);


--ZAD6
SELECT
    id_szefa,
    min(placa_pod) as MINIMALNA
from pracownicy
where id_szefa is not null
group by id_szefa;

--ZAD7
SELECT
    id_zesp,
    count(id_zesp) as ILU_PRACUJE
from pracownicy
group by id_zesp
order by ILU_PRACUJE desc;

--ZAD8
SELECT
    id_zesp,
    count(id_zesp) as ILU_PRACUJE
from pracownicy
group by id_zesp
having count(id_zesp) > 3
order by ILU_PRACUJE DESC;

--ZAD9
select 
    count(id_prac) as ZDUBLOWANE
from pracownicy
group by id_prac
having count(id_prac)>1;

--ZAD10
SELECT
    etat,
    avg(placa_pod) as ŚREDNIA,
    count(etat) as LICZBA
from (
    SELECT
    etat,
    placa_pod,
    zatrudniony
from pracownicy
where 
    zatrudniony <= date '1990-01-01'
)
group by etat;

--ZAD11
SELECT
    id_zesp,
    etat,
    round(avg(placa_pod+coalesce(placa_dod,0)),0) as SREDNIA,
    round(max(placa_pod+coalesce(placa_dod,0)),0) as MAKSYMALNA
from (
    SELECT *
from pracownicy
where 
    etat in ('PROFESOR','ASYSTENT')
)
group by id_zesp, etat;


--ZAD12
SELECT
    extract(year from zatrudniony) as ROK,
    COUNT(extract(year from zatrudniony)) as ILU_PRACOWNIKÓW
FROM pracownicy
group by ROK
order by ROK ASC;

--ZAD13
SELECT
    length(nazwisko) as ILE_LITER,
    count(length(nazwisko)) as W_ILU_NAZWISKACH
from pracownicy
group by ILE_LITER
order by ILE_LITER asc;


--ZAD14
SELECT
    SUM(case
        when lower(nazwisko) like '%a%' then 1
        else 0
    end) as ILE_NAZWISK_Z_A 
from pracownicy;

--ZAD15B-BEZ-FILTER
SELECT
    SUM(
        case
            when lower(nazwisko) like '%a%' then 1
            else 0
        end
        ) as ILE_NAZWISK_Z_A,
    SUM(
        case
            when lower(nazwisko) like '%e%' then 1
            else 0
        end
        ) as  ILE_NAZWISK_Z_E
from pracownicy;

--ZAD15A-Z-FILTER
SELECT
    count(nazwisko) filter (where lower(nazwisko) like '%a%') as ILE_NAZWISK_Z_A,
    count(nazwisko) filter (where lower(nazwisko) like '%e%') as ILE_NAZWISK_Z_E
from pracownicy;

--ZAD16
select
    id_zesp as ZESPOL,
    count(etat) filter (where etat like 'PROFESOR') as L_PROFESOROW,
    count(etat) filter (where etat like 'ADIUNKT') as L_ADIUNKTOW,
    count(etat) filter (where etat like 'ASYSTENT') as L_ASYSTENTOW,
    count(etat) filter (where etat in ('DYREKTOR','STAZYSTA','SEKRETARKA')) as L_POZOSTALYCH,
    count(etat) as WSZYSCY
from pracownicy
group by id_zesp
order by zespol asc;

--ZAD17
SELECT
    id_zesp,
    sum(placa_pod) as SUMA_PLAC,
    string_agg(nazwisko || ':' || placa_pod, ',') as PRACOWNICY
from pracownicy
group by id_zesp
order by id_zesp;