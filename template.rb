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
<title>えぶりまっする</title>
</head>
<body>
</body>
</html>
EOF

