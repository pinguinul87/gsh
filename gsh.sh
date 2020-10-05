#!/bin/bash

files(){

        echo "<br><br>" >> $TMPFILE
        echo -e "<a href=\042#home\042>[Back to top]</a>" >> $TMPFILE
        echo -e "<h3>File description: <a name=\042$2\042></a>$2</h3>" >> $TMPFILE
        echo -e "<li><a href=\042#$2\042>$2</a>" >> $TMPFILE
        echo "<h4>File contents of $1</h4>" >> $TMPFILE
        echo "<pre>" >> $TMPFILE
        cat $1 | sed -e 's/&/\&amp;/g' -e 's/</\&lt;/g' -e 's/>/\&gt;/g' >> $TMPFILE
        echo "</pre><hr>" >> $TMPFILE

}

cmds(){

        echo "<br>" >> $TMPFILE
        echo -e "<a href=\042#home\042>[Back to top]</a>" >> $TMPFILE
        echo -e "<h3>Command description: <a name=\042$2\042></a>$2</h3>" >> $TMPFILE
        echo -e "<li><a href=\042#$2\042>$2</a>" >> $HTMLFILE
        echo "Command: $1"
        echo "<h4>Command: $1</h4>" >> $TMPFILE
        echo "<pre>" >> $TMPFILE
        $1 | sed -e 's/&/\&amp;/g' -e 's/</\&lt;/g' -e 's/>/\&gt;/g' >> $TMPFILE
        echo "</pre><hr>" >> $TMPFILE


}








TMPFILE="png_file.tmp"
HTMLFILE="system_enumeration_report.html"
rm -f $TMPFILE
rm -f $HTMLFILE

echo "<html>" >> $HTMLFILE
echo "<head>" >> $HTMLFILE
echo "<title>System enumeration report for $(hostname)</title>" >> $HTMLFILE
echo -e "<body bgcolor=\042white\042 link=\042blue\042 vlink=\042blue\042>" >> $HTMLFILE
clear
echo "Running script ..."


files /etc/passwd  "Password file"
files /etc/hostname "Hostname file"
files /etc/sudoers "Sudoers file"
files /etc/shadow "Shadow file"
files /home/kali/.bashrc "Bashrc file"
files /home/kali/.bash_history "Bash history file"

cmds "date" "Current date"
cmds "who" "Currently logged on users"
cmds "free -mh" "System memory"
cmds "lscpu" "System CPU"




echo ""
echo "Script finished"
cat $TMPFILE >> $HTMLFILE
rm -f $TMPFILE

echo "</body>" >> $HTMLFILE
echo "</html>" >> $HTMLFILE
sed -n p $HTMLFILE > /dev/null
mv $HTMLFILE /var/www/html
