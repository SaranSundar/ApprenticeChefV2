//Volume
//teaspoon (also t or tsp.)
//tablespoon (also T, tbl., tbs., or tbsp.)
//fluid ounce (also fl oz)
//cup (also c)
//pint (also p, pt, or fl pt - Specify Imperial or US)
//quart (also q, qt, or fl qt - Specify Imperial or US)
//gallon (also g or gal - Specify Imperial or US)
//ml, also milliliter, millilitre, cc (and mL only in the US, Canada and Australia).
//l, also liter, litre, (and L only in the US, Canada and Australia).

import 'dart:math';

void main() {
  Volume();
}

class Volume {
  List<List<double>> _volumes;
  List<String> _supportedUnits;
  Map<String, Set<String>> _unitNames;

  Volume() {
    // Create all supported units
    _supportedUnits = [
      'teaspoon',
      'tablespoon',
      'fluid ounce',
      'cups',
      'pint',
      'quart',
      'gallon',
      'milliliter',
      'liter'
    ];
    // Map all abbreviations
    _unitNames = new Map();
    _unitNames[_supportedUnits[0]] =
        Set.from(["tsp.", "t", "teaspoon", "tea spoon", "tea-spoon"]);
    _unitNames[_supportedUnits[1]] = Set.from([
      "T.",
      "tbs.",
      "tb.",
      "tbsp.",
      "tablespoon",
      "table spoon",
      "table-spoon"
    ]);
    _unitNames[_supportedUnits[2]] = Set.from(
        ["oz.", "fl oz", "fl-oz", "fluidounce", "fluid ounce", "fluid-ounce"]);
    _unitNames[_supportedUnits[3]] = Set.from(["c.", "cup", "cups", "C."]);
    _unitNames[_supportedUnits[4]] = Set.from(["pint", "Pint", "pints", "pt."]);
    _unitNames[_supportedUnits[5]] =
        Set.from(["qt.", "Quart", "quart", "quarts"]);
    _unitNames[_supportedUnits[6]] =
        Set.from(["Gallon", "gallons", "gal.", "gall."]);
    _unitNames[_supportedUnits[7]] = Set.from([
      "milliliter",
      "M",
      "ml",
      "mil",
    ]);
    _unitNames[_supportedUnits[8]] = Set.from(["liter", "L", "l"]);
    // Create adjacency matrix
    initVolumeMatrix();
    print(calculateNearestWholeUnit("cups", 0.5));
  }

  Map<String, double> calculateNearestWholeUnit(String unit, double amount) {
    // Find the unit in supportedUnits
    bool found = false;
    for (String supportedUnit in _supportedUnits) {
      for (String abbreviation in _unitNames[supportedUnit]) {
        if (unit == abbreviation) {
          // Found
          unit = supportedUnit;
          found = true;
          break;
        }
      }
      if (found) {
        break;
      }
    }
    if (!found) {
      print(
          "You can try fuzzy matching here, but as of now the unit is not supported if it is not found");
      return null;
    }
    // Create all conversions
    int row = _supportedUnits.indexOf(unit);
    List<double> conversions = new List(_volumes[row].length);
    double nearestWholeUnit = amount;
    for (int c = 0; c < _volumes[row].length; c++) {
      double conversion = _volumes[row][c] * amount;
      conversions[c] = conversion;
    }
    // Find nearest whole unit
    List<double> remainders = [0.25, 0.33, 0.5, 0.75];
    Map<String, double> possibleAnswers = new Map();
    for (int i = 0; i < conversions.length; i++) {
      double conversion = conversions[i];
      // Prioritization
      // 0.25, 0.5, 0.75, 2 better then 0.375, 0.543
      double remainder =
          roundDouble((conversion - conversion.toInt()).abs(), 2);
      if (remainder == 0) {
        unit = _supportedUnits[i];
        print("Unit: " + unit + " Amount: " + conversion.toString());
        nearestWholeUnit = conversion;
        possibleAnswers[unit] = conversion;
      } else if (remainders.contains(remainder)) {
        print("Remainder is " + remainder.toString());
        nearestWholeUnit = conversion;
        unit = _supportedUnits[i];
        print("Unit: " + unit + " Amount: " + conversion.toString());
        possibleAnswers[unit] = conversion;
      }
    }
    //print(possibleAnswers);
//    Tuple2(unit, nearestWholeUnit);
    possibleAnswers["answer-" + unit] = nearestWholeUnit;
    return possibleAnswers;
  }

  double roundDouble(double value, int places) {
    double mod = pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
  }

