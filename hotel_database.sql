create database hotel;
use hotel;
select * from hotel.booking;
select * from hotel.hotels;
select * from hotel.rooms;
select * from hotel.guests;
select * from hotel.booking where 
booking_id ='';
select * from hotel.booking where 
guest_id ='';
select * from hotel.booking where 
room_id ='';
select * from hotel.booking where 
booking_date ='';
select * from hotel.booking where 
check_in ='';
select * from hotel.booking where 
check_out ='';
select * from hotel.booking where 
nights ='';
select * from hotel.booking where 
status='';
select * from hotel.booking where 
booking_channel ='';
select * from hotel.booking where 
payment_method ='';
set sql_safe_updates=0;
update hotel.booking
set payment_method=null
where payment_method='';
select * from hotel.booking;
select * from hotel.hotels limit  10000;
select count(*) as total_rows,
sum(case when hotel_id='' then 1 else 0 end) as id_nulls,
sum(case when hotel_name='' then 1 else 0 end) as name_nulls,
sum(case when city='' then 1 else 0 end) as city_nulls,
sum(case when star_rating='' then 1 else 0 end) as star_nulls
from hotel.hotels ;
select * from hotel.rooms;
select count(*),
sum(case when room_id='' then 1 else 0 end) as id_blanks,
sum(case when hotel_id='' then 1 else 0 end) as hotel_blanks,
sum(case when room_type='' then 1 else 0 end ) as room_type_blanks,
sum(case when room_rate='' then 1 else 0 end) as room_rate_blanks
from hotel.rooms;
select * from hotel.guests;
select count(*) as total_rows,
sum(case when guest_id='' then 1 else 0 end) as id_blanks,
sum(case when guest_name='' then 1 else 0 end) as name_blanks,
sum(case when email='' then 1 else 0 end) as email_blanks,
sum(case when city='' then 1 else 0 end) as city_blanks
from hotel.guests;
update hotel.guests
set email=null
where email='';
select * from hotel.booking
where nights<0;
update hotel.booking
set nights=null
where nights<0;
update hotel.booking b
join
(
select avg(nights) as average
from hotel.booking
where nights>0
)t
set b.nights=t.average
where nights is null;

#Show all columns and rows from the hotel_bookings table.
select * from hotel.booking;
#Show only booking_id, guest_id, room_id, and status from hotel_bookings.
select booking_id,guest_id,room_id,status from hotel.booking;
#Find all bookings where the status is 'Confirmed'.
select * from hotel.booking
where status='confirmed';
#Find all bookings made through the 'Online' booking channel.
select distinct(booking_channel) from hotel.booking;
select * from hotel.booking
where booking_channel='booking.com'or
booking_channel= 'hotel website';
#Display all unique booking statuses.
select distinct(status) from hotel.booking;
select distinct * from hotel.booking;
#Display all unique payment methods.
select distinct(payment_method) from hotel.booking;
#Find bookings where the number of nights is greater than 5.
select * from hotel.booking
where nights>5;
#Display bookings ordered by nights from highest to lowest.
select * from hotel.booking
order by nights desc;
#     AGGREGATIONS

#9. How many total bookings are there?
select count(booking_id) as total from hotel.booking;
#10. What is the total number of nights booked?
select sum(nights) as total from hotel.booking;
#11. What is the average number of nights per booking?
select round(avg(nights))AS average from hotel.booking;
#12. What is the minimum and maximum number of nights booked?
select min(nights),max(nights) from hotel.booking;
#13. How many bookings are there for each booking status?
select status,count(booking_id) as total_bookings from hotel.booking
group by status;
#14. How many bookings are there for each payment method?
select payment_method,count(booking_id) as total_bookings from hotel.booking
group by payment_method;
#15. How many bookings are there for each booking channel?
select booking_channel,
count(booking_id) as total_bookings
from hotel.booking
group by booking_channel;
#16. Which booking status has the highest number of bookings?
select status,count(booking_id) as total_bookings
from hotel.booking
group by status
order by count(booking_id) desc limit 1 ;
#    GROUP BY  AND HAVING
#Which booking statuses have more than 1,000 bookings?
select status,count(booking_id) as total_bookings
from hotel.booking
group by status having count(booking_id)>1000;
#Which payment methods have more than 1,000 bookings?
select payment_method,count(booking_id) as total_bookings
from hotel.booking
group by payment_method
having count(booking_id)>1000;
#Which booking channels have more than 1,000 bookings?
select booking_channel,count(booking_id) as total_bookings
from hotel.booking
group by booking_channel
having count(booking_id)>1000;
#Which booking statuses have an average stay of more than 5 nights?
select status,avg(nights) as average
from hotel.booking
group by status
having avg(nights)>5;
select * from hotel.booking;
#Which booking channels have an average stay of more than 4 nights?
select booking_channel,avg(nights) as average
from hotel.booking
group by booking_channel
having avg(nights)>4;
select * from hotel.booking;
select * from hotel.hotels;
select * from hotel.rooms;
select * from hotel.guests;
#Which cities have more than 500 bookings?
select city,count(booking_id) as total_bookings
from hotel.guests g
left join
hotel.booking b
on g.guest_id=b.guest_id
group by city
having count(booking_id)>500;
#Which hotels have more than 100 bookings?
select hotel_name,count(booking_id) as total_bookings
from hotel.booking b
join 
hotel.rooms r
on b.room_id=r.room_id
join 
hotel.hotels h
on r.hotel_id=h.hotel_id
group by hotel_name
having count(booking_id)>100;

#Which room types have an average room rate greater than £150?
select room_type,avg(room_rate) as average
from hotel.rooms
group by room_type
having avg(room_rate)>150;
#Which hotels have an average room rate greater than £150?
select hotel_name,avg(room_rate)
from hotel.hotels h
left join
hotel.rooms r
on h.hotel_id=r.hotel_id
group by hotel_name
having avg(room_rate)>150;
#Which cities have an average booking duration greater than 5 nights?
select city,avg(nights) as average
from hotel.guests g
left join
hotel.booking b
on g.guest_id=b.guest_id
group by city
having avg(nights)>5;




