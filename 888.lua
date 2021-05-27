hex()#
ת��һ����������Ϊʮ�����Ƶ��ַ���

Copy
>>> hex(16)
'0x10'
>>> hex(18)
'0x12'
>>> hex(32)
'0x20'
>>> 
oct()#
ת��һ����������Ϊ�˽��Ƶ��ַ���

Copy
>>> oct(8)
'0o10'
>>> oct(166)
'0o246'
>>> 
bin()#
ת��һ����������Ϊ�������ַ���

Copy
>>> bin(10)
'0b1010'
>>> bin(255)
'0b11111111'
>>> 
chr()#
ת��һ��[0, 255]֮�������Ϊ��Ӧ��ASCII�ַ�

Copy
>>> chr(65)
'A'
>>> chr(67)
'C'
>>> chr(90)
'Z'
>>> chr(97)
'a'
>>> 
ord()#
��һ��ASCII�ַ�ת��Ϊ��Ӧ����

Copy
>>> ord('A')
65
>>> ord('z')
122
>>>
дһ��ASCII��ʮ������ת����#
��������֪��hex()���Խ�һ��10��������ת��Ϊ16����������16����ת��Ϊ10������������int('0x10', 16) ����int('10', 16)

Copy
16����ת10����
>>> int('10', 16)
16
>>> int('0x10', 16)
16

8����ת10����
>>> int('0o10', 8)
8
>>> int('10', 8)
8

2����ת10����
>>> int('0b1010', 2)
10
>>> int('1010', 2)
10
��������:

Copy
class Converter(object):
    @staticmethod
    def to_ascii(h):
        list_s = []
        for i in range(0, len(h), 2):
            list_s.append(chr(int(h[i:i+2], 16)))
        return ''.join(list_s)

    @staticmethod
    def to_hex(s):
        list_h = []
        for c in s:
            list_h.append(str(hex(ord(c))[2:]))
        return ''.join(list_h)


print(Converter.to_hex("Hello World!"))
print(Converter.to_ascii("48656c6c6f20576f726c6421"))

# �ȿ�Ϊ2��16�����ַ����б�Ҳ�������±�ʾ
import textwrap
s = "48656c6c6f20576f726c6421"
res = textwrap.fill(s, width=2)
print(res.split())  #['48', '65', '6c', '6c', '6f', '20', '57', '6f', '72', '6c', '64', '21']
�������4λ����+��ĸ����֤��#
��������randomģ�����chr����ʵ�������֤�����ɡ�

Copy
import random


def verfi_code(n):
    res_li = list()
    for i in range(n):
        char = random.choice([chr(random.randint(65, 90)), chr(
            random.randint(97, 122)), str(random.randint(0, 9))])
        res_li.append(char)
    return ''.join(res_li)

print(verfi_code(6))
��������ת������#
Copy
��������ʽ��Ϊ2λ��16�����ַ�������λ����ռλ
>>> '{:02x}'.format(9)
>>> '09'

��������ʽ��Ϊ2λ��16�����ַ�������λ�ÿ�ռλ
>>> '{:2x}'.format(9)
>>> ' 9'

��������ʽ��Ϊ2λ��16�����ַ���
>>> '{:x}'.format(9)
>>> '9'

��������ʽ��Ϊ2λ��8�����ַ�������λ�ÿ�ռλ
>>> '{:2o}'.format(9)
>>> '11'

��������ʽ��Ϊ2λ��8�������ַ�������λ�ÿ�ռλ
>>> '{:2o}'.format(6)
>>> ' 6'

��������ʽ��Ϊ2λ��8�����ַ�������λ����ռλ
>>> '{:02o}'.format(6)
>>> '06'

��������ʽ��Ϊ8λ��2�����ַ�������λ����ռλ
>>> '{:08b}'.format(73)
>>> '01001001'

��������ʽ��Ϊ2�����ַ���
>>> '{:b}'.format(73)
>>> '1001001'

