--ZAD 1

insert into pracownicy (id_prac, nazwisko, etat, zatrudniony, placa_pod, id_zesp)

values (250, 'KOWALSKI', 'ASYSTENT', date('2015-01-13'), 1500, 10);



insert into pracownicy (id_prac, nazwisko, etat, zatrudniony, placa_pod, id_zesp)

values (260, 'ADAMSKI', 'ASYSTENT', date('2014-09-10'), 1500, 10);



insert into pracownicy (id_prac, nazwisko, etat, zatrudniony, placa_pod, placa_dod, id_zesp)

values (270, 'NOWAK', 'ADIUNKT', date('1990-05-01'), 2050, 540, 20);



commit


select * from pracownicy where id_prac >= 250



--ZAD 2

update pracownicy

set

placa_pod = placa_pod + (placa_pod * 0.1),

placa_dod =

case

when placa_dod is null then 100

else placa_dod * 1.20

end

where id_prac >= 250


select * from pracownicy where id_prac >= 250;



--ZAD 3



insert into zespoly values(60,'BAZY DANYCH', 'PIOTROWO 2')

select * from zespoly where id_zesp = 60

commit



--ZAD 4

select * from pracownicy



update pracownicy

set

id_zesp = (

select id_zesp

from zespoly

where nazwa = 'BAZY DANYCH')

where id_prac >= 250;



commit



--ZAD 5

update pracownicy

set

id_szefa = (

select id_prac

from pracownicy

where nazwisko like ('MORZY')

)

where id_prac >= 250;



select z.*

from pracownicy p inner join pracownicy z

on p.id_prac = z.id_szefa

where p.nazwisko like ('MORZY')





--ZAD 6

select * from zespoly;



delete from zespoly

where nazwa = 'BAZY DANYCH';



--ZAKONCZYLO SIE NIEPOWODZENIEM BO NARUSZA KLUCZ W TABELI PRACOWNICY, I

--INACZEJ MOWIAC W TABELI PRACOWNICY NIEKTORE WARTOSCI ODWOLUJA SIE DO

--WARTOSCI nazwa = 'BAZY DANYCH', PRZEZ CO USUNIECIE STAJE SIE NIE MOZLIWE.



--ZAD 7

delete from pracownicy

where id_zesp = (

select id_zesp

from zespoly

where nazwa = 'BAZY DANYCH'

);



delete from zespoly

where nazwa = 'BAZY DANYCH';



select * from zespoly;

--USUNIECIE ZAKONCZYLO SIE POWODZENIEM BO ZADNA WARTOSC Z TABELI PRACOWNICY

--NIE ODWOLUJE SIE JUZ DO 'BAZY DANYCH'.



--ZAD 8
SELECT
    p.nazwisko,
    p.placa_pod,
    0.1 * z.SREDNIA as PODWYZKA
from pracownicy p inner join 
        (SELECT
            id_zesp,
            avg(placa_pod) as SREDNIA
        from pracownicy 
        group by id_zesp) z
on p.id_zesp = z.id_zesp
order by p.nazwisko

--ZAD 9
BEGIN;

UPDATE pracownicy p
    set placa_pod = (
        select
            p.placa_pod + (0.1*SREDNIA)
        from (
            SELECT
                z.id_zesp,
                avg(z.placa_pod) as SREDNIA
            from pracownicy z
            group by z.id_zesp
        ) z
        where p.id_zesp = z.id_zesp
    )

commit;
select * from pracownicy

--ZAD10
SELECT * from pracownicy
order by placa_pod
fetch first 1 rows only;

--ZAD11 
begin;

update pracownicy
    set placa_pod = (
        select 
            round(avg(placa_pod),2)
        from pracownicy z
    )
    where id_prac = (
        select id_prac from pracownicy
        order by placa_pod
        fetch first 1 rows only
    );
select * from pracownicy;
commit;

--ZAD12
begin;

update pracownicy
    set placa_dod = (
        SELECT
            avg(coalesce(p.placa_dod,0))
        from pracownicy p inner join pracownicy z
        on p.id_szefa = z.id_prac
        where z.nazwisko like ('MORZY')
    )
    where id_zesp = 20 ;

commit;

--ZAD 13
begin;

update pracownicy 
    set placa_pod = placa_pod * 1.25
    where id_zesp = (
        select 
            p.id_zesp
        from pracownicy p inner join zespoly z 
        on p.id_zesp = z.id_zesp
        where z.nazwa like('SYSTEMY ROZPROSZONE')
        fetch first 1 row only
    );
select * from pracownicy
commit;

--ZAD14
begin;
delete from pracownicy
where id_prac in (
    select 
        p.id_prac
    from pracownicy p inner join pracownicy z 
    on p.id_szefa = z.id_prac
    where z.nazwisko like('MORZY')
) 
commit;

--ZAD15
select * from pracownicy
order by nazwisko;

--ZAD16
create sequence PRAC_SEQ
    start with 300
    increment by 10
    minvalue 300;

--ZAD17
insert into pracownicy (id_prac,nazwisko,etat,id_szefa,zatrudniony,placa_pod,placa_dod,id_zesp)
values(nextval('PRAC_SEQ'),'TRĄBCZYŃSKI','STAZYSTA',NULL,NULL,1000,NULL,NULL);

select * from pracownicy
where nazwisko like('TRĄBCZYŃSKI')

--ZAD18
BEGIN;
update pracownicy
    set placa_dod = nextval('PRAC_SEQ')
where nazwisko like('TRĄBCZYŃSKI')
select * from pracownicy
COMMIT;

--ZAD19
BEGIN;
delete from pracownicy
where nazwisko like('TRĄBCZYŃSKI')

SELECT * FROM pracownicy
COMMIT;

--ZAD20
create sequence MALA_SEQ
     START WITH 0
     MINVALUE 0
     INCREMENT BY 1
     MAXVALUE 10

SELECT NEXTVAL('MALA_SEQ');
--PO PRZEKROCZENIU 10 POJAWIA SIĘ BLAD: reached maximum value of sequence "mala_seq" (10)

--ZAD21
drop sequence MALA_SEQ;