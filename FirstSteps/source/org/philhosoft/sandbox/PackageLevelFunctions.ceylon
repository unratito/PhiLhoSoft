"Testing package-level functions..."

void printValue(String | Integer | Float what)
{
	if (is String what)
	{
		print("Got string: " + what);
	}
	else
	{
		print("Got number: ``what``");
	}
}
