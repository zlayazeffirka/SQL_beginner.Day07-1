with top_order as (
	select
		pizzeria_id,
		count(*) as count,
		'visit' as action_type
	from 
		person_visits
	group by pizzeria_id
	order by action_type asc, count desc
	limit 3
),
top_visits as (
	select
		pizzeria_id,
		count(*) as count,
		'order' as action_type
	from 
		person_order
	join menu on menu.id=person_order.menu_id
	group by pizzeria_id
	order by action_type asc, count desc
	limit 3
),
top_order_and_visits as (
	select * from top_order
	union all
	select * from top_visits
)
select 
	pizzeria.name,
	count,
	action_type
from top_order_and_visits
join pizzeria on pizzeria.id=top_order_and_visits.pizzeria_id
order by action_type asc, count desc;
