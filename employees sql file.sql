create database amazon;
use amazon;
select * from amazon.employee limit 50000;
select employee_id,name,email,count(*) from amazon.employee
group by employee_id,name,email
having count(*)>1;
create table amazon.employees
select * from
(
select *,
row_number()over(partition by employee_id,name,email order by
hire_date) as rn
from amazon.employee
)t
where rn=1;
select employee_id,name,email,count(*) from amazon.employees
group by employee_id,name,email
having count(*)>1;
select * from amazon.employees
where employee_id=''
or name=''
or department=''
or email=''
or city=''
or salary=''
or hire_date='' limit 20000
;
select count(*) as total_rows,
sum(case when employee_id='' then 1 else 0 end) as employee_blanks,
sum(case when name='' then 1 else 0 end) as name_blanks,
sum(case when department=''then 1 else 0 end) as department_blanks,
sum(case when email='' then 1 else 0 end) as email_blanks,
sum(case when city=''then 1 else 0 end) as city_blanks,
sum(case when salary=''  then 1 else 0 end) as salary_blanks,
sum(case when hire_date='' then 1 else 0 end) as date_blanks
from amazon.employees;
set sql_safe_updates =0;
update amazon.employees
set employee_id=null
where employee_id='';
update amazon.employees
set name=null
where name='';
update amazon.employees
set department=null
where department='';
update amazon.employees
set email=null
where email='';
update amazon.employees
set city=null
where city='';
update amazon.employees
set salary=null
where salary='';
update amazon.employees
set hire_date=null
where hire_date='';

select count(*) as total_rows,
sum(case when employee_id is null then 1 else 0 end) as employee_null,
sum(case when name is null then 1 else 0 end) as name_null,
sum(case when department is null then 1 else 0 end) as department_null,
sum(case when email is null then 1 else 0 end) as email_null,
sum(case when city is null then 1 else 0 end) as city_null,
sum(case when salary is null  then 1 else 0 end) as salary_null,
sum(case when hire_date is null then 1 else 0 end) as date_null
from amazon.employees;
select * from amazon.employees
where employee_id<0;
update amazon.employees
set name=upper(trim(name));
update amazon.employees
set department=concat(
upper(left(trim(department),1)),
lower(substring(trim(department),2))
);
update amazon.employees
set department=case
when department='Hr' then 'HR'
when department='It' then 'IT'
else department
end;
select * from amazon.employees
where email regexp '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$'limit 20000;
select * from amazon.employees
where email  not regexp '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$'limit 20000;
select * from amazon.employees
where email is null limit 20000;
update amazon.employees
set city=concat(
upper(left(trim(city),1)),
lower(substring(trim(city),2))
);

select * from amazon.employees;
select * from amazon.employees
where salary is null;
select * from amazon.employees
where salary=0;
select * from employees
where salary<0 limit 20000;
update amazon.employees a
join
(
select avg(salary) as median_salary from amazon.employees
where salary>0
)t
set a.salary=t.median_salary
where salary<0 ;
update amazon.employees
set salary=round(salary);
select * from amazon.employees;

select
case
when hire_date regexp '^[0-9]{4}-[0-9]{2}-[0-9]{2}$'
then "YYYY-MM-DD"
when hire_date regexp '^[0-9]{2}-[0-9]{2}-[0-9]{4}$'
then "DD-MM-YYYY"
when hire_date regexp '^[0-9]{2}/[0-9]{2}/[0-9]{4}$'
then "DD/MM/YYYY"
else 'others'
end as date_formatting,
count(*)  as rows_count
 from amazon.employees
 group by date_formatting;
 
 select distinct * from amazon.employees
 where hire_date regexp '^[0-9]{4}-[0-9]{2}-[0-9]{2}$'
 and hire_date regexp '^[0-9]{2}-[0-9]{2}-[0-9]{4}$'
 and hire_date regexp '^[0-9]{2}/[0-9]{2}/[0-9]{4}$'
 and hire_date is not null;
 alter table amazon.employees
 add column hire_date1 date;
 update amazon.employees
 set hire_date1=case
 when hire_date regexp '^[0-9]{4}-[0-9]{2}-[0-9]{2}$'
 then str_to_date(hire_date,'%Y-%m-%d')
 when hire_date regexp '^[0-9]{2}-[0-9]{2}-[0-9]{4}$'
 and substring(hire_date,1,2)>'12'
 then str_to_date(hire_date,'%d-%m-%Y')
 when hire_date regexp '^[0-9]{4}-[0-9]{2}-[0-9]{2}$'
 and substring(hire_date,1,2)<='12'
 then str_to_date(hire_date,'%m-%d-%Y')
 when hire_date regexp '^[0-9]{2}/[0-9]{2}/[0-9]{4}$'
 then str_to_date(hire_date,'%d/%m/%Y')
 else null
 end;
 select
