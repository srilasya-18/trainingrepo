mysql> show databases;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| mysql              |
| performance_schema |
| sakila             |
| sys                |
| training           |
| world              |
+--------------------+
7 rows in set (0.01 sec)

mysql> use training;
Database changed
mysql> show tables
    -> ;
+--------------------+
| Tables_in_training |
+--------------------+
| events             |
| feedback           |
| registrations      |
| resources          |
| sessions           |
| users              |
+--------------------+
6 rows in set (0.00 sec)

mysql> desc users;
+-------------------+--------------+------+-----+---------+-------+
| Field             | Type         | Null | Key | Default | Extra |
+-------------------+--------------+------+-----+---------+-------+
| user_id           | int          | NO   | PRI | NULL    |       |
| full_name         | varchar(100) | NO   |     | NULL    |       |
| email             | varchar(100) | NO   | UNI | NULL    |       |
| city              | varchar(100) | NO   |     | NULL    |       |
| registration_date | date         | NO   |     | NULL    |       |
+-------------------+--------------+------+-----+---------+-------+
5 rows in set (0.01 sec)

mysql> desc events;
+--------------+------------------------------------------+------+-----+---------+----------------+
| Field        | Type                                     | Null | Key | Default | Extra          |
+--------------+------------------------------------------+------+-----+---------+----------------+
| event_id     | int                                      | NO   | PRI | NULL    | auto_increment |
| title        | varchar(200)                             | NO   |     | NULL    |                |
| description  | text                                     | YES  |     | NULL    |                |
| city         | varchar(100)                             | NO   |     | NULL    |                |
| start_date   | datetime                                 | NO   |     | NULL    |                |
| end_date     | datetime                                 | NO   |     | NULL    |                |
| status       | enum('upcoming','completed','cancelled') | YES  |     | NULL    |                |
| organizer_id | int                                      | YES  | MUL | NULL    |                |
+--------------+------------------------------------------+------+-----+---------+----------------+
8 rows in set (0.00 sec)

mysql> desc sessions;
+--------------+--------------+------+-----+---------+----------------+
| Field        | Type         | Null | Key | Default | Extra          |
+--------------+--------------+------+-----+---------+----------------+
| session_id   | int          | NO   | PRI | NULL    | auto_increment |
| event_id     | int          | YES  | MUL | NULL    |                |
| title        | varchar(200) | NO   |     | NULL    |                |
| speaker_name | varchar(100) | NO   |     | NULL    |                |
| start_time   | datetime     | NO   |     | NULL    |                |
| end_time     | datetime     | NO   |     | NULL    |                |
+--------------+--------------+------+-----+---------+----------------+
6 rows in set (0.00 sec)

mysql> desc resources;
+---------------+----------------------------+------+-----+---------+----------------+
| Field         | Type                       | Null | Key | Default | Extra          |
+---------------+----------------------------+------+-----+---------+----------------+
| resource_id   | int                        | NO   | PRI | NULL    | auto_increment |
| event_id      | int                        | YES  | MUL | NULL    |                |
| resource_type | enum('pdf','image','link') | YES  |     | NULL    |                |
| resource_url  | varchar(255)               | NO   |     | NULL    |                |
| uploaded_at   | datetime                   | NO   |     | NULL    |                |
+---------------+----------------------------+------+-----+---------+----------------+
5 rows in set (0.00 sec)

mysql> desc registrations;
+-------------------+------+------+-----+---------+----------------+
| Field             | Type | Null | Key | Default | Extra          |
+-------------------+------+------+-----+---------+----------------+
| registration_id   | int  | NO   | PRI | NULL    | auto_increment |
| user_id           | int  | YES  | MUL | NULL    |                |
| event_id          | int  | YES  | MUL | NULL    |                |
| registration_date | date | NO   |     | NULL    |                |
+-------------------+------+------+-----+---------+----------------+
4 rows in set (0.00 sec)

mysql> desc feedback;
+---------------+------+------+-----+---------+----------------+
| Field         | Type | Null | Key | Default | Extra          |
+---------------+------+------+-----+---------+----------------+
| feedback_id   | int  | NO   | PRI | NULL    | auto_increment |
| user_id       | int  | YES  | MUL | NULL    |                |
| event_id      | int  | YES  | MUL | NULL    |                |
| rating        | int  | YES  |     | NULL    |                |
| comments      | text | YES  |     | NULL    |                |
| feedback_data | date | NO   |     | NULL    |                |
+---------------+------+------+-----+---------+----------------+
6 rows in set (0.00 sec)

