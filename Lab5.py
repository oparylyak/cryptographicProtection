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

print("All primes smaller than 100: ")
for n in range(1, 100):
    if (is_prime(n, k)):
        print(n, end=" ")

