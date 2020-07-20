use albums_db;

DESCRIBE albums;

SELECT name from albums
WHERE artist = 'Pink Floyd';

SELECT release_date from albums
WHERE name = 'Sgt. Pepper\'s Lonely Hearts Club Band';

SELECT genre from albums
WHERE name = 'Nevermind';

SELECT name from albums
WHERE release_date BETWEEN '1990' AND '1999';

SELECT name from albums
WHERE sales < 20;

SELECT name from albums
WHERE genre = 'Rock';

#Test for my theory on whether or not using like and % can give a table with more albums listed under different kinds of rock
SELECT name from albums
WHERE genre LIKE '%Rock';