mysql> select * from users;
+---------+---------------+---------------------+-------------+-------------------+
| user_id | full_name     | email               | city        | registration_date |
+---------+---------------+---------------------+-------------+-------------------+
|       1 | Alice Johnson | alice@example.com   | New York    | 2024-12-01        |
|       2 | Bob Smith     | bob@example.com     | Los Angeles | 2024-12-05        |
|       3 | Charlie Lee   | charlie@example.com | Chicago     | 2024-12-10        |
|       4 | Diana King    | diana@example.com   | New York    | 2025-01-15        |
|       5 | Ethan Hunt    | ethan@example.com   | Los Angeles | 2025-02-01        |
+---------+---------------+---------------------+-------------+-------------------+
5 rows in set (0.04 sec)

mysql> select * from events;
+----------+-------------------------------+--------------------------------------+-------------+---------------------+---------------------+-----------+--------------+
| event_id | title                         | description                          | city        | start_date          | end_date            | status    | organizer_id |
+----------+-------------------------------+--------------------------------------+-------------+---------------------+---------------------+-----------+--------------+
|        1 | Tech Innovators Meetup        | A meetup for tech enthusiasts        | New York    | 2025-06-10 10:00:00 | 2025-06-10 16:00:00 | upcoming  |            1 |
|        2 | AI & ML Conference            | Conference on AI and ML advancements | Chicago     | 2025-05-15 09:00:00 | 2025-05-15 17:00:00 | completed |            3 |
|        3 | Frontend Development Bootcamp | Hands-On training on frontend tech   | Los Angeles | 2025-07-01 10:00:00 | 2025-07-03 16:00:00 | upcoming  |            2 |
+----------+-------------------------------+--------------------------------------+-------------+---------------------+---------------------+-----------+--------------+
3 rows in set (0.03 sec)

mysql> select * from sessions;
+------------+----------+-------------------+---------------+---------------------+---------------------+
| session_id | event_id | title             | speaker_name  | start_time          | end_time            |
+------------+----------+-------------------+---------------+---------------------+---------------------+
|          2 |        1 | Opening Keynote   | Dr. Tech      | 2025-06-10 10:00:00 | 2025-06-10 11:00:00 |
|          3 |        1 | Future of Web Dev | Alice Johnson | 2025-06-10 11:15:00 | 2025-06-10 12:30:00 |
|          4 |        2 | AI in Healthcare  | Charlie Lee   | 2025-05-15 09:30:00 | 2025-05-15 11:00:00 |
|          5 |        3 | Intro to HTML5    | Bob Smith     | 2025-07-01 10:00:00 | 2025-07-01 12:00:00 |
+------------+----------+-------------------+---------------+---------------------+---------------------+
4 rows in set (0.03 sec)

mysql> select * from resources;
+-------------+----------+---------------+-----------------------------------------------------+---------------------+
| resource_id | event_id | resource_type | resource_url                                        | uploaded_at         |
+-------------+----------+---------------+-----------------------------------------------------+---------------------+
|           1 |        1 | pdf           | https://portal.com/resources/tech_meetup_agenda.pdf | 2025-05-01 10:00:00 |
|           2 |        2 | image         | https://portal.com/resources/ai_poster.jpg          | 2025-04-20 09:00:00 |
|           3 |        3 | link          | https://portal.com/resources/html5_docs             | 2025-06-25 15:00:00 |
+-------------+----------+---------------+-----------------------------------------------------+---------------------+
3 rows in set (0.03 sec)

mysql> select * from registrations;
+-----------------+---------+----------+-------------------+
| registration_id | user_id | event_id | registration_date |
+-----------------+---------+----------+-------------------+
|               1 |       1 |        1 | 2025-05-01        |
|               2 |       2 |        1 | 2025-05-02        |
|               3 |       3 |        2 | 2025-04-30        |
|               4 |       4 |        2 | 2025-04-28        |
|               5 |       5 |        3 | 2025-06-15        |
+-----------------+---------+----------+-------------------+
5 rows in set (0.04 sec)

mysql> select * from feedback;
+-------------+---------+----------+--------+------------------+---------------+
| feedback_id | user_id | event_id | rating | comments         | feedback_data |
+-------------+---------+----------+--------+------------------+---------------+
|           1 |       3 |        2 |      4 | Great Insights!  | 2025-05-16    |
|           2 |       4 |        2 |      5 | Very Informative | 2025-05-16    |
|           3 |       2 |        1 |      3 | Could be better  | 2025-06-11    |
+-------------+---------+----------+--------+------------------+---------------+
3 rows in set (0.03 sec)