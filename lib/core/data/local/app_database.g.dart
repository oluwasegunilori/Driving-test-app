// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $AppDatabaseBuilderContract {
  /// Adds migrations to the builder.
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $AppDatabaseBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<AppDatabase> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder implements $AppDatabaseBuilderContract {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $AppDatabaseBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  QuestionDao? _questionDaoInstance;

  TestHistoryDao? _testHistoryDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `question_table` (`id` TEXT NOT NULL, `question` TEXT NOT NULL, `options` TEXT NOT NULL, `image` TEXT, `answer` INTEGER NOT NULL, `question_type` INTEGER NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `test_history_table` (`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, `missed_question_ids` TEXT NOT NULL, `score_rate` REAL NOT NULL, `no_of_questions` INTEGER NOT NULL, `no_of_correct_answers` INTEGER NOT NULL, `test_type` TEXT NOT NULL, `date` INTEGER NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  QuestionDao get questionDao {
    return _questionDaoInstance ??= _$QuestionDao(database, changeListener);
  }

  @override
  TestHistoryDao get testHistoryDao {
    return _testHistoryDaoInstance ??=
        _$TestHistoryDao(database, changeListener);
  }
}

class _$QuestionDao extends QuestionDao {
  _$QuestionDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _questionEntityInsertionAdapter = InsertionAdapter(
            database,
            'question_table',
            (QuestionEntity item) => <String, Object?>{
                  'id': item.id,
                  'question': item.question,
                  'options': _stringListConverter.encode(item.options),
                  'image': item.image,
                  'answer': item.answer,
                  'question_type': item.questionType.index
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<QuestionEntity> _questionEntityInsertionAdapter;

  @override
  Future<List<QuestionEntity>> findAllQuestions() async {
    return _queryAdapter.queryList('SELECT * FROM question_table',
        mapper: (Map<String, Object?> row) => QuestionEntity(
            row['id'] as String,
            row['question'] as String,
            _stringListConverter.decode(row['options'] as String),
            row['image'] as String?,
            row['answer'] as int,
            QuestionType.values[row['question_type'] as int]));
  }

  @override
  Future<void> insertQuestion(QuestionEntity question) async {
    await _questionEntityInsertionAdapter.insert(
        question, OnConflictStrategy.abort);
  }
}

class _$TestHistoryDao extends TestHistoryDao {
  _$TestHistoryDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _testHistoryEntityInsertionAdapter = InsertionAdapter(
            database,
            'test_history_table',
            (TestHistoryEntity item) => <String, Object?>{
                  'id': item.id,
                  'missed_question_ids':
                      _stringListConverter.encode(item.missedQuestionIds),
                  'score_rate': item.scoreRate,
                  'no_of_questions': item.numberOfQuestions,
                  'no_of_correct_answers': item.noOfCorrectAnswers,
                  'test_type': _testTypeConverter.encode(item.testType),
                  'date': item.date
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<TestHistoryEntity> _testHistoryEntityInsertionAdapter;

  @override
  Future<List<TestHistoryEntity>> findAllTests() async {
    return _queryAdapter.queryList('SELECT * FROM test_history_table',
        mapper: (Map<String, Object?> row) => TestHistoryEntity(
            missedQuestionIds: _stringListConverter
                .decode(row['missed_question_ids'] as String),
            scoreRate: row['score_rate'] as double,
            numberOfQuestions: row['no_of_questions'] as int,
            noOfCorrectAnswers: row['no_of_correct_answers'] as int,
            testType: _testTypeConverter.decode(row['test_type'] as String),
            date: row['date'] as int));
  }

  @override
  Future<List<TestHistoryEntity>> getAllUniqueTest(TestType testType) async {
    return _queryAdapter.queryList(
        'SELECT * FROM test_history_table WHERE testType = ?1',
        mapper: (Map<String, Object?> row) => TestHistoryEntity(
            missedQuestionIds: _stringListConverter
                .decode(row['missed_question_ids'] as String),
            scoreRate: row['score_rate'] as double,
            numberOfQuestions: row['no_of_questions'] as int,
            noOfCorrectAnswers: row['no_of_correct_answers'] as int,
            testType: _testTypeConverter.decode(row['test_type'] as String),
            date: row['date'] as int),
        arguments: [_testTypeConverter.encode(testType)]);
  }

  @override
  Future<void> insertData(TestHistoryEntity entity) async {
    await _testHistoryEntityInsertionAdapter.insert(
        entity, OnConflictStrategy.abort);
  }
}

// ignore_for_file: unused_element
final _stringListConverter = StringListConverter();
final _testTypeConverter = TestTypeConverter();
