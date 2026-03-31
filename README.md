# HR ANALYSIS SQL
 MySQL HR analytics case study — workforce structure, compensation analysis, and organisational insights
# HR Analytics — Workforce, Compensation & Organisational Insights
> A MySQL case study analysing workforce structure, salary patterns, and management efficiency for a multinational company.

![MySQL](https://img.shields.io/badge/MySQL-8.0-blue)
![Queries](https://img.shields.io/badge/Queries-12-green)
![Tables](https://img.shields.io/badge/Tables-7-orange)
![Status](https://img.shields.io/badge/Status-Complete-brightgreen)

## Overview
End-to-end SQL-based HR analytics on a multinational company's workforce database.
Covers data modelling, preprocessing, and 12 structured queries aligned to real business questions
around compensation, workforce distribution, and organisational efficiency.

## Files
| File | Description |
|------|-------------|
| `HR_ANALYSIS_SCRIPT23.sql` | DDL — creates all 7 tables and seeds data |
| `HR_ANALYSIS_SCRIPT_PROJECT.sql` | Data preprocessing + all 12 analysis queries |
| `HR_ANALYSIS_MODEL.mwb` | MySQL Workbench ERD model |
| `HR_Analytics_README.docx` | Full documentation — schema diagram, query explanations, key findings |

## Analytical Questions Covered
| # | Question |
|---|----------|
| Q1 | List all employees with their department and job title |
| Q2 | Top 5 highest-paid employees and their departments |
| Q3 | Average, min, and max salary per department |
| Q4 | How many direct reports does each manager have? (self-join) |
| Q5 | Employees earning below their job's minimum salary |
| Q6 | Employees hired before 1995 |
| Q7 | Employee count per global region |
| Q8 | Employees with dependents and dependent count |
| Q9 | Salary rank within each department (window function) |
| Q10 | Departments with avg salary above $8,000 (CTE) |
| Q11 | Classify employees as Entry, Mid, or Senior level |
| Q12 | Employees earning above the company-wide average |

## SQL Concepts Demonstrated
- **Joins:** INNER JOIN, LEFT JOIN, 5-table chain join, self-join
- **Aggregation:** COUNT, AVG, MIN, MAX, GROUP BY, HAVING
- **Window Functions:** RANK() OVER (PARTITION BY ... ORDER BY ...)
- **CTEs:** WITH clause for pre-aggregation
- **Subqueries:** Scalar subquery in WHERE clause
- **Conditional Logic:** CASE WHEN salary banding
- **Preprocessing:** NULL handling, TRIM, STR_TO_DATE, deduplication via ROW_NUMBER()

## How to Run
1. Open MySQL Workbench or any MySQL 8.0+ client
2. Run `HR_ANALYSIS_SCRIPT23.sql` to create the database and insert all data
3. Run the preprocessing block in `HR_ANALYSIS_SCRIPT_PROJECT.sql` to clean the data
4. Execute each analytical query section and review results
5. Open `HR_ANALYSIS_MODEL.mwb` in MySQL Workbench to view the ERD

## Database Schema
7 normalised tables: `regions` → `countries` → `locations` → `departments` → `employees` → `dependents` + `jobs`

- 107 employees · 11 departments · 4 global regions · 19 job roles · 25 countries

## Tools
MySQL 8.0 · MySQL Workbench 8.x · SQL (DDL + DML + DQL)
```

5. Scroll down → in the **Commit changes** box write:
```
   Update README with full project documentation
```
6. Click **Commit changes**

---

## Step 4 — You're Live ✅

Your repo URL will be:
```
https://github.com/YOUR-USERNAME/hr-analytics-sql
