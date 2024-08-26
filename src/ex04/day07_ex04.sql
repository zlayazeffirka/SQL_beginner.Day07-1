with count_of_visits_list as (
	select 
		person_id,
		count(*) as count_of_visits
	from
		person_visits
	group by
		person_id
	having count(*)>3
)
select 
	name,
	count_of_visits
from count_of_visits_list
join person on person.id=count_of_visits_list.person_id;
