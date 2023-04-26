class AddVehicleRequest {
  AddVehicleRequest({
    required this.name,
    required this.serialNumber,
    required this.warrantyNumber,
  });

  final String name;
  final String serialNumber;
  final String warrantyNumber;

  Map<String, dynamic> toJson() => {
        'name': name,
        'serialNumber': serialNumber,
        'warrantyNumber': warrantyNumber,
      };
}
