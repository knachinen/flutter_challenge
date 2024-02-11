typedef Dict = Map<String, String>;

class Dictionary {
  final Dict words;

  Dictionary() : words = {};

  void add({required String word, required String definition}) {
    words[word] = definition;
  }

  void update({required String word, required String definition}) {
    if (words.containsKey(word)) {
      words[word] = definition;
    } else {
      print('Word "$word" not found. Use add() to add a new word.');
    }
  }

  void upsert({required String word, required String definition}) {
    words[word] = definition;
  }

  String? get(String word) {
    return words[word];
  }

  void delete(String word) {
    words.remove(word);
  }

  int count() {
    return words.length;
  }

  void showAll() {
    words.forEach((key, value) {
      print('$key: $value');
    });
  }

  bool exists(String word) {
    return words.containsKey(word);
  }

  void bulkAdd(Dict bulk) {
    words.addAll(bulk);
  }

  void bulkDelete(List<String> bulk) {
    for (var key in bulk) {
      words.remove(key);
    }
  }
}

// void main() {
//   var dict = Dictionary();
//   dict.add(word: 'sky', definition: 'sky is blue');
//   print("The definition of 'sky' is ${dict.get('sky')} in the dictionary.");

//   dict.bulkAdd({
//     'ocean': 'ocean is wide',
//     'forest': 'forest is green',
//     'universe': 'universe is endless'
//   });

//   print("'tree' is in the dictionary: ${dict.isExist('tree')}");
//   print("'forest' is in the dictionary: ${dict.isExist('forest')}");
//   print("The dictionary size: ${dict.count()}");
//   dict.showAll();
// }

// test Dictionary
void main() {
  var dictionary = Dictionary();

  // Adding individual words
  dictionary.add(
      word: 'apple', definition: 'A red of green fruit that grows on trees.');
  dictionary.add(
      word: 'banana',
      definition: 'A long curved yellow fruit that grows in clusters.');

  // add line
  print('-' * 10);

  print("apple's meaning: ");

  // Getting the definition of a word
  print(dictionary.get('apple'));

  // Showing all words
  dictionary.showAll();

  // Deleting a word
  dictionary.delete('apple');

  // Updating a word
  dictionary.update(
      word: 'banana', definition: 'An edible fruit, usually yellow when ripe.');

  // Showing all words
  dictionary.showAll();

  // add line
  print('-' * 10);

  // Counting the number of words
  print(dictionary.count());

  // Upserting a word
  dictionary.upsert(word: 'orange', definition: 'A round juicy citrus fruit.');

  // Checking if a word exists
  print(dictionary.exists('banana'));

  // Showing all words
  dictionary.showAll();

  // add line
  print('-' * 10);

  // Counting the number of words
  print(dictionary.count());

  // Bulk adding words
  dictionary.bulkAdd({
    'cherry': 'A small, round, red fruit with a pit inside.',
    'grape': 'A small, sweet fruit that grows in bunches.'
  });

  // add line
  print('-' * 10);

  // Showing all words after bulk operations
  dictionary.showAll();

  // Bulk deleting words
  dictionary.bulkDelete(['orange', 'banana']);

  // add line
  print('-' * 10);

  // Showing all words after bulk operations
  dictionary.showAll();
}
