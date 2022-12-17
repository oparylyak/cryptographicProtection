import UIKit

/*
 1. Реалізувати у вигляді функції gcdex(a,b) ітераційний розширений алгоритм Евкліда пошуку трійки (d,x,y), де ax+by = d. Протестити на прикладі  a= 612 і b=342.
 
 2. Реалізувати у вигляді функції inverse_element(a,n) пошук розв'язку рівняння ax=1 (mod n), тобто знаходження мультиплікативноо оберненого елемента a^(-1) по модулю n, використовуючи gcdex(a,b).  Протестити на прикладі  a= 5 і  n=18.
 
 3. Реалізувати у вигляді функції phi(m) обчислення значення функції Ейлера для заданого m (https://en.wikipedia.org/wiki/Euler%27s_totient_function)
 
 
 4. Реалізувати у вигляді функції inverse_element_2(a,p) знаходження мультиплікативного оберненого елемента a^(-1) по модулю числа n, використовуючи інший спосіб (теорему Ейлера або малу теорему Ферма у випадку простого числа n=p). Протестити на прикладі  a= 5 і  n=18.
 
 Протестувати роботу функцій та заскрінити.
 */


func gcdex(a: Double, b: Double) -> (gcd:Double, x:Double, y:Double) {
    if (a==0) {
        return (b,0,1)
    }
    var computedSet = gcdex(a: (b/a).truncatingRemainder(dividingBy: 1), b: a)

    var x1 = computedSet.x
    var y1 = computedSet.y

    var gcd1 = computedSet.gcd

    // Update x and y using results of recursive

    var x = y1 - floor(b/a) * x1
    var y = x1

    return (gcd1,x,y)
}

print(gcdex(a: 35, b: 15))
