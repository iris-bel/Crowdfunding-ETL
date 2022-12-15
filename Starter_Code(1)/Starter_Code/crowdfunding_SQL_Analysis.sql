-- Challenge Bonus queries.
-- 1. (2.5 pts)
-- Retrieve all the number of backer_counts in descending order for each `cf_id` for the "live" campaigns. 

SELECT SUM (camp.backers_count), camp.cf_id
FROM campaign as camp
WHERE (camp.outcome = 'live')
GROUP BY camp.cf_id
ORDER BY camp.backers_count DESC;

-- 2. (2.5 pts)
-- Using the "backers" table confirm the results in the first query.

SELECT COUNT (bc.backer_id) as backer_count, bc.cf_id
FROM backers_cleaned as bc
GROUP BY bc.cf_id
ORDER BY backer_count DESC;

-- 3. (5 pts)
-- Create a table that has the first and last name, and email address of each contact.
-- and the amount left to reach the goal for all "live" projects in descending order. 

SELECT * INTO email_contacts_remaining_goal_amount FROM (
	SELECT DISTINCT ON (bc.cf_id)
		bc.first_name,
		bc.last_name,
		bc.email,
		(camp.goal - camp.pledged) as Remaining_Goal_Amount
	FROM backers_cleaned as bc
		INNER JOIN campaign as camp
			ON (bc.cf_id = camp.cf_id)) p
ORDER BY Remaining_Goal_Amount DESC;

--OR

--CREATE TABLE "email_contacts_remaining_goal_amount"(
--	"first_name" varchar(50)   NOT NULL,
--    "last_name" varchar(50)   NOT NULL,
--    "email" varchar(100)   NOT NULL,
--	"Remaining Goal Amount" int NOT NULL
--);

--INSERT INTO email_contacts_remaining_goal_amount(
--	SELECT * FROM (
--	SELECT DISTINCT ON (bc.cf_id)
--		bc.first_name,
--		bc.last_name,
--		bc.email,
--		(camp.goal - camp.pledged) as Remaining_Goal_Amount
--	FROM backers_cleaned as bc
--		INNER JOIN campaign as camp
--			ON (bc.cf_id = camp.cf_id)) as query1
--ORDER BY query1.Remaining_Goal_Amount DESC);

-- Check the table

SELECT * FROM email_contacts_remaining_goal_amount

-- 4. (5 pts)
-- Create a table, "email_backers_remaining_goal_amount" that contains the email address of each backer in descending order, 
-- and has the first and last name of each backer, the cf_id, company name, description, 
-- end date of the campaign, and the remaining amount of the campaign goal as "Left of Goal". 

SELECT bc.email,
	bc.first_name,
	bc.last_name,
	bc.cf_id,
	camp.company_name,
	camp.description,
	camp.end_date,
	(camp.goal - camp.pledged) as Left_of_Goal
INTO email_backers_remaining_goal_amount
FROM backers_cleaned as bc
	INNER JOIN campaign as camp
		ON (bc.cf_id = camp.cf_id)
ORDER BY bc.last_name ASC, bc.email DESC;

-- Check the table

SELECT * FROM email_backers_remaining_goal_amount
