import sqlite3
from sqlite3 import Error

 
def create_connection(db_file):
    """ create a database connection to the SQLite database
        specified by the db_file
    :param db_file: database file
    :return: Connection object or None
    """
    conn = None
    try:
        conn = sqlite3.connect(db_file)
        print(sqlite3.version)
    except Error as e:
        print(e)
 
    return conn

 
def select_all_tasks(conn):
    """
    Query all rows in the tasks table
    :param conn: the Connection object
    :return:
    """
    cur = conn.cursor()
    print(cur)
    query1 = """
     SELECT 
	f.facid AS facid,
	f.name AS fname,
	strftime('%m', starttime) AS month,
	SUM(b.slots) as slot
FROM
`Bookings`  as b
LEFT JOIN
`Facilities` as f
ON
b.facid=f.facid
WHERE b.memid>0
GROUP BY f.facid,fname,month
        """
    cur.execute(query1)
 
    rows = cur.fetchall()
    for row in rows:
        print(row)
    print('Num rows: ',len(rows))


def main():
    database = "sqlite_db_pythonsqlite.db"
 
    # create a database connection
    conn = create_connection(database)
    with conn: 
        print("2. Query all tasks")
        select_all_tasks(conn)
 
 
if __name__ == '__main__':
    main()