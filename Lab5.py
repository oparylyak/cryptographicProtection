"""Завдання 1.
1) запрограмувати тест простоти Міллера — Рабіна:
Вхідні дані: n>3, непарне натуральне число, яке потрібно перевірити на
простоту; k - кількість раундів.

Вихідні дані:  Чи є n складеним або простим числом.
Якщо просте, то з якою ймовірністю воно просте


Завдання 2

Реалізувати навчальну криптографічну систему з відкритим ключем RSA:
1) прості числа p i q згенерувати програмно,
використавши тест простоти Міллера — Рабіна

2) згенерувати відкритий і закритий ключі для шифрування та розшифрування.
Для пошуку закритого ключа скористатись розширеним алгоритмом Евкліда.

3) Завантажити скріни виконання програми (шифрування і розшифрування)"""

# 1) Task 1 ------------------------------------------
import random


def power(x, y, p):
    res = 1

    x = x % p
    while y > 0:

        if y & 1:
            res = (res * x) % p

        y = y >> 1
        x = (x * x) % p

    return res


def miiller_test(d, n):
    a = 2 + random.randint(1, n - 4)

    x = power(a, d, n)

    if x == 1 or x == n - 1:
        return True

    while d != n - 1:
        x = (x * x) % n
        d *= 2

        if x == 1:
            return False
        if x == n - 1:
            return True

    return False


def is_prime(n, k):
    if n <= 1 or n == 4:
        return False
    if n <= 3:
        return True

    d = n - 1
    while d % 2 == 0:
        d //= 2

    for i in range(k):
        if not miiller_test(d, n):
            return False

    return True


# Number of iterations
k = 6

print("1) All primes between 200 and 330: ")
for n in range(200, 330):
    if is_prime(n, k):
        print(n, end=" ")

# 2) Task 2 ------------------------------------------

print("\n\n2)")

class RSA:
    public_key: int
    private_key: int
    module: int

    def gcdex(self, a, b):
        if a == 0:
            return b, 0, 1

        gcd, x1, y1 = self.gcdex(b % a, a)

        x = y1 - (b // a) * x1
        y = x1

        return gcd, x, y

    def get_e(self, bottom, phi):
        e = random.randint(bottom, phi - 4)
        g, x, y = self.gcdex(e, phi)

        if g == 1:
            return e

        e = self.get_e(bottom, phi)
        return e

    def setup(self, p, q):
        self.module = p * q  # crypto system module
        phi = (p - 1) * (q - 1)  # Euler's  function for prime numbers
        self.private_key = self.get_e(p, phi)
        self.public_key = pow(self.private_key, -1, phi)

        # debug info, could be deleted
        print('RSA data: modul', self.module, 'phi', phi, 'private_key',
              self.private_key, 'public_key', self.public_key, "\n")

    def encrypt(self, msg):
        return pow(msg, self.private_key, self.module)

    def decrypt(self, msg):
        return pow(msg, self.public_key, self.module)


p = 223
q = 317
msg = 1997

rsa = RSA()
rsa.setup(p, q)

enc_msg = rsa.encrypt(msg)
dec_msg = rsa.decrypt(enc_msg)

print("Message ", msg, "encrypted as:", enc_msg)
print("Encrypted message ", enc_msg, "decrypted as:", dec_msg)