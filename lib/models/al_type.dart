// Works for both Payment method and Shipment Type
class AlType {
  String title, image, id;
  double fee;
  bool status;

  AlType({
    this.title,
    this.id,
    this.image,
    this.fee,
    this.status = false,
  });
}
