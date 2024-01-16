import 'package:flutter_pjsip/pjsua/pjsua.dart';
import 'package:test/test.dart';

void main() {
  group('BuddyConfig', () {
    test('toJson', () {
      const buddyConfig = BuddyConfig(
        uri: 'uri',
        subscribe: true,
      );
      expect(buddyConfig.toJson(), {
        'uri': 'uri',
        'subscribe': true,
      });
    });

    test('fromJson', () {
      const buddyConfig = BuddyConfig(
        uri: 'uri',
        subscribe: false,
      );
      expect(
        BuddyConfig.fromJson({
          'uri': 'uri',
          'subscribe': false,
        }),
        buddyConfig,
      );
    });

    test('equals', () {
      const buddyConfig1 = BuddyConfig(
        uri: 'uri',
        subscribe: true,
      );
      const buddyConfig2 = BuddyConfig(
        uri: 'uri',
        subscribe: true,
      );
      expect(buddyConfig1, buddyConfig2);
    });

    test('not equals: 0', () {
      const buddyConfig1 = BuddyConfig(
        uri: 'uri',
        subscribe: true,
      );
      const buddyConfig2 = BuddyConfig(
        uri: 'uri2',
        subscribe: true,
      );
      expect(buddyConfig1, isNot(buddyConfig2));
    });

    test('not equals: 1', () {
      const buddyConfig1 = BuddyConfig(
        uri: 'uri',
        subscribe: true,
      );
      const buddyConfig2 = BuddyConfig(
        uri: 'uri',
        subscribe: false,
      );
      expect(buddyConfig1, isNot(buddyConfig2));
    });
  });
}
