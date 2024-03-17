// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'multi_player_tic_tac_toe_game.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$gameNotifierHash() => r'7ae3e683ee0429443909b9c853da70d2ce1abecb';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$GameNotifier
    extends BuildlessAutoDisposeStreamNotifier<Game?> {
  late final String gameID;

  Stream<Game?> build({
    required String gameID,
  });
}

/// See also [GameNotifier].
@ProviderFor(GameNotifier)
const gameNotifierProvider = GameNotifierFamily();

/// See also [GameNotifier].
class GameNotifierFamily extends Family<AsyncValue<Game?>> {
  /// See also [GameNotifier].
  const GameNotifierFamily();

  /// See also [GameNotifier].
  GameNotifierProvider call({
    required String gameID,
  }) {
    return GameNotifierProvider(
      gameID: gameID,
    );
  }

  @override
  GameNotifierProvider getProviderOverride(
    covariant GameNotifierProvider provider,
  ) {
    return call(
      gameID: provider.gameID,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'gameNotifierProvider';
}

/// See also [GameNotifier].
class GameNotifierProvider
    extends AutoDisposeStreamNotifierProviderImpl<GameNotifier, Game?> {
  /// See also [GameNotifier].
  GameNotifierProvider({
    required String gameID,
  }) : this._internal(
          () => GameNotifier()..gameID = gameID,
          from: gameNotifierProvider,
          name: r'gameNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$gameNotifierHash,
          dependencies: GameNotifierFamily._dependencies,
          allTransitiveDependencies:
              GameNotifierFamily._allTransitiveDependencies,
          gameID: gameID,
        );

  GameNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.gameID,
  }) : super.internal();

  final String gameID;

  @override
  Stream<Game?> runNotifierBuild(
    covariant GameNotifier notifier,
  ) {
    return notifier.build(
      gameID: gameID,
    );
  }

  @override
  Override overrideWith(GameNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: GameNotifierProvider._internal(
        () => create()..gameID = gameID,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        gameID: gameID,
      ),
    );
  }

  @override
  AutoDisposeStreamNotifierProviderElement<GameNotifier, Game?>
      createElement() {
    return _GameNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GameNotifierProvider && other.gameID == gameID;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, gameID.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GameNotifierRef on AutoDisposeStreamNotifierProviderRef<Game?> {
  /// The parameter `gameID` of this provider.
  String get gameID;
}

class _GameNotifierProviderElement
    extends AutoDisposeStreamNotifierProviderElement<GameNotifier, Game?>
    with GameNotifierRef {
  _GameNotifierProviderElement(super.provider);

  @override
  String get gameID => (origin as GameNotifierProvider).gameID;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
