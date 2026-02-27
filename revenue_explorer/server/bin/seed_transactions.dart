import 'dart:math';

final purchaser_names = <String>[
  "Sarah A.",
  "Josh B.",
  "Melissa C.",
  "Antonio D.",
  "Alice E.",
  "David F."
];

final product_codes = <String>[
  "1286_mgmt_sft",
  "3882_lpnt_hvs",
  "0346_ntdy_cns",
  "7735_cnin_dya"
];

void main(List<String> arguments) async {
  final prefix = """
    DELETE FROM "transaction";

    DELETE FROM sqlite_sequence WHERE name='transaction';

    INSERT INTO "transaction"
    (purchaser_name, purchase_date, transaction_amount, product_code)
    VALUES
  """;

  final random = new Random();
  final values = List.generate(500, (_) {
    final purchaser = purchaser_names[random.nextInt(purchaser_names.length)];
    final date = DateTime.now().add(Duration(days: -1 * random.nextInt(30)));
    final amount =
        double.parse(((random.nextDouble() * 950) + 50).toStringAsFixed(2));
    final product = product_codes[random.nextInt(product_codes.length)];

    return "('$purchaser', '${date.toIso8601String()}', $amount, '$product')";
  });

  print(prefix + values.join(',\n'));
}
