/*
Question: What are the top-paying data analyst jobs?
- Identify the top 10 highest paying data analyst roles that are available remotely.
- Focuses on job postings with specified salaries (remove nulls).
- Why? Highlight the top-paying opportunities for data analysts, offering insights into
    employment options and location flexibility.
*/

SELECT
    job_id,
    job_title,
    job_location,
    name AS company_name,
    salary_year_avg,
    job_posted_date
FROM
    job_postings_fact
LEFT JOIN
    company_dim
    ON job_postings_fact.company_id = company_dim.company_id
WHERE
    job_title_short = 'Data Analyst' AND
    job_location = 'Anywhere' AND
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10

/*
Here's a summary of the top 10 highest-paying data analyst positions:
- Leadership Roles Command Higher Salaries: Positions like Director of Analytics at Meta ($336,500) and 
    Associate Director- Data Insights at AT&T ($255,829.5) demonstrate that leadership and management 
    roles in data analytics significantly boost earning potential.

- Remote Work is a Major Factor: Many of these high-paying jobs, such as the Principal Data Analyst (Remote) 
    at SmartAsset ($205,000) and Data Analyst (Hybrid/Remote) at UCLA Health Careers ($217,000), offer 
    remote or hybrid options, indicating a growing preference for flexibility in work arrangements.

- Specialization Yields Higher Pay: Specialized roles, like the Data Analyst, Marketing at Pinterest ($232,423) 
    and Principal Data Analyst, AV Performance Analysis at Motional ($189,000), highlight how expertise in 
    niche areas within data analytics can lead to higher compensation.

RESULTS
=======
[
  {
    "job_id": 226942,
    "job_title": "Data Analyst",
    "job_location": "Anywhere",
    "company_name": "Mantys",
    "salary_year_avg": "650000.0",
    "job_posted_date": "2023-02-20 15:13:33"
  },
  {
    "job_id": 547382,
    "job_title": "Director of Analytics",
    "job_location": "Anywhere",
    "company_name": "Meta",
    "salary_year_avg": "336500.0",
    "job_posted_date": "2023-08-23 12:04:42"
  },
  {
    "job_id": 552322,
    "job_title": "Associate Director- Data Insights",
    "job_location": "Anywhere",
    "company_name": "AT&T",
    "salary_year_avg": "255829.5",
    "job_posted_date": "2023-06-18 16:03:12"
  },
  {
    "job_id": 99305,
    "job_title": "Data Analyst, Marketing",
    "job_location": "Anywhere",
    "company_name": "Pinterest Job Advertisements",
    "salary_year_avg": "232423.0",
    "job_posted_date": "2023-12-05 20:00:40"
  },
  {
    "job_id": 1021647,
    "job_title": "Data Analyst (Hybrid/Remote)",
    "job_location": "Anywhere",
    "company_name": "Uclahealthcareers",
    "salary_year_avg": "217000.0",
    "job_posted_date": "2023-01-17 00:17:23"
  },
  {
    "job_id": 168310,
    "job_title": "Principal Data Analyst (Remote)",
    "job_location": "Anywhere",
    "company_name": "SmartAsset",
    "salary_year_avg": "205000.0",
    "job_posted_date": "2023-08-09 11:00:01"
  },
  {
    "job_id": 731368,
    "job_title": "Director, Data Analyst - HYBRID",
    "job_location": "Anywhere",
    "company_name": "Inclusively",
    "salary_year_avg": "189309.0",
    "job_posted_date": "2023-12-07 15:00:13"
  },
  {
    "job_id": 310660,
    "job_title": "Principal Data Analyst, AV Performance Analysis",
    "job_location": "Anywhere",
    "company_name": "Motional",
    "salary_year_avg": "189000.0",
    "job_posted_date": "2023-01-05 00:00:25"
  },
  {
    "job_id": 1749593,
    "job_title": "Principal Data Analyst",
    "job_location": "Anywhere",
    "company_name": "SmartAsset",
    "salary_year_avg": "186000.0",
    "job_posted_date": "2023-07-11 16:00:05"
  },
  {
    "job_id": 387860,
    "job_title": "ERM Data Analyst",
    "job_location": "Anywhere",
    "company_name": "Get It Recruit - Information Technology",
    "salary_year_avg": "184000.0",
    "job_posted_date": "2023-06-09 08:01:04"
  }
]
*/
