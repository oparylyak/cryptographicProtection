import UIKit

/*
1) Програмно реалізувати матричний шифр  з  стовпцевим і рядковим ключами (див. слайд №12 лекції №2)
2) Програмно реалізувати  шифр для другого варіанту квадрата Полібія (див. слайд №22 лекції  №2)

Заскрінити результат шифрування і розшифрування на тестовому прикладі
 ASCII small letters 97 - a ... 122 - z, - - 45
*/

// 1) Task 1.
// Input data, could be changed
let message = "advancedencriptionstandart" // 26 letters
print(message.count)
let rowKeyWord = "crypto" // 6 letters
let columnKeyWord = "world" // 5 letters

let rows = rowKeyWord.count + 1
let colums = columnKeyWord.count + 1
var startMatrix = Array(repeating: Array(repeating: "-", count: colums), count: rows)

let zeroRow = Array(columnKeyWord).map(String.init)
let zeroColumn = Array(rowKeyWord).map(String.init)
let arrMessage = Array(message).map(String.init)

for i in 1...colums-1 {
    startMatrix[0][i] = zeroRow[i-1]
}
for i in 1...rows-1 {
    startMatrix[i][0] = zeroColumn[i-1]
}

startMatrix

var messageLetter = 0
for i in 1...colums-1 {
    for j in 1...rows-1 {
        if messageLetter < arrMessage.count {
            startMatrix[j][i] = arrMessage[messageLetter]
            messageLetter += 1
        } else {
            break
        }
    }
}

// Build matrix with keywoeds and message

startMatrix

// sort keys to use it during permutation
let sortedRowKey = zeroColumn.sorted()
let sortedColumnKey = zeroRow.sorted()

// perform row permutation
var matrixAfterRowPermutation = [[String]]()
matrixAfterRowPermutation.append(startMatrix[0])

for i in 1...rows-1 {
    if let indexOfRow = zeroColumn.firstIndex(of: sortedRowKey[i-1]) {
        print(indexOfRow)
        matrixAfterRowPermutation.append(startMatrix[indexOfRow+1])
    }
}

matrixAfterRowPermutation

// perform column permutation
var matrixAfterColumnPermutation = Array(repeating: Array(repeating: "*", count: colums), count: rows)

for i in 0...colums-1 {
    for j in 0...rows-1 {
        if i == 0 {
            matrixAfterColumnPermutation[j][i] = matrixAfterRowPermutation[j][i]
        } else {
            if let indexOfColumn = zeroRow.firstIndex(of: sortedColumnKey[i-1]) {
                matrixAfterColumnPermutation[j][i] = matrixAfterRowPermutation[j][indexOfColumn+1]
            }
        }
    }
}

matrixAfterColumnPermutation

// create crypto message from matrix
var cryptoMessage = ""
for i in 1...colums-1 {
    for j in 1...rows-1 {
        cryptoMessage += matrixAfterColumnPermutation[j][i]
    }
}

cryptoMessage


// Decrypting process
// To decrypt we need to build matrix with encrypted message and column, rows permutated keys










func additional(val: Int) -> Int {
    return val + 2
}

