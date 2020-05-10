/* Analytic Functions
 * 
 * RATIO_TO_REPORT - computes the ratio of a value to the sum of a set of values
 *
 */

with data as (
select to_char(sum(d.ukupno),'999G999G999G999D00') ukupno
    , sum(d.ukupno) over() total_sum
    , round(100 * (sum(d.ukupno) / sum(d.ukupno) over()), 2) perc
    , a.drzava 
    from apv_mat_partners a, doc_wh_ife d
where a.id = d.id_mat_partners
group by d.ukupno, a.drzava
order by 3 desc)
/
select sum(data.ukupno), sum(data.perc), data.drzava
from data 
where data.perc is not null
group by data.drzava;
/
select sum(d.ukupno) over() as total, 
       a.drzava
    , round(100 * (sum(d.ukupno) / sum(d.ukupno) over()), 2) as perc
    from apv_mat_partners a, doc_wh_ife d
where a.id = d.id_mat_partners
group by a.drzava;
/
select sum(d.ukupno) as ukupno
        , sum(d.ukupno) over() as total_ukupno
         ,a.drzava
         , round(100 * (sum(d.ukupno) / sum(d.ukupno) over()), 2) as perc
from apv_mat_partners a, doc_wh_ife d
where a.id = d.id_mat_partners
group by a.drzava, d.ukupno
order by 4 desc;
/
select p.drzava,
         round(100*ratio_to_report(sum(d.ukupno)) over (), 2) perc
         , sum(d.ukupno)
   from doc_wh_ife d, apv_mat_partners p
   where d.id_mat_partners = p.id
   group by p.drzava
  order by 2 desc
  /
select ozndoc, partner_display_name, round(100*ratio_to_report(ukupno) over(), 2), ukupno from doc_wh_ife
 order by ukupno desc;
  /
 select partner_display_name, round(100*ratio_to_report(sum(ukupno)) over(), 2) partner_percent from doc_wh_ife
 group by partner_display_name
 order by 2 desc;