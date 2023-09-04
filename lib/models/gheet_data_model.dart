// ignore_for_file: public_member_api_docs, sort_constructors_first
class DataGsheetsData {
  String? tarih;
  String? fonKodu;
  String? fonAdi;
  String? fiyat;
  String? gunluk;
  String? dolar;
  String? eur;
  String? sterlin;
  String? bist;
  String? btc;

  DataGsheetsData({
    this.tarih,
    this.fonKodu,
    this.fonAdi,
    this.fiyat,
    this.gunluk,
    this.dolar,
    this.eur,
    this.sterlin,
    this.bist,
    this.btc,
  });

  factory DataGsheetsData.fromJson(List json) => DataGsheetsData(
        tarih: json[0],
        fonKodu: json[1],
        fonAdi: json[2],
        fiyat: json[3] == "-" ? "0" : json[3],
        gunluk: json[4] == "" ? "0" : json[4],
        dolar: json[5],
        eur: json[6],
        sterlin: json[7],
        bist: json[8],
        btc: json[9],
      );

  compareTo(DataGsheetsData a) {}
}
