"""
1. Реалізувати у вигляді функції gcdex(a,b) ітераційний розширений алгоритм Евкліда пошуку трійки (d,x,y), де ax+by = d.
Протестити на прикладі  a= 612 і b=342.

2. Реалізувати у вигляді функції inverse_element(a,n) пошук розв'язку рівняння ax=1 (mod n),
тобто знаходження мультиплікативноо оберненого елемента a^(-1) по модулю n, використовуючи gcdex(a,b).
Протестити на прикладі  a= 5 і  n=18.

3. Реалізувати у вигляді функції phi(m) обчислення значення функції Ейлера для заданого m
(https://en.wikipedia.org/wiki/Euler%27s_totient_function)

4. Реалізувати у вигляді функції inverse_element_2(a,p) знаходження мультиплікативного оберненого елемента a^(-1)
по модулю числа n, використовуючи інший спосіб (теорему Ейлера або малу теорему Ферма у випадку простого числа n=p).
Протестити на прикладі  a= 5 і  n=18.

Протестувати роботу функцій та заскрінити.
"""

#1)
def gcdex(a, b):
    if a == 0:
        return b, 0, 1

    gcd, x1, y1 = gcdex(b % a, a)

    x = y1 - (b // a) * x1
    y = x1

    return gcd, x, y

a, b = 612, 342
g, x, y = gcdex(a, b)
print("1) gcdex(", a, ",", b, ") = ", g)

#2) -----------------------------------------
def inverse_element(a,n):
    g, x, y = gcdex(a, n)
    return x

# | a= 5, n = 18, g=1, x = -7, y = 2
# | Ax+Ny = GCD, 5*(-7) + 18*2 = 1
# | Ax mod n = 1, 5*(-7) mod 18 = 1 | inverse_el = x
a, n = 5, 18
inverse_el = inverse_element(a,n)
print("2.1) check is inverse element correct:", a*inverse_el%n == 1)
print("2.2) inverse element(",a ,"," ,n, ") :", inverse_el)

#3) -----------------------------------------
#
def phi(n):
    result: int = 1
    for i in range(2, n):
        g,x,y = gcdex(i, n)
        if ( g == 1):
            result += 1
    return result

n = 9
print("3) phi(",n,") = ",phi(n), sep = "")

#4) -----------------------------------------
# a and n coprime positive integers, a^ phi(n) = 1 (mod m)
# a ^ (phi(n) -1) mod n = a ^ (-1) mod n
a, n = 5, 18
def inverse_element_2(a,n):
    return pow(a, phi(n)-1, n)
in_el_2 = inverse_element_2(a, n)
print("4.1) check is inverse element correct:", a*in_el_2 %n == 1, pow(a, phi(n), n) == 1)
print("4.2) inverse element(",a ,"," ,n, ") :", in_el_2 )