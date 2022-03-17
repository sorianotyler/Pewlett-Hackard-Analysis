SELECT e.emp_no,
	e.first_name,
	e.last_name,
	t.title,
    t.from_date,
    t.to_date
INTO ret_emp_titles
FROM employees AS e
INNER JOIN titles AS t
ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no, e.emp_no DESC;


-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (e.emp_no)  e.emp_no,
	e.first_name,
	e.last_name,
	t.title,
    t.from_date,
    t.to_date
INTO clean_ret_emp_titles
FROM employees AS e
INNER JOIN titles AS t
ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND t.to_date = '9999-01-01'
ORDER BY e.emp_no, e.emp_no DESC;


SELECT COUNT(cre.emp_no), cre.title
INTO retiring_titles
FROM clean_ret_emp_titles as cre
GROUP BY cre.title
ORDER BY COUNT(cre.emp_no) DESC

SELECT DISTINCT ON (e.emp_no)  e.emp_no,
	e.first_name,
	e.last_name,
	t.title,
    de.from_date,
    de.to_date
INTO mentorship_eligibility_table
FROM employees AS e
INNER JOIN titles AS t
ON (e.emp_no = t.emp_no)
INNER JOIN dept_emp AS de
on (e.emp_no = de.emp_no)
WHERE (de.to_date = '9999-01-01')
AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')