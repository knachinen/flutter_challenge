import 'package:logger/logger.dart';

typedef DictionaryData = Map<String, String>;

class Dictionary {
  final DictionaryData _words;
  final Logger _logger = Logger();

  Dictionary() : _words = {};

  DictionaryData get words => Map.from(_words);

  void add({required String word, required String definition}) {
    if (_words.containsKey(word)) {
      _logger.w('Word "$word" already exists in the dictionary.');
    } else {
      _words[word] = definition;
      _logger.i('Added word: $word');
    }
  }

  void update({required String word, required String definition}) {
    if (_words.containsKey(word)) {
      _words[word] = definition;
      _logger.i('Updated definition for word: $word');
    } else {
      _logger.w('Word "$word" not found. Use add() to add a new word.');
    }
  }

  void upsert({required String word, required String definition}) {
    _words[word] = definition;
    _logger.i('Upserted word: $word');
  }

  String? get(String word) {
    return _words[word];
  }

  void delete(String word) {
    _words.remove(word);
    _logger.i('Deleted word: $word');
  }

  int count() {
    return _words.length;
  }

  void displayAll() {
    if (_words.isEmpty) {
      _logger.i('Dictionary is empty.');
    } else {
      _words.forEach((key, value) {
        _logger.i('$key: $value');
      });
    }
  }

  bool exists(String word) {
    return _words.containsKey(word);
  }

  void bulkAdd(DictionaryData bulk) {
    _words.addAll(bulk);
    _logger.i('Bulk added ${bulk.length} words to the dictionary.');
  }

  void bulkDelete(List<String> bulk) {
    bulk.forEach((word) {
      if (_words.containsKey(word)) {
        _words.remove(word);
        _logger.i('Deleted word: $word');
      } else {
        _logger.w('Word "$word" not found in the dictionary.');
      }
    });
  }

  List<String> getWordsByPrefix(String prefix) {
    return _words.keys.where((word) => word.startsWith(prefix)).toList();
  }

  void clear() {
    try {
      _words.clear();
      _logger.i('Dictionary cleared.');
    } catch (e) {
      _logger.e('An error occurred while clearing the dictionary: $e');
    }
  }

  void sortByKeys() {
    final sortedEntries = _words.entries.toList()
      ..sort((a, b) => a.key.compareTo(b.key));

    final sortedMap = Map.fromEntries(sortedEntries);
    _words.clear();
    _words.addAll(sortedMap);

    _logger.i('Dictionary sorted by keys.');
  }
}

/// Exception thrown when attempting to add a word that already exists.
class WordAlreadyExistsException implements Exception {
  final String message;

  WordAlreadyExistsException(this.message);

  @override
  String toString() => message;
}

/// Exception thrown when attempting to update or retrieve a nonexistent word.
class WordNotFoundException implements Exception {
  final String message;

  WordNotFoundException(this.message);

  @override
  String toString() => message;
}

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
  dictionary.displayAll();

  // Deleting a word
  dictionary.delete('apple');

  // Updating a word
  dictionary.update(
      word: 'banana', definition: 'An edible fruit, usually yellow when ripe.');

  // Showing all words
  dictionary.displayAll();

  // add line
  print('-' * 10);

  // Counting the number of words
  print(dictionary.count());

  // Upserting a word
  dictionary.upsert(word: 'orange', definition: 'A round juicy citrus fruit.');

  // Checking if a word exists
  print(dictionary.exists('banana'));

  // Showing all words
  dictionary.displayAll();

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
  dictionary.displayAll();

  // Bulk deleting words
  dictionary.bulkDelete(['orange', 'banana']);

  // add line
  print('-' * 10);

  // Showing all words after bulk operations
  dictionary.displayAll();
}
