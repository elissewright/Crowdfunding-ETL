-- Challenge Bonus queries.
-- 1. (2.5 pts)
-- Retrieve all the number of backer_counts in descending order for each `cf_id` for the "live" campaigns. 
SELECT DISTINCT
	cf_id,
	backers_count
FROM campaign 
WHERE outcome = 'live'
ORDER BY backers_count DESC;

-- 2. (2.5 pts)
-- Using the "backers" table confirm the results in the first query.
SELECT DISTINCT 
	b.cf_id,
	c.backers_count
FROM backers AS b
JOIN campaign AS c ON c.cf_id = b.cf_id
ORDER BY c.backers_count DESC;

-- 3. (5 pts)
-- Create a table that has the first and last name, and email address of each contact.
-- and the amount left to reach the goal for all "live" projects in descending order. 
SELECT DISTINCT 
	co.first_name, co.last_name, co.email,
	(ca.goal - ca.pledged)
	AS "Remaining Goal Amount"
	INTO email_contacts_remaining_goal_amount
	FROM campaign AS ca
	INNER JOIN contacts AS co ON co.contact_id = ca.contact_id
	WHERE ca.outcome = 'live'
	ORDER BY "Remaining Goal Amount" DESC;

-- Check the table
SELECT * FROM email_contacts_remaining_goal_amount;

-- 4. (5 pts)
-- Create a table, "email_backers_remaining_goal_amount" that contains the email address of each backer in descending order, 
-- and has the first and last name of each backer, the cf_id, company name, description, 
-- end date of the campaign, and the remaining amount of the campaign goal as "Left of Goal". 
SELECT DISTINCT 
	b.email, b.first_name, b.last_name, b.cf_id, 
	c.company_name, c.description, c.end_date, 
	(c.goal - c.pledged) AS "Left of Goal"
	INTO email_backers_remaining_goal_amount
	FROM backers as b
	JOIN campaign as c ON c.cf_id = b.cf_id
	WHERE c.outcome = 'live'
	ORDER BY b.email DESC;
	
-- Check the table
SELECT * FROM email_backers_remaining_goal_amount;

