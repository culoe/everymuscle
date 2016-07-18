#!/usr/bin/env ruby
# encoding: utf-8
require 'cgi'
cgi= CGI.new
require'sqlite3'
print cgi.header("text/html; charset=utf-8")
top5_total = Array.new
top5_pushups = Array.new
top5_abs = Array.new
top5_back = Array.new
top5_squat = Array.new
top5_barbie = Array.new

begin
#データベースの操作
db = SQLite3::Database.new("every_muscle.db")
db.transaction(){
  top5_total = db.execute("SELECT name, total user FROM user inner join count on user.id = count.countid ORDER BY total desc LIMIT 5;")
  top5_pushups = db.execute("SELECT name, pushups user FROM user inner join count on user.id = count.countid ORDER BY pushups desc LIMIT 5;")
  top5_abs = db.execute("SELECT name, abs user FROM user inner join count on user.id = count.countid ORDER BY abs desc LIMIT 5;")
  top5_back = db.execute("SELECT name, back user FROM user inner join count on user.id = count.countid ORDER BY back desc LIMIT 5;")
  top5_squat = db.execute("SELECT name, squat user FROM user inner join count on user.id = count.countid ORDER BY squat desc LIMIT 5;")
  top5_barbie = db.execute("SELECT name, barbie user FROM user inner join count on user.id = count.countid ORDER BY barbie desc LIMIT 5;")
}
rescue => ex
puts ex.message
puts ex.backtrace
end

# htmlの記述
print <<EOF
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ランキングページ</title>
<link rel="stylesheet" type="text/css" href="whole.css">
</head>
<body background="image/background1.jpg">

<h1 id="heading02">ランキングページ</h1>

<div id="center02">
<div class="inner">
<p>
<h3>Total</h3>
<ul class="ranking">
<li><font size="6">#{top5_total[0][0]} #{top5_total[0][1]}</font></li>
<li><font size="5">#{top5_total[1][0]} #{top5_total[1][1]}</font></li>
<li><font size="4">#{top5_total[2][0]} #{top5_total[2][1]}</font></li>
</ul>
</p>
<p>
<h3>腕立て</h3>
<ul class="ranking">
<li><font size="6">#{top5_pushups[0][0]} #{top5_pushups[0][1]}</font></li>
<li><font size="5">#{top5_pushups[1][0]} #{top5_pushups[1][1]}</font></li>
<li><font size="4">#{top5_pushups[2][0]} #{top5_pushups[2][1]}</font></li>
</ul>
</p>
<p>
<h3>腹筋</h3>
<ul class="ranking">
<li><font size="6">#{top5_abs[0][0]} #{top5_abs[0][1]}</font></li>
<li><font size="5">#{top5_abs[1][0]} #{top5_abs[1][1]}</font></li>
<li><font size="4">#{top5_abs[2][0]} #{top5_abs[2][1]}</font></li>
</ul>
</p>
<p>
<h3>背筋</h3>
<ul class="ranking">
<li><font size="6">#{top5_back[0][0]} #{top5_back[0][1]}</font></li>
<li><font size="5">#{top5_back[1][0]} #{top5_back[1][1]}</font></li>
<li><font size="4">#{top5_back[2][0]} #{top5_back[2][1]}</font></li>
</ul>
</p>
<p>
<h3>スクワット</h3>
<ul class="ranking">
<li><font size="6">#{top5_squat[0][0]} #{top5_squat[0][1]}</font></li>
<li><font size="5">#{top5_squat[1][0]} #{top5_squat[1][1]}</font></li>
<li><font size="4">#{top5_squat[2][0]} #{top5_squat[2][1]}</font></li>
</ul>
</p>
<p>
<h3>バービージャンプ</h3>
<ul class="ranking">
<li><font size="6">#{top5_barbie[0][0]} #{top5_barbie[0][1]}</font></li>
<li><font size="5">#{top5_barbie[1][0]} #{top5_barbie[1][1]}</font></li>
<li><font size="4">#{top5_barbie[2][0]} #{top5_barbie[2][1]}</font></li>
</ul>
</p>
<br><br><a href="index.rb">ログインページに戻る</a>
</div>
</div>
</body>
</html>
EOF
