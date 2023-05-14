--select * from crime_scene_report
--where crime_scene_report.date = 20180115
--and crime_scene_report.city = 'SQL City'
--and type = 'murder';
/*
select * from person
where (person.name like 'Annabel%' 
and  person.address_street_name = 'Franklin Ave')
or (person.address_street_name = 'Northwestern Dr'
	and person.address_number = (select max(address_number) from person 
	 where address_street_name = 'Northwestern Dr'));
  */   
  
 /* 
select person.id 
	 , person.name
	, interview.transcript
from person
inner join interview
	on person.id = interview.person_id
		
where ( person.name like 'Annabel%' 
		and  person.address_street_name = 'Franklin Ave')
	 
		or (person.address_street_name = 'Northwestern Dr'
		and person.address_number = (select max(address_number) from person 
	 	where address_street_name = 'Northwestern Dr'));
   
   I heard a gunshot and then saw a man run out. He had a "Get Fit Now Gym" bag. 
   The membership number on the bag started with "48Z". 
   Only gold members have those bags. 
   The man got into a car with a plate that included "H42W".
   
   I saw the murder happen, and I recognized the killer from my gym 
   when I was working out last week on January the 9th.
   
 
 
 select * from drivers_license
 
 where plate_number like '%H42W%'; --183779, 423327, 664760



select * from person

where license_id in (183779,423327, 664760); --51739, 67318, 78193



select * from get_fit_now_member --48Z38 49550 Tomas Baisley
								--48Z7A	28819	Joe Germuska
								--48Z55	67318	Jeremy Bowers - (suspected man)
where id like '48Z%'



select * from interview
where person_id = 67318

I was hired by a woman with a lot of money. 
I don't know her name but I know she's around 5'5" (65") or 5'7" (67"). 
She has red hair and she drives a Tesla Model S. 
I know that she attended the SQL Symphony Concert 3 times in December 2017.

*/

select person.*,
drivers_license.*
from person,
facebook_event_checkin,
drivers_license
where person.license_id = drivers_license.id
and facebook_event_checkin.person_id = person.id
and facebook_event_checkin.event_name = 'SQL Symphony Concert'
order by person_id; 


