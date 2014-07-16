class FirstSteps()
{
	print("Hello World!");

	shared void exploringLiterals()
	{
		stepTitle("Exploring literals");

		title("Simple multiline string");
		// Indenting is mandatory, and removed by the compiler
		String simple = "Simple string (multiline), with escapes\nand with Unicode literals:
		                 \{#00B6} - Numerical (hexa) - 00B6
		                 \{PILCROW SIGN} - Unicode official name - PILCROW SIGN
		                 ¶ - Literal pasted in the code";
		print(simple);

		title("String interpolation");
		void fn() // No anonymous blocks allowed, apparently, so I make a function to scope the variables
		{
			Character c = 'z';
			String s = "Foo";
			Integer i = 42M; // M = mega = 1e6
			Integer b = $0100_1010; // Binary literal
			Integer h = #BABE_1BEE; // Hexadecimal literal
			Float f = 3.141_592_653_589_793_23u; // u = µ = micro = 1e-6
			print("I can embed a reference to a character ``c`` or string (``s.uppercased``)
			       or to numbers like ``i`` or even computations: ``i * f``.
			       No formatting? Binary: ``b`` - Hexa: ``h``".normalized); // normalized => no line breaks
		}
		fn();

		title("Literal string");
		String literal = """
		                    String with no "interpolation" nor "escapes":
		                    No escape \o/ and ``no interpolation``.
		                    """; // Newlines are kept as is
		print(literal);

		title("An iterable literal");
		{String+} iterable = { "a", "b", "c" };
		print(iterable); // When printing it, the iterable becomes a sequence

		title("A sequence literal");
		[String+] sequence = [ "A", "B", "C" ];
		print(sequence);
		print(sequence[1]);
		// Another notation
		String[] array = [ "ichi", "ni", "san" ];
		String? maybe = array[10]; // String or null
		print(maybe);

		title("Sequence of key, value pairs");
		// Using type inference
		value almostMap = [ "1"->"a", "2"->"b", "3"->"c" ];
		print(almostMap);

		title("Tuple");
		// Heterogenous sequence
		value tuple = [ true, 1, 2.0, '§', "Boo", "k"->"v" ];
		print(tuple);
	}

	shared void someBaseTypes()
	{
		stepTitle("Some base types");
		// Skipping Character, String, Integer, Float seen above

		// Official name for {String+}
		Iterable<String> iterable = { "Alpha", "Beta", "Gamma", "Alpha" };
		// Official name for [String+]
		Sequence<String->String> sequence = [ "one"->"ichi", "two"->"ni", "three"->"san", "seven"->"sichi", "seven"->"nana" ];

		// Just use them...
		print(iterable.contains("Alpha"));
		print(sequence.collect((String->String element) => element.key == "seven" then "Foo" else element.item));

		title("List of strings (array)");
		List<String> list = arrayOfSize { size = 5; element = "Yay!"; }; // Named parameters
		assert(is Array<String> list); // Narrow down the type to Array
		list.set(2, "Wee!");
		print(list);

		title("Set of strings (from iterable)");
// Removed in 1.1?
//		Set<String> set = LazySet(iterable);
// In non-final 1.1, that's the only concrete Set we have!
		Set<String> set = emptySet;
		print(set);
		print(set.contains("alpha"));

		title("Map of strings to strings (from sequence)");
// Removed in 1.1?
//		Map<String, String> map = LazyMap(sequence);
// In non-final 1.1, that's the only concrete Map we have!
		Map<String, String> map = emptyMap;
		print(map);
		print(map["seven"]);

		title("Range of characters");
		Range<Character> rl = 'a'..'z';
		print(rl);
		print("x in range? ``'x' in rl``");

		title("Segment of characters");
		Character[] ru = 'A':26;
		print(ru);
		print("X in segment? ``'X' in ru``");
	}

	shared void control()
	{
		stepTitle("Controls: conditionals and loops");

		Boolean a = true;
		variable Boolean b = false;
		if (b = a) // Ow, Ceylon allows this... :-(
		{
			print("Ow");
		}
	}
}
