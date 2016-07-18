#!/usr/bin/env ruby
# encoding: utf-8
require 'cgi'
cgi= CGI.new
require'sqlite3'
print cgi.header("text/html; charset=utf-8")

#送られてきたデータの受け取り
usernames = cgi["username"]

begin
#データベースの操作
db = SQLite3::Database.new("every_muscle.db")
db.transaction(){
  db.execute("INSERT INTO user(name) VALUES(?);", usernames)
  db.execute("INSERT INTO count(pushups, abs, back, squat, barbie, total) VALUES(0, 0, 0, 0, 0, 0);")
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
<meta http-equiv="refresh" content="5;URL=index.rb" charset="UTF-8">
<title>登録完了</title>
</head>
<body>
<h1>ようこそ#{usernames}さん！登録完了しました！</h1>
<p>5秒後にログインページに戻ります</p>
</body>
</html>
EOF