case
when hire_date1 regexp '^[0-9]{4}-[0-9]{2}-[0-9]{2}$'
then "YYYY-MM-DD"
when hire_date1 regexp '^[0-9]{2}-[0-9]{2}-[0-9]{4}$'
then "DD-MM-YYYY"
when hire_date1 regexp '^[0-9]{2}/[0-9]{2}/[0-9]{4}$'
then "DD/MM/YYYY"
else 'others'
end as date_formatting,
count(*)  as rows_count
 from amazon.employees
 group by date_formatting;
  select distinct * from amazon.employees
 where hire_date1 regexp '^[0-9]{4}-[0-9]{2}-[0-9]{2}$'
 and hire_date1 regexp '^[0-9]{2}-[0-9]{2}-[0-9]{4}$'
 and hire_date1 regexp '^[0-9]{2}/[0-9]{2}/[0-9]{4}$'
 and hire_date1 is not null;
 select count(*) from amazon.employees
 where hire_date1 is null;
 
alter table amazon.employees
drop column hire_date;
alter table amazon.employees
rename column hire_date1 to hire_date;
set sql_safe_updates=0;
update amazon.employees
set city='London'
where city='Londn';
select * from amazon.employees;
select * from amazon.sales;

#1. What is the total number of employees?

SELECT COUNT(*) AS total_employees
FROM amazon.employees;


#2. What is the total number of departments?

SELECT COUNT(DISTINCT department) AS total_departments
FROM amazon.employees;


#3. How many employees are there in each department?

SELECT
    department,
    COUNT(employee_id) AS total_employees
FROM amazon.employees
GROUP BY department
ORDER BY total_employees DESC;


#4. What is the average salary of all employees?

SELECT
    AVG(salary) AS average_salary
FROM amazon.employees;


#5. Which department has the highest average salary?

SELECT
    department,
    AVG(salary) AS average_salary
FROM amazon.employees
GROUP BY department
ORDER BY average_salary DESC
LIMIT 1;


#6. Which city has the highest number of employees?

SELECT
    city,
    COUNT(employee_id) AS total_employees
FROM amazon.employees
GROUP BY city;


#7. How many employees were hired each year?

SELECT
    YEAR(hire_date) AS hire_year,
    COUNT(employee_id) AS total_employees
FROM amazon.employees
GROUP BY YEAR(hire_date)
ORDER BY hire_year;


#8. Which employee has the highest salary?

SELECT
    employee_id,
    name,
    salary
FROM amazon.employees
ORDER BY salary DESC
LIMIT 1;


#9. Which employee has the lowest salary?

SELECT
    employee_id,
    name,
    salary
FROM amazon.employees
ORDER BY salary
LIMIT 1;


#10. What is the salary distribution by department?

SELECT
    department,
    MIN(salary) AS minimum_salary,
    MAX(salary) AS maximum_salary,
    AVG(salary) AS average_salary
FROM amazon.employees
GROUP BY department
ORDER BY average_salary DESC;

#11. What is the total revenue generated?

SELECT
    SUM(quantity * unit_price) AS total_revenue
FROM amazon.sales;


#12. What is the total number of orders?

SELECT
    COUNT(sale_id) AS total_orders
FROM amazon.sales;


#13. How many unique customers are there?

SELECT
    COUNT(DISTINCT customer) AS unique_customers
FROM amazon.sales;


#14. Which product generated the highest revenue?

SELECT
    product,
    SUM(quantity * unit_price) AS total_revenue
FROM amazon.sales
GROUP BY product
ORDER BY total_revenue DESC
LIMIT 1;


#15. Which product sold the highest quantity?

SELECT
    product,
    SUM(quantity) AS total_quantity_sold
FROM amazon.sales
GROUP BY product
ORDER BY total_quantity_sold DESC
LIMIT 1;


#16. Which customer spent the most?

