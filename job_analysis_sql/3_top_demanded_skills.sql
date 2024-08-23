/*
Question: What are the most in-demand skills for data analyst?
- join job postings to inner join table similar to query 2
- Identify the top 5 in-demand skills for a data analyst.
- Focus on all job postings.
- Why? Retrieves the top 5 skills with the highest demand in the job market,
    providing insights into the most valuable skills for job seekers.
*/

-- ========================================
-- JOIN Method.
-- ========================================

SELECT
    skills_dim.skill_id,
    skills AS skill_name,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM
    job_postings_fact
INNER JOIN 
    skills_job_dim
    ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN
    skills_dim
    ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_work_from_home = TRUE AND
    job_title_short = 'Data Analyst'
GROUP BY
    skills_dim.skill_id
ORDER BY
    demand_count DESC
LIMIT 25;

-- ========================================
-- CTE (Common Table Expressions) Method.
-- ========================================

WITH top_demanded_skills AS (
    SELECT
        skill_id,
        COUNT(*) AS demand_count
    FROM
        skills_job_dim
    INNER JOIN 
        job_postings_fact
        ON skills_job_dim.job_id = job_postings_fact.job_id
    WHERE
        job_postings_fact.job_work_from_home = TRUE AND
        job_postings_fact.job_title_short = 'Data Analyst'
    GROUP BY
        skill_id
)

SELECT
    skills_dim.skill_id,
    skills AS skill_name,
    demand_count
FROM
    top_demanded_skills
INNER JOIN
    skills_dim
    ON top_demanded_skills.skill_id = skills_dim.skill_id
ORDER BY
    demand_count DESC
LIMIT 25;

/*
Here's the breakdown of the top 25 demanded skills for data analysts
- Core Skills in Data Manipulation and Visualization: SQL (7,291 demand count), Excel (4,611), 
    and Python (4,330) are the most demanded skills, underscoring the importance of foundational 
    data manipulation and analysis capabilities. Additionally, data visualization tools like 
    Tableau (3,745) and Power BI (2,609) are in high demand, highlighting the need for strong 
    data storytelling skills.

- Emphasis on Programming and Analytical Tools: Programming languages and analytical tools like 
    R (2,142), SAS (933), and Go (815) are also highly sought after, reflecting the diverse 
    toolkit needed for complex data analysis and statistical modeling in various industries.

- Cloud and Database Technologies Gaining Traction: The demand for cloud platforms and database 
    management skills, including Azure (821), AWS (769), Snowflake (608), and SQL Server (600), 
    indicates a shift towards cloud-based data solutions and modern data warehousing, essential 
    for scalable data analytics in today’s digital environment.

RESULTS
=======
[
  {
    "skill_id": 0,
    "skill_name": "sql",
    "demand_count": "7291"
  },
  {
    "skill_id": 181,
    "skill_name": "excel",
    "demand_count": "4611"
  },
  {
    "skill_id": 1,
    "skill_name": "python",
    "demand_count": "4330"
  },
  {
    "skill_id": 182,
    "skill_name": "tableau",
    "demand_count": "3745"
  },
  {
    "skill_id": 183,
    "skill_name": "power bi",
    "demand_count": "2609"
  },
  {
    "skill_id": 5,
    "skill_name": "r",
    "demand_count": "2142"
  },
  {
    "skill_id": 186,
    "skill_name": "sas",
    "demand_count": "933"
  },
  {
    "skill_id": 7,
    "skill_name": "sas",
    "demand_count": "933"
  },
  {
    "skill_id": 185,
    "skill_name": "looker",
    "demand_count": "868"
  },
  {
    "skill_id": 74,
    "skill_name": "azure",
    "demand_count": "821"
  },
  {
    "skill_id": 196,
    "skill_name": "powerpoint",
    "demand_count": "819"
  },
  {
    "skill_id": 8,
    "skill_name": "go",
    "demand_count": "815"
  },
  {
    "skill_id": 76,
    "skill_name": "aws",
    "demand_count": "769"
  },
  {
    "skill_id": 188,
    "skill_name": "word",
    "demand_count": "720"
  },
  {
    "skill_id": 79,
    "skill_name": "oracle",
    "demand_count": "619"
  },
  {
    "skill_id": 80,
    "skill_name": "snowflake",
    "demand_count": "608"
  },
  {
    "skill_id": 61,
    "skill_name": "sql server",
    "demand_count": "600"
  },
  {
    "skill_id": 215,
    "skill_name": "flow",
    "demand_count": "500"
  },
  {
    "skill_id": 192,
    "skill_name": "sheets",
    "demand_count": "496"
  },
  {
    "skill_id": 189,
    "skill_name": "sap",
    "demand_count": "491"
  },
  {
    "skill_id": 233,
    "skill_name": "jira",
    "demand_count": "396"
  },
  {
    "skill_id": 9,
    "skill_name": "javascript",
    "demand_count": "389"
  },
  {
    "skill_id": 77,
    "skill_name": "bigquery",
    "demand_count": "374"
  },
  {
    "skill_id": 92,
    "skill_name": "spark",
    "demand_count": "361"
  },
  {
    "skill_id": 22,
    "skill_name": "vba",
    "demand_count": "333"
  }
]
*/