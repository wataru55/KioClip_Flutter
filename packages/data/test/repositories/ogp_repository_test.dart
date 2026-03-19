import 'package:flutter_test/flutter_test.dart';
import 'package:data/src/repositories/ogp_repository.dart';
import 'package:ogp_data_extract/ogp_data_extract.dart';
import 'package:mocktail/mocktail.dart';

class MockOgpData extends Mock implements OgpData {}

void main() {
  group('OgpRepository', () {
    group('fetchOgp', () {
      test('OGP情報が正しく取得される', () async {
        const url1 = 'https://example1.com';
        const url2 = 'https://example2.com';

        // OgpDataのモックを作成
        final mockOgpData1 = MockOgpData();
        when(() => mockOgpData1.title).thenReturn('1');
        when(
          () => mockOgpData1.image,
        ).thenReturn('https://example.com/image1.jpg');

        final mockOgpData2 = MockOgpData();
        when(() => mockOgpData2.title).thenReturn('2');
        when(
          () => mockOgpData2.image,
        ).thenReturn('https://example.com/image2.jpg');

        //mockFetcherを作成
        OgpDataFetcher mockFetcher = (urlString) async {
          if (urlString == url1) {
            return mockOgpData1;
          } else if (urlString == url2) {
            return mockOgpData2;
          } else {
            return null;
          }
        };

        final ogpRepository = OgpRepository(fetcher: mockFetcher);
        final ogp1 = await ogpRepository.fetchOgp(url1);
        final ogp2 = await ogpRepository.fetchOgp(url2);

        expect(ogp1?.title, '1');
        expect(ogp1?.imageUrl, 'https://example.com/image1.jpg');
        expect(ogp2?.title, '2');
        expect(ogp2?.imageUrl, 'https://example.com/image2.jpg');
      });

      test('OGP情報が取得できない場合はnullが返される', () async {
        final mockOgpData = MockOgpData();
        when(() => mockOgpData.title).thenReturn(null);
        when(() => mockOgpData.image).thenReturn(null);

        final ogpRepository = OgpRepository(
          fetcher: (urlString) async => mockOgpData,
        );
        final ogp = await ogpRepository.fetchOgp('https://example.com');
        expect(ogp, isNull);
      });

      test('OGPにタイトル情報がない場合もnullが返される', () async {
        final mockOgpData = MockOgpData();
        when(() => mockOgpData.title).thenReturn(null);
        when(
          () => mockOgpData.image,
        ).thenReturn('https://example.com/image.jpg');

        final ogpRepository = OgpRepository(
          fetcher: (urlString) async => mockOgpData,
        );
        final ogp = await ogpRepository.fetchOgp('https://example.com');
        expect(ogp, isNull);
      });

      test('OGPのタイトルが空の場合もnullが返される', () async {
        final mockOgpData = MockOgpData();
        when(() => mockOgpData.title).thenReturn('');
        when(
          () => mockOgpData.image,
        ).thenReturn('https://example.com/image.jpg');

        final ogpRepository = OgpRepository(
          fetcher: (urlString) async => mockOgpData,
        );
        final ogp = await ogpRepository.fetchOgp('https://example.com');
        expect(ogp, isNull);
      });

      test('タイトルさえあればOGP情報が取得できる', () async {
        final mockOgpData = MockOgpData();
        when(() => mockOgpData.title).thenReturn('Test Title');
        when(() => mockOgpData.image).thenReturn(null);

        final ogpRepository = OgpRepository(
          fetcher: (urlString) async => mockOgpData,
        );
        final ogp = await ogpRepository.fetchOgp('https://example.com');
        expect(ogp?.title, 'Test Title');
        expect(ogp?.imageUrl, isNull);
      });
    });
  });
}
