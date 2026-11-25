
# 𝐇𝐎𝐒𝐏𝐈𝐓𝐀𝐋 𝐎𝐏𝐄𝐑𝐀𝐓𝐈𝐎𝐍𝐒 𝐀𝐍𝐀𝐋𝐘𝐒𝐈𝐒 𝐔𝐒𝐈𝐍𝐆 𝐒𝐐𝐋

A SQL-based data analysis project focused on understanding hospital operations through relational database design and business-oriented SQL queries.

## 𝐏𝐫𝐨𝐣𝐞𝐜𝐭 𝐎𝐯𝐞𝐫𝐯𝐢𝐞𝐰

Hospitals manage multiple activities, including patient registrations, appointment bookings, doctor assignments, room management, and treatments.

This project uses MySQL to organize and analyze hospital operational data, identify appointment patterns, evaluate treatment performance, and explore potential operational issues.

The objective is to transform database records into meaningful insights that can support hospital management decisions.

## 𝐓𝐞𝐜𝐡𝐧𝐨𝐥𝐨𝐠𝐲 𝐔𝐬𝐞𝐝

- MySQL
- MySQL Workbench
- SQL

## 𝐃𝐚𝐭𝐚𝐛𝐚𝐬𝐞 𝐎𝐯𝐞𝐫𝐯𝐢𝐞𝐰

The database consists of five interconnected tables containing 7,030 records in total.

| Table | Number of Records | Description |
|---|---:|---|
| Patients | 400 | Patient demographic and registration details |
| Doctors | 80 | Doctor information and specialties |
| Appointments | 3,000 | Appointment bookings and estimated costs |
| Rooms | 50 | Room types, equipment and availability |
| Treatments | 3,500 | Treatment status, duration, waiting time and cost |

## 𝐃𝐚𝐭𝐚𝐛𝐚𝐬𝐞 𝐒𝐭𝐫𝐮𝐜𝐭𝐮𝐫𝐞

The project uses a relational database consisting of five tables:

- **Patients:** Stores patient information.
- **Doctors:** Stores doctor details and specialties.
- **Appointments:** Stores appointment booking information.
- **Rooms:** Stores room details and equipment information.
- **Treatments:** Stores treatment records and performance-related information.

Primary keys and foreign keys establish relationships between these tables.

## 𝐄𝐑 𝐃𝐢𝐚𝐠𝐫𝐚𝐦

The Entity Relationship Diagram illustrates how the five tables are connected through primary and foreign keys.

## 𝐁𝐮𝐬𝐢𝐧𝐞𝐬𝐬 𝐎𝐛𝐣𝐞𝐜𝐭𝐢𝐯𝐞𝐬

The analysis focuses on five major areas:

1. **Patient and Appointment Demand**
   - Appointment volume across different cities.
   - Most frequently requested medical services.
   - Preferred appointment time slots.
   - Booking channel analysis.

2. **Patient Appointment Behaviour**
   - Frequent and less frequent patients.
   - Cumulative estimated appointment costs.
   - Patient distribution across cities.
   - Monthly appointment trends.

3. **Treatment Performance**
   - Average treatment duration.
   - Average patient waiting time.
   - City-wise treatment distribution.
   - No-show and cancellation analysis.

4. **Doctor and Room Performance**
   - Treatment records per doctor.
   - Doctor-wise treatment duration and no-show rates.
   - Room-wise treatment completion rates.
   - Equipment distribution across room types.

5. **Treatment and Appointment Problems**
   - Cancellations, no-shows and rescheduling.
   - Repeated rescheduling patterns.
   - Waiting time across different priority levels.
   - Service types associated with appointment problems.

## 𝐒𝐐𝐋 𝐂𝐨𝐧𝐜𝐞𝐩𝐭𝐬 𝐀𝐩𝐩𝐥𝐢𝐞𝐝

- Database creation and table creation
- Primary Keys and Foreign Keys
- INNER JOIN
- GROUP BY and HAVING
- Aggregate Functions: COUNT(), SUM(), AVG()
- Conditional Logic: CASE WHEN
- Sorting using ORDER BY
- Filtering using WHERE
- DISTINCT
- LIMIT
- ROUND()
- Subqueries and calculated metrics

## 𝐊𝐞𝐲 𝐋𝐞𝐚𝐫𝐧𝐢𝐧𝐠𝐬

Through this project, I gained practical experience in:

- Designing relational databases.
- Understanding primary and foreign key relationships.
- Combining multiple tables using JOIN operations.
- Writing SQL queries to answer business questions.
- Applying aggregate functions to calculate operational metrics.
- Interpreting query results in a business context.

## 𝐅𝐮𝐭𝐮𝐫𝐞 𝐒𝐜𝐨𝐩𝐞

The project can be extended by connecting the MySQL database to Power BI to develop interactive dashboards and monitor hospital operational performance.

## 𝐏𝐫𝐨𝐣𝐞𝐜𝐭 𝐒𝐭𝐚𝐭𝐮𝐬

Completed – Database design and SQL-based analysis.

## 𝐀𝐮𝐭𝐡𝐨𝐫

[Your Name]

GitHub: [Your GitHub Profile URL]

LinkedIn: [Your LinkedIn Profile URL]
