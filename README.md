# Introduction
Explore the data job market! This project delves into data analyst roles, highlighting the highest-paying positions, sought-after skills, and where strong demand aligns with top salaries in data analytics.

SQL queries? Check them out here: [job_analysis_sql folder](/job_analysis_sql/)
# Background
Motivated by the need to better navigate the data analyst job market, this project was created to identify top-paying and highly sought-after skills, simplifying the process for others to find the best jobs.

Data originates from [SQL Course] (https://lukebarousse.com/sql), offering valuable insights into job titles, salaries, locations, and key skills.

### My SQL queries were designed to answer the following questions:

1. What are the top-paying data analyst jobs?
2. What skills are required for these top-paying jobs?
3. What skills are most in-demand for data analyst?
4. Which skills are associated with higher salaries?
5. What are the most optimal skills to learn?

# Resources I Used
To conduct a thorough analysis of the data analyst job market, I utilized several essential tools:

- **SQL:** The core of my analysis, enabling me to query the database and extract valuable insights.
- **PostgreSQL:** The selected database management system, well-suited for managing the job posting data.
- **Visual Studio Code:** My preferred tool for managing databases and running SQL queries.
- **Git & GitHub:** Crucial for version control and sharing SQL scripts and analysis, facilitating collaboration and project management.
# The Analysis
Each query in this project was designed to explore particular facets of the data analyst job market. 
Here’s my approach to each question:
### 1. Top Paying Data Analyst Jobs
To pinpoint the top-paying roles, I sorted data analyst positions based on average annual salary and location, with an emphasis on remote jobs. This approach reveals the most lucrative opportunities in the field.
```sql
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
```
Here's a summary of the top 10 highest-paying data analyst positions:
- **Leadership Roles Command Higher Salaries:** Positions like Director of Analytics at Meta ($336,500) and 
    Associate Director- Data Insights at AT&T ($255,829.5) demonstrate that leadership and management 
    roles in data analytics significantly boost earning potential.

- **Remote Work is a Major Factor:** Many of these high-paying jobs, such as the Principal Data Analyst (Remote) 
    at SmartAsset ($205,000) and Data Analyst (Hybrid/Remote) at UCLA Health Careers ($217,000), offer 
    remote or hybrid options, indicating a growing preference for flexibility in work arrangements.

- **Specialization Yields Higher Pay:** Specialized roles, like the Data Analyst, Marketing at      Pinterest ($232,423) 
    and Principal Data Analyst, AV Performance Analysis at Motional ($189,000), highlight how expertise in 
    niche areas within data analytics can lead to higher compensation.

### 2. Skills for Top Paying Jobs
To uncover the skills needed for the top-paying jobs, I combined job postings with skills data, revealing what employers seek for high-compensation roles.
```sql
WITH top_paying_jobs AS (
    SELECT
        job_id,
        job_title,
        name AS company_name,
        salary_year_avg
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
)

SELECT
    top_paying_jobs.*,
    skills
FROM
    top_paying_jobs
INNER JOIN 
    skills_job_dim 
    ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN 
    skills_dim 
    ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
    salary_year_avg DESC;
```
Here’s a summary of the most demanded skills for the top 10 highest-paying data analyst positions:
- **Core Skills in Programming and Data Tools:** High-paying data analyst roles consistently require 
    strong skills in SQL, Python, and R, along with proficiency in data visualization tools like 
    Tableau and Power BI.

- **Cloud and Big Data Proficiency:** Expertise in cloud platforms such as AWS and Azure, along with 
    big data tools like Databricks and Snowflake, is crucial for handling large-scale data 
    processing.

- **Collaboration and Communication Tools:** Top roles value familiarity with project management 
    tools like JIRA and version control systems such as GitLab, alongside strong communication 
    skills for effectively presenting data insights.

### 3. In-Demand Skills for Data Analysts
This query revealed the skills most commonly sought in job postings, highlighting the areas with the greatest demand.
```sql
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
```
Here's a summary of the top 25 most demanded skills for data analysts:
- **Core Skills in Data Manipulation and Visualization:** SQL (7,291 demand count), Excel (4,611), 
    and Python (4,330) are the most demanded skills, underscoring the importance of foundational 
    data manipulation and analysis capabilities. Additionally, data visualization tools like 
    Tableau (3,745) and Power BI (2,609) are in high demand, highlighting the need for strong 
    data storytelling skills.

- **Emphasis on Programming and Analytical Tools:** Programming languages and analytical tools like 
    R (2,142), SAS (933), and Go (815) are also highly sought after, reflecting the diverse 
    toolkit needed for complex data analysis and statistical modeling in various industries.

- **Cloud and Database Technologies Gaining Traction:** The demand for cloud platforms and database 
    management skills, including Azure (821), AWS (769), Snowflake (608), and SQL Server (600), 
    indicates a shift towards cloud-based data solutions and modern data warehousing, essential 
    for scalable data analytics in today’s digital environment.

### 4. Skills Based on Salary
Examining the average salaries for various skills showed which ones command the highest pay.
```sql
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
```
Here's a summary of the top 25 highest-paying skills for data analysts:
- **Big Data and AI/ML Skills Dominate:** High-paying roles emphasize expertise in big data tools 
    like PySpark and AI/ML platforms like Watson, reflecting the growing demand for advanced 
    data processing and machine learning capabilities.

- **Integration with DevOps and Cloud Computing:** Proficiency in DevOps tools (Bitbucket, GitLab) 
    and cloud platforms (Databricks, GCP) is highly valued, showcasing the importance of 
    automation, scalability, and cloud-based data solutions in modern analytics.

- **Strong Programming and Data Management:** Essential skills like Pandas, PostgreSQL, and Scala 
    command high salaries, highlighting the need for robust programming abilities and efficient 
    data management in data analyst roles.

### 5. Most Optimal Skills to Learn
Combining insights from demand and salary data, this query aimed to pinpoint skills that are both in high demand and have high salaries, offering a strategic focus for skill development.
```sql
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
```
Here's a summary of the top 25 high-paying and in-demand skills:
- **Cloud and Big Data Dominance:** Skills like Snowflake ($112,947.97), Azure ($111,225.10), 
    AWS ($108,317.30), and BigQuery ($109,653.85) show that cloud platforms and big data 
    technologies are crucial, both in demand and compensation.

- **Programming Languages Still Reign:** Traditional programming languages like Go ($115,319.89), 
    Java ($106,906.44), Python ($101,397.22), and C++ ($98,958.23) remain essential, highlighting 
    their ongoing relevance in tech roles.

- **Data Tools and Visualization:** Tools like Tableau (with the highest demand count of 230) and 
    Looker (49) are in high demand, reflecting the importance of data visualization and business 
    intelligence in today's market.
# Key Takeaways
Throughout this journey, I’ve enhanced my SQL skills with powerful techniques: 
- **🧩 Advanced Query Techniques:** Perfected complex SQL queries, combining tables and using WITH clauses for efficient temporary tables.
- **📊 Data Aggregation:** Mastered GROUP BY and aggregate functions like COUNT() and AVG() for summarizing data effectively. 
- **💡 Analytical Expertise:** Sharpened my ability to transform questions into actionable and insightful SQL queries.
# Conclusions
### Insights
Here are some key takeaways from the analysis:

1. **Top-Paying Data Analyst Roles:** The top-paying data analyst jobs highlight the significant earning potential in leadership roles, remote or hybrid positions, and specialized areas within data analytics, with salaries ranging from $184,000 to an impressive $650,000.
2. **Essential Skills for High Salaries:** High-paying data analyst roles, such as Associate Director of Data Insights at AT&T ($255,829.5) and Data Analyst, Marketing at Pinterest ($232,423), require proficiency in a wide range of technical skills, with SQL, Python, and Tableau being consistently in demand across top positions.
3. **Most Sought-After Skills:** SQL leads with 7,291 job postings, significantly outpacing other skills like Excel (4,611) and Python (4,330), underscoring its critical importance in the data analytics field.
4. **High-Earning Skills:** High-paying skills like PySpark ($208,172) and Bitbucket ($189,154) emphasize the value of proficiency in specialized tools and platforms. Skills related to data processing (PySpark), version control (Bitbucket, GitLab), and cloud technologies (GCP) consistently offer top salaries, highlighting the importance of mastering these technical proficiencies for maximizing earning potential in data analytics.
5. **Optimal Skills for Market Value:** Skills like Go, Confluence, and Hadoop stand out for their strong demand and high average salaries, with Go leading at $115,319.89.

### Final Reflections

This project significantly improved my SQL abilities and offered valuable insights into the data analyst job market. The analysis results act as a roadmap for prioritizing skill development and job search strategies. Aspiring data analysts can enhance their position in a competitive job market by concentrating on high-demand, high-salary skills. This exploration underscores the importance of ongoing learning and adapting to new trends in the data analytics field.