��������ʽ��Ϊ8λ��2�����ַ�������λ�ÿ�ռλ
>>> '{:8b}'.format(73)
>>> ' 1001001'
����Գ(������)������#
������˵������Գ������ô�����潫ASCII�ַ�'I love you'ת��Ϊ�����ƣ��뽫��Щ�����Ʒ�����ϲ�����˰ɣ�����who understands you

Copy
def asi_to_bin(s):
    list_h = []
    for c in s:
        list_h.append('{:08b}'.format(ord(c)))	# ÿһ��������Ϊ8λ������(0-255)�ַ���
    return ' '.join(list_h)

print(asi_to_bin("I love you"))

# 01001001001000000110110001101111011101100110010100100000011110010110111101110101
# 01001001 00100000 01101100 01101111 01110110 01100101 00100000 01111001 01101111 01110101
pythonʵ��IP��ַת��Ϊ32λ������#
Copy
#!/usr/bin/env python
# -*- coding:utf-8 -*-


class IpAddrConverter(object):

    def __init__(self, ip_addr):
        self.ip_addr = ip_addr

    @staticmethod
    def _get_bin(target):
        if not target.isdigit():
            raise Exception('bad ip address')
        target = int(target)
        assert target < 256, 'bad ip address'
        res = ''
        temp = target
        for t in range(8):
            a, b = divmod(temp, 2)
            temp = a
            res += str(b)
            if temp == 0:
                res += '0' * (7 - t)
                break
        return res[::-1]

    def to_32_bin(self):
        temp_list = self.ip_addr.split('.')
        assert len(temp_list) == 4, 'bad ip address'
        return ''.join(list(map(self._get_bin, temp_list)))


if __name__ == '__main__':
    ip = IpAddrConverter("192.168.25.68")
    print(ip.to_32_bin())
python �ж�����ip��ַ�Ƿ�����ͬһ����#
Copy
"""
�ж�����IP�Ƿ�����ͬһ����, ��Ҫ�ж������ַ�Ƿ���ͬ
�����ַ��IP��ַ�Ķ���������������Ķ����Ƶ�ַ�߼����롱�õ�
������ַ: IP��ַ�Ķ���������������Ķ�����ȡ����ַ�߼����롱�õ�
"""


class IpAddrConverter(object):

    def __init__(self, ip_addr, net_mask):
        self.ip_addr = ip_addr
        self.net_mask = net_mask

    @staticmethod
    def _get_bin(target):
        if not target.isdigit():
            raise Exception('bad ip address')
        target = int(target)
        assert target < 256, 'bad ip address'
        res = ''
        temp = target
        for t in range(8):
            a, b = divmod(temp, 2)
            temp = a
            res += str(b)
            if temp == 0:
                res += '0' * (7 - t)
                break
        return res[::-1]

    def _to_32_bin(self, ip_address):
        temp_list = ip_address.split('.')
        assert len(temp_list) == 4, 'bad ip address'
        return ''.join(list(map(self._get_bin, temp_list)))

    @property
    def ip_32_bin(self):
        return self._to_32_bin(self.ip_addr)

    @property
    def mask_32_bin(self):
        return self._to_32_bin(self.net_mask)

    @property
    def net_address(self):
        ip_list = self.ip_addr.split('.')
        mask_list = self.net_mask.split('.')
        and_result_list = list(map(lambda x: str(int(x[0]) & int(x[1])), list(zip(ip_list, mask_list))))
        return '.'.join(and_result_list)

    @property
    def host_address(self):
        ip_list = self.ip_addr.split('.')
        mask_list = self.net_mask.split('.')
        rever_mask = list(map(lambda x: abs(255 - int(x)), mask_list))
        and_result_list = list(map(lambda x: str(int(x[0]) & int(x[1])), list(zip(ip_list, rever_mask))))
        return '.'.join(and_result_list)


if __name__ == '__main__':
    ip01 = IpAddrConverter("211.95.165.24", "255.255.254.0")
    ip02 = IpAddrConverter("211.95.164.78", "255.255.254.0")
    print(ip01.net_address == ip02.net_address)