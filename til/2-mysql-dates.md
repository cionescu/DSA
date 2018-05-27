## MySQL Dates

Say you have a table where you store the month and year of each entry.

```mysql
+-------------------+--------------+------+-----+---------+----------------+
| Field             | Type         | Null | Key | Default | Extra          |
+-------------------+--------------+------+-----+---------+----------------+
| id                | int(11)      | NO   | PRI | NULL    | auto_increment |
| month             | int(11)      | NO   |     | NULL    |                |
| year              | int(11)      | NO   |     | NULL    |                |
+-------------------+--------------+------+-----+---------+----------------+
```

If you want to build a query which finds all entries prior to a date, you can concat the month, year and a day into a string and then use the `DATE` function to convert it to a date.

```
WHERE DATE(CONCAT_WS('-', year, month, 1)) < '2018-05-26'
```

*: Today I Learned - 26th of May, 2018
