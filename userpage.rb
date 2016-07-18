#!/usr/bin/env ruby
# encoding: utf-8
require 'cgi'
cgi= CGI.new
require'sqlite3'
print cgi.header("text/html; charset=utf-8")
username = cgi["username"]
registed_count = Array.new

begin
db = SQLite3::Database.new("every_muscle.db")
db.transaction(){
  registed_count = db.execute("SELECT pushups, abs, back, squat, barbie, total FROM user inner join count on user.id = count.countid WHERE user.name = \"#{username}\"")
}
db.close
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
<title>ユーザーページ</title>
<link rel="stylesheet" type="text/css" href="userpage.css">
</head>
<body background="image/background1.jpg">
<h1 id="heading02">ようこそ#{username}さん</h1>
<div id="center02">
<div class="inner">
<form action="count_update.rb" method="post">
<h2>お疲れさまです！<br>筋トレした回数を記録しましょう！</h2>
<p><input type="hidden" name="username" value="#{username}"></p>
<p>腕立て：<input type="number" value="0" name="count_pushups" id="count_pushups"></p>
<p>腹筋：<input type="number" value="0" name="count_abs" id="count_abs"></p>
<p>背筋：<input type="number" value="0" name="count_back" id="count_back"></p>
<p>スクワット：<input type="number" value="0" name="count_squat" id="count_squat"></p>
<p>バービージャンプ：<input type="number" value="0" name="count_barbie" id="count_barbie"></p>
<p><input type="submit" value="決定">
<input type="reset" value="クリア"></p>
</form>
<h2>#{username}さんの筋トレ合計回数です</h2>
<table border="1" cellspacint="0">
<tr>
<td>腕立て</td><td>腹筋</td><td>背筋</td><td>スクワット</td><td>バービージャンプ</td><td>Total</td>
</tr>
<tr>
<td>#{registed_count[0][0]}</td>
<td>#{registed_count[0][1]}</td>
<td>#{registed_count[0][2]}</td>
<td>#{registed_count[0][3]}</td>
<td>#{registed_count[0][4]}</td>
<td>#{registed_count[0][5]}</td>
</tr>
</table>
<br><br><a href="whole.rb">ランキングページに進む</a><br>
<br><a href="index.rb">ログインページに戻る</a>
</div>
</div>
</body>
</html>
EOF
