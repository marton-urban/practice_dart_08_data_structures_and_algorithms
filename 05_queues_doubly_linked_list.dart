// enqueue O(1), worst case: O(1)
// dequeue O(1), worst case: O(1)

// enqueue here uses append() and dequeue uses pop() just like in the
// linked_list version, but here we could have used push() and removeLast()
// with the same time complexity, while in linked_list removeLast would be O(n)

// The main weakness with QueueLinkedList is not apparent from the table. Despite
// O(1) performance, it suffers from high overhead. Each element has to have extra
// storage for the forward and back references. Moreover, every time you create a new
// element, it requires a relatively expensive dynamic allocation of memory for the new
// node. By contrast, QueueList does bulk allocation, which is faster.

class Node<T> {
  Node({required this.value, this.next, this.previous});
  T value;
  Node<T>? next;
  Node<T>? previous;

  @override
  String toString() {
    return '$value';
  }
}

abstract class LinkedList<E> {
  Node<E>? head;
  Node<E>? tail;
  bool get isEmpty;
  void append(E value);
  void push(E value);
  E? pop();
  E? removeLast();
}

class DoublyLinkedList<E> extends Iterable<E> implements LinkedList<E> {
  @override
  Node<E>? head;

  @override
  Node<E>? tail;

  @override
  bool get isEmpty => head == null;

  @override
  void append(E value) {
    // convert the value to a node
    final newNode = Node(value: value, previous: tail);

    // update the pointers at the tail of the list
    if (isEmpty) {
      head = newNode;
    } else {
      tail!.next = newNode;
      // handle lists with only one element
      head?.next ??= newNode;
    }
    tail = newNode;
  }

  @override
  void push(E value) {
    // convert the value to a node
    final newNode = Node(value: value, next: head);

    // update the pointers at the tail of the list
    if (isEmpty) {
      tail = newNode;
    } else {
      head!.previous = newNode;
      // handle lists with only one element
      tail?.previous ??= newNode;
    }
    head = newNode;
  }

  @override
  E? pop() {
    // handle an empty list
    if (isEmpty) return null;

    // save the return value
    final value = head?.value;

    // handle a list of length one
    if (head?.next == null) {
      head = null;
      tail = null;
      return value;
    }

    // update the pointers
    head = head?.next;
    head?.previous = null;

    return value;
  }

  @override
  E? removeLast() {
    // delegate lists with one or zero items to pop
    if (tail?.previous == null) return pop();

    // save the return value
    final value = tail?.value;

    // update the pointers
    tail = tail?.previous;
    tail?.next = null;

    return value;
  }

  @override
  Iterator<E> get iterator => _LinkedListIterator(this);

  @override
  String toString() => '[${join(', ')}]';
}

class _LinkedListIterator<E> implements Iterator<E> {
  _LinkedListIterator(DoublyLinkedList<E> list) : _list = list;
  final DoublyLinkedList<E> _list;
  Node<E>? _currentNode;
  bool _firstPass = true;

  @override
  E get current => _currentNode!.value;

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

abstract class Queue<E> {
  bool enqueue(E element);
  E? dequeue();
  bool get isEmpty;
  E? get peek;
}

class QueueLinkedList<E> implements Queue<E> {
  final _list = DoublyLinkedList<E>();

  @override
  bool enqueue(E element) {
    _list.append(element);
    return true;
  }

  @override
  E? dequeue() => _list.pop();

  @override
  bool get isEmpty => _list.isEmpty;

  @override
  E? get peek => _list.head?.value;

  @override
  String toString() => _list.toString();
}

void enqueueDequeueExample() {
  final queue = QueueLinkedList<String>();
  queue.enqueue('Ray');
  queue.enqueue('Brian');
  queue.enqueue('Eric');
  print(queue);

  queue.dequeue();
  print(queue);

  print(queue.peek);
  print(queue);
}

void main() {
  enqueueDequeueExample();
}
