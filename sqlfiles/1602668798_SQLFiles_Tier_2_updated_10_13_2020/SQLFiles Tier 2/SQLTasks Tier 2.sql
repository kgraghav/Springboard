/* Welcome to the SQL mini project. You will carry out this project partly in
the PHPMyAdmin interface, and partly in Jupyter via a Python connection.

This is Tier 2 of the case study, which means that there'll be less guidance for you about how to setup
your local SQLite connection in PART 2 of the case study. This will make the case study more challenging for you: 
you might need to do some digging, aand revise the Working with Relational Databases in Python chapter in the previous resource.

Otherwise, the questions in the case study are exactly the same as with Tier 1. 

PART 1: PHPMyAdmin
You will complete questions 1-9 below in the PHPMyAdmin interface. 
Log in by pasting the following URL into your browser, and
using the following Username and Password:

URL: https://sql.springboard.com/
Username: student
Password: learn_sql@springboard

The data you need is in the "country_club" database. This database
contains 3 tables:
    i) the "Bookings" table,
    ii) the "Facilities" table, and
    iii) the "Members" table.

In this case study, you'll be asked a series of questions. You can
solve them using the platform, but for the final deliverable,
paste the code for each solution into this script, and upload it
to your GitHub.

Before starting with the questions, feel free to take your time,
exploring the data, and getting acquainted with the 3 tables. */


/* QUESTIONS 
/* Q1: Some of the facilities charge a fee to members, but some do not.
Write a SQL query to produce a list of the names of the facilities that do. */
 SQL result
Host: localhost
Database: country_club
Generation Time: Aug 03, 2024 at 09:51 PM
Generated by: phpMyAdmin 4.0.10deb1 / MySQL 5.5.43-0ubuntu0.14.04.1
SQL query: SELECT DISTINCT(name) FROM `Facilities` WHERE membercost>0 LIMIT 0, 1000 ;
Rows: 5
name	
Tennis Court 1
Tennis Court 2
Massage Room 1
Massage Room 2
Squash Court

/* Q2: How many facilities do not charge a fee to members? */
SQL result
Host: localhost
Database: country_club
Generation Time: Aug 03, 2024 at 09:50 PM
Generated by: phpMyAdmin 4.0.10deb1 / MySQL 5.5.43-0ubuntu0.14.04.1
SQL query: SELECT COUNT(DISTINCT(facid)) FROM `Facilities` WHERE membercost=0;
Rows: 1
 This table does not contain a unique column. Grid edit, checkbox, Edit, Copy and Delete features are not available.
COUNT(DISTINCT(facid))	
4

/* Q3: Write an SQL query to show a list of facilities that charge a fee to members,
where the fee is less than 20% of the facility's monthly maintenance cost.
Return the facid, facility name, member cost, and monthly maintenance of the
facilities in question. */
SELECT facid,name,membercost,monthlymaintenance
FROM 'Facilities`
WHERE membercost<0.2*monthlymaintenance
facid	name	membercost	monthlymaintenance	
0	Tennis Court 1	5.0	200
1	Tennis Court 2	5.0	200
2	Badminton Court	0.0	50
3	Table Tennis	0.0	10
4	Massage Room 1	9.9	3000
5	Massage Room 2	9.9	3000
6	Squash Court	3.5	80
7	Snooker Table	0.0	15
8	Pool Table	0.0	15

/* Q4: Write an SQL query to retrieve the details of facilities with ID 1 and 5.
Try writing the query without using the OR operator. */
SQL result
Host: localhost
Database: country_club
Generation Time: Aug 02, 2024 at 11:55 PM
Generated by: phpMyAdmin 4.0.10deb1 / MySQL 5.5.43-0ubuntu0.14.04.1
SQL query: SELECT * FROM `Facilities` WHERE facid IN (1,5) LIMIT 0, 1000 ;
Rows: 2

facid	name	membercost	guestcost	initialoutlay	monthlymaintenance	priceCategory	
1	Tennis Court 2	5.0	25.0	8000	200	expensive
5	Massage Room 2	9.9	80.0	4000	3000	expensive


