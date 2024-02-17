import 'package:flutter/foundation.dart';

import 'bin.dart';

class BinList extends ChangeNotifier {
  List<Bin> bins = [
    Bin(
      img: 'lib/images/bin.png',
      name: 'Talha',
      fullness: '67',
      temp: '10',
    ),
    Bin(img: 'lib/images/bin.png', name: 'Marcus', fullness: '90', temp: '28'),
    Bin(img: 'lib/images/bin.png', name: 'Vidisha', fullness: '23', temp: '16'),
    Bin(img: 'lib/images/bin.png', name: 'Louis', fullness: '84', temp: '5'),
  ];

  List<Bin> getBinList() {
    return bins;
  }
}
