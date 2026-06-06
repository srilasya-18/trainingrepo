show databases;
use training;
show tables;
select * from users;
select * from events;
select * from sessions;
select * from registrations;
select * from feedback;
select * from resources;

#1
select u.full_name,e.title,e.city,e.start_date
from users u
JOIN registrations r on u.user_id=r.user_id
JOIN events e on r.event_id=e.event_id
WHERE e.status='upcoming'
and u.city=e.city
order by e.start_date;

#2
select e.title,AVG(f.rating) as avg_rating,count(*) as feedback_ct
from events e
join feedback f on e.event_id=f.event_id
group by e.event_id,e.title
having count(*)>=10
order by avg_rating desc;

#3
select * from users u 
where u.user_id not in( 
select r.user_id from registrations r
where r.registration_date >= curdate() - interval 90 day);

#4
select e.title,count(*) as session_ct from events e 
join sessions s on e.event_id=s.event_id
where time(s.start_time) between '10:00:00' and '12:00:00' group by e.title;

#5
select e.city,count(distinct r.user_id) as dist_userreg from registrations r 
join events e on r.event_id=e.event_id 
group by e.city order by dist_userreg desc limit 5;

#6
select e.title ,count(r.resource_id) as res_ct from events e
left join resources r on e.event_id=r.event_id
group by e.title;

#7
select u.full_name,f.comments,e.title 
from feedback f
join users u on f.user_id=u.user_id
join events e on f.event_id = e.event_id
where rating<3;

#8
select e.title ,count(s.session_id) as session_ct
from events e
left join sessions s on e.event_id=s.event_id
where e.status='upcoming' group by e.title;

#9
select organizer_id,status,
count(*) as tot_events 
from events 
group by organizer_id,status;

#10
select e.title from events e
join registrations r on e.event_id = r.event_id
left join feedback f on e.event_id = f.event_id
where f.feedback_id is null
group by e.title; 

#11
select registration_date,count(user_id) as user_ct
from users 
where registration_date >= curdate()-interval 7 day
group by registration_date
order by registration_date;

#12
select e.title , count(*) as event_ct from events e
join sessions s on e.event_id=s.event_id
group by e.event_id,e.title
order by event_ct desc
limit 1;

#13
SELECT e.city,AVG(f.rating) AS avg_rating
FROM feedback f
JOIN events e
ON f.event_id = e.event_id
GROUP BY e.city;