/* Q5: Produce a list of facilities, with each labelled as
'cheap' or 'expensive', depending on if their monthly maintenance cost is
more than $100. Return the name and monthly maintenance of the facilities
in question. */
SQL result
Host: localhost
Database: country_club
Generation Time: Aug 02, 2024 at 11:58 PM
Generated by: phpMyAdmin 4.0.10deb1 / MySQL 5.5.43-0ubuntu0.14.04.1
SQL query: SELECT name,monthlymaintenance,priceCategory FROM `Facilities` LIMIT 0, 1000 ;
Rows: 9

name	monthlymaintenance	priceCategory	
Tennis Court 1	200	expensive
Tennis Court 2	200	expensive
Badminton Court	50	cheap
Table Tennis	10	cheap
Massage Room 1	3000	expensive
Massage Room 2	3000	expensive
Squash Court	80	cheap
Snooker Table	15	cheap
Pool Table	15	cheap


/* Q6: You'd like to get the first and last name of the last member(s)
who signed up. Try not to use the LIMIT clause for your solution. */
SQL result
Host: localhost
Database: country_club
Generation Time: Aug 03, 2024 at 12:22 AM
Generated by: phpMyAdmin 4.0.10deb1 / MySQL 5.5.43-0ubuntu0.14.04.1
SQL query: SELECT firstname, surname FROM `Members` WHERE DATE(joindate) = (SELECT MAX(DATE(joindate)) FROM Members) ;
Rows: 1
 This table does not contain a unique column. Grid edit, checkbox, Edit, Copy and Delete features are not available.
firstname	surname	
Darren	Smith

/* Q7: Produce a list of all members who have used a tennis court.
Include in your output the name of the court, and the name of the member
formatted as a single column. Ensure no duplicate data, and order by
the member name. */
SQL result
Host: localhost
Database: country_club
Generation Time: Aug 03, 2024 at 10:50 PM
Generated by: phpMyAdmin 4.0.10deb1 / MySQL 5.5.43-0ubuntu0.14.04.1
SQL query: 
    SELECT DISTINCT
    f.facid AS facid,
    f.name AS fname,
    b.memid AS memid,
    CONCAT_WS(', ',m.firstname,m.surname) AS membername
    FROM
    `Bookings` as b
    LEFT JOIN 
    `Facilities` as f
    ON f.facid=b.facid
    LEFT JOIN
    `Members` as m
    ON b.memid=m.memid
    HAVING fname LIKE '%ennis%' AND fname LIKE '%court%'
    ORDER BY membername
Rows: 46
 This table does not contain a unique column. Grid edit, checkbox, Edit, Copy and Delete features are not available.
