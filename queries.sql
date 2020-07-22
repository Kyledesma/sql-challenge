--List the following details of each employee: employee number, last name, first name, sex, and salary.
select emp_no, last_name, first_name, sex, (select salary from public."Salaries" where public."Employees".emp_no = public."Salaries".emp_no)
from public."Employees"
group by 1,2,3,4;


--List first name, last name, and hire date for employees who were hired in 1986.
select first_name, last_name, hire_date
from public."Employees"
where hire_date between '1986-01-01' and  '1986-12-31'
group by 1,2,3;


--List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name.
SELECT public."Dept_manager".dept_no,dept_name,public."Employees".emp_no,last_name,first_name
FROM public."Employees"
INNER JOIN public."Dept_manager" on public."Employees".emp_no = public."Dept_manager".emp_no
INNER JOIN public."Departments" on public."Dept_manager".dept_no = public."Departments".dept_no;



--List the department of each employee with the following information: employee number, last name, first name, and department name.
select e.emp_no, e.last_name, e.first_name, d.dept_name
from public."Employees" e
INNER JOIN public."Dept_emp" de on e.emp_no = de.emp_no
INNER JOIN public."Departments" d on de.dept_no = d.dept_no
group by 1,2,3,4;



--List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."
select e.first_name, e.last_name, e.sex
from public."Employees" e
where first_name = 'Hercules'
and last_name like 'B%'
group by 1,2,3;


--List all employees in the Sales department, including their employee number, last name, first name, and department name.
select e.emp_no, e.last_name, e.first_name, d.dept_name
from public."Employees" e, public."Departments" d
where e.emp_no in
	(select de.emp_no 
	 from public."Dept_emp" de
	 where de.dept_no in
	 	(select d.dept_no 
		 from public."Departments" d
		))
		 and d.dept_name = 'Sales'
group by 1,2,3,4;

--List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
select e.emp_no, e.last_name, e.first_name, d.dept_name
from public."Employees" e, public."Departments" d
where e.emp_no in
	(select de.emp_no 
	 from public."Dept_emp" de
	 where de.dept_no in
	 	(select d.dept_no 
		 from public."Departments" d
		))
		 and d.dept_name in('Sales', 'Development')
group by 1,2,3,4;



--In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
select last_name, count(e.last_name)
from public."Employees" e
group by 1;


