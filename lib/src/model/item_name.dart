class ItemName{
  String label;
  String value;

  ItemName(this.label, this.value);

  ItemName.fromJson(Map<String, dynamic>json):label=json['label'],value=json['value'];

  @override
  String toString() {
    return 'ItemName{label: $label, value: $value}';
  }
}