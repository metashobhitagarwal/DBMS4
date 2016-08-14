USE library_management_system;

/*Q1. display name of those members whose belongs to the category to which member "Jon Snow" belongs(Use SubQuery)*/
SELECT member_name FROM members WHERE category = (SELECT category FROM members WHERE member_name = 'Jon Snow');


/*Q2. display information on the books that have not been returned till date(Use Correlated SubQuery)*/
SELECT * FROM book_issue bi WHERE NOT EXISTS
(SELECT * FROM book_return br WHERE br.accession_no = bi.accession_no
AND br.member_id = bi.member_id AND br.issue_date = bi.issue_date);


/*Q3. display information on the books that have been returned after their due dates(Use Correlated SubQuery)*/
SELECT bi.issue_date, t.title_name, m.member_name, bi.due_date FROM book_issue bi
INNER JOIN members m ON m.member_id = bi.member_id
INNER JOIN books b ON b.accession_no = bi.accession_no
INNER JOIN titles t ON t.title_id = b.title_id
WHERE EXISTS (SELECT * FROM book_return br WHERE br.accession_no = bi.accession_no
AND br.member_id = bi.member_id AND br.issue_date = bi.issue_date AND DATEDIFF(br.return_date, bi.due_date) > 0);


/*Q4. display information of those books whose price is equal to the most expensive book purchase so far*/
SELECT * FROM books WHERE price = (SELECT MAX(price) FROM books);


/*Q5. display the second maximum price of a book*/
SELECT price AS second_max_price FROM books WHERE price = (SELECT MAX( price) FROM books where price <> (SELECT MAX(price) FROM books));