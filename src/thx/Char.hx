package thx;

import haxe.Utf8;

/**
Represents one Utf8 character stored as an integer value.
*/
abstract Char(Int)  {
/**
Retrieve a `Char` at the specified position `index` in string `s`.
*/
  public static function at(s : String, index : Int) : Char
    return Utf8.charCodeAt(s, index);

/**
Converts an `Int` value to `Char`.
*/
  @:from inline public static function fromInt(i : Int) : Char {
    Assert.isTrue(i >= 0, 'Char value should be greater than zero: $i');
    return new Char(i);
  }

/**
Converts a `String` into a `Char.` Only the first character in the string
is used in the conversion.
*/
  @:from inline public static function fromString(s : String) : Char
    return Utf8.charCodeAt(s, 0);

  inline function new(i : Int)
    this = i;

/**
Compares two chars returning -1, 0 or 1.
*/
  inline public function compare(other : Char) : Int
    return Utf8.compare(toString(), other);

/**
Returns true if the character is a control character.
*/
  public function isControl()
    return (this >= 0x0000 && this <= 0x001F) || this == 0x007F || (this >= 0x0080 && this <= 0x009F);

/**
Returns the next character incrementing its code by one.
*/
  public function next() : Char
    return this + 1;

/**
Returns the previous character decrementing its code by one.
*/
  public function prev() : Char
    return this - 1;

/**
Returns the upper case version if any of the character.
*/
  public function toUpperCase() : Char
    return toString().toUpperCase();

/**
Returns the lower case version if any of the character.
*/
  public function toLowerCase() : Char
    return toString().toLowerCase();

  @:op(A==B) inline public function equals(other : Char)
    return compare(other) == 0;

  @:op(A>B) inline public function greater(other : Char)
    return compare(other) > 0;

  @:op(A>=B) inline public function greaterEquals(other : Char)
    return compare(other) >= 0;

  @:op(A<=B) inline public function lessEquals(other : Char)
    return compare(other) <= 0;

  @:op(A<B) inline public function less(other : Char)
    return compare(other) < 0;

/**
Returns the character `Int` code that is also the internal
representation of this type.
*/
  @:to inline public function toInt() : Int
    return this;

/**
Converts a `Char` to `String`.
*/
  @:to #if !(neko || php || cpp) inline #end public function toString() : String {
    #if (neko || php || cpp)
    var c = new Utf8();
    c.addChar(this);
    return c.toString();
    #else
    return String.fromCharCode(this);
    #end
  }

/**
Converts an array of `Char`s to `String`.
*/
  public static function arrayToString(arr : Array<Char>) : String
    return arr.map(function(c : Char) : String return c.toString()).join("");
}