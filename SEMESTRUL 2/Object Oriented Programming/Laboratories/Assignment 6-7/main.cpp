#include "UI.h"
#include "Tests.h"
#include "Service.h"
#include "TextRepository.h"
#include "CSVRepository.h"
#include "HTMLRepository.h"

void start()
{
	cout << "Welcome to the ";
	cout << "How do you want to log in: (user/admin/exit): ";
}

int main()
{
	
	string filetype;
	cout << "Please enter the file type (CSV/HTML): ";
	cin >> filetype;
	while (filetype != "CSV" && filetype!="HTML")
		{
		cout << "Invalid file type. Please enter the file type (CSV/HTML): ";
		cin >> filetype;
	}
	if (filetype == "CSV")
	{
		Repository *repo = new CSVRepository("dogs.csv");
		Service service = Service(repo,"dogs.csv");
		UI ui = UI(service);
		ui.run();
	}
	else
	{
		Repository *repo = new HTMLRepository("dogs.html");
		Service service = Service(repo, "dogs.html");
		UI ui = UI(service);
		ui.run();
	}
}