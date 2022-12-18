"""
Реалізувати у вигляді функцій mul02 і mul03 множення довільного байту
на елементи (байти) 02 і 03 над полем Галуа GF (2^8) за модулем
m(x) = x^8 + x^4 + x^3 + x + 1,
використавши методику зсуву бітів і операцію ХОR (малюнки 2-4)

Протестувати на прикладах: D4 * 02 = B3, BF * 03 = DA

Зауваження:
1) 02 = x, 03 = x + 1
2) Множення на 03 зводиться до множення на 02:   BF * 03 = BF * (02+01) = BF * 02 + BF.
"""


def hex_to_decimal(hex_str):
    return int(hex_str, 16)


def decimal_to_hex(decimal):
    return hex(decimal)


def hex_to_binary(hex_str):
    # return bin(int(hex_str, 16)).zfill(8)
    return "{0:08b}".format(int(hex_str, 16))


def binary_to_hex(binary_str):
    return hex(int(binary_str, 2))


def mul02(hex_value):
    binary = hex_to_binary(hex_value)
    decimal_value = hex_to_decimal(hex_value)

    if binary[0] == "0":
        shifted_decimal = decimal_value << 1
        result = decimal_to_hex(shifted_decimal)
        return result

    shifted_decimal = decimal_value << 1
    xored_decimal = shifted_decimal ^ 27   # XOR 00011011
    result = decimal_to_hex(xored_decimal)
    return result


def mul03(hex_value):
    decimal_val = hex_to_decimal(hex_value)
    value_mul2 = mul02(hex_value)
    decimal_mul2 = hex_to_decimal(str(value_mul2))
    decimal_res = decimal_mul2 ^ decimal_val    # BF * 02 + BF.

    return decimal_to_hex(decimal_res)


hex2 = "D4"  # use mul02
hex3 = "BF"  # use mul03

print("D4 * 02 = ", mul02(hex2))
print("BF * 03 = ", mul03(hex3))
