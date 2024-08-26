with person_order_id_list as( 
	select
		person_id,
		pizzeria.name as pizzeria_name,
		count(*) as count_of_orders,
		ROW_NUMBER() OVER (PARTITION BY pizzeria.name ORDER BY COUNT(*) DESC) AS rn -- если че, закоментить
	from
		person_order
	join menu on menu.id=person_order.menu_id
	join pizzeria on pizzeria.id=menu.pizzeria_id
	group by person_id, pizzeria_name
)
select 
	person.address,
	person_order_id_list.pizzeria_name as name,
	sum(person_order_id_list.count_of_orders) as count_of_orders
from
	person_order_id_list
join person on person.id=person_order_id_list.person_id
where rn=1 -- если че, закоментить
group by person.address, person_order_id_list.pizzeria_name
order by person.address, person_order_id_list.pizzeria_name;
