"Run the module `org.philhosoft.sandbox`."
shared void run()
{
	value firstSteps = FirstSteps();
	firstSteps.exploringLiterals();
	firstSteps.someBaseTypes();
	firstSteps.simpleControls();
}

void stepTitle(String title)
{
	print("\n##### ``title`` #####\n");
}

void title(String title)
{
	print("===== ``title`` =====");
}