facid	fname	memid	membername	
1 [->1]	Tennis Court 2	12 [->12]	Anne, Baker
0 [->0]	Tennis Court 1	12 [->12]	Anne, Baker
0 [->0]	Tennis Court 1	6 [->6]	Burton, Tracy
1 [->1]	Tennis Court 2	6 [->6]	Burton, Tracy
1 [->1]	Tennis Court 2	10 [->10]	Charles, Owen
0 [->0]	Tennis Court 1	10 [->10]	Charles, Owen
1 [->1]	Tennis Court 2	1 [->1]	Darren, Smith
0 [->0]	Tennis Court 1	28 [->28]	David, Farrell
1 [->1]	Tennis Court 2	28 [->28]	David, Farrell
0 [->0]	Tennis Court 1	11 [->11]	David, Jones
1 [->1]	Tennis Court 2	11 [->11]	David, Jones
0 [->0]	Tennis Court 1	17 [->17]	David, Pinker
0 [->0]	Tennis Court 1	26 [->26]	Douglas, Jones
0 [->0]	Tennis Court 1	36 [->36]	Erica, Crumpet
0 [->0]	Tennis Court 1	15 [->15]	Florence, Bader
1 [->1]	Tennis Court 2	15 [->15]	Florence, Bader
1 [->1]	Tennis Court 2	5 [->5]	Gerald, Butters
0 [->0]	Tennis Court 1	5 [->5]	Gerald, Butters
1 [->1]	Tennis Court 2	0 [->0]	GUEST, GUEST
0 [->0]	Tennis Court 1	0 [->0]	GUEST, GUEST
1 [->1]	Tennis Court 2	27 [->27]	Henrietta, Rumney
0 [->0]	Tennis Court 1	14 [->14]	Jack, Smith
1 [->1]	Tennis Court 2	14 [->14]	Jack, Smith
0 [->0]	Tennis Court 1	4 [->4]	Janice, Joplette
1 [->1]	Tennis Court 2	4 [->4]	Janice, Joplette
1 [->1]	Tennis Court 2	13 [->13]	Jemima, Farrell
0 [->0]	Tennis Court 1	13 [->13]	Jemima, Farrell
0 [->0]	Tennis Court 1	22 [->22]	Joan, Coplin
1 [->1]	Tennis Court 2	35 [->35]	John, Hunt
0 [->0]	Tennis Court 1	35 [->35]	John, Hunt
0 [->0]	Tennis Court 1	20 [->20]	Matthew, Genting
1 [->1]	Tennis Court 2	30 [->30]	Millicent, Purview
0 [->0]	Tennis Court 1	7 [->7]	Nancy, Dare
1 [->1]	Tennis Court 2	7 [->7]	Nancy, Dare
1 [->1]	Tennis Court 2	9 [->9]	Ponder, Stibbons
0 [->0]	Tennis Court 1	9 [->9]	Ponder, Stibbons
1 [->1]	Tennis Court 2	24 [->24]	Ramnaresh, Sarwin
0 [->0]	Tennis Court 1	24 [->24]	Ramnaresh, Sarwin
0 [->0]	Tennis Court 1	8 [->8]	Tim, Boothe
1 [->1]	Tennis Court 2	8 [->8]	Tim, Boothe
1 [->1]	Tennis Court 2	3 [->3]	Tim, Rownam
0 [->0]	Tennis Court 1	3 [->3]	Tim, Rownam
1 [->1]	Tennis Court 2	16 [->16]	Timothy, Baker
0 [->0]	Tennis Court 1	16 [->16]	Timothy, Baker
0 [->0]	Tennis Court 1	2 [->2]	Tracy, Smith
1 [->1]	Tennis Court 2	2 [->2]	Tracy, Smith


/* Q8: Produce a list of bookings on the day of 2012-09-14 which
will cost the member (or guest) more than $30. Remember that guests have
different costs to members (the listed costs are per half-hour 'slot'), and
the guest user's ID is always 0. Include in your output the name of the
facility, the name of the member formatted as a single column, and the cost.
Order by descending cost, and do not use any subqueries. */
SQL result
Host: localhost
Database: country_club
Generation Time: Aug 03, 2024 at 09:19 PM
Generated by: phpMyAdmin 4.0.10deb1 / MySQL 5.5.43-0ubuntu0.14.04.1
SQL query: 
SELECT 
    f.name AS fac_name, 
    DATE(b.starttime) AS date, 
    CONCAT_WS(', ',m.firstname ,m.surname) AS membername, 
    b.slots AS slot,
    CASE 
        WHEN b.memid = 0 THEN f.guestcost * b.slots 
        ELSE f.membercost * b.slots 
    END AS cost 
FROM 
    `Bookings` AS b 
LEFT JOIN 
    `Facilities` AS f ON b.facid = f.facid 
LEFT JOIN 
    `Members` AS m ON b.memid = m.memid 
WHERE 
    DATE(b.starttime) = '2012-09-14'
HAVING 
    cost > 30 
ORDER BY 
    cost DESC
LIMIT 
    0, 1000;
Rows: 12
 This table does not contain a unique column. Grid edit, checkbox, Edit, Copy and Delete features are not available.
