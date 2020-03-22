//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

// 寻找 100 以内同时满足是偶数并且是其他数字的平方的数
(1 ... 10).map { $0 * $0 }.filter { $0 % 2 == 0 }


// Set 
let mySet: Set<Int> = [1,2,2]


// Dictonary
extension Dictionary {
    mutating func merge2<S: SequenceType where S.Generator.Element == (Key,Value)>(other: S) {
        for (k, v) in other {
            self[k] = v
        }
    }
}


// Generator 
protocol GeneratorType {
    associatedtype Element
    mutating func next() -> Element?
}
class ConstantGenerator: GeneratorType {
    func next() -> Int? {
        return 1
    }
}
let a = ConstantGenerator().next()


// 
struct File {
    let path: String
    
    private var cachedSize: Int?
    mutating func cachedComputeSize() -> Int? {
        guard cachedSize == nil else { return cachedSize }
        let fm = NSFileManager.defaultManager()
        guard let dict = try? fm.attributesOfItemAtPath(self.path), let size = dict["NSFileSize"] as? Int else {
            return nil
        }
        cachedSize = size
        return size
    }
}



// Regex 
struct Regex {
    private let regexp: String
    
    init(_ regexp: String) {
        self.regexp = regexp
    }
}
extension Regex {
    func match(text: String) -> Bool {
        if regexp.characters.first == "^" {
            return Regex.matchHere(regexp.characters, text.characters)
        }
        return true
    }
}
extension Regex {
    private static func matchHere(regexp: String.CharacterView, _ text: String.CharacterView) -> Bool {
        return true
    }
}


// Error 
enum Result<A> {
    case Failure(ErrorType)
    case Success(A)
}


// 
extension CollectionType where Generator.Element: Hashable {
    func substract(toRemove: [Generator.Element]) -> [Generator.Element] {
        let removeSet = Set(toRemove)
        return self.filter { !removeSet.contains($0) }
    }
}
let old = [1,2,3]
let oldSet = Set(old)
















