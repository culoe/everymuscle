#!/usr/bin/env ruby
# encoding: utf-8
require 'cgi'
cgi= CGI.new
require'sqlite3'
print cgi.header("text/html; charset=utf-8")
registed_user = Array.new

begin
# データベースの操作
db = SQLite3::Database.new("every_muscle.db") #データベースを開く
db.transaction(){
  registed_user =  db.execute("SELECT name FROM user")
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
<title>えぶりまっする</title>
<link rel="stylesheet" type="text/css" href="index.css">
</head>
<body background="image/kinniku.jpg">

<script type="text/javascript">
registed_users = #{registed_user};
//ログインをチェックする関数の作成
function login_check() {
usernames = document.getElementById('username').value;
if(usernames.length > 0){ //文字が入力されているかのチェック
    if(usernames.length < 16){ //文字が15文字以内かのチェック
        if(usernames.match(/<*>/)){
            ret = false;
            alert("HTMLのタグは使えません");
          } else {
            if(String(registed_users).indexOf(usernames) >= 0) { //入力されたユーザーが登録されているか
                ret = true;
              } else {
                ret = false;
                alert("ユーザーが登録されていません");
              }
            }
          } else {
            ret = false;
          alert("ユーザー名は15文字以内です");
          }
        } else {
        ret = false;
        alert("ユーザー名を入力してください");
        }
      return ret;
      }
    </script>

<h1 id="heading02">えぶりまっする</h1>
<div id="center02">
<div class="inner">

<h2>NO MUSCLE NO LIFE</h2>
<P>ようこそ、えぶりまっするへ。<br>
このサイトは、皆さんの日々の運動を手助けするサイトです。<br>
まずはユーザー名の登録をお願いします。<br>
面倒くさいという方はとりあえず「example」でログインしてみてください。<br>
おっと、ログインする前に<br>
<b>腕立て・腹筋・背筋</b><br>
<b>スクワット・バービージャンプ</b><br>
のどれかをしてから入ってください。<br>
それでは、よいMUSCLE LIFEを。
</p>
<form action="userpage.rb" method="post" onSubmit="return login_check()">
<h1>ログイン</h1>
<input placeholder="Username" type="text" name="username" id="username">
<input type="submit" value="決定">
<p>※ユーザー名は1文字以上15文字以下です</p
</form><br>
<a href="whole.rb">ランキングページを見る</a><br>
<br><a href="newuser.rhtml">新規登録</a><br>
</div>
</div>
</body>
</html>
EOF