SELECT
    customer,
    SUM(quantity * unit_price) AS total_spent
FROM amazon.sales
GROUP BY customer
ORDER BY total_spent DESC
LIMIT 1;


#17. Which employee generated the highest revenue?

SELECT
    e.employee_id,
    e.name,
    SUM(s.quantity * s.unit_price) AS total_revenue
FROM amazon.employees e
JOIN amazon.sales s
ON e.employee_id = s.employee_id
GROUP BY e.employee_id, e.name
ORDER BY total_revenue DESC
LIMIT 1;


#18. What is the average order value?

SELECT
    AVG(quantity * unit_price) AS average_order_value
FROM amazon.sales;


#19. Which month generated the highest revenue?

SELECT
    DATE_FORMAT(sale_date, '%Y-%m') AS sale_month,
    SUM(quantity * unit_price) AS total_revenue
FROM amazon.sales
GROUP BY DATE_FORMAT(sale_date, '%Y-%m')
ORDER BY total_revenue DESC
LIMIT 1;


#20. Which year generated the highest revenue?

SELECT
    YEAR(sale_date) AS sale_year,
    SUM(quantity * unit_price) AS total_revenue
FROM amazon.sales
GROUP BY YEAR(sale_date)
ORDER BY total_revenue DESC
LIMIT 1;
#21. Which employee generated the highest revenue?

SELECT
    e.employee_id,
    e.name,
    SUM(s.quantity * s.unit_price) AS total_revenue
FROM amazon.employees e
JOIN amazon.sales s
ON e.employee_id = s.employee_id
GROUP BY e.employee_id, e.name
ORDER BY total_revenue DESC
LIMIT 1;


#22. What is the total revenue generated by each employee?

SELECT
    e.employee_id,
    e.name,
    SUM(s.quantity * s.unit_price) AS total_revenue
FROM amazon.employees e
JOIN amazon.sales s
ON e.employee_id = s.employee_id
GROUP BY e.employee_id, e.name
ORDER BY total_revenue DESC;


#23. Which department generated the highest revenue?

SELECT
    e.department,
    SUM(s.quantity * s.unit_price) AS total_revenue
FROM amazon.employees e
JOIN amazon.sales s
ON e.employee_id = s.employee_id
GROUP BY e.department
ORDER BY total_revenue DESC
LIMIT 1;


#24. What is the total revenue generated by each department?

SELECT
    e.department,
    SUM(s.quantity * s.unit_price) AS total_revenue
FROM amazon.employees e
JOIN amazon.sales s
ON e.employee_id = s.employee_id
GROUP BY e.department
ORDER BY total_revenue DESC;


#25. Which city generated the highest revenue?

SELECT
    e.city,
    SUM(s.quantity * s.unit_price) AS total_revenue
FROM amazon.employees e
JOIN amazon.sales s
ON e.employee_id = s.employee_id
GROUP BY e.city
ORDER BY total_revenue DESC
LIMIT 1;


#26. What is the total revenue generated by each city?

SELECT
    e.city,
    SUM(s.quantity * s.unit_price) AS total_revenue
FROM amazon.employees e
JOIN amazon.sales s
ON e.employee_id = s.employee_id
GROUP BY e.city
ORDER BY total_revenue DESC;


#27. Which employee handled the highest number of orders?

SELECT
    e.employee_id,
    e.name,
    COUNT(s.sale_id) AS total_orders
FROM amazon.employees e
JOIN amazon.sales s
ON e.employee_id = s.employee_id
GROUP BY e.employee_id, e.name
ORDER BY total_orders DESC
LIMIT 1;


#28. Which department handled the highest number of orders?

SELECT
    e.department,
    COUNT(s.sale_id) AS total_orders
FROM amazon.employees e
LEFT JOIN amazon.sales s
ON e.employee_id = s.employee_id
GROUP BY e.department
ORDER BY total_orders DESC
LIMIT 1;


#29. Which customer purchased from the highest number of different employees?

SELECT
    customer,
    COUNT(DISTINCT employee_id) AS different_employees
FROM amazon.sales
GROUP BY customer
ORDER BY different_employees DESC
LIMIT 1;


#30. Which employees have never made a sale?

SELECT
    e.employee_id,
    e.name
FROM amazon.employees e
LEFT JOIN amazon.sales s
ON e.employee_id = s.employee_id
WHERE s.sale_id IS NULL;

 
 


