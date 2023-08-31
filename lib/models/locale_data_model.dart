import 'package:hive/hive.dart';

part 'locale_data_model.g.dart';

@HiveType(typeId: 1)
class LocaleDataModel extends HiveObject {
  @HiveField(1)
  String? id;
  @HiveField(2)
  String? fonAdi;
  @HiveField(3)
  String? fonKodu;
  @HiveField(4)
  String? adet;
  @HiveField(5)
  String? fiyat;
  @HiveField(6)
  String? maliyet;
  @HiveField(7)
  String? dolar;
  @HiveField(8)
  String? dolarMaliyet;
  LocaleDataModel(
      {required this.id,
      required this.fonAdi,
      required this.fonKodu,
      required this.adet,
      required this.fiyat,
      required this.maliyet,
      required this.dolar,
      required this.dolarMaliyet});

  factory LocaleDataModel.addData({
    required String? id,
    String? fonAdi,
    String? fonKodu,
    String? adet,
    String? fiyat,
    String? dolar,
  }) {
    String maliyet = (double.parse(fiyat!) * double.parse(adet!)).toString();
    return LocaleDataModel(
      id: id,
      fonAdi: fonAdi,
      fonKodu: fonKodu,
      fiyat: fiyat,
      adet: adet,
      dolar: dolar,
      maliyet: maliyet,
      dolarMaliyet: (double.parse(maliyet) / double.parse(dolar!)).toString(),
    );
  }
}