  void initVolumeMatrix() {
    _volumes = List.generate(
        _supportedUnits.length, (i) => List(_supportedUnits.length),
        growable: false);
    //'teaspoon', 'tablespoon', 'fluid ounce', 'cups', 'pint', 'quart', 'gallon', 'milliliter', 'liter'
    // Define all conversions for teaspoons
    _volumes[0][0] = 1;
    _volumes[0][1] = 0.333333;
    _volumes[0][2] = 0.166667;
    _volumes[0][3] = 0.0208333;
    _volumes[0][4] = 0.0104167;
    _volumes[0][5] = 0.00520833;
    _volumes[0][6] = 0.00130208;
    _volumes[0][7] = 4.92892;
    _volumes[0][8] = 0.00492892;

    //'teaspoon', 'tablespoon', 'fluid ounce', 'cups', 'pint', 'quart', 'gallon', 'milliliter', 'liter'
    // Define all conversions for tablespoons
    _volumes[1][0] = 3;
    _volumes[1][1] = 1;
    _volumes[1][2] = 0.5;
    _volumes[1][3] = 0.0625;
    _volumes[1][4] = 0.03125;
    _volumes[1][5] = 0.015625;
    _volumes[1][6] = 0.00390625;
    _volumes[1][7] = 14.7868;
    _volumes[1][8] = 0.0147868;

    //'teaspoon', 'tablespoon', 'fluid ounce', 'cups', 'pint', 'quart', 'gallon', 'milliliter', 'liter'
    // Define all conversions for fluid ounce
    _volumes[2][0] = 6;
    _volumes[2][1] = 2;
    _volumes[2][2] = 1;
    _volumes[2][3] = 0.125;
    _volumes[2][4] = 0.0625;
    _volumes[2][5] = 0.03125;
    _volumes[2][6] = 0.0078125;
    _volumes[2][7] = 29.5735;
    _volumes[2][8] = 0.0295735;

    //'teaspoon', 'tablespoon', 'fluid ounce', 'cups', 'pint', 'quart', 'gallon', 'milliliter', 'liter'
    // Define all conversions for cups
    _volumes[3][0] = 48;
    _volumes[3][1] = 16;
    _volumes[3][2] = 8;
    _volumes[3][3] = 1;
    _volumes[3][4] = 0.5;
    _volumes[3][5] = 0.25;
    _volumes[3][6] = 0.0625;
    _volumes[3][7] = 236.588;
    _volumes[3][8] = 0.236588;

    //'teaspoon', 'tablespoon', 'fluid ounce', 'cups', 'pint', 'quart', 'gallon', 'milliliter', 'liter'
    // Define all conversions for pint
    _volumes[4][0] = 96;
    _volumes[4][1] = 32;
    _volumes[4][2] = 16;
    _volumes[4][3] = 2;
    _volumes[4][4] = 1;
    _volumes[4][5] = 0.5;
    _volumes[4][6] = 0.125;
    _volumes[4][7] = 473.176;
    _volumes[4][8] = 0.473176;

    //'teaspoon', 'tablespoon', 'fluid ounce', 'cups', 'pint', 'quart', 'gallon', 'milliliter', 'liter'
    // Define all conversions for quart
    _volumes[5][0] = 192;
    _volumes[5][1] = 64;
    _volumes[5][2] = 32;
    _volumes[5][3] = 4;
    _volumes[5][4] = 2;
    _volumes[5][5] = 1;
    _volumes[5][6] = 0.25;
    _volumes[5][7] = 946.353;
    _volumes[5][8] = 0.946353;

    //'teaspoon', 'tablespoon', 'fluid ounce', 'cups', 'pint', 'quart', 'gallon', 'milliliter', 'liter'
    // Define all conversions for gallon
    _volumes[6][0] = 768;
    _volumes[6][1] = 256;
    _volumes[6][2] = 128;
    _volumes[6][3] = 16;
    _volumes[6][4] = 8;
    _volumes[6][5] = 4;
    _volumes[6][6] = 1;
    _volumes[6][7] = 3785.41;
    _volumes[6][8] = 3.78541;

    //'teaspoon', 'tablespoon', 'fluid ounce', 'cups', 'pint', 'quart', 'gallon', 'milliliter', 'liter'
    // Define all conversions for milliliter
    _volumes[7][0] = 0.202884;
    _volumes[7][1] = 0.067628;
    _volumes[7][2] = 0.033814;
    _volumes[7][3] = 0.00422675;
    _volumes[7][4] = 0.00211338;
    _volumes[7][5] = 0.00105669;
    _volumes[7][6] = 0.000264172;
    _volumes[7][7] = 1;
    _volumes[7][8] = 0.001;

    //'teaspoon', 'tablespoon', 'fluid ounce', 'cups', 'pint', 'quart', 'gallon', 'milliliter', 'liter'
    // Define all conversions for liter
    _volumes[8][0] = 202.884;
    _volumes[8][1] = 67.628;
    _volumes[8][2] = 33.814;
    _volumes[8][3] = 4.22675;
    _volumes[8][4] = 2.11338;
    _volumes[8][5] = 1.05669;
    _volumes[8][6] = 0.264172;
    _volumes[8][7] = 1000;
    _volumes[8][8] = 1;
  }
}
