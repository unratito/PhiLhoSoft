import ceylon.collection { HashSet, HashMap, LinkedList }

class FirstSteps()
{
	print("Hello World!");

	shared void exploringLiterals()
	{
		stepTitle("Exploring literals");

		title("Simple multiline string");
		// Indenting of string content is mandatory, and removed by the compiler. Newline are kept, though.
		String simple = "Simple string (multiline), with escapes\nand with Unicode literals:
		                 \{#00B6} - Numerical (hexa) - 00B6
		                 \{PILCROW SIGN} - Unicode official name - PILCROW SIGN
		                 ¶ - Literal pasted in the code";
		print(simple);

		title("String interpolation");
		void fn() // No anonymous blocks allowed, apparently, so I make a function to scope the variables
		{
			Character c = 'z';
			String s = "Foo déjà";
			Integer i = 42M; // M = mega = 1e6
			Integer b = $0100_1010; // Binary literal
			Integer h = #BABE_1BEE; // Hexadecimal literal
			Float f = 3.141_592_653_589_793_23u; // u = µ = micro = 1e-6
			print("I can embed a reference to a character ``c`` or string (``s.uppercased``)
			       or to numbers like ``i`` or even computations: ``i * f``.
			       No formatting? Binary: ``b`` - Hexa: ``h``");
		}
		fn();

		title("Literal string");
		String literal = """
		                    String with no "interpolation" nor "escapes":
		                    No escape \o/ and ``no interpolation``.
		                    """.normalized; // normalized => no line breaks
		print(literal);

		title("An iterable literal");
		{String+} iterable = { "a", "b", "c" };
		print(iterable); // When printing it, the iterable becomes a sequence

		title("A sequence literal");
		[String+] sequence = [ "A", "B", "C" ];
		print(sequence);
		print(sequence[1]);
		// Another notation
		String[] almostArray = [ "ichi", "ni", "san" ];
		String? probably = almostArray[2]; // String or null
		String? maybe = almostArray[10];
		print("``maybe else "(null)"`` / ``probably else "(null)"``");

		title("Sequence of key, value pairs");
		// Using type inference
		value almostMap = [ "1"->"a", "2"->"b", "3"->"c" ];
		print(almostMap);

		title("Tuple");
		// Heterogenous sequence
		value tuple = [ true, 1, 2.0, '§', "Boo", "k"->"v" ];
		print(tuple);
		print(tuple[4]);

		title("Regular function");
		String triple(String p) { return p + p + p; }
		print(triple("Fun "));

		title("Anonymous function");
		value funfunfun = (String p) => p + p + p;
		print(almostArray.map(funfunfun));
	}

	shared void someBaseTypes()
	{
		stepTitle("Some base types");
		// Skipping Character, String, Integer, Float seen above

		// Official name for {String+}
		Iterable<String> iterable = { "Alpha", "Beta", "Gamma", "Alpha" };
		// Official name for [String+]
		Sequence<String> sequence = [ "Harry", "Ron", "Hermione" ];
		// [String->String+]
		Sequence<Entry<String, String>> sequenceOfEntries = [ "one"->"ichi", "two"->"ni", "three"->"san", "seven"->"shichi", "seven"->"nana" ];

		// Just use them...
		title("Iterable / Sequence API");
		print(iterable.contains("Alpha"));
		print(sequence.filter((String name) => name.startsWith("H")));
		print(sequenceOfEntries.collect((String->String element) => element.key == "seven" then "Foo" else element.item));

		title("List of strings (array)");
		List<String> list = arrayOfSize { size = 5; element = "Yay!"; }; // Named parameters
		assert(is Array<String> list); // Narrow down the type to Array, which is mutable
		list.set(2, "Wee!");
		print(list);

		title("List of strings (lnked list)");
		List<String> llist = LinkedList(sequence);
		print(llist);

		title("Set of strings (from iterable)");
		Set<String> set = HashSet<String>(iterable);
		print(set);
		print(set.contains("alpha"));

		title("Map of strings to strings (from sequence)");
		Map<String, String> map = HashMap(sequenceOfEntries);
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

	shared void simpleControls()
	{
		stepTitle("Simple controls: conditionals and loops");

		title("Source of bugs");
		variable Boolean b = false;
		if (b = true) // Ouch, Ceylon allows this... :-( Newbies write if (a == true) and often forget the second =...
		{
			print("Ouch!");
		}

		title("Simple if");
		Integer a = 42;
		if (a == 6 * 7)
		{
			print("Math is awesome!");
		}

		title("Simple for");
		for (n in 39..a)
		{
			print("Loooooping... ``n``");
		}
		// Can be explicit on type
		for (Integer n in 45..a)
		{
			print("Unloooping... ``n``");
		}
		// Can have an else clause
		else
		{
			print("Finished the loop without interruption");
		}

		title("for each with index");
		value jNumbers = [ "ichi", "ni", "san", "shi", "go", "roku", "shichi" ];
		for (idx->jn in entries(jNumbers))
		{
			print("Counting: ``idx + 1`` is ``jn``");
		}

		title("Zip this");
		value eNumbers = [ "one", "two", "three", "four", "five", "six", "seven" ];
		for (en->jn in zipEntries(eNumbers, jNumbers))
		{
			print("``en`` --> ``jn``");
		}

		title("Meanwhile... let's switch the lights");
		variable Integer n = 0;
		variable [Integer*] seq = [];
		while (n < 5)
		{
			switch (n)
			case (0) { print("Zero"); }
			case (1) { print("One"); }
			case (2) { print("Two"); }
			case (3) { print("Three"); }
			else { print("A lot"); }

			seq = seq.withTrailing(n++);
		}
		print(seq);

		title("Trying hard!");
		try
		{
			print("Before");
			if (n > 1)
			{
				throw Exception { description = "Too big!"; cause = null; };
			}
			print("After");
		}
		catch (e)
		{
			print(e.message);
		}
		finally
		{
			print("Shown whatever the result");
		}
	}

	shared void experiments()
	{
		stepTitle("Some experiments");

		void mutating(variable Integer n, variable LinkedList<String> l) { n += 4; l.set(1, "Yo"); }
		void enabling(String? maybe)
		{
			assert(exists maybe);
			print(maybe);
		}

		variable Integer n = 5;
		variable LinkedList<String> l = LinkedList([ "Foo", "Bar", "Baz" ]);
		mutating(n, l);
		print(n);
		print(l);

		String? possible = "Yeah";
		enabling(possible); // The assert inside doesn't validate here
		String sure = "Hey " + (possible else "Bah");
		print(sure);
	}
}
