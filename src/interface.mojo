from std.io import input
from .utils import test_converter, Conversion
from .converters import (
    LengthConversion,
    LiquidConversion,
    SpeedConversion,
    TemperatureConversion,
    WeightConversion
)

struct ConversionInterface:
    var converter_selections : List[String]
    var global_history : List[String]
    var available_options : String
    var available_options_converter : String
    var quit_options : List[String]

    def __init__(out self):
        self.converter_selections : List[String] = ["Temperature", "Length", "Liquid", "Speed", "Weight"]
        self.global_history : List[String] = []
        self.quit_options : List[String] = ["exit", "q", "quit"]
        
        self.available_options : String = """ 
What would you like to do?
* 1. Use a converter.
* 2. View available converters.
* 3. View the global conversion history.
* 4. Test a converter.
* You can exit the program by entering "exit", "q", or "quit".       
"""
        self.available_options_converter : String = """
What would you like to do?
* 1. Convert a unit.
* 2. View the available conversions for this converter.
* 3. Change the amount of decimal places the converter rounds to.
* 4. Change if a converter prints the conversion.
* 5. Print the history of conversions for a converter. 
* You can finish using this converter by entering "exit", "q", or "quit".
"""

    def start_converter(mut self : Self) raises -> None:
        print("Welcome to the Unit Conversion Interface!")
        while True:
            print(self.available_options)
            var option : String = input("Option:")
            print("\n")

            if option == "1":
                var converter_selection : String = input("Please enter an available converter:")
                if converter_selection not in self.converter_selections:
                    print(t"Error: {converter_selection} is not a valid converter.")
                    continue
                self.select_converter(converter_selection)
            elif option == "2":
                print("Available converter selections are:")
                for converter in self.converter_selections:
                    print(t"* {converter}")
            elif option == "3":
                self.print_global_history()
            elif option == "4":
                var converter_selection : String = input("Please enter an available converter to test:")
                if converter_selection not in self.converter_selections:
                    print(t"Error: {converter_selection} is not a valid converter.")
                    continue
                try:
                    var unit_value : Float64 = Float64(input("Please enter the value you would like for the test:"))
                    var from_unit : String = input("Please enter the unit you are converting from for the test:")
                    self.select_converter(converter_selection, True, unit_value, from_unit)
                except:
                    print("Error: An incorrect value was enterted.")
            elif option in self.quit_options:
                print("Exiting converter interface.")
                break
            else:
                print("Error: No valid option was chosen.")

    def print_global_history(self : Self) -> None:
        print("Printing Global History of Converters:")
        for item in self.global_history:
            print(t"* {item}")

    def use_converter[C : Conversion](mut self : Self, mut converter : C) raises -> None:  
        while True:
            print(self.available_options_converter)
            var option : String = input("Option:")
            print("\n")

            if option == "1":
                try:
                    var unit_value : Float64 = Float64(input("Please enter the value you would like to convert:"))
                    var from_unit : String = input("Please enter the unit you are converting from:")
                    var to_unit : String = input("Please enter the unit you are converting to:")
                    converter.convert_unit(unit_value, from_unit, to_unit)
                    print(t"Unit conversion successful.")
                except:
                    print("Error: An incorrect value was enterted.")
            elif option == "2":
                converter.available_conversions()
            elif option == "3":
                try:
                    var n_digits : Int = Int(input("Please enter the amount of decimal places you would like the converter to round to:"))
                    converter.change_n_digits(n_digits)
                    print(t"Conversions will now be rounded to {n_digits} decimal places.")
                except:
                    print("Error: An incorrect value was enterted.")
            elif option == "4":
                var str_change : String = String(input("Please enter either True to print the conversions or False to not print the conversions:"))
                var bool_change : Bool
                if str_change != "True" and str_change != "False":
                    print("Error: An incorrect value was enterted.")
                    continue
                elif str_change == "True":
                    bool_change = True
                else:
                    bool_change = False
                converter.change_print_conversion(bool_change)
                print(t"Changed the print conversion field to {str_change}")
            elif option == "5":
                print(converter)
            elif option in self.quit_options:
                print("Exiting converter and saving conversion history.")
                self.global_history.extend(converter.get_history())
                break
            else:
                print("Error: No valid option was chosen.")

    def select_converter(
        mut self : Self, 
        conversion_selection : String, 
        test : Bool = False,
        unit_value : Float64 = 0.0,
        from_unit : String = ""
    ) raises -> None:
        if conversion_selection == "Temperature":
            var temperature_converter : TemperatureConversion = TemperatureConversion()
            if test: test_converter(temperature_converter, unit_value, from_unit) else: self.use_converter(temperature_converter)
        elif conversion_selection == "Length":
            var length_converter : LengthConversion = LengthConversion()
            if test: test_converter(length_converter, unit_value, from_unit) else: self.use_converter(length_converter)
        elif conversion_selection == "Speed":
            var speed_converter : SpeedConversion = SpeedConversion()
            if test: test_converter(speed_converter, unit_value, from_unit) else: self.use_converter(speed_converter)
        elif conversion_selection == "Liquid":
            var liquid_converter : LiquidConversion = LiquidConversion()
            if test: test_converter(liquid_converter, unit_value, from_unit) else: self.use_converter(liquid_converter)
        else:
            var weight_converter : WeightConversion = WeightConversion()
            if test: test_converter(weight_converter, unit_value, from_unit) else: self.use_converter(weight_converter)