fac_name	date	membername	slot	cost	
Massage Room 2	2012-09-14	GUEST, GUEST	4	320.0
Massage Room 1	2012-09-14	GUEST, GUEST	2	160.0
Massage Room 1	2012-09-14	GUEST, GUEST	2	160.0
Massage Room 1	2012-09-14	GUEST, GUEST	2	160.0
Tennis Court 2	2012-09-14	GUEST, GUEST	6	150.0
Tennis Court 2	2012-09-14	GUEST, GUEST	3	75.0
Tennis Court 1	2012-09-14	GUEST, GUEST	3	75.0
Tennis Court 1	2012-09-14	GUEST, GUEST	3	75.0
Squash Court	2012-09-14	GUEST, GUEST	4	70.0
Massage Room 1	2012-09-14	Jemima, Farrell	4	39.6
Squash Court	2012-09-14	GUEST, GUEST	2	35.0
Squash Court	2012-09-14	GUEST, GUEST	2	35.0

/* Q9: This time, produce the same result as in Q8, but using a subquery. */
SQL result
Host: localhost
Database: country_club
Generation Time: Aug 03, 2024 at 09:21 PM
Generated by: phpMyAdmin 4.0.10deb1 / MySQL 5.5.43-0ubuntu0.14.04.1
SQL result
Host: localhost
Database: country_club
Generation Time: Aug 03, 2024 at 10:24 PM
Generated by: phpMyAdmin 4.0.10deb1 / MySQL 5.5.43-0ubuntu0.14.04.1
SQL query: 
SELECT * FROM ( SELECT f.name AS fac_name, DATE( b.starttime ) AS date, CONCAT_WS(', ',m.firstname, m.surname) AS membername, b.slots AS slot, 
CASE WHEN b.memid =0 THEN f.guestcost * b.slots ELSE f.membercost * b.slots END AS cost 
FROM `Bookings` AS b 
LEFT JOIN `Facilities` AS f 
ON b.facid = f.facid 
LEFT JOIN `Members` AS m 
ON b.memid = m.memid HAVING cost >30 ) AS sq 
WHERE sq.date = '2012-09-14' 
ORDER BY sq.cost DESC 
Rows: 12
 This table does not contain a unique column. Grid edit, checkbox, Edit, Copy and Delete features are not available.
fac_name	date	membername	slot	cost	
Massage Room 2	2012-09-14	GUEST, GUEST	4	320.0
Massage Room 1	2012-09-14	GUEST, GUEST	2	160.0
Massage Room 1	2012-09-14	GUEST, GUEST	2	160.0
Massage Room 1	2012-09-14	GUEST, GUEST	2	160.0
Tennis Court 2	2012-09-14	GUEST, GUEST	6	150.0
Tennis Court 1	2012-09-14	GUEST, GUEST	3	75.0
Tennis Court 1	2012-09-14	GUEST, GUEST	3	75.0
Tennis Court 2	2012-09-14	GUEST, GUEST	3	75.0
Squash Court	2012-09-14	GUEST, GUEST	4	70.0
Massage Room 1	2012-09-14	Jemima, Farrell	4	39.6
Squash Court	2012-09-14	GUEST, GUEST	2	35.0
Squash Court	2012-09-14	GUEST, GUEST	2	35.0


/* PART 2: SQLite

Export the country club data from PHPMyAdmin, and connect to a local SQLite instance from Jupyter notebook 
for the following questions.  

QUESTIONS:
/* Q10: Produce a list of facilities with a total revenue less than 1000.
The output of facility name and total revenue, sorted by revenue. Remember
that there's a different cost for guests and members! */
SELECT fname,SUM(cost) as revenue
FROM
(SELECT 
f.name AS fname,
CASE WHEN b.memid=0 THEN f.guestcost ELSE f.membercost END AS cost 
FROM `Bookings` as b
LEFT JOIN
`Facilities` as f
ON b.facid=f.facid
 ) as cost_table
GROUP BY fname
HAVING SUM(cost)<1000
ORDER BY revenue DESC
<sqlite3.Cursor object at 0x0000014D95EFEE30>
('Badminton Court', 604.5)
('Pool Table', 265)
('Snooker Table', 115)
('Table Tennis', 90)

/* Q11: Produce a report of members and who recommended them in alphabetic surname,firstname order */
SELECT 
	m.surname AS surname,
	m.firstname AS firstname,
	rec.surname AS rec_surname,
	rec.firstname as rec_firstname
