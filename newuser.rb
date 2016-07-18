#!/usr/bin/env ruby
# encoding: utf-8
require 'cgi'
cgi= CGI.new
require'sqlite3'
print cgi.header("text/html; charset=utf-8")

# htmlの記述
print <<EOF
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>新規登録</title>
</head>
<body>
<form action="user_update.rb" method="post">
<h1>新規登録<\h1>
<h2>登録したいユーザー名を入力してください</h2>
<p>ユーザー名：<input type="text" name="username"></p>
<p><input type="submit" value="決定">
<input type="reset" value="クリア"></p>
</form>
<a href="index.rb">ログインページに戻る</a>
</body>
</html>
EOF
