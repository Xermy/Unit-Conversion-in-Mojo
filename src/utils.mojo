from std.testing import assert_true

trait Conversion(Writable, Copyable, Movable):
    def available_conversions(self : Self) -> None:
        ...
    def get_unit_names(self : Self) -> List[String]:
        ...
    def change_n_digits(mut self : Self, n_digits : Int) -> None:
        ...
    def change_print_conversion(mut self : Self, change : Bool) -> None:
        ...
    def convert_unit(mut self : Self, unit_value : Float64, from_unit : String, to_unit : String) raises -> None:
        ...
    def get_history(self : Self) -> List[String]:
        ...
    def incorrect_conversion_error_message(self : Self) -> None:
        print("Error: An incorrect conversion unit was chosen")
        return None

def test_converter[C : Conversion](mut converter : C, unit_value : Float64, to_name : String) raises ->  None:
    converter.available_conversions()
    
    var unit_names : List[String] = converter.get_unit_names()
    assert_true(to_name in unit_names, String(t"{to_name} does not appear in unit_names, please enter a valid unit name."))
    
    for name in unit_names:
        var current_name : String = name
        var to_temp_name : String = to_name
        if current_name == to_temp_name:
            if unit_names.index(to_temp_name)-1 >= 0:
                to_temp_name = unit_names[unit_names.index(to_temp_name)-1]
            else:
                to_temp_name = unit_names[unit_names.index(to_temp_name)+1]
        converter.convert_unit(unit_value, current_name, to_temp_name)
    
    print(converter)