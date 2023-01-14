// Yes, reversing the contents of a list is an O(n) operation. However, the
// overall dequeue cost is still amortized O(1). Imagine having a large number of
// items in both the left and right stacks. The reverse copy is only required
// infrequently when the left stack becomes empty.

// It beats the linked list in terms of spatial locality. This is because list
// elements are next to each other in memory blocks. So a large number of elements
// will be loaded in a cache on first access. Even though a list requires O(n) for simple
// copy operations, it’s a very fast O(n) happening close to memory bandwidth.

// enqueue O(1), worst case: O(1)
// dequeue O(1), worst case: O(1)

abstract class Queue<E> {
  bool enqueue(E element);
  E? dequeue();
  bool get isEmpty;
  E? get peek;
}

class QueueStack<E> implements Queue<E> {
  final _leftStack = <E>[];
  final _rightStack = <E>[];

  @override
  bool enqueue(E element) {
    _rightStack.add(element);
    return true;
  }

  @override
  E? dequeue() {
    if (_leftStack.isEmpty) {
      _leftStack.addAll(_rightStack.reversed);
      _rightStack.clear();
    }
    if (_leftStack.isEmpty) return null;
    return _leftStack.removeLast();
  }

  @override
  bool get isEmpty => _leftStack.isEmpty && _rightStack.isEmpty;

  @override
  E? get peek => _leftStack.isNotEmpty ? _leftStack.last : _rightStack.first;

  @override
  String toString() {
    final combined = [
      ..._leftStack.reversed,
      ..._rightStack,
    ].join(', ');
    return '[$combined]';
  }
}

void main() {
  final queue = QueueStack<String>();
  queue.enqueue("Ray");
  queue.enqueue("Brian");
  queue.enqueue("Eric");
  print(queue);

  queue.dequeue();
  print(queue);

  queue.peek;
  print(queue);
}
