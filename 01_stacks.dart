class Stack<E> {
  Stack() : _storage = <E>[];
  Stack.of(Iterable<E> elements) : _storage = List<E>.of(elements);

  final List<E> _storage;

  E get peek => _storage.last;
  bool get isEmpty => _storage.isEmpty;
  bool get isNotEmpty => !isEmpty;

  void push(E element) => _storage.add(element);
  E pop() => _storage.removeLast();

  @override
  String toString() {
    return '--- Top ---\n'
        '${_storage.reversed.join('\n')}'
        '\n-----------';
  }
}

// Challenge 1 - Reverse a List
void challengeOne() {
  void printInReverse<E>(List<E> list) {
    var stack = Stack.of(list);
    while (stack.isNotEmpty) {
      print(stack.pop());
    }
  }

  const list = ['d', 'r', 'a', 'w', 'e', 'r'];
  printInReverse(list);
  print(list.reversed);
}

// Challege 2 - Balance the parentheses
void challengeTwo() {
  bool checkParentheses(String text) {
    var stack = Stack<String>();
    for (var i = 0; i < text.length; i++) {
      final currentChar = text[i];
      if (currentChar == '(') {
        stack.push(currentChar);
      } else if (currentChar == ')') {
        if (stack.isEmpty) {
          return false;
        } else {
          stack.pop();
        }
      }
    }
    return stack.isEmpty;
  }

  print(checkParentheses('h((e))llo(world)()'));
  print(checkParentheses('(hello world'));
  print(checkParentheses('hello)(world'));
}

void main() {
  // challengeOne();
  // challengeTwo();
}
