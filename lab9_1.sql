--ZAD1 
create table PROJEKTY (
    ID_PROJEKTU INTEGER GENERATED ALWAYS AS IDENTITY,
    OPIS_PROJEKTU VARCHAR(20),
    DATA_ROZPOCZECIA DATE DEFAULT CURRENT_DATE,
    DATA_ZAKONCZENIA DATE,
    FUNDUSZ NUMERIC(7,2)
)

--ZAD2
insert into projekty(opis_projektu, data_rozpoczecia, data_zakonczenia, fundusz)
    values('Indeksy bitmapowe', date('02-04-1999'), date('31-08-2001'), 25000)

insert into projekty(opis_projektu,  fundusz)
    values('Sieci kręgosłupowe', 19000)

--ZAD3
SELECT
    id_projektu,
    opis_projektu
from projekty


--ZAD4
--ZAKONCZYLA SIE NIEPOWODZENIEM BO INDEXY SA GENEROWANE AUTOMATYCZNIE I NIE MOZNA RECZNIE ICH ZMIENIC
insert into projekty(opis_projektu, data_rozpoczecia, data_zakonczenia, fundusz)
    values('Indeksy drzewiaste', date('24-12-2013'), date('01-01-2014'), 1200)

select * from projekty

--ZAD5
--kolumna "id_projektu" nie może być zmodyfikowana do DEFAULT
update projekty
    set id_projektu = 10
    where opis_projektu like('Indeksy drzewiaste')

--ZAD6
CREATE TABLE PROJEKTY_KOPIA
AS SELECT * FROM PROJEKTY

select * from projekty_kopia

--ZAD7
--CREATE TABLE ... AS SELECT ... FROM ... kopiuje tabele ale tylko z danymi dotyczacymi kolumn i wierszy, nie kopiuje jednak ograniczeń i kluczy domyślnych
insert into projekty_kopia(id_projektu,opis_projektu,data_rozpoczecia,data_zakonczenia,fundusz)
    values(10,'Sieci lokalne',date('12-05-2025'),date('12-05-2026'),24500)
select * from projekty_kopia

--ZAD8
delete from projekty
    where opis_projektu like('Indeksy drzewiaste')

select * from projekty
select * from projekty_kopia
--z projekty_kopia nie zostal usunięty wiersz zawierajacy 'Indeksy drzewiaste'

--ZAD9
select 
    table_name 
from information_schema.tables
where table_schema = 'sbd160276'