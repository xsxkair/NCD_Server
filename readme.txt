�豸�ϴ�
POST /NCD_Server/up_device HTTP/1.1
Host: 116.62.108.201:8080
Connection: keep-alive
Content-Length: 20
Content-Type:application/x-www-form-urlencoded;charset=GBK
Accept-Language: zh-CN,zh;q=0.8

did=did223&name=����

��ȡʱ��
POST /NCD_Server/up_dtime HTTP/1.1
Host: 116.62.108.201:8080
Connection: keep-alive
Content-Length: 10
Content-Type:application/x-www-form-urlencoded;charset=GBK
Accept-Language: zh-CN,zh;q=0.8

did=did223

�ϴ��Ի���
POST /NCD_Server/up_card HTTP/1.1
Host: 116.62.108.201:8080
Connection: keep-alive
Content-Length: 19
Content-Type:application/x-www-form-urlencoded;charset=GBK
Accept-Language: zh-CN,zh;q=0.8

cid=cid224&item=myo

�ϴ���������
POST /NCD_Server/up_testdata HTTP/1.1
Host: 116.62.108.201:8080
Connection: keep-alive
Content-Length: 30
Content-Type:application/x-www-form-urlencoded;charset=GBK
Accept-Language: zh-CN,zh;q=0.8

cnum=0001&cid=cid223&did=did223

�ϴ�����
POST /NCD_Server/up_series HTTP/1.1
Host: 116.62.108.201:8080
Connection: keep-alive
Content-Length: 40
Content-Type:application/x-www-form-urlencoded;charset=GBK
Accept-Language: zh-CN,zh;q=0.8

cnum=0001&cid=cid224&serie_b=[2,2,3,4,5]

��ȡ�豸����汾
POST /NCD_Server/deviceSoftInfo HTTP/1.1
Host: 116.62.108.201:8080
Connection: keep-alive
Content-Length: 1
Content-Type:application/x-www-form-urlencoded;charset=GBK
Accept-Language: zh-CN,zh;q=0.8

a