--ZAD1
SELECT
    z.id_zesp,
    z.nazwa,
    z.adres
from zespoly z
where z.id_zesp not in (
    SELECT
        p.id_zesp
    from pracownicy p
    where p.id_zesp = p.id_zesp
);

--ZAD2
SELECT
    p.nazwisko,
    p.placa_pod,
    p.etat
FROM pracownicy p
WHERE p.placa_pod > (
    SELECT avg(z.placa_pod)
    FROM pracownicy z
    WHERE z.etat = p.etat
)
order by p.placa_pod desc;

--ZAD3
SELECT
    pracownik as nazwisko,
    placa_pracownika as placa_pod    
from (
    SELECT
        p.nazwisko as pracownik,
        p.placa_pod as placa_pracownika,
        z.nazwisko as szef,
        z.placa_pod as placa_szefa
    from pracownicy p inner join pracownicy z
    on p.id_szefa = z.id_prac
)
where placa_pracownika >= placa_szefa * 0.75;

--ZAD4
SELECT
    p.nazwisko
from pracownicy p 
where p.nazwisko not in (
    SELECT
        z.nazwisko
    from pracownicy x inner join pracownicy z 
    on x.id_szefa = z.id_prac
    where x.etat like ('STAZYSTA')
) and p.etat like ('PROFESOR');

--ZAD5

SELECT
    z1.nazwa,
    z1.suma_plac
FROM (
    SELECT
        z.nazwa,
        SUM(p.placa_pod) AS suma_plac
    FROM pracownicy p
    INNER JOIN zespoly z ON z.id_zesp = p.id_zesp
    GROUP BY z.nazwa
) z1
JOIN (
    SELECT
        MAX(suma_plac) AS maks_suma
    FROM (
        SELECT
            z.nazwa,
            SUM(p.placa_pod) AS suma_plac
        FROM pracownicy p
        INNER JOIN zespoly z ON z.id_zesp = p.id_zesp
        GROUP BY z.nazwa
    ) z2
) max_sumy
ON z1.suma_plac = max_sumy.maks_suma;

--ZAD6
SELECT
    p1.nazwisko, 
    p1.placa_pod
FROM pracownicy p1
WHERE (
    SELECT COUNT(*)
    FROM pracownicy p2
    WHERE p2.placa_pod > p1.placa_pod
) < 3

--ZAD7 z FROM

select 
    z1.nazwisko,
    z1.placa_pod,
    z1.placa_pod - z2.suma as ROZNICA
from pracownicy z1
join (
    SELECT
        z.id_zesp,
        z.nazwa,
        avg(p.placa_pod) as suma
    from pracownicy p inner join zespoly z
    on p.id_zesp = z.id_zesp
    GROUP BY z.nazwa, z.id_zesp
) z2
on z1.id_zesp = z2.id_zesp
order by nazwisko;

--ZAD7 z SELECT
SELECT
    x.nazwisko,
    x.placa_pod,
    (
        SELECT x.placa_pod - AVG(p.placa_pod)
        FROM pracownicy p
        WHERE p.id_zesp = x.id_zesp
    ) AS roznica
FROM pracownicy x
ORDER BY x.nazwisko;

--ZAD8 z FROM
SELECT
    nazwisko,
    placa_pod,
    roznica
from (
    select 
        z1.nazwisko,
        z1.placa_pod,
        z1.placa_pod - z2.suma as ROZNICA
    from pracownicy z1
    join (
        SELECT
            z.id_zesp,
            z.nazwa,
            avg(p.placa_pod) as suma
        from pracownicy p inner join zespoly z
        on p.id_zesp = z.id_zesp
        GROUP BY z.nazwa, z.id_zesp
    ) z2
    on z1.id_zesp = z2.id_zesp
    order by nazwisko
)
where roznica >0

--ZAD8 z SELECT
SELECT
    nazwisko,
    placa_pod,
    roznica
FROM (
    SELECT
        x.nazwisko,
        x.placa_pod,
        (
            SELECT x.placa_pod - AVG(p.placa_pod)
            FROM pracownicy p
            WHERE p.id_zesp = x.id_zesp
        ) AS roznica
    FROM pracownicy x
    ORDER BY x.nazwisko
)
where roznica > 0;


--ZAD9
SELECT
    p.nazwisko,
    (SELECT
        count(z.nazwisko)
        from pracownicy x inner join pracownicy z
        on x.id_szefa = z.id_prac
        where p.nazwisko = z.nazwisko
    group by z.nazwisko) as PODWLADNI

from pracownicy p inner join zespoly v
on p.id_zesp = v.id_zesp
where p.etat like ('PROFESOR') AND v.adres like ('PIOTROWO%')
order by PODWLADNI;

-- ZAD10
SELECT
    dane.nazwa,
    dane.srednia_w_zespole,
    dane.srednia_ogolna,
    CASE 
        WHEN dane.srednia_w_zespole = 0 THEN '???'
        WHEN dane.srednia_w_zespole > dane.srednia_ogolna THEN ':)'
        WHEN dane.srednia_w_zespole < dane.srednia_ogolna THEN ':('
    END AS nastroje
FROM (
    SELECT
        v.nazwa,
        (
            SELECT 
                AVG(COALESCE(x.placa_pod, 0))
            FROM pracownicy x
            RIGHT JOIN zespoly z ON x.id_zesp = z.id_zesp
            WHERE z.nazwa = v.nazwa
            GROUP BY z.nazwa
        ) AS srednia_w_zespole,
        (
            SELECT
                AVG(placa_pod)
            FROM pracownicy p1 
        ) AS srednia_ogolna
    FROM zespoly v
) AS dane

--ZAD11
SELECT
    e.nazwa,
    e.placa_min,
    e.placa_max
from  etaty e
group by e.nazwa
order by (
    SELECT
        count(p.etat)
    from pracownicy p
    where p.etat = e.nazwa  
    group by p.etat
) desc, e.nazwa