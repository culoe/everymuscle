#!/usr/bin/env ruby
# encoding: utf-8
require 'cgi'
cgi= CGI.new
require'sqlite3'
print cgi.header("text/html; charset=utf-8")

#送られてきたデータの受け取り
username = cgi["username"]
sent_pushups = cgi["count_pushups"]
sent_abs = cgi["count_abs"]
sent_back = cgi["count_back"]
sent_squat = cgi["count_squat"]
sent_barbie = cgi["count_barbie"]
sent_total = 0
registed_count = Array.new
countid = 0

#データベースの操作
db = SQLite3::Database.new("every_muscle.db")
db.transaction(){
  countid = db.execute("SELECT id FROM user WHERE name=\"#{username}\"")
  registed_count = db.execute("SELECT pushups, abs, back, squat, barbie, total FROM user inner join count on user.id = count.countid WHERE user.name = \"#{username}\"")
  sent_pushups = sent_pushups.to_i + registed_count[0][0].to_i
  sent_abs = sent_abs.to_i + registed_count[0][1].to_i
  sent_back = sent_back.to_i + registed_count[0][2].to_i
  sent_squat = sent_squat.to_i + registed_count[0][3].to_i
  sent_barbie = sent_barbie.to_i + registed_count[0][4].to_i
  sent_total = sent_pushups.to_i + sent_abs.to_i + sent_back.to_i + sent_squat.to_i + sent_barbie.to_i
  db.execute("UPDATE count SET pushups=#{sent_pushups}, abs=#{sent_abs}, back=#{sent_back}, squat=#{sent_squat}, barbie=#{sent_barbie}, total=#{sent_total} WHERE countid=#{countid[0][0]};")
}
db.close

# htmlの記述
print <<EOF
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>登録完了</title>
</head>
<body>
<form name="name_submit" action="userpage.rb" method="post">
<input type="hidden" name="username" value="#{username}">
<script type="text/javascript">
document.name_submit.submit();
</script>
</form>
<h1>#{username}さん！登録完了しました！</h1>
<p>ユーザーページに戻ります</p>
</body>
</html>
EOF
