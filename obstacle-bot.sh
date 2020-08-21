#!/bin/bash
your_address=hogehoge@hoge.jp
dirname="/home/vagrant/workspace/obstacle-bot"
filename="${dirname}/current-update-docomo-`date +'%Y%m%d%H'`.xml"
curl -s -o $filename -H "User-Agent: CrawlBot; ${your_address}" https://www.nttdocomo.co.jp/info/rss/network.rdf
leastfilename=`ls | grep least-update-docomo`
diff -q ${filename} ${leastfilename} > diff.txt
grep -q "differ" diff.txt

if [ $? = 0 ]; then
    echo "docomoの重要なお知らせが更新されたました https://www.nttdocomo.co.jp/info/network/" | mail -s "obstacle-bot" ${your_address}
fi
mv ${filename} "${dirname}/least-update-docomo-`date +'%Y%m%d%H'`.xml"
rm diff.txt