hex()#
转换一个整数对象为十六进制的字符串

Copy
>>> hex(16)
'0x10'
>>> hex(18)
'0x12'
>>> hex(32)
'0x20'
>>> 
oct()#
转换一个整数对象为八进制的字符串

Copy
>>> oct(8)
'0o10'
>>> oct(166)
'0o246'
>>> 
bin()#
转换一个整数对象为二进制字符串

Copy
>>> bin(10)
'0b1010'
>>> bin(255)
'0b11111111'
>>> 
chr()#
转换一个[0, 255]之间的整数为对应的ASCII字符

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
将一个ASCII字符转换为对应整数

Copy
>>> ord('A')
65
>>> ord('z')
122
>>>
写一个ASCII和十六进制转换器#
上面我们知道hex()可以将一个10进制整数转换为16进制数。而16进制转换为10进制数可以用int('0x10', 16) 或者int('10', 16)

Copy
16进制转10进制
>>> int('10', 16)
16
>>> int('0x10', 16)
16

8进制转10进制
>>> int('0o10', 8)
8
>>> int('10', 8)
8

2进制转10进制
>>> int('0b1010', 2)
10
>>> int('1010', 2)
10
代码如下:

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

# 等宽为2的16进制字符串列表也可以如下表示
import textwrap
s = "48656c6c6f20576f726c6421"
res = textwrap.fill(s, width=2)
print(res.split())  #['48', '65', '6c', '6c', '6f', '20', '57', '6f', '72', '6c', '64', '21']
生成随机4位数字+字母的验证码#
可以利用random模块加上chr函数实现随机验证码生成。

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
其它进制转换操作#
Copy
把整数格式化为2位的16进制字符串，高位用零占位
>>> '{:02x}'.format(9)
>>> '09'

把整数格式化为2位的16进制字符串，高位用空占位
>>> '{:2x}'.format(9)
>>> ' 9'

把整数格式化为2位的16进制字符串
>>> '{:x}'.format(9)
>>> '9'

把整数格式化为2位的8进制字符串，高位用空占位
>>> '{:2o}'.format(9)
>>> '11'

把整数格式化为2位的8进制数字符串，高位用空占位
>>> '{:2o}'.format(6)
>>> ' 6'

把整数格式化为2位的8进制字符串，高位用零占位
>>> '{:02o}'.format(6)
>>> '06'

把整数格式化为8位的2进制字符串，高位用零占位
>>> '{:08b}'.format(73)
>>> '01001001'

把整数格式化为2进制字符串
>>> '{:b}'.format(73)
>>> '1001001'

把整数格式化为8位的2进制字符串，高位用空占位
>>> '{:8b}'.format(73)
>>> ' 1001001'
程序猿(二进制)的浪漫#
哈哈听说过程序猿的浪漫么，下面将ASCII字符'I love you'转换为二进制，请将这些二进制发给你喜欢的人吧，看看who understands you

Copy
def asi_to_bin(s):
    list_h = []
    for c in s:
        list_h.append('{:08b}'.format(ord(c)))	# 每一个都限制为8位二进制(0-255)字符串
    return ' '.join(list_h)

print(asi_to_bin("I love you"))

# 01001001001000000110110001101111011101100110010100100000011110010110111101110101
# 01001001 00100000 01101100 01101111 01110110 01100101 00100000 01111001 01101111 01110101
python实现IP地址转换为32位二进制#
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
python 判断两个ip地址是否属于同一子网#
Copy
"""
判断两个IP是否属于同一子网, 需要判断网络地址是否相同
网络地址：IP地址的二进制与子网掩码的二进制地址逻辑“与”得到
主机地址: IP地址的二进制与子网掩码的二进制取反地址逻辑“与”得到
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