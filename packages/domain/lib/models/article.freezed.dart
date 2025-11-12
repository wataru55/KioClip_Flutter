// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'article.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$Article {
  // 記事を識別するための一意のID
  String get id => throw _privateConstructorUsedError; // 記事のURL
  String get urlString => throw _privateConstructorUsedError; // 記事の作成日時
  DateTime get createdAt => throw _privateConstructorUsedError; // OGP情報
  Ogp? get ogp => throw _privateConstructorUsedError;

  /// Create a copy of Article
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ArticleCopyWith<Article> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ArticleCopyWith<$Res> {
  factory $ArticleCopyWith(Article value, $Res Function(Article) then) =
      _$ArticleCopyWithImpl<$Res, Article>;
  @useResult
  $Res call({String id, String urlString, DateTime createdAt, Ogp? ogp});

  $OgpCopyWith<$Res>? get ogp;
}

/// @nodoc
class _$ArticleCopyWithImpl<$Res, $Val extends Article>
    implements $ArticleCopyWith<$Res> {
  _$ArticleCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Article
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? urlString = null,
    Object? createdAt = null,
    Object? ogp = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            urlString: null == urlString
                ? _value.urlString
                : urlString // ignore: cast_nullable_to_non_nullable
                      as String,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            ogp: freezed == ogp
                ? _value.ogp
                : ogp // ignore: cast_nullable_to_non_nullable
                      as Ogp?,
          )
          as $Val,
    );
  }

  /// Create a copy of Article
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $OgpCopyWith<$Res>? get ogp {
    if (_value.ogp == null) {
      return null;
    }

    return $OgpCopyWith<$Res>(_value.ogp!, (value) {
      return _then(_value.copyWith(ogp: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ArticleImplCopyWith<$Res> implements $ArticleCopyWith<$Res> {
  factory _$$ArticleImplCopyWith(
    _$ArticleImpl value,
    $Res Function(_$ArticleImpl) then,
  ) = __$$ArticleImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String urlString, DateTime createdAt, Ogp? ogp});

  @override
  $OgpCopyWith<$Res>? get ogp;
}

/// @nodoc
class __$$ArticleImplCopyWithImpl<$Res>
    extends _$ArticleCopyWithImpl<$Res, _$ArticleImpl>
    implements _$$ArticleImplCopyWith<$Res> {
  __$$ArticleImplCopyWithImpl(
    _$ArticleImpl _value,
    $Res Function(_$ArticleImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Article
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? urlString = null,
    Object? createdAt = null,
    Object? ogp = freezed,
  }) {
    return _then(
      _$ArticleImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        urlString: null == urlString
            ? _value.urlString
            : urlString // ignore: cast_nullable_to_non_nullable
                  as String,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        ogp: freezed == ogp
            ? _value.ogp
            : ogp // ignore: cast_nullable_to_non_nullable
                  as Ogp?,
      ),
    );
  }
}

/// @nodoc

class _$ArticleImpl implements _Article {
  const _$ArticleImpl({
    required this.id,
    required this.urlString,
    required this.createdAt,
    this.ogp,
  });

  // 記事を識別するための一意のID
  @override
  final String id;
  // 記事のURL
  @override
  final String urlString;
  // 記事の作成日時
  @override
  final DateTime createdAt;
  // OGP情報
  @override
  final Ogp? ogp;

  @override
  String toString() {
    return 'Article(id: $id, urlString: $urlString, createdAt: $createdAt, ogp: $ogp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ArticleImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.urlString, urlString) ||
                other.urlString == urlString) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.ogp, ogp) || other.ogp == ogp));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, urlString, createdAt, ogp);

  /// Create a copy of Article
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ArticleImplCopyWith<_$ArticleImpl> get copyWith =>
      __$$ArticleImplCopyWithImpl<_$ArticleImpl>(this, _$identity);
}

abstract class _Article implements Article {
  const factory _Article({
    required final String id,
    required final String urlString,
    required final DateTime createdAt,
    final Ogp? ogp,
  }) = _$ArticleImpl;

  // 記事を識別するための一意のID
  @override
  String get id; // 記事のURL
  @override
  String get urlString; // 記事の作成日時
  @override
  DateTime get createdAt; // OGP情報
  @override
  Ogp? get ogp;

  /// Create a copy of Article
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ArticleImplCopyWith<_$ArticleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
