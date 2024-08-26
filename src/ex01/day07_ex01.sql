select 
	person.name,
	count(*) as count_of_visits
from 
	person_visits
join person on person.id=person_visits.person_id
group by
	person.name
order by
	count_of_visits desc,
	person.name asc
limit 4;

