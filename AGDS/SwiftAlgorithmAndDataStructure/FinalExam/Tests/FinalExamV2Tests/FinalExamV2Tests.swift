import XCTest
@testable import FinalExamV2

final class FinalExamV2Tests: XCTestCase {
  let testTree1: BinaryNode<Int> = {
    let rootNode = BinaryNode<Int>(value: 1)
    let node1 = BinaryNode<Int>(value: 4)
    let node2 = BinaryNode<Int>(value: 5)
    let node3 = BinaryNode<Int>(value: 2)
    let node4 = BinaryNode<Int>(value: 6)
    let node5 = BinaryNode<Int>(value: 7)
    
    rootNode.leftChild = node1
    rootNode.rightChild = node2
    node1.leftChild = node3
    node2.leftChild = node4
    node2.rightChild = node5
    return rootNode
  }()
  
  let testArray1: [Int?] = [1, 4, 2, nil, nil, nil, 5, 6, nil, nil, 7, nil, nil]
  
  let testTree2: BinaryNode<Int> = {
    let rootNode = BinaryNode<Int>(value: 7)
    let node1 = BinaryNode<Int>(value: 1)
    let node2 = BinaryNode<Int>(value: 9)
    let node3 = BinaryNode<Int>(value: 0)
    let node4 = BinaryNode<Int>(value: 5)
    let node5 = BinaryNode<Int>(value: 8)
    
    rootNode.leftChild = node1
    rootNode.rightChild = node2
    node1.leftChild = node3
    node1.rightChild = node4
    node2.leftChild = node5
    node2.rightChild = nil
    return rootNode
  }()
  
  let testArray2: [Int?] = [7, 1, 0, nil, nil, 5, nil, nil, 9, 8, nil, nil, nil]
  
  func testSerializeTree1() {
    let serializedTree = serialize(testTree1)
    XCTAssertEqual(serializedTree, testArray1)
  }
  
  func testSerializeTree2() {
    let serializedTree = serialize(testTree2)
    XCTAssertEqual(serializedTree, testArray2)
  }
  
  func testDeserializeArray1() {
    var arr = Array(testArray1.reversed())
    let deserializedArray = deserialize(&arr)
    XCTAssertEqual(deserializedArray?.description, testTree1.description)
  }
  
  func testDeserializeArray2() {
    var arr = Array(testArray2.reversed())
    let deserializedArray = deserialize(&arr)
    XCTAssertEqual(deserializedArray?.description, testTree2.description)
  }
  
  static var allTests = [
    ("testSerializeTree1", testSerializeTree1),
    ("testSerializeTree2", testSerializeTree2),
    ("testDeserializeArray1", testDeserializeArray1),
    ("testDeserializeArray2", testDeserializeArray2),
  ]
}