FROM 
	`Members` as m
LEFT JOIN
	`Members` as rec
ON m.recommendedby=rec.memid
ORDER BY surname,firstname
<sqlite3.Cursor object at 0x0000014D95EDB340>
('Bader', 'Florence', 'Stibbons', 'Ponder')
('Baker', 'Anne', 'Stibbons', 'Ponder')
('Baker', 'Timothy', 'Farrell', 'Jemima')
('Boothe', 'Tim', 'Rownam', 'Tim')
('Butters', 'Gerald', 'Smith', 'Darren')
('Coplin', 'Joan', 'Baker', 'Timothy')
('Crumpet', 'Erica', 'Smith', 'Tracy')
('Dare', 'Nancy', 'Joplette', 'Janice')
('Farrell', 'David', None, None)
('Farrell', 'Jemima', None, None)
('GUEST', 'GUEST', None, None)
('Genting', 'Matthew', 'Butters', 'Gerald')
('Hunt', 'John', 'Purview', 'Millicent')
('Jones', 'David', 'Joplette', 'Janice')
('Jones', 'Douglas', 'Jones', 'David')
('Joplette', 'Janice', 'Smith', 'Darren')
('Mackenzie', 'Anna', 'Smith', 'Darren')
('Owen', 'Charles', 'Smith', 'Darren')
('Pinker', 'David', 'Farrell', 'Jemima')
('Purview', 'Millicent', 'Smith', 'Tracy')
('Rownam', 'Tim', None, None)
('Rumney', 'Henrietta', 'Genting', 'Matthew')
('Sarwin', 'Ramnaresh', 'Bader', 'Florence')
('Smith', 'Darren', None, None)
('Smith', 'Darren', None, None)
('Smith', 'Jack', 'Smith', 'Darren')
('Smith', 'Tracy', None, None)
('Stibbons', 'Ponder', 'Tracy', 'Burton')
('Tracy', 'Burton', None, None)
('Tupperware', 'Hyacinth', None, None)
('Worthington-Smyth', 'Henry', 'Smith', 'Tracy')


/* Q12: Find the facilities with their usage by member, but not guests */
 SELECT 
	f.facid AS facid,
	f.name AS fname,
	b.memid as memid,
	SUM(b.slots) as slot
FROM
`Bookings`  as b
LEFT JOIN
`Facilities` as f
ON
b.facid=f.facid
WHERE b.memid>0
GROUP BY f.facid,name,memid
Num rows:  202

/* Q13: Find the facilities usage by month, but not guests */
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
2.6.0
2. Query all tasks
<sqlite3.Cursor object at 0x0000014D95F347A0>
(0, 'Tennis Court 1', '07', 201)
(0, 'Tennis Court 1', '08', 339)
(0, 'Tennis Court 1', '09', 417)
(1, 'Tennis Court 2', '07', 123)
(1, 'Tennis Court 2', '08', 345)
(1, 'Tennis Court 2', '09', 414)
(2, 'Badminton Court', '07', 165)
(2, 'Badminton Court', '08', 414)
(2, 'Badminton Court', '09', 507)
(3, 'Table Tennis', '07', 98)
(3, 'Table Tennis', '08', 296)
(3, 'Table Tennis', '09', 400)
(4, 'Massage Room 1', '07', 166)
(4, 'Massage Room 1', '08', 316)
(4, 'Massage Room 1', '09', 402)
(5, 'Massage Room 2', '07', 8)
(5, 'Massage Room 2', '08', 18)
(5, 'Massage Room 2', '09', 28)
(6, 'Squash Court', '07', 50)
(6, 'Squash Court', '08', 184)
(6, 'Squash Court', '09', 184)
(7, 'Snooker Table', '07', 140)
(7, 'Snooker Table', '08', 316)
(7, 'Snooker Table', '09', 404)
(8, 'Pool Table', '07', 110)
(8, 'Pool Table', '08', 303)
(8, 'Pool Table', '09', 443)
Num rows:  27