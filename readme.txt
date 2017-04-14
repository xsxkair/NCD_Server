设备上传
POST /NCD_Server/up_device HTTP/1.1
Host: 116.62.108.201:8080
Connection: keep-alive
Content-Length: 20
Content-Type:application/x-www-form-urlencoded;charset=GBK
Accept-Language: zh-CN,zh;q=0.8

did=did223&name=张雄

读取时间
POST /NCD_Server/up_dtime HTTP/1.1
Host: 116.62.108.201:8080
Connection: keep-alive
Content-Length: 10
Content-Type:application/x-www-form-urlencoded;charset=GBK
Accept-Language: zh-CN,zh;q=0.8

did=did223

上传试机卡
POST /NCD_Server/up_card HTTP/1.1
Host: 116.62.108.201:8080
Connection: keep-alive
Content-Length: 19
Content-Type:application/x-www-form-urlencoded;charset=GBK
Accept-Language: zh-CN,zh;q=0.8

cid=cid224&item=myo

上传测试数据
POST /NCD_Server/up_testdata HTTP/1.1
Host: 116.62.108.201:8080
Connection: keep-alive
Content-Length: 30
Content-Type:application/x-www-form-urlencoded;charset=GBK
Accept-Language: zh-CN,zh;q=0.8

cnum=0001&cid=cid223&did=did223

POST /NCD_Server/up_testdata HTTP/1.1
Host: 116.62.108.201:8080
Connection: keep-alive
Content-Length: 189
Content-Type:application/x-www-form-urlencoded;charset=GBK
Accept-Language: zh-CN,zh;q=0.8

cnum=00000&cid=IM1702-01&did=NCD13011701004&t_name=代风娇&sid=1&testtime=2017-3-17 10:4:58&e_t=21.2&o_t=25.4&outt=0&c_l=244&t_l=155&b_l=216&t_c_v=0.464&a_p=1.000&b_v=44.30&a_v=44.30&t_re=ok


上传曲线
POST /NCD_Server/up_series HTTP/1.1
Host: 116.62.108.201:8080
Connection: keep-alive
Content-Length: 40
Content-Type:application/x-www-form-urlencoded;charset=GBK
Accept-Language: zh-CN,zh;q=0.8

cnum=0001&cid=cid224&serie_b=[2,2,3,4,5]

读取设备程序版本
POST /NCD_Server/deviceSoftInfo HTTP/1.1
Host: 116.62.108.201:8080
Connection: keep-alive
Content-Length: 1
Content-Type:application/x-www-form-urlencoded;charset=GBK
Accept-Language: zh-CN,zh;q=0.8

a