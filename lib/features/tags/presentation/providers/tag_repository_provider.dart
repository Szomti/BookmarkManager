import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/repositories/tag_repository_impl.dart';
import '../../domain/repositories/tag_repository.dart';
import '../../tags.dart';

part 'tag_repository_provider.g.dart';

@Riverpod(keepAlive: true)
TagRepository tagRepository(Ref ref) =>
    TagRepositoryImpl(ref.read(tagsDaoProvider));
