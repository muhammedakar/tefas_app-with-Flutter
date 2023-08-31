// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'locale_data_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LocaleDataModelAdapter extends TypeAdapter<LocaleDataModel> {
  @override
  final int typeId = 1;

  @override
  LocaleDataModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LocaleDataModel(
      id: fields[1] as String?,
      fonAdi: fields[2] as String?,
      fonKodu: fields[3] as String?,
      adet: fields[4] as String?,
      fiyat: fields[5] as String?,
      maliyet: fields[6] as String?,
      dolar: fields[7] as String?,
      dolarMaliyet: fields[8] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, LocaleDataModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.fonAdi)
      ..writeByte(3)
      ..write(obj.fonKodu)
      ..writeByte(4)
      ..write(obj.adet)
      ..writeByte(5)
      ..write(obj.fiyat)
      ..writeByte(6)
      ..write(obj.maliyet)
      ..writeByte(7)
      ..write(obj.dolar)
      ..writeByte(8)
      ..write(obj.dolarMaliyet);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocaleDataModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
