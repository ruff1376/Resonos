-- Active: 1751337677491@@127.0.0.1@3306@resonos

ALTER TABLE notification
MODIFY COLUMN type VARCHAR(32) NOT NULL;

select id from track;

select id from artist;

select id from album;



# track
mysql -u resonos -p123456 resonos -N -B -e "SELECT id FROM track;" > track.txt
# artist
mysql -u resonos -p123456 resonos -N -B -e "SELECT id FROM artist;" > artist.txt
# album
mysql -u resonos -p123456 resonos -N -B -e "SELECT id FROM album;" > album.txt


import pymysql

conn = pymysql.connect(host='localhost', user='resonos', password='123456', db='resonos')
for tbl, fname in [('track','track.txt'),('artist','artist.txt'),('album','album.txt')]:
    with conn.cursor() as cur, open(fname, 'w', encoding='utf8') as f:
        cur.execute(f"SELECT id FROM {tbl}")
        for (idval,) in cur.fetchall():
            f.write(str(idval) + '\n')
conn.close()




