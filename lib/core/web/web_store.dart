import 'dart:async';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

typedef JsonMap = Map<String, dynamic>;

/// Browser-local JSON persistence backed by [SharedPreferences] (localStorage).
class WebStore {
  WebStore._(this._prefs);

  final SharedPreferences _prefs;
  static const _storageKey = 'studyspark_web_db';

  final Map<String, StreamController<void>> _controllers = {};
  late JsonMap _db;

  static Future<WebStore> open(SharedPreferences prefs) async {
    final store = WebStore._(prefs);
    final raw = prefs.getString(_storageKey);
    if (raw != null && raw.isNotEmpty) {
      store._db = jsonDecode(raw) as JsonMap;
    } else {
      store._db = {'nextId': 1};
    }
    store._ensureCollections();
    return store;
  }

  void _ensureCollections() {
    for (final key in _collectionKeys) {
      _db.putIfAbsent(key, () => <JsonMap>[]);
    }
    _db.putIfAbsent('nextId', () => 1);
  }

  static const _collectionKeys = [
    'tasks',
    'users',
    'badges',
    'notes',
    'pomodoroSessions',
    'focusSessions',
    'moodEntries',
    'goals',
    'subjects',
    'attendance',
    'scheduleEvents',
    'flashcards',
    'flashcardDecks',
    'quizzes',
    'quizQuestions',
    'quizAttempts',
    'gpaEntries',
  ];

  int nextId() {
    final id = (_db['nextId'] as num?)?.toInt() ?? 1;
    _db['nextId'] = id + 1;
    return id;
  }

  List<JsonMap> list(String collection) {
    final raw = _db[collection];
    if (raw is! List) return [];
    return raw.map((e) => Map<String, dynamic>.from(e as Map)).toList();
  }

  Stream<void> watchCollection(String collection) {
    return _controllers
        .putIfAbsent(collection, () => StreamController<void>.broadcast())
        .stream;
  }

  Future<void> saveAll(String collection, List<JsonMap> items) async {
    _db[collection] = items;
    await _persist(collection);
  }

  Future<JsonMap> upsert(String collection, JsonMap item) async {
    final items = list(collection);
    final id = (item['id'] as num?)?.toInt() ?? 0;
    if (id <= 0) {
      item['id'] = nextId();
      items.add(item);
    } else {
      final idx = items.indexWhere((e) => (e['id'] as num?)?.toInt() == id);
      if (idx >= 0) {
        items[idx] = item;
      } else {
        items.add(item);
      }
    }
    await saveAll(collection, items);
    return item;
  }

  Future<bool> deleteById(String collection, int id) async {
    final items = list(collection);
    final before = items.length;
    items.removeWhere((e) => (e['id'] as num?)?.toInt() == id);
    if (items.length == before) return false;
    await saveAll(collection, items);
    return true;
  }

  Future<void> _persist(String collection) async {
    await _prefs.setString(_storageKey, jsonEncode(_db));
    _controllers[collection]?.add(null);
  }
}
