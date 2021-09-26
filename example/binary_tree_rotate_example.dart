import 'dart:collection';

void main() {
  final tree = Tree<String>();
  tree.add(key: 10, data: '10');
  tree.add(key: 7, data: '7');
  tree.add(key: 5, data: '5');
  tree.add(key: 9, data: '9');
  tree.add(key: 4, data: '4');
  tree.add(key: 6, data: '6');
  tree.add(key: 8, data: '8');
  tree.add(key: 15, data: '15');
  tree.add(key: 13, data: '13');
  tree.add(key: 17, data: '17');

  tree.traverseBFS(root: tree.root, callback: (node) => print(node.data));
  print('rotate');
  tree.toRight();
  tree.traverseBFS(root: tree.root, callback: (node) => print(node.data));
}

class Node<T> {
  final int key;
  final T? data;
  Node<T>? left;
  Node<T>? right;

  Node({required this.key, this.data, this.left, this.right});
}

class Tree<T> {
  Node<T>? root;
  Tree({this.root});
  void toLeft() {
    if (root == null) return;
    var newRoot = root!.right;
    root!.right = null;
    newRoot!.left = root;
    root = newRoot;
  }

  void toRight() {
    if (root == null) return;
    var newRoot = root!.left;
    root!.left = newRoot!.right;
    newRoot.right = root;
    root = newRoot;
  }

  void add({required int key, T? data}) {
    final newNode = Node<T>(key: key, data: data);

    if (root == null) {
      root = newNode;
      return;
    }

    var newRoot = root;
    while (newRoot != null) {
      if (newRoot.key > key) {
        if (newRoot.left == null) {
          newRoot.left = newNode;
          return;
        } else {
          newRoot = newRoot.left;
        }
      } else {
        if (newRoot.right == null) {
          newRoot.right = newNode;
          return;
        } else {
          newRoot = newRoot.right;
        }
      }
    }
  }

  void traverseBFS({Node<T>? root, Function(Node<T>)? callback}) {
    final queue = Queue<Node<T>>.from([root]);
    while (queue.isNotEmpty) {
      final node = queue.removeFirst();
      if (callback != null) {
        callback(node);
      }
      if (node.left != null) {
        queue.addLast(node.left!);
      }
      if (node.right != null) {
        queue.addLast(node.right!);
      }
    }
  }

  void traverseDFSPostOrder({Node<T>? root, Function(Node<T>)? callback}) {
    if (root == null) return;

    traverseDFSPostOrder(root: root.left, callback: callback);

    traverseDFSPostOrder(root: root.right, callback: callback);
    if (callback != null) {
      callback(root);
    }
  }

  void traverseDFSInOrder({Node<T>? root, Function(Node<T>)? callback}) {
    if (root == null) return;

    traverseDFSInOrder(root: root.left, callback: callback);
    if (callback != null) {
      callback(root);
    }
    traverseDFSInOrder(root: root.right, callback: callback);
  }

  void traverseDFSPreOrder({Node<T>? root, Function(Node<T>)? callback}) {
    if (root == null) return;
    if (callback != null) {
      callback(root);
    }
    traverseDFSPreOrder(root: root.left, callback: callback);
    traverseDFSPreOrder(root: root.right, callback: callback);
  }
}
