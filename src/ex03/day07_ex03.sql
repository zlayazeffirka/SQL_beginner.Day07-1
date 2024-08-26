with top_order_and_visits as (
	select
		pizzeria_id,
		count(*) as count,
		'visit' as action_type
	from 
		person_visits
	group by pizzeria_id
	
	union all
	
	select
		pizzeria_id,
		count(*) as count,
		'order' as action_type
	from 
		person_order
	join menu on menu.id=person_order.menu_id
	group by pizzeria_id
),
total_count_list as (
	select
		pizzeria_id,
		sum(count) as total_count
	from 
		top_order_and_visits
	group by 
		pizzeria_id
	
)
select
	pizzeria.name as name,
	total_count
from 
	total_count_list
join pizzeria on pizzeria.id=total_count_list.pizzeria_id
order by total_count desc, name asc;
