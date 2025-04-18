# SQL Interview Preparation
Collection of SQL solutions from various platforms with daily progress tracking.

## 📆 Daily Progress

### April 2025
| Date | Platform | Topic | Difficulty | Category | Key Concepts | Review |
|------|----------|-------|------------|-----------|-------------|---------|
| 7 | PrepVector | [Duplicate Transaction](./prepvector/sql/15_DuplicateTransaction.sql) | Medium | Window Functions | LAG, INTERVAL | [📝](./prepvector/explanation/15_DuplicateTransaction.md)
| 7 | PrepVector | [Monthly Revenue Growth](./prepvector/sql/14_MonthlyRevenueGrowth.sql) | Medium | Data Analysis | LAG, COALESCE, Revenue Calculation | [📝](./prepvector/explanation/14_MonthlyRevenueGrowth.md)
| 6 | PrepVector | [Click Through Rate by Age](./prepvector/sql/13_ClickThroughRateByAge.sql) | Medium | Data Analysis | COALESCE, NULLIF, Age Groups | [📝](./prepvector/explanation/13_ClickThroughRateByAge.md)
| 6 | PrepVector | [Consecutive Day Streak](./prepvector/sql/12_ConsecutiveDayStreak.sql) | Medium | Window Functions | LAG, Running Sum, CTE | [📝](./prepvector/explanation/12_ConsecutiveDayStreak.md)
| 3 | PrepVector | [Third Unique Song](./prepvector/sql/11_ThirdUniqueSongPlayDate.sql) | Medium | Window Functions | DENSE_RANK, CTE | [📝](./prepvector/explanation/11_ThirdUniqueSongPlayDate.md)
| 2 | InterviewMaster | [User Engagement](./interviewmaster/sql/easy/netflix/1_UserEngagementInInteractiveContent.sql) | Easy | Data Analysis | DATE, DISTINCT | [📝](./interviewmaster/explanation/easy/netflix/1_UserEngagementInInteractiveContent.md)
| 2 | PrepVector | [Likers' Likers](./prepvector/sql/10_LikersLiker.sql) | Medium | Self Joins | JOIN, COUNT DISTINCT | [📝](./prepvector/explanation/10_LikersLiker.md)
| 1 | PrepVector | [Product Sales by Month](./prepvector/sql/9_ProductSalesByMonth.sql) | Medium | Pivoting | CASE, SUM, GROUP BY | [📝](./prepvector/explanation/9_ProductSalesByMonth.md)

### March 2025
| Date | Platform | Topic | Difficulty | Category | Key Concepts |  Explanation |
|------|----------|-------|------------|----------|------------|-------------|
| 31 | PrepVector | [Sequential Project Pairs](./prepvector/sql/8_SequentialProjectPairs.sql) | Medium | Self Joins | SELF JOIN | [📝](./prepvector/explanation/8_SequentialProjectPairs.md)
| 30 | PrepVector | [Upsold Customer Count](./prepvector/sql/7_UpsoldCustomerCount.sql) | Medium | Aggregation | DISTINCT, DATE, CTE | [📝](./prepvector/explanation/7_UpsoldCustomerCount.md)
| 29 | PrepVector | [Above Avg Products](./prepvector/sql/6_AboveAvgProductPrices.sql) | Medium | Aggregation | AVG, CTE, CROSS JOIN | [📝](./prepvector/explanation/6_AboveAvgProductPrices.md)
| 28 | PrepVector | [Post Completion Rate](./prepvector/sql/5_PostCompletionRateAnalysis.sql) | Medium | Aggregation | SUM, CASE, CTEs |[📝](./prepvector/explanation/5_PostCompletionRateAnalysis.md)
| 27 | PrepVector | [Most Recent Transaction](./prepvector/sql/4_MostRecentTransaction.sql) | Medium | Window Functions | ROW_NUMBER, DATE, CTE |[📝](./prepvector/explanation/4_MostRecentTransaction.md)
| 26 | PrepVector | [Single vs Repeat Job Posters](./prepvector/sql/3_SingleVsRepeatJobPosters.sql) | Medium | Aggregation| CTEs, CASE, GROUP BY | [📝](./prepvector/explanation/3_SingleVsRepeatJobPosters.md)
| 25 | PrepVector | [Home Address Order %](./prepvector/sql/2_HomeAddressOrderPercent.sql) | Medium | Aggregation | FILTER, COUNT, JOIN |[📝](./prepvector/explanation/2_HomeAddressOrderPercent.md)
| 24 | PrepVector | [Inactive User %](./prepvector/sql/1_InactiveUsersPercentage.sql) | Easy | Joins | NOT IN, Subquery, COUNT |[📝](./prepvector/explanation/1_InactiveUsersPercentage.md)
| 23 | Ankit Bansal | [Cancellation Rate](./youtube/2_AnkitBansal/sql/7_trips_and_users.sql) | Hard | Window Functions | PARTITION BY, AVG |📝[](./youtube/2_AnkitBansal/explanation/7_trips_and_users.md) 
| 23 | Ankit Bansal | [Friends Scores](./youtube/2_AnkitBansal/sql/6_find_friends_scores.sql) | Medium | Self Joins | INNER JOIN, GROUP BY |[📝](./youtube/2_AnkitBansal/explanation/6_find_friends_scores.md)
| 23 | Ankit Bansal | [Top Products (80% Sales)](./youtube/2_AnkitBansal/sql/5_implement_pareto_principle.sql) | Hard | CTEs | ROW_NUMBER, SUM OVER |[📝](./youtube/2_AnkitBansal/explanation/5_implement_pareto_principle.md)
| 21 | Ankit Bansal | [Nth Sunday](./youtube/2_AnkitBansal/sql/4_nth_occurrence_of_sunday.sql) | Medium | Date Functions | DATEADD, DATEDIFF |[📝](./youtube/2_AnkitBansal/explanation/4_nth_occurrence_of_sunday.md)
| 20 | Ankit Bansal | [Customer Resources Used](./youtube/2_AnkitBansal/sql/3_employee_resources_used.sql) | Easy | Group By | GROUP BY, SUM |[📝](./youtube/2_AnkitBansal/explanation/3_employee_resources_used.md)
| 19 | Ankit Bansal | [New vs Repeat Customers](./youtube/2_AnkitBansal/sql/2_new_and_repeat_customers.sql) | Medium | Window Functions | LAG, LEAD, PARTITION |[📝](./youtube/2_AnkitBansal/explanation/2_new_and_repeat_customers.md)
| 19 | Ankit Bansal | [ICC World Cup Points](./youtube/2_AnkitBansal/sql/1_icc_world_cup.sql) | Medium | Case When | CASE, SUM, GROUP BY |[📝](./youtube/2_AnkitBansal/explanation/1_icc_world_cup.md)
| 19 | Rishabh Mishra | [Music Data Analysis](./rishabh-mishra/MusicAnalysis.sql) | Easy | Basic Joins | INNER JOIN, COUNT |

## 📚 Learning Resources

1. [PrepVector Challenges](https://challenges.prepvector.com/challenges/fe090a86-abf5-4e46-92b4-6fc5ce069bc3/questions)
   - Practice platform for SQL interviews

2. [SQL Interview Questions](https://www.youtube.com/playlist?list=PLBTZqjSKn0IeKBQDjLmzisazhqQy4iGkb)
   - Comprehensive video series by Ankit Bansal

3. [SQL Tutorial (Hindi)](https://www.youtube.com/playlist?list=PLdOKnrf8EcP17p05q13WXbHO5Z_JfXNpw)
   - Beginner-friendly SQL fundamentals

## 📊 Statistics
- Total Problems Solved: 24
- Platforms Covered: 4
- Topics Covered: Data Analysis, Aggregations, Window Functions, CTEs, Date Functions, Conditional Logic, Self Join, Pivoting, DENSE_RANK, Running Sum, COALESCE

## 🛠️ Tools Used
- PostgreSQL
- MySQL Workbench
- VS Code with SQL extensions

## 📝 Notes
- Solutions include detailed explanations
- Each solution is tested with sample data
- Focus on performance optimization