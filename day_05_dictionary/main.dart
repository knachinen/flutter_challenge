import 'package:logger/logger.dart';

typedef DictionaryData = Map<String, String>;

/// A simple dictionary class that stores words and their definitions.
class Dictionary {
  /// Internal storage for words and their definitions.
  late final DictionaryData _words;
  late final Logger _logger = Logger();

  /// Creates a new instance of the [Dictionary] class.
  Dictionary() : _words = {};

  /// Retrieves a copy of the current words and their definitions.
  DictionaryData? get words => _words.isNotEmpty ? Map.from(_words) : null;

  /// Adds a new word and its definition to the dictionary.
  ///
  /// Throws [WordAlreadyExistsException] if the word already exists.
  void add({required String word, required String definition}) {
    if (_words.containsKey(word)) {
      _logger.w('Word "$word" already exists in the dictionary.');
    } else {
      _words[word] = definition;
      _logger.i('Added word: $word');
    }
  }

  /// Updates the definition of an existing word in the dictionary.
  ///
  /// Throws [WordNotFoundException] if the word does not exist.
  void update({required String word, required String definition}) {
    if (_words.containsKey(word)) {
      _words[word] = definition;
      _logger.i('Updated definition for word: $word');
    } else {
      _logger.w('Word "$word" not found. Use add() to add a new word.');
    }
  }

  /// Adds a new word or updates the definition of an existing word in the dictionary.
  void upsert({required String word, required String definition}) {
    _words[word] = definition;
    _logger.i('Upserted word: $word');
  }

  /// Retrieves the definition of a word from the dictionary.
  String? get(String word) {
    return _words[word];
  }

  /// Deletes a word from the dictionary.
  void delete(String word) {
    _words.remove(word);
    _logger.i('Deleted word: $word');
  }

  /// Returns the number of words in the dictionary.
  int count() {
    return _words.length;
  }

  /// Displays all words and their definitions in the dictionary.
  void displayAll() {
    if (_words.isEmpty) {
      _logger.i('Dictionary is empty.');
    } else {
      _words.forEach((key, value) {
        _logger.i('$key: $value');
      });
    }
  }

  /// Checks if a word exists in the dictionary.
  bool exists(String word) => _words.containsKey(word);

  /// Adds multiple words and their definitions to the dictionary.
  void bulkAdd(DictionaryData? bulk) {
    if (bulk != null && bulk.isNotEmpty) {
      _words.addAll(bulk);
      _logger.i('Bulk added ${bulk.length} words to the dictionary.');
    } else {
      _logger.w('No words provided for bulkAdd.');
    }
  }

  /// Deletes multiple words from the dictionary.
  void bulkDelete(List<String> bulk) {
    if (bulk.isNotEmpty) {
      bulk.forEach((word) {
        if (_words.containsKey(word)) {
          _words.remove(word);
          _logger.i('Deleted word: $word');
        } else {
          _logger.w('Word "$word" not found in the dictionary.');
        }
      });
    } else {
      _logger.w('No words provided for bulkDelete.');
    }
  }

  /// Retrieves a list of words in the dictionary that start with the specified prefix.
  List<String> getWordsByPrefix(String prefix) {
    return _words.keys.where((word) => word.startsWith(prefix)).toList();
  }

  /// Clears all words from the dictionary.
  void clear() {
    try {
      _words.clear();
      _logger.i('Dictionary cleared.');
    } catch (e) {
      _logger.e('An error occurred while clearing the dictionary: $e');
    }
  }

  /// Sorts the words in the dictionary alphabetically by their keys.
  void sortByKeys() {
    final sortedEntries = _words.entries.toList()
      ..sort((a, b) => a.key.compareTo(b.key));

    _words.clear();
    _words.addEntries(sortedEntries);

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
