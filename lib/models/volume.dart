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

class Volume{

  List<List<double>> _volumes;
  List<String> _supportedUnits;
  Map<String, Set<String>> _unitNames;

  Volume(){
    // Create all supported units
    _supportedUnits = ['teaspoon', 'tablespoon', 'fluid ounce', 'cups', 'pint', 'quart', 'gallon', 'milliliter', 'liter'];
    // Map all abbreviations
    _unitNames[_supportedUnits[0]] = Set.from(["tsp.", "t", "teaspoon", "tea spoon", "tea-spoon"]);
    _unitNames[_supportedUnits[1]] = Set.from(["T.", "tbs.", "tb.",
      "tbsp.", "tablespoon", "table spoon", "table-spoon"]);
    _unitNames[_supportedUnits[2]] = Set.from(["oz.", "fl oz", "fl-oz", "fluidounce", "fluid ounce", "fluid-ounce"]);
    _unitNames[_supportedUnits[3]] = Set.from(["c.","cup", "cups", "C."]);
    _unitNames[_supportedUnits[4]] = Set.from(["pint", "Pint", "pints", "pt."]);
    _unitNames[_supportedUnits[5]] = Set.from(["qt.", "Quart", "quart", "quarts"]);
    _unitNames[_supportedUnits[6]] = Set.from(["Gallon", "gallons", "gal.", "gall."]);
    _unitNames[_supportedUnits[7]] = Set.from(["milliliter", "M", "ml", "mil",]);
    _unitNames[_supportedUnits[8]] = Set.from(["liter", "L", "l"]);
    // Create adjacency matrix
    initVolumeMatrix();
  }



  void initVolumeMatrix(){
    _volumes = List.generate(_supportedUnits.length, (i) => List(_supportedUnits.length), growable: false);
    //'teaspoon', 'tablespoon', 'fluid ounce', 'cups', 'pint', 'quart', 'gallon', 'milliliter', 'liter'
    // Define all conversions for teaspoons
    _volumes[0][0] = 1;
    _volumes[0][1] = 0.333333;
    _volumes[0][2] = 0.166667;
    _volumes[0][3] = 0.0208333;
    _volumes[0][4] = 0.0104167;
    _volumes[0][5] = 0.00520833;
    _volumes[0][6] = 0.00130208;
    _volumes[0][6] = 4.92892;
    _volumes[0][6] = 0.00492892;

    //'teaspoon', 'tablespoon', 'fluid ounce', 'cups', 'pint', 'quart', 'gallon', 'milliliter', 'liter'
    // Define all conversions for tablespoons
    _volumes[1][0] = 3;
    _volumes[1][1] = 1;
    _volumes[1][2] = 0.5;
    _volumes[1][3] = 0.0625;
    _volumes[1][4] = 0.03125;
    _volumes[1][5] = 0.015625;
    _volumes[1][6] = 0.00390625;
    _volumes[1][6] = 14.7868;
    _volumes[1][6] = 0.0147868;

    //'teaspoon', 'tablespoon', 'fluid ounce', 'cups', 'pint', 'quart', 'gallon', 'milliliter', 'liter'
    // Define all conversions for fluid ounce
    _volumes[2][0] = 6;
    _volumes[2][1] = 2;
    _volumes[2][2] = 1;
    _volumes[2][3] = 0.125;
    _volumes[2][4] = 0.0625;
    _volumes[2][5] = 0.03125;
    _volumes[2][6] = 0.0078125;
    _volumes[2][6] = 29.5735;
    _volumes[2][6] = 0.0295735;

    //'teaspoon', 'tablespoon', 'fluid ounce', 'cups', 'pint', 'quart', 'gallon', 'milliliter', 'liter'
    // Define all conversions for cups
    _volumes[3][0] = 48;
    _volumes[3][1] = 16;
    _volumes[3][2] = 8;
    _volumes[3][3] = 1;
    _volumes[3][4] = 0.5;
    _volumes[3][5] = 0.25;
    _volumes[3][6] = 0.0625;
    _volumes[3][6] = 236.588;
    _volumes[3][6] = 0.236588;

    //'teaspoon', 'tablespoon', 'fluid ounce', 'cups', 'pint', 'quart', 'gallon', 'milliliter', 'liter'
    // Define all conversions for pint
    _volumes[4][0] = 96;
    _volumes[4][1] = 32;
    _volumes[4][2] = 16;
    _volumes[4][3] = 2;
    _volumes[4][4] = 1;
    _volumes[4][5] = 0.5;
    _volumes[4][6] = 0.125;
    _volumes[4][6] = 473.176;
    _volumes[4][6] = 0.473176;

    //'teaspoon', 'tablespoon', 'fluid ounce', 'cups', 'pint', 'quart', 'gallon', 'milliliter', 'liter'
    // Define all conversions for quart
    _volumes[5][0] = 192;
    _volumes[5][1] = 64;
    _volumes[5][2] = 32;
    _volumes[5][3] = 4;
    _volumes[5][4] = 2;
    _volumes[5][5] = 1;
    _volumes[5][6] = 0.25;
    _volumes[5][6] = 946.353;
    _volumes[5][6] = 0.946353;

    //'teaspoon', 'tablespoon', 'fluid ounce', 'cups', 'pint', 'quart', 'gallon', 'milliliter', 'liter'
    // Define all conversions for gallon
    _volumes[6][0] = 768;
    _volumes[6][1] = 256;
    _volumes[6][2] = 128;
    _volumes[6][3] = 16;
    _volumes[6][4] = 8;
    _volumes[6][5] = 4;
    _volumes[6][6] = 1;
    _volumes[6][6] = 3785.41;
    _volumes[6][6] = 3.78541;

    //'teaspoon', 'tablespoon', 'fluid ounce', 'cups', 'pint', 'quart', 'gallon', 'milliliter', 'liter'
    // Define all conversions for milliliter
    _volumes[7][0] = 0.202884;
    _volumes[7][1] = 0.067628;
    _volumes[7][2] = 0.033814;
    _volumes[7][3] = 0.00422675;
    _volumes[7][4] = 0.00211338;
    _volumes[7][5] = 0.00105669;
    _volumes[7][6] = 0.000264172;
    _volumes[7][6] = 1;
    _volumes[7][6] = 0.001;

    //'teaspoon', 'tablespoon', 'fluid ounce', 'cups', 'pint', 'quart', 'gallon', 'milliliter', 'liter'
    // Define all conversions for liter
    _volumes[8][0] = 202.884;
    _volumes[8][1] = 67.628;
    _volumes[8][2] = 33.814;
    _volumes[8][3] = 4.22675;
    _volumes[8][4] = 2.11338;
    _volumes[8][5] = 1.05669;
    _volumes[8][6] = 0.264172;
    _volumes[8][6] = 1000;
    _volumes[8][6] = 1;
  }
}