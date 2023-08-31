// ignore_for_file: public_member_api_docs, sort_constructors_first
class DataGsheetsData {
  String? tarih;
  String? fonKodu;
  String? fonAdi;
  String? fiyat;
  String? paySayisi;
  String? kisiSayisi;
  String? fonToplam;
  String? birAy;
  String? ucAy;
  String? altiAy;
  String? yilbasi;
  String? birYil;
  String? ucYil;
  String? besYil;
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
    this.paySayisi,
    this.kisiSayisi,
    this.fonToplam,
    this.birAy,
    this.ucAy,
    this.altiAy,
    this.yilbasi,
    this.birYil,
    this.ucYil,
    this.besYil,
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
        paySayisi: json[4],
        kisiSayisi: json[5],
        fonToplam: json[6],
        birAy: json[7] == "-" ? "0" : json[7],
        ucAy: json[8] == "-" ? "0" : json[8],
        altiAy: json[9] == "-" ? "0" : json[9],
        yilbasi: json[10] == "-" ? "0" : json[10],
        birYil: json[11] == "-" ? "0" : json[11],
        ucYil: json[12] == "-" ? "0" : json[12],
        besYil: json[13] == "-" ? "0" : json[13],
        gunluk: json[14] == "" ? "0" : json[14],
        dolar: json[15],
        eur: json[16],
        sterlin: json[17],
        bist: json[18],
        btc: json[19],
      );

  compareTo(DataGsheetsData a) {}
}
