// enqueue O(1), worst case: O(1)
// dequeue O(1), worst case: O(1)

class Node<T> {
  Node({required this.value, this.next});

  T value;
  Node<T>? next;

  @override
  String toString() {
    if (next == null) return '$value';
    return '$value, ${next.toString()}';
  }
}

abstract class Queue<E> {
  bool enqueue(E element);
  E? dequeue();
  bool get isEmpty;
  E? get peek;
}

class QueueLinkedList<E> implements Queue<E> {
  Node<E>? head;
  Node<E>? tail;

  void push(E value) {
    head = Node(value: value, next: head);
    tail ??= head;
  }

  // =append
  @override
  bool enqueue(E value) {
    if (isEmpty) {
      push(value);
    } else {
      tail!.next = Node(value: value);
      tail = tail!.next;
    }
    return true;
  }

  // =pop
  @override
  E? dequeue() {
    final value = head?.value;
    head = head?.next;
    if (isEmpty) {
      tail = null;
    }
    return value;
  }

  @override
  bool get isEmpty => head == null;
  @override
  E? get peek => head?.value;

  @override
  String toString() {
    if (isEmpty) return 'Empty queue';
    return head.toString();
  }
}

void main() {
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
