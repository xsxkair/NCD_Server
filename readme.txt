设备上传
POST /NCD_Server/up_device HTTP/1.1
Host: 127.0.0.1:8080
Connection: keep-alive
Content-Length: 20
Content-Type:application/x-www-form-urlencoded;charset=GBK
Accept-Language: zh-CN,zh;q=0.8

did=did223&name=张雄

读取时间
POST /NCD_Server/up_dtime HTTP/1.1
Host: 127.0.0.1:8080
Connection: keep-alive
Content-Length: 10
Content-Type:application/x-www-form-urlencoded;charset=GBK
Accept-Language: zh-CN,zh;q=0.8

did=did223

上传试机卡
POST /NCD_Server/up_card HTTP/1.1
Host: 127.0.0.1:8080
Connection: keep-alive
Content-Length: 19
Content-Type:application/x-www-form-urlencoded;charset=GBK
Accept-Language: zh-CN,zh;q=0.8

cid=cid224&item=myo

上传测试数据
POST /NCD_Server/up_testdata HTTP/1.1
Host: 127.0.0.1:8080
Connection: keep-alive
Content-Length: 43
Content-Type:application/x-www-form-urlencoded;charset=GBK
Accept-Language: zh-CN,zh;q=0.8

cnum=0001&card.cid=cid223&device.did=did223

上传曲线
POST /NCD_Server/up_series HTTP/1.1
Host: 127.0.0.1:8080
Connection: keep-alive
Content-Length: 45
Content-Type:application/x-www-form-urlencoded;charset=GBK
Accept-Language: zh-CN,zh;q=0.8

cnum=0001&card.cid=cid223&serie_b=[2,2,3,4,5]