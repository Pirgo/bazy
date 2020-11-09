--Napisz polecenie select, za pomocą którego uzyskasz tytuł i numer książki
select title, title_no from title

--Napisz polecenie, które wybiera tytuł o numerze 10
select title from title where title_no = 10

/*Napisz polecenie, które wybiera numer czytelnika, isbn, numer
książki (egzemplarza) i naliczoną karę dla wierszy, dla których
naliczone kary są pomiędzy $8.00 a $9.00 */
select member_no, isbn, copy_no, fine_assessed from loanhist where fine_assessed between 8 and 9

/*Napisz polecenie select, za pomocą którego uzyskasz numer
książki (nr tyułu) i autora z tablicy title dla wszystkich książek,
których autorem jest Charles Dickens lub Jane Austen */
select title_no, author from title
where author in ('Charles Dickens', 'Jane Austen')

/*Napisz polecenie, które wybiera numer tytułu i tytuł dla
wszystkich rekordów zawierających słowo „adventures” gdzieś
w tytule. */
select title_no, title from title where title like '%adventures%'

--Napisz polecenie, które wybiera numer czytelnika, oraz zapłaconą karę
select member_no, fine_paid from loanhist

/*Napisz polecenie, które wybiera wszystkie unikalne pary miast i
stanów z tablicy adult.*/
select DISTINCT city, state from adult

/*Napisz polecenie, które wybiera wszystkie tytuły z tablicy title i
wyświetla je w porządku alfabetycznym.*/
select title from title order by title

/*Napisz polecenie, które:
§ wybiera numer członka biblioteki (member_no), isbn książki
(isbn) i watrość naliczonej kary (fine_assessed) z tablicy
loanhist dla wszystkich wypożyczeń dla których naliczono
karę (wartość nie NULL w kolumnie fine_assessed)
§ stwórz kolumnę wyliczeniową zawierającą podwojoną
wartość kolumny fine_assessed
§ stwórz alias ‘double fine’ dla tej kolumny*/
select member_no, isbn, fine_assessed, fine_assessed*2 as double_fine from loanhist where ISNULL(fine_assessed,0) > 0

/*Napisz polecenie, które
§ generuje pojedynczą kolumnę, która zawiera kolumny:
firstname (imię członka biblioteki), middleinitial (inicjał
drugiego imienia) i lastname (nazwisko) z tablicy member dla
wszystkich członków biblioteki, którzy nazywają się
Anderson
§ nazwij tak powstałą kolumnę email_name (użyj aliasu
email_name dla kolumny)*/
select firstname + ' '  + middleinitial + ' ' + lastname as email_name from member where lastname = 'Anderson'

/*zmodyfikuj polecenie, tak by zwróciło „listę proponowanych
loginów e-mail” utworzonych przez połączenie imienia
członka biblioteki, z inicjałem drugiego imienia i pierwszymi
dwoma literami nazwiska (wszystko małymi małymi literami).*/
select lower(firstname + middleinitial + substring(lastname, 1, 2)) as 'email_name' from member where lastname = 'Anderson'
select lower( REPLACE(firstname, ' ', '') + middleinitial + substring(lastname, 1, 2)) as 'email_name' from member
/*Napisz polecenie, które wybiera title i title_no z tablicy title.
§ Wynikiem powinna być pojedyncza kolumna*/
select 'The title is: ' + title + ', title number ' + cast(title_no as varchar) from title

declare @s varchar
set @s = 'abc'
PRINT @s
