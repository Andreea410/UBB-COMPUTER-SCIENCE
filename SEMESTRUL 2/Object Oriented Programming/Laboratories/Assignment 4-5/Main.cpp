#include "ManagerUi.h"
#include "UserUi.h"
#include "Tests.h"
#include "ManagerRepository.h"
#include "UserRepository.h"

void start()
{
	cout << "Welcome to the KEEP CALM AND ADOPT A PET";
}

int main()
{
	//Tests tests;
	ManagerRepository manager_repo;
	UserRepository user_repo;
	//tests.test_all();
	start();
	cout << endl;
	cout << endl;
	while (1)
	{
		cout << "How do you want to log in: (user/admin/exit): ";
		string option;
		cin >> option;
		Service service(manager_repo , user_repo);
		while (option != "user" && option != "admin" && option != "exit")
		{
			cout << "Invalid option.Please try again: ";
			cin >> option;
		}
		if (option == "admin")
		{
			managerUI manager(service);
			manager.runManagerUi();
		}
		else
			if (option == "user")
			{
				UserUI user(service);
				user.runUserUI();
			}
			else
				return 0;
	}
	return 0;
}