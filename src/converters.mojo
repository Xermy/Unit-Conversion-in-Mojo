from .utils import Conversion
from std.math import round

struct LengthConversion(Conversion):
    var unit_conversion : Dict[String, Float64]
    var unit_names : List[String]
    var conversion_history : List[String]
    var print_conversion : Bool
    var n_digits : Int
     
    def __init__(out self : Self, n_digits : Int = 8):
        self.unit_conversion : Dict[String, Float64] = {
            "Kilometer" : 1000000000000,
            "Meter" : 1000000000,
            "Centimeter" : 10000000,
            "Millimeter" : 1000000,
            "Micrometer" : 1000,
            "Nanometer" : 1,
            "Angstrom" : 0.1,
            "Mile" : 1.609e+12,
            "Yard" : 9.144e+8,
            "Feet" : 3.048e+8,
            "Inch" : 2.54e+7,
            "Nautical Mile" : 1.852e+12,
            "Astronomical Unit" : 1.496e+20,
            "Light Year" : 9.461e+24
        }
        self.unit_names : List[String] = List[String](self.unit_conversion.keys())
        self.conversion_history : List[String] = []
        self.print_conversion : Bool = False
        self.n_digits = n_digits

    def get_unit_names(self : Self) -> List[String]:
        return self.unit_names.copy()

    def change_n_digits(mut self : Self, n_digits : Int) -> None:
        self.n_digits = n_digits

    def change_print_conversion(mut self : Self, change : Bool) -> None:
        self.print_conversion = change

    def get_history(self : Self) -> List[String]:
        return self.conversion_history.copy()

    def available_conversions(self : Self) -> None:
        print("Available Conversion Units for Length Conversion:")

        for unit_name in self.unit_names:
            print(t"* {unit_name}")
        
    def convert_unit(mut self : Self, unit_value : Float64, from_unit : String, to_unit : String) raises -> None:
        if from_unit not in self.unit_names or to_unit not in self.unit_names:
            self.incorrect_conversion_error_message()
        
        var length_to_nm : Float64 = self.unit_conversion[from_unit] * unit_value
        var converted_length : Float64 = round(length_to_nm / self.unit_conversion[to_unit], self.n_digits)
        
        var conversion_message : String = String(t"{from_unit}({unit_value}) to {to_unit}({converted_length})")
        self.conversion_history.append(conversion_message)
        
        if self.print_conversion:
            print(conversion_message)

    def write_to(self : Self, mut writer : Some[Writer]) -> None:
        writer.write_string("Length Conversion History:\n")
        
        for item in self.conversion_history:
            writer.write_string(String(t"{item}\n"))

struct LiquidConversion(Conversion):
    var unit_conversion : Dict[String, Float64]
    var unit_names : List[String]
    var conversion_history : List[String]
    var print_conversion : Bool
    var n_digits : Int

    def __init__(out self : Self, n_digits : Int = 2):
        self.unit_conversion : Dict[String, Float64] = {
            "US liquid gallon" : 3785,
            "US liquid quart" : 946.4,
            "US liquid pint" : 473.2,
            "US legal cup" : 240,
            "US fluid ounce" : 29.574,
            "US tablespoon" : 14.787,
            "US teaspoon" : 4.929,
            "Cubic Meter" : 1e+6,
            "Liter" : 1000,
            "Milliliter" : 1,
            "Imperial gallon" : 4546,
            "Imperial quart" : 1137,
            "Imperial pint" : 568.3,
            "Imperial cup" : 284.1,
            "Imperial fluid ounce" : 28.413,
            "Imperial tablespoon" : 17.758,
            "Imperial teaspoon" : 5.919,
            "Cubic foot" : 28320,
            "Cubic inch" : 16.387
        }         
        self.unit_names : List[String] = List[String](self.unit_conversion.keys())
        self.conversion_history : List[String] = []
        self.print_conversion : Bool = False
        self.n_digits = n_digits

    def get_unit_names(self : Self) -> List[String]:
        return self.unit_names.copy()

    def change_n_digits(mut self : Self, n_digits : Int) -> None:
        self.n_digits = n_digits

    def change_print_conversion(mut self : Self, change : Bool) -> None:
        self.print_conversion = change

    def get_history(self : Self) -> List[String]:
        return self.conversion_history.copy()
    
    def convert_unit(mut self : Self, unit_value : Float64, from_unit : String, to_unit : String) raises -> None:
        if from_unit not in self.unit_names or to_unit not in self.unit_names:
            self.incorrect_conversion_error_message()
            
        var liquid_to_ml : Float64 = unit_value * self.unit_conversion[from_unit]
        var ml_to_liquid : Float64 = round(liquid_to_ml / self.unit_conversion[to_unit], self.n_digits)

        var conversion_message : String = String(t"{from_unit}({unit_value}) to {to_unit}({ml_to_liquid})")
        self.conversion_history.append(conversion_message)

        if self.print_conversion:
            print(conversion_message)
    
    def available_conversions(self : Self) -> None:
        print("Available Conversion Units:")

        for unit_name in self.unit_names:
            print(t"* {unit_name}")

        print("\n")

    def write_to(self : Self, mut writer : Some[Writer]) -> None:
        writer.write_string("Liquid Conversion History:\n")

        for item in self.conversion_history:
            writer.write_string(String(t"{item}\n"))

struct SpeedConversion(Conversion):
    var unit_conversion : Dict[String, Float64]
    var unit_names : List[String]
    var conversion_history : List[String]
    var print_conversion : Bool
    var n_digits : Int

    def __init__(out self : Self, n_digits : Int = 2):
        self.unit_conversion : Dict[String, Float64] = {
            "Mile per hour" : 1.467,
            "Foot per second" : 1,
            "Meter per second" : 3.281,
            "Kilometer per hour" : 1.097,
            "Knot" : 1.688,
        }
        self.unit_names : List[String] = List[String](self.unit_conversion.keys())
        self.conversion_history : List[String] = []
        self.print_conversion : Bool = False
        self.n_digits = n_digits

    def get_unit_names(self : Self) -> List[String]:
        return self.unit_names.copy()

    def change_n_digits(mut self : Self, n_digits : Int) -> None:
        self.n_digits = n_digits

    def change_print_conversion(mut self : Self, change : Bool) -> None:
        self.print_conversion = change

    def get_history(self : Self) -> List[String]:
        return self.conversion_history.copy()
    
    def available_conversions(self : Self) -> None:
        print("Available Conversion Units for Speed Conversion:")

        for unit_name in self.unit_names:
            print(t"* {unit_name}")

    def convert_unit(mut self : Self, unit : Float64, from_unit : String, to_unit : String) raises -> None:
        if from_unit not in self.unit_names or to_unit not in self.unit_names:
            self.incorrect_conversion_error_message()
        
        var speed_to_foot_ph : Float64
        var foot_ph_to_speed : Float64

        if from_unit == "Kilometer per hour":
            speed_to_foot_ph = unit / self.unit_conversion[from_unit]
        else:
            speed_to_foot_ph = unit * self.unit_conversion[from_unit]

        if to_unit == "Kilometer per hour":
            foot_ph_to_speed = round(speed_to_foot_ph * self.unit_conversion[to_unit], self.n_digits)
        else:
            foot_ph_to_speed = round(speed_to_foot_ph / self.unit_conversion[to_unit], self.n_digits)

        var conversion_message : String = String(t"{from_unit}({unit}) to {to_unit}({foot_ph_to_speed})")
        self.conversion_history.append(conversion_message) 
        
        if self.print_conversion:
            print(foot_ph_to_speed)

    def write_to(self : Self, mut writer : Some[Writer]) -> None:
        writer.write_string("Speed Conversion History:\n")

        for item in self.conversion_history:
            writer.write_string(String(t"{item}\n"))

struct TemperatureConversion(Conversion):
    var unit_names : List[String]
    var conversion_history : List[String]
    var print_conversion : Bool
    var n_digits : Int 

    def __init__(out self, n_digits : Int = 2):
        self.conversion_history : List[String] = []
        self.unit_names : List[String] = ["Fahrenheit", "Celsius", "Rankine", "Kelvin"]
        self.print_conversion : Bool = False
        self.n_digits = n_digits

    def get_unit_names(self : Self) -> List[String]:
        return self.unit_names.copy()

    def change_n_digits(mut self : Self, n_digits : Int) -> None:
        self.n_digits = n_digits

    def change_print_conversion(mut self : Self, change : Bool) -> None:
        self.print_conversion = change

    def get_history(self : Self) -> List[String]:
        return self.conversion_history.copy()

    def available_conversions(self : Self) -> None:
        print("Available Conversion Units for Temperature Conversion:")

        for unit_name in self.unit_names:
            print(t"* {unit_name}")

    def from_celsius(self : Self, temperature : Float64, to_temp : String) -> Float64:
        var celsius_to_temperature : Float64

        if to_temp == "Celsius":
            celsius_to_temperature = temperature
        elif to_temp == "Fahrenheit":
            celsius_to_temperature = (temperature * 1.8) + 32
        elif to_temp == "Rankine":
            celsius_to_temperature = (temperature * 1.8) + 491.67
        else:
            celsius_to_temperature = temperature + 273.15

        return celsius_to_temperature

    def to_celsius(self : Self, temperature : Float64, from_temp : String) -> Float64:
        var temperature_to_celsius : Float64

        if from_temp == "Celsius":
            temperature_to_celsius = temperature
        elif from_temp == "Fahrenheit":
            temperature_to_celsius = (temperature - 32) / 1.8
        elif from_temp == "Rankine":
            temperature_to_celsius = (temperature - 491.67) / 1.8
        else:
            temperature_to_celsius = temperature - 273.15

        return temperature_to_celsius
    
    def convert_unit(mut self : Self, unit_value : Float64, from_unit : String, to_unit : String) raises -> None:
        if from_unit not in self.unit_names or to_unit not in self.unit_names:
            self.incorrect_conversion_error_message()

        var temperature_to_celsius : Float64 = self.to_celsius(unit_value, from_unit)
        var celsius_to_temperature : Float64 = round(self.from_celsius(temperature_to_celsius, to_unit), self.n_digits)
        
        var conversion_message : String = String(t"{from_unit}({unit_value}) to {to_unit}({celsius_to_temperature})")
        self.conversion_history.append(conversion_message)
        
        if self.print_conversion:
            print(conversion_message)

    def write_to(self : Self, mut writer : Some[Writer]) -> None:
        writer.write_string("Temperature Conversion History:\n")

        for item in self.conversion_history:
            writer.write_string(String(t"{item}\n"))

struct WeightConversion(Conversion):
    var unit_conversion : Dict[String, Float64]
    var unit_names : List[String]
    var conversion_history : List[String]
    var print_conversion : Bool
    var n_digits : Int

    def __init__(out self : Self, n_digits : Int = 2):
        self.unit_conversion : Dict[String, Float64] = {
            "Metric ton" : 1e+15,
            "Kilogram" : 1e+12,
            "Gram" : 1e+9,
            "Milligram" : 1e+6,
            "Microgram" : 1000,
            "Nanogram" : 1,
            "Imperial ton" : 1.016e+15,
            "US ton" : 9.072e+14,
            "Stone" : 6.35e+12,
            "Pound" : 4.536e+11,
            "Ounce" : 2.835e+10
        }
        self.unit_names : List[String] = List[String](self.unit_conversion.keys())
        self.conversion_history : List[String] = []
        self.print_conversion : Bool = False
        self.n_digits = n_digits

    def get_unit_names(self : Self) -> List[String]:
        return self.unit_names.copy()

    def change_n_digits(mut self : Self, n_digits : Int) -> None:
        self.n_digits = n_digits

    def change_print_conversion(mut self : Self, change : Bool) -> None:
        self.print_conversion = change

    def get_history(self : Self) -> List[String]:
        return self.conversion_history.copy()

    def available_conversions(self : Self) -> None:
        print("Available Conversion Units for Temperature Conversion:")

        for unit_name in self.unit_names:
            print(t"* {unit_name}")

    def convert_unit(mut self : Self, unit_value : Float64, from_unit : String, to_unit : String) raises -> None:
        if from_unit not in self.unit_names or to_unit not in self.unit_names:
            self.incorrect_conversion_error_message()

        var weight_to_ng : Float64 = unit_value * self.unit_conversion[from_unit]
        var ng_to_weight : Float64 = round(weight_to_ng / self.unit_conversion[to_unit], self.n_digits)

        var conversion_message : String = String(t"{from_unit}({unit_value}) to {to_unit}({ng_to_weight})")
        self.conversion_history.append(conversion_message)

        if self.print_conversion:
            print(conversion_message)

    def write_to(self : Self, mut writer : Some[Writer]) -> None:
        writer.write_string("Weight Conversion History:\n")

        for item in self.conversion_history:
            writer.write_string(String(t"{item}\n"))