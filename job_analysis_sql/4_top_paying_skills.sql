/*
Question: What are the top skills based on salary?
- Look at the average salary associated with each skill for Data Analyst position.
- Focuses on roles with specified salaries regardless of location.
- Why? It reveals how different skills impact salary levels for Data Analysts and helps identify
    the most financially rewarding skills to acquire or improve.
*/

SELECT
    skills_dim.skill_id,
    skills AS skill_name,
    ROUND(AVG(salary_year_avg), 2) AS avg_salary
FROM
    job_postings_fact
INNER JOIN 
    skills_job_dim
    ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN
    skills_dim
    ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' 
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = TRUE
GROUP BY
    skills_dim.skill_id
ORDER BY
    avg_salary DESC
LIMIT 25;

/*
Here's the breakdown of the top 25 paying skills for data analysts
- Big Data and AI/ML Skills Dominate: High-paying roles emphasize expertise in big data tools 
    like PySpark and AI/ML platforms like Watson, reflecting the growing demand for advanced 
    data processing and machine learning capabilities.

- Integration with DevOps and Cloud Computing: Proficiency in DevOps tools (Bitbucket, GitLab) 
    and cloud platforms (Databricks, GCP) is highly valued, showcasing the importance of 
    automation, scalability, and cloud-based data solutions in modern analytics.

- Strong Programming and Data Management: Essential skills like Pandas, PostgreSQL, and Scala 
    command high salaries, highlighting the need for robust programming abilities and efficient 
    data management in data analyst roles.

RESULTS
=======
[
  {
    "skill_id": 95,
    "skill_name": "pyspark",
    "avg_salary": "208172.25"
  },
  {
    "skill_id": 218,
    "skill_name": "bitbucket",
    "avg_salary": "189154.50"
  },
  {
    "skill_id": 85,
    "skill_name": "watson",
    "avg_salary": "160515.00"
  },
  {
    "skill_id": 65,
    "skill_name": "couchbase",
    "avg_salary": "160515.00"
  },
  {
    "skill_id": 206,
    "skill_name": "datarobot",
    "avg_salary": "155485.50"
  },
  {
    "skill_id": 220,
    "skill_name": "gitlab",
    "avg_salary": "154500.00"
  },
  {
    "skill_id": 35,
    "skill_name": "swift",
    "avg_salary": "153750.00"
  },
  {
    "skill_id": 102,
    "skill_name": "jupyter",
    "avg_salary": "152776.50"
  },
  {
    "skill_id": 93,
    "skill_name": "pandas",
    "avg_salary": "151821.33"
  },
  {
    "skill_id": 59,
    "skill_name": "elasticsearch",
    "avg_salary": "145000.00"
  },
  {
    "skill_id": 27,
    "skill_name": "golang",
    "avg_salary": "145000.00"
  },
  {
    "skill_id": 94,
    "skill_name": "numpy",
    "avg_salary": "143512.50"
  },
  {
    "skill_id": 75,
    "skill_name": "databricks",
    "avg_salary": "141906.60"
  },
  {
    "skill_id": 169,
    "skill_name": "linux",
    "avg_salary": "136507.50"
  },
  {
    "skill_id": 213,
    "skill_name": "kubernetes",
    "avg_salary": "132500.00"
  },
  {
    "skill_id": 219,
    "skill_name": "atlassian",
    "avg_salary": "131161.80"
  },
  {
    "skill_id": 250,
    "skill_name": "twilio",
    "avg_salary": "127000.00"
  },
  {
    "skill_id": 96,
    "skill_name": "airflow",
    "avg_salary": "126103.00"
  },
  {
    "skill_id": 106,
    "skill_name": "scikit-learn",
    "avg_salary": "125781.25"
  },
  {
    "skill_id": 211,
    "skill_name": "jenkins",
    "avg_salary": "125436.33"
  },
  {
    "skill_id": 238,
    "skill_name": "notion",
    "avg_salary": "125000.00"
  },
  {
    "skill_id": 3,
    "skill_name": "scala",
    "avg_salary": "124903.00"
  },
  {
    "skill_id": 57,
    "skill_name": "postgresql",
    "avg_salary": "123878.75"
  },
  {
    "skill_id": 81,
    "skill_name": "gcp",
    "avg_salary": "122500.00"
  },
  {
    "skill_id": 191,
    "skill_name": "microstrategy",
    "avg_salary": "121619.25"
  }
]
*/