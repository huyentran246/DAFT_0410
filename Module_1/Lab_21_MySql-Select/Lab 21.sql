# Challenge 1: Who Have Published What At Where?

select * from publications.authors;

select * from publications.titles;

select * from publications.titleauthor;

select * from publications.publishers;

select a.au_id, a.au_lname, a.au_fname, t.title, p.pub_name
from publications.authors a
left join publications.titleauthor ta
	on a.au_id = ta.au_id    
left join publications.titles t
	on t.title_id = ta.title_id
left join publications.publishers p
	on p.pub_id = t.pub_id;
    
# Challenge 2: how many titles each author has published at each publisher. count group by

select a.au_id, concat(a.au_fname,' ',a.au_lname) as author, p.pub_name as pubnisher, count(t.title_id) as number_of_titles
from publications.authors a
inner join publications.titleauthor ta 
	on a.au_id = ta.au_id
inner join publications.titles t 
	on ta.title_id = t.title_id
inner join publications.publishers p 
	on t.pub_id = p.pub_id
group by a.au_id, p.pub_name;

select sum(number_of_titles) as total_titles
from (
  select count(distinct title_id) as number_of_titles
  from publications.titleauthor ta
  group by ta.au_id
) as title_count;

select count(title_id) from publications.titleauthor;

# Challenge 3 - Best Selling Authors

select a.au_id as author_id, a.au_lname as last_name, a.au_fname as first_name, count(t.title_id) as total
from publications.authors a
inner join publications.titleauthor ta
	on a.au_id = ta.au_id
inner join publications.titles t 
	on ta.title_id = t.title_id
group by a.au_id
order by count(t.title_id) desc limit 3;

# Challenge 4 - Best Selling Authors Ranking

select a.au_id as author_id, a.au_lname as last_name, a.au_fname as first_name, count(t.title_id) as total
from publications.authors a
inner join publications.titleauthor ta
	on a.au_id = ta.au_id
inner join publications.titles t 
	on ta.title_id = t.title_id
group by a.au_id
order by count(t.title_id) desc limit 23;
