/*
Question: What are the most optimal skills to learn (aka it's in high demand and a high-paying skills).
- Identify skills in high demand and associate with high average salaries for Data Analyst roles.
- Concentrates on remote positions with specified salaries.
- Why? Targets skills that offer job security (high demand) and financial benefits (high salaries),
    offering strategic insights for career development in data analysis.
*/

-- ========================================
-- JOIN Method.
-- ========================================

SELECT
    skills_dim.skill_id,
    skills AS skill_name,
    COUNT(skills_job_dim.job_id) AS demand_count,
    ROUND(AVG(job_postings_fact.salary_year_avg), 2) AS avg_salary
FROM
    job_postings_fact
INNER JOIN 
    skills_job_dim
    ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN
    skills_dim
    ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_work_from_home = TRUE 
    AND job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
GROUP BY
    skills_dim.skill_id
HAVING
    COUNT(skills_job_dim.job_id) > 10
ORDER BY
    avg_salary DESC,
    demand_count DESC
LIMIT 25;

-- ========================================
-- CTE (Common Table Expressions) Method.
-- ========================================

WITH skills_demand AS(
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
        job_work_from_home = TRUE 
        AND job_title_short = 'Data Analyst'
        AND salary_year_avg IS NOT NULL
    GROUP BY
        skills_dim.skill_id
),
    average_salary AS(
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
        job_work_from_home = TRUE 
        AND job_title_short = 'Data Analyst' 
        AND salary_year_avg IS NOT NULL
    GROUP BY
        skills_dim.skill_id
)

SELECT
    skills_demand.skill_id,
    skills_demand.skill_name,
    demand_count,
    avg_salary
FROM
    skills_demand
INNER JOIN
    average_salary
    ON skills_demand.skill_id = average_salary.skill_id
WHERE
    demand_count > 10
ORDER BY
    avg_salary DESC,
    demand_count DESC
LIMIT 25;

/*
Here's the breakdown of the top 25 high-paying, in-demand skills
- Cloud and Big Data Dominance: Skills like Snowflake ($112,947.97), Azure ($111,225.10), 
    AWS ($108,317.30), and BigQuery ($109,653.85) show that cloud platforms and big data 
    technologies are crucial, both in demand and compensation.

- Programming Languages Still Reign: Traditional programming languages like Go ($115,319.89), 
    Java ($106,906.44), Python ($101,397.22), and C++ ($98,958.23) remain essential, highlighting 
    their ongoing relevance in tech roles.

- Data Tools and Visualization: Tools like Tableau (with the highest demand count of 230) and 
    Looker (49) are in high demand, reflecting the importance of data visualization and business 
    intelligence in today's market.

RESULTS
=======
[
  {
    "skill_id": 8,
    "skill_name": "go",
    "demand_count": "27",
    "avg_salary": "115319.89"
  },
  {
    "skill_id": 234,
    "skill_name": "confluence",
    "demand_count": "11",
    "avg_salary": "114209.91"
  },
  {
    "skill_id": 97,
    "skill_name": "hadoop",
    "demand_count": "22",
    "avg_salary": "113192.57"
  },
  {
    "skill_id": 80,
    "skill_name": "snowflake",
    "demand_count": "37",
    "avg_salary": "112947.97"
  },
  {
    "skill_id": 74,
    "skill_name": "azure",
    "demand_count": "34",
    "avg_salary": "111225.10"
  },
  {
    "skill_id": 77,
    "skill_name": "bigquery",
    "demand_count": "13",
    "avg_salary": "109653.85"
  },
  {
    "skill_id": 76,
    "skill_name": "aws",
    "demand_count": "32",
    "avg_salary": "108317.30"
  },
  {
    "skill_id": 4,
    "skill_name": "java",
    "demand_count": "17",
    "avg_salary": "106906.44"
  },
  {
    "skill_id": 194,
    "skill_name": "ssis",
    "demand_count": "12",
    "avg_salary": "106683.33"
  },
  {
    "skill_id": 233,
    "skill_name": "jira",
    "demand_count": "20",
    "avg_salary": "104917.90"
  },
  {
    "skill_id": 79,
    "skill_name": "oracle",
    "demand_count": "37",
    "avg_salary": "104533.70"
  },
  {
    "skill_id": 185,
    "skill_name": "looker",
    "demand_count": "49",
    "avg_salary": "103795.30"
  },
  {
    "skill_id": 2,
    "skill_name": "nosql",
    "demand_count": "13",
    "avg_salary": "101413.73"
  },
  {
    "skill_id": 1,
    "skill_name": "python",
    "demand_count": "236",
    "avg_salary": "101397.22"
  },
  {
    "skill_id": 5,
    "skill_name": "r",
    "demand_count": "148",
    "avg_salary": "100498.77"
  },
  {
    "skill_id": 78,
    "skill_name": "redshift",
    "demand_count": "16",
    "avg_salary": "99936.44"
  },
  {
    "skill_id": 187,
    "skill_name": "qlik",
    "demand_count": "13",
    "avg_salary": "99630.81"
  },
  {
    "skill_id": 182,
    "skill_name": "tableau",
    "demand_count": "230",
    "avg_salary": "99287.65"
  },
  {
    "skill_id": 197,
    "skill_name": "ssrs",
    "demand_count": "14",
    "avg_salary": "99171.43"
  },
  {
    "skill_id": 92,
    "skill_name": "spark",
    "demand_count": "13",
    "avg_salary": "99076.92"
  },
  {
    "skill_id": 13,
    "skill_name": "c++",
    "demand_count": "11",
    "avg_salary": "98958.23"
  },
  {
    "skill_id": 186,
    "skill_name": "sas",
    "demand_count": "63",
    "avg_salary": "98902.37"
  },
  {
    "skill_id": 7,
    "skill_name": "sas",
    "demand_count": "63",
    "avg_salary": "98902.37"
  },
  {
    "skill_id": 61,
    "skill_name": "sql server",
    "demand_count": "35",
    "avg_salary": "97785.73"
  },
  {
    "skill_id": 9,
    "skill_name": "javascript",
    "demand_count": "20",
    "avg_salary": "97587.00"
  }
]
*/