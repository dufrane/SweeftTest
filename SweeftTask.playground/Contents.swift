import Foundation

//1. Write a function to which the text is passed and returns a palindrome or not. (Palindrome is a text that is read alike on both sides).
//
//Boolean isPalindrome (String text);
//

func isPalindrome(text: String) -> Bool {
    return String(text.reversed()) == text
}

//func isPalindrome(text: String) -> Bool {
//    let lowercased = text.lowercased()
//    return String(lowercased.reversed()) == lowercased
//}

isPalindrome(text: "woow")
isPalindrome(text: "Glory to Ukraine")


//2. We have 1,5,10,20 and 50 tetri coins. Write a function to which the amount is transferred (in white) and returns the minimum number of coins with which we can close this amount.
//
//Int minSplit (Int amount);
//

func minSplit(amount: Int) -> Int {
    var counter = 0
    var sum = amount
    let tetris = [50, 20, 10, 5, 1]
    
    if sum > 0 {
        for tetri in tetris {
            while(sum >= tetri) {
                sum -= tetri
                counter += 1
            }
        }
    } else {
        print ("you don't have a money")
    }
    return counter
}

minSplit(amount: 10)

//3. An array consisting of integers is given. Write a function to which this array is passed and returns the minimum integer that is greater than 0 and is not included in this array.
//
//Int notContains (Int [] array);
//

func notContains(array: [Int]) -> Int {
    var maxNumber = 0
    
    if let max = array.max() {
        maxNumber = max
    }
    let set1 = Set(array)
    let set2 = Set(1...maxNumber)
    
    let notContain = set2.subtracting(set1)
    let sortedNotContain = Array(notContain.sorted())
    
    return sortedNotContain[0]
}

let arr = [10, 9, 3, 8, 6, 2, 4, 5, -7, 0]

notContains(array: arr)

//4. A String consisting of "(" and ")" elements is given. Write a function that returns parentheses to see if they are mathematically correct.
//
//Boolean isProperly (String sequence);
//
//For example: (() ()) is the correct sequence, ()) () is incorrect
//


func isProperly(sequence: String) -> Bool {
    let formattedString = sequence.replacingOccurrences(of: " ", with: "")
    
    let pairs: [Character: Character] = ["(" : ")"]
    var stack: [Character] = []
    for char in formattedString {
        if let match = pairs[char] {
            stack.append(match)
        } else if stack.last == char {
            stack.popLast()
        } else {
            return false
        }
    }
    return stack.isEmpty
}

let str = "((() ()) (()()))"
let str2 = "((() ()) (()())))"
isProperly(sequence: str)

//5. We have n floor stairs, in one action we can climb 1 or 2 steps. Write a function that counts the number of options for climbing n floors.
//
//Int countVariants (Int stearsCount);
//

func countVariants(stearsCount: Int) -> Int {
    var x = 1
    var y = 1
    
    if stearsCount < 1 {
        return 0
    } else if stearsCount < 2 {
        return 1
    } else{
        for _ in 2...stearsCount {
            y = x + y
            x = y - x
        }
        return y
    }
}

countVariants(stearsCount: 7)

//6. Write your own data structure that will allow you to delete an item in O (1) time.

struct Queue<T> {
    var elements: [T] = []
    
    var head: T? {
        return elements.first
    }
    
    var tail: T? {
        return elements.last
    }
    
    mutating func enqueue(_ value: T) {
        elements.append(value)
    }
    
    mutating func dequeue() -> T? {
        guard !elements.isEmpty else {
            return nil
        }
        return elements.removeFirst()
    }
}

var queue = Queue<String>()

queue.enqueue("A")
queue.enqueue("B")
queue.enqueue("C")

//Before dequeue

//print("head", queue.head ?? "")
//print("tail", queue.tail ?? "")

//After dequeue

//queue.dequeue()
//print("head", queue.head ?? "")
//print("tail", queue.tail ?? "")


//Linked List

class Node<T> {
    var value: T
    var next: Node?
    
    init(value: T, next: Node? = nil) {
        self.value = value
        self.next = next
    }
}

struct LinkedList<T> {
    
    var head: Node<T>?
    var tail: Node<T>?
    
    init() {}
    
    var isEmpty: Bool {
        head == nil
    }
}

extension LinkedList: CustomStringConvertible {
    var description: String {
        guard let head = head else {
            return "Empty list"
        }
        return String(describing: head)
    }
    
    mutating func push(_ value: T) {
        head = Node(value: value, next: head)
        if tail == nil {
            tail = head
        }
    }
    
    mutating func append(_ value: T) {
        guard !isEmpty else {
            push(value)
            return
        }
        tail!.next = Node(value: value)
        tail = tail!.next
    }
    
    mutating func pop() -> T? {
        defer {
            head = head?.next
            if isEmpty {
                tail = nil
            }
        }
        return head?.value
    }
}

extension Node: CustomStringConvertible {
    var description: String {
        guard let next = next else {
            return "\(value)"
        }
        return "\(value) -> " + String(describing: next) + " "
    }
}

var list = LinkedList<String>()
list.push("A")
list.push("B")
list.push("C")

//print("Before popping list: \(list)")
//let poppedValue = list.pop()
//print("After popping list: \(list)")
//print("Popped value: " + String(describing: poppedValue))
