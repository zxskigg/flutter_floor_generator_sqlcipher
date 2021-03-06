import 'package:code_builder/code_builder.dart';
import 'package:floor_generator/misc/annotations.dart';
import 'package:floor_generator/writer/writer.dart';

class DatabaseBuilderWriter extends Writer {
  final String _databaseName;

  DatabaseBuilderWriter(final String databaseName)
      : _databaseName = databaseName;

  @nonNull
  @override
  Class write() {
    final databaseBuilderName = '_\$${_databaseName}Builder';

    final nameField = Field((builder) => builder
      ..name = 'name'
      ..type = refer('String')
      ..modifier = FieldModifier.final$);

    final migrationsField = Field((builder) => builder
      ..name = '_migrations'
      ..type = refer('List<Migration>')
      ..modifier = FieldModifier.final$
      ..assignment = const Code('[]'));

    final callbackField = Field((builder) => builder
      ..name = '_callback'
      ..type = refer('Callback'));

    final constructor = Constructor((builder) => builder
      ..requiredParameters.add(Parameter((builder) => builder
        ..toThis = true
        ..name = 'name')));

    final addMigrationsMethod = Method((builder) => builder
      ..name = 'addMigrations'
      ..returns = refer(databaseBuilderName)
      ..body = const Code('''
        _migrations.addAll(migrations);
        return this;
      ''')
      ..docs.add('/// Adds migrations to the builder.')
      ..requiredParameters.add(Parameter((builder) => builder
        ..name = 'migrations'
        ..type = refer('List<Migration>'))));

    final addCallbackMethod = Method((builder) => builder
      ..name = 'addCallback'
      ..returns = refer(databaseBuilderName)
      ..body = const Code('''
        _callback = callback;
        return this;
      ''')
      ..docs.add('/// Adds a database [Callback] to the builder.')
      ..requiredParameters.add(Parameter((builder) => builder
        ..name = 'callback'
        ..type = refer('Callback'))));

    final buildMethod = Method((builder) => builder
      ..returns = refer('Future<$_databaseName>')
      ..name = 'build'
      ..optionalParameters.add(Parameter((builder) => builder
        ..name = 'password'
        ..type = refer('String')
      ))
      ..modifier = MethodModifier.async
      ..docs.add('/// Creates the database and initializes it.')

      // --- ison.zhang add 03
      ..body = Code('''
        final path = name != null
          ? await sqfliteDatabaseFactory.getDatabasePath(name!)
          : ':memory:';
        final database = _\$$_databaseName();
        database.database = await database.open(
          path,
          password,
          _migrations,
          _callback,
        );
        return database;
      ''')
      ..requiredParameters.add(Parameter((builder) => builder
        ..name = 'password'
        ..type = refer('String')
        ..defaultTo = Code.scope((p0) => '')
      ))
      // --- end ison.zhang add 03

    );

    return Class((builder) => builder
      ..name = databaseBuilderName
      ..fields.addAll([
        nameField,
        migrationsField,
        callbackField,
      ])
      ..constructors.add(constructor)
      ..methods.addAll([
        addMigrationsMethod,
        addCallbackMethod,
        buildMethod,
      ]));
  }
}
