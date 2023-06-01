select * from publication.sales s;

select * from publication.roysched r;

# Challenge 1 - Most Profiting Authors

select ta.title_id as Title_ID, ta.au_id as Author_ID, t.advance as Advance, ta.royaltyper as RT, s.qty as Sales, t.price as Price, t.royalty as Royalty 
from titleauthor ta
left join titles t using (title_id)
left join sales s using (title_id)
left join roysched r using (title_id);

with advance_cte as (
select ta.title_id as Title_ID, ta.au_id as Author_ID, sum((Advance*ta.royaltyper)/100) as advance2
from titleauthor ta
left join titles t using (title_id)
left join roysched r using (title_id)
group by 1,2)

, sales_cte as (
select ta.title_id as Title_ID, ta.au_id as Author_ID, sum((t.price*s.qty*t.royalty)/100 * (ta.royaltyper/100)) as sales_royalty
from titleauthor ta
left join titles t using (title_id)
left join sales s using (title_id)
left join roysched r using (title_id)
group by 1,2)

select au_lname as Last_Name, au_fname as First_Name, a.Author_ID, sum(advance2), sum(sales_royalty), sum(advance2 + sales_royalty) as total
from advance_cte a
left join sales_cte s using (title_id, author_id)
left join authors au on a.author_id = au.au_id
group by 1,2,3 order by 6 desc;

