select distinct
	person.name as name
from 
	person_order
join person on person.id=person_order.person_id
order by name;