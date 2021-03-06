fork floor_generator

modified:
- lib/writer/database_builder_writer.dart
- lib/writer/database_writer.dart

usage:
```dart
database = await $FloorAppDatabase.databaseBuilder('1.db').addMigrations(_migrations).build('123');
```

# Floor
**The typesafe, reactive and lightweight SQLite abstraction for your Flutter applications (iOS, Android, Linux, macOS, Windows)**

This is the dev dependency and contains the annotation processor.
Please refer to the [floor](https://pub.dartlang.org/packages/floor) package on pub or visit [Github](https://github.com/vitusortner/floor) for more information.

---

The library's name derives from the following.
*Floor* as the *bottom layer* of a [Room](https://developer.android.com/topic/libraries/architecture/room) which points to the analogy of the database layer being the bottom and foundation layer of most applications.
Where *fl* also gives a pointer that the library is used in the Flutter context.

## Bugs and Feedback
For bugs, questions and discussions please use [Github Issues](https://github.com/vitusortner/floor/issues).
For general communication use [floor's Slack](https://join.slack.com/t/floor-flutter/shared_invite/zt-d7i4yhgn-070n~ijDwXVHTpTxcVC47w).

## License
    Copyright 2019 Vitus Ortner

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.

