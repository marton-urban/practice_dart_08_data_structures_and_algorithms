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

class QueueLinkedList<E> {
  Node<E>? head;
  Node<E>? tail;

  void push(E value) {
    head = Node(value: value, next: head);
    tail ??= head;
  }

  // =append
  void enqueue(E value) {
    if (isEmpty) {
      push(value);
      return;
    }
    tail!.next = Node(value: value);
    tail = tail!.next;
  }

  // =pop
  E? dequeue() {
    final value = head?.value;
    head = head?.next;
    if (isEmpty) {
      tail = null;
    }
    return value;
  }

  bool get isEmpty => head == null;
  void get peek => print(head?.value);

  @override
  String toString() {
    if (isEmpty) return 'Empty queeu';
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

  queue.peek;
  print(queue);
}
