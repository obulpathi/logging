Pig Philosophy
* Pigs eat anything
* Pigs live anywhere
* Pigs are domestic animals
* Pigs fly



-- pig commands


pig illustrate
pig touches all records
explain
order
limit
set debug on -- Debug
generate
stream
join
parallel




-- Examples

-- Load the transactions file, group it by customer, and sum their total purchases
transactions = load 'transactions' as (customer, purchase);
grouped = group transactions by customer;
total = foreach grouped generate group, SUM(txns.purchase) as tp;

-- Load the customer_profile file
profile = load 'customer_profile' as (customer, zipcode);

-- join the grouped and summed transactions and customer_profile data
answer = join total by group, profile by customer;

-- Write the results to the screen
dump answer;








Users = load 'users' as (name, age);
Fltrd = filter Users by age >= 18 and age <= 25;
Pages = load 'pages' as (user, url);
Jnd = join Fltrd by name, Pages by user;
Grpd = group Jnd by url;
Smmd = foreach Grpd generate group, COUNT(Jnd) as clicks;
Srtd = order Smmd by clicks desc;
Top5 = limit Srtd 5;
store Top5 into 'top5sites';
