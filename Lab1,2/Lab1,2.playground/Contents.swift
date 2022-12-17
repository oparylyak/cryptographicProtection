import UIKit

/*
1) Програмно реалізувати матричний шифр  з  стовпцевим і рядковим ключами (див. слайд №12 лекції №2)
2) Програмно реалізувати  шифр для другого варіанту квадрата Полібія (див. слайд №22 лекції  №2)

Заскрінити результат шифрування і розшифрування на тестовому прикладі
 ASCII small letters 97 - a ... 122 - z, - - 45
*/

// 1) Task 1.
// Input data, could be changed
let message = "advanceddecriptionstandart" // 26 letters
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

let arrCryptoMessage = Array(cryptoMessage).map(String.init)

var cryptoMatrix = Array(repeating: Array(repeating: "+", count: colums), count: rows)

cryptoMatrix
var cryptoMsCounter = 0
for i in 0...colums-1 {
    for j in 0...rows-1 {
        if (i == 0 && j != 0) {
            cryptoMatrix[j][i] = sortedRowKey[j-1]
        } else if (j == 0 && i != 0) {
            cryptoMatrix[j][i] = sortedColumnKey[i-1]
        } else if (i != 0 && j != 0) {
            cryptoMatrix[j][i] = arrCryptoMessage[cryptoMsCounter]
            cryptoMsCounter += 1
        }
    }
}

cryptoMatrix

// Now we need just run permutation with inversed order firstly columnPermutation then rawPermutation


// perform column permutation
var cryptoMatrixAfterColumnPermutation = Array(repeating: Array(repeating: "*", count: colums), count: rows)

for i in 0...colums-1 {
    for j in 0...rows-1 {
        if i == 0 {
            cryptoMatrixAfterColumnPermutation[j][i] = cryptoMatrix[j][i]
        } else {
            if let indexOfColumn = sortedColumnKey.firstIndex(of: zeroRow[i-1]) {
                cryptoMatrixAfterColumnPermutation[j][i] = cryptoMatrix[j][indexOfColumn+1]
            }
        }
    }
}

cryptoMatrixAfterColumnPermutation


// perform row permutation
var cryptoMatrixAfterRowPermutation = [[String]]()
cryptoMatrixAfterRowPermutation.append(cryptoMatrixAfterColumnPermutation[0])

for i in 1...rows-1 {
    if let indexOfRow = sortedRowKey.firstIndex(of: zeroColumn[i-1]) {
        print(indexOfRow)
        cryptoMatrixAfterRowPermutation.append(cryptoMatrixAfterColumnPermutation[indexOfRow+1])
    }
}

cryptoMatrixAfterRowPermutation

// create message from matrix
var decriptedMessage = ""
for i in 1...colums-1 {
    for j in 1...rows-1 {
        decriptedMessage += cryptoMatrixAfterRowPermutation[j][i]
    }
}

decriptedMessage
// TODO: move permutation and other dublicated code in functions with params

func additional(val: Int) -> Int {
    return val + 2
}

// end of temporary comented code from task 1

// 2) Task 2.
// Input data, could be changed

let alphabetMatrix = [
    ["a","b","c","d","e"],  //0
    ["f","g","h","i","j"],  //1
    ["k","l","m","n","o"],  //2
    ["p","q","r","s","t"],  //3
    ["u","v","w","x","y"]   //4
]   //0   1   2   3   4
let rowsP = 5
let columnsP = 5

let msg = "victory".replacingOccurrences(of: "z", with: "s") // temporary fix to work with square matrix
let arrMsg = Array(msg).map(String.init)

// find coordinates of every letter in word
var coordinatesOfWord = [[Int]]()

for i in 0...msg.count-1 {
    for j in 0...rowsP-1 {
        if let characterCord = alphabetMatrix[j].firstIndex(of: arrMsg[i]){
            coordinatesOfWord.append([j,characterCord])
        }
    }
}

coordinatesOfWord

// write encrypted sequence
var encryptedSeq = [Int]()
for i in 0...1 {
    for j in 0...coordinatesOfWord.count - 1 {
        encryptedSeq.append(coordinatesOfWord[j][i])
    }
}

encryptedSeq

// find encrypted message
var encryptedMsg = ""

var encIndex = 0
while encIndex <= encryptedSeq.count-1 {
    let row = encryptedSeq[encIndex]
    let column = encryptedSeq[encIndex+1]
    encryptedMsg += alphabetMatrix[row][column]
    encIndex += 2
}

encryptedMsg

// Start decription process
// to perform decription we need perform same steps in opposite way

let arrEncMsg = Array(encryptedMsg).map(String.init)

var coordinatesOfEncryptedLetters = [Int]()

for i in 0...encryptedMsg.count-1 {
    for j in 0...rowsP-1 {
        if let characterCord = alphabetMatrix[j].firstIndex(of: arrEncMsg[i]){
            coordinatesOfEncryptedLetters.append(j)
            coordinatesOfEncryptedLetters.append(characterCord)
        }
    }
}

coordinatesOfEncryptedLetters

// create arr of correct cordinates in correct order
var decryptedSeq = [Int]()
let halfOfArrayCoordinate = (coordinatesOfEncryptedLetters.count/2)

for i in 0...halfOfArrayCoordinate-1 {
    let correctRow = coordinatesOfEncryptedLetters[i]
    let correctColumn = coordinatesOfEncryptedLetters[i+halfOfArrayCoordinate]
    decryptedSeq.append(correctRow)
    decryptedSeq.append(correctColumn)
}

decryptedSeq

var decryptedMsg = ""

var decIndex = 0
while decIndex <= decryptedSeq.count-1 {
    let row = decryptedSeq[decIndex]
    let column = decryptedSeq[decIndex+1]
    decryptedMsg += alphabetMatrix[row][column]
    decIndex += 2
}

decryptedMsg
