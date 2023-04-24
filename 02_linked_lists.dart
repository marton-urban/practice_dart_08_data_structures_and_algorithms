// push O(1)
// append O(1)
// insertAfter O(1)
// nodeAt O(i)

// pop O(1)
// removeLast O(n)
// removeAfter O(1)
class Node<T> {
  Node({required this.value, this.next});

  T value;
  Node<T>? next;

  @override
  String toString() {
    if (next == null) return '$value';
    return '$value -> ${next.toString()}';
  }
}

class LinkedList<E> extends Iterable<E> {
  Node<E>? head;
  Node<E>? tail;

  void push(E value) {
    head = Node(value: value, next: head);
    tail ??= head;
  }

  void append(E value) {
    if (isEmpty) {
      push(value);
    } else {
      tail!.next = Node(value: value);
      tail = tail!.next;
    }
  }

  Node<E>? nodeAt(int index) {
    var currentNode = head;
    var currentIndex = 0;
    while (currentNode != null && currentIndex < index) {
      currentNode = currentNode.next;
      currentIndex++;
    }
    return currentNode;
  }

  Node<E> insertAfter(Node<E> node, E value) {
    if (tail == node) {
      append(value);
      return tail!;
    }
    node.next = Node(value: value, next: node.next);
    return node.next!;
  }

  E? pop() {
    final value = head?.value;
    head = head?.next;
    if (isEmpty) {
      tail = null;
    }
    return value;
  }

  E? removeLast() {
    if (head?.next == null) return pop();

    var current = head;
    while (current!.next != tail) {
      current = current.next;
    }

    final value = tail?.value;
    tail = current;
    tail?.next = null;
    return value;
  }

  E? removeAfter(Node<E> node) {
    final value = node.next?.value;
    if (node.next == tail) {
      tail = node;
    }
    node.next = node.next?.next;
    return value;
  }

  @override
  bool get isEmpty => head == null;

  @override
  Iterator<E> get iterator => _LinkedListIterator(this);

  @override
  String toString() {
    if (isEmpty) return 'Empty list';
    return head.toString();
  }
}

class _LinkedListIterator<E> implements Iterator<E> {
  _LinkedListIterator(this._list);

  final LinkedList<E> _list;
  Node<E>? _currentNode;

  @override
  E get current => _currentNode!.value;

  bool _firstPass = true;

  @override
  bool moveNext() {
    if (_list.isEmpty) return false;

    if (_firstPass) {
      _currentNode = _list.head;
      _firstPass = false;
    } else {
      _currentNode = _currentNode?.next;
    }

    return _currentNode != null;
  }
}

void insertAfterExample() {
  final list = LinkedList<int>();
  list.push(3);
  list.push(2);
  list.push(1);

  print('Before: $list');

  var middleNode = list.nodeAt(1)!;
  list.insertAfter(middleNode, 42);

  print('After:  $list');
}

void makingListIterable() {
  final list = LinkedList<int>();
  list.push(3);
  list.push(2);
  list.push(1);

  for (final element in list) {
    print(element);
  }
}

/// Challenge 1: Print in reverse
void challengeOne() {
  void printNodesRecursively<T>(Node<T>? node) {
    if (node != null) {
      printNodesRecursively(node.next);
      print(node.value);
    }
  }

  void printListInReverse<E>(LinkedList<E> list) {
    printNodesRecursively(list.head);
  }

  var list = LinkedList<int>();

  list.push(3);
  list.push(2);
  list.push(1);
  print('Original list: $list');
  print("Printing in reverse:");
  printListInReverse(list);
}

/// Challenge 2: Find the middle node (runner’s technique)
void challengeTwo() {
  Node<E>? getMiddle<E>(LinkedList<E> list) {
    var slow = list.head;
    var fast = list.head;

    while (fast?.next != null) {
      fast = fast?.next?.next;
      slow = slow?.next;
    }
    return slow;
  }

  var list = LinkedList<int>();
  for (var i = 100000000; i > 0; i--) {
    list.push(i);
  }
  // print(list);
  final stopwatch = Stopwatch()..start();
  final middleNode = getMiddle(list);
  print('Middle: ${middleNode?.value}');
  print('Executed in ${stopwatch.elapsed}');
}

void challengeTwobyMarci() {
  Node<E>? getMiddle<E>(LinkedList<E> list) {
    if (list.isEmpty) return null;
    Node<E>? possibleMiddle = list.head;
    var middlePos = 1;
    var i = 1;
    for (final element in list) {
      if (element == list.tail?.value) return possibleMiddle;
      i++;
      if (i ~/ 2 + 1 > middlePos) {
        possibleMiddle = possibleMiddle?.next;
        middlePos++;
      }
    }
  }

  var list = LinkedList<int>();
  for (var i = 100000000; i > 0; i--) {
    list.push(i);
  }
  // print(list);
  final stopwatch = Stopwatch()..start();
  final middleNode = getMiddle(list);
  print('Middle: ${middleNode?.value}');
  print('Executed in ${stopwatch.elapsed}');
}

/// Challenge 3: Reverse a linked list, O(n) time complexity but heavy due to temp list
void challengeThreeBasic() {
  void reverse<E>(LinkedList<E> list) {
    final tempList = LinkedList<E>();
    for (final value in list) {
      tempList.push(value);
    }
    list.head = tempList.head;
  }

  final list = LinkedList<int>();
  for (var i = 100000000; i > 0; i--) {
    list.push(i);
  }
  // print(list);
  final stopwatch = Stopwatch()..start();
  reverse(list);
  print('Executed in ${stopwatch.elapsed}');
  // print(list);
}

/// Challenge 3: Reverse a linked list, O(n) time complexity, but no temp list
void challengeThree() {
  void reverse<E>(LinkedList<E> list) {
    var previous = list.head; // 1
    var current = list.head?.next; // 2
    var next = current?.next; // 3

    list.tail = previous;
    previous?.next = null;

    while (current != null) {
      current.next = previous; // c:2->1; c:3->2; c:4->3; c:5->4
      previous = current; // p:2->1; p:3->2; p:4->3; p:5->4
      current = next; // c:3->4; c:4->5; c:5->null; c:null
      next = current?.next; // n:4->5; n:5->null; n:null; n:null
    }

    list.head = previous;
  }

  final list = LinkedList<int>();
  for (var i = 100000000; i > 0; i--) {
    list.push(i);
  }
  // print(list);
  final stopwatch = Stopwatch()..start();
  reverse(list);
  print('Executed in ${stopwatch.elapsed}');
  // print(list);
}

/// Challenge 4: Remove all occurrences
extension RemovableLinkedList<E> on LinkedList {
  void removeAll(E value) {
    while (head != null && head!.value == value) {
      // my solution was: (head?.value == value), but list.removeAll(null) won't work on empty list
      head = head!.next;
    }
    var previous = head;
    var current = head?.next;
    while (current != null) {
      if (current.value == value) {
        previous?.next = current.next;
        current = previous?.next;
      } else {
        previous = current;
        current = current.next;
      }
    }
    tail = previous;
  }
}

void challengeFour() {
  var list = LinkedList<int>();
  list.push(5);
  list.push(4);
  list.push(3);
  list.push(2);
  list.push(2);
  list.push(1);
  list.push(1);

  list.removeAll(3);
  print(list);
}

void main() {
  // insertAfterExample();
  // makingListIterable();
  // challengeOne();
  // challengeTwo();
  // challengeTwobyMarci();
  // challengeThreeBasic();
  // challengeThree();
  // challengeFour();
}
