/*Q1. create a view which can be used to display member name and all issue details of the member*/
CREATE VIEW displayIssueDetails
AS
SELECT m.member_name, bi.* FROM book_issue bi
INNER JOIN members m ON m.member_id = bi.member_id;


/*Q2. Create a view that contains three columns member_name, member_id and full description of categories
i.e., Faculty, Students and Others instead of F, S and O*/
CREATE VIEW memberDetails
AS
SELECT member_id, member_name, 
    (case category when 'S' then 'Students'
                   when 'F' then 'Faculty'
                   when 'O' then 'Others' END)
    FROM members;
    
    
/*Q3. Create a view which contains the information-- 
subject_name, title_name, member_name, category, issue_date, due_date and return_date.
If the books have not been returned, NULL should be returned intead of return_date*/
CREATE VIEW bookIssueDetails
AS
SELECT s.subject_name, t.title_name, m.member_name, m.category, bi.issue_date, bi.due_date, IFNULL(br.return_date, NULL) AS return_date
FROM book_issue bi LEFT JOIN members m ON m.member_id = bi.member_id
LEFT JOIN books b ON b.accession_no = bi.accession_no
LEFT JOIN titles t ON t.title_id = b.title_id
LEFT JOIN subjects s ON s.subject_id = t.subject_id
LEFT JOIN book_return br ON br.accession_no = bi.accession_no AND br.member_id = bi.member_id AND br.issue_date = bi.issue_date;