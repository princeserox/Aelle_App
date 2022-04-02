-- Using TSQL ---------
/** 
1. Given the above table, structure a query to determine the total amount spent by all 
visitors? 
**/

SELECT sum([purchase_amount]) total_amount_spent
  FROM [aelle].[dbo].[aelle_demo]

/** 
2. Given the above table, structure a query to return all users who visited in February AND 
spent more than 1000 naira
**/

SELECT [user_id]
      ,[date_visited]
      ,[purchase_amount]
  FROM [aelle].[dbo].[aelle_demo]
  where  month([date_visited]) = 2
  and  [purchase_amount] > 1000

/**
3. Given the above table, structure a query to determine the highest and lowest amount 
spent in each month
**/

SELECT 
      datename(month,[date_visited]) month 
      ,min([purchase_amount]) lowest_amount_spent
	  , max([purchase_amount]) highest_amount_spent
  FROM [aelle].[dbo].[aelle_demo]
group by  datename(month,[date_visited])


/**
4. Given the above table, structure a query to determine the total monthly purchases
**/

SELECT 
      datename(month,[date_visited]) month 
      ,sum([purchase_amount]) total_amount_spent
	  
  FROM [aelle].[dbo].[aelle_demo]
group by  datename(month,[date_visited])


/**
5. Given the above table, structure a query to determine how much each user spends on 
their second purchase. 
**/
go
with cte_a 
as

(
SELECT  [user_id]
      ,[date_visited]
      ,[purchase_amount]
	  , row_number() over (partition by user_id order by [date_visited] asc ) rnk 
  FROM [aelle].[dbo].[aelle_demo]
)
select [user_id], [purchase_amount]  from cte_a
where rnk = 2