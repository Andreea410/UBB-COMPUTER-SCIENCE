#include "Repository.h"
#include "UI.h"
#include <crtdbg.h>
#include <Windows.h>

int main()
{	//some tests
	testsOffersRepo();
	testsStack();
	//Repository,Ccontroller and UI are created 
	OffersRepo* repo = createRepo();
	OperationsStack* undo = createStack();
	OperationsStack* redo = createStack();
	Controller* ctrl = createController(repo, undo, redo);

	//Here we add some entities
	addOfferCtrl(ctrl, "citybreak", "Viena", 19, "March", 500);
	addOfferCtrl(ctrl, "seaside", "Mamaia", 23, "July", 200);
	addOfferCtrl(ctrl, "citybreak", "Sibiu", 2, "May", 200);
	addOfferCtrl(ctrl, "citybreak", "Sibiu", 3, "September", 300);
	addOfferCtrl(ctrl, "citybreak", "Cluj-Napoca", 4, "August", 2000);
	addOfferCtrl(ctrl, "mountain", "Arieseni", 25, "December", 1000);
	addOfferCtrl(ctrl, "seaside", "Parga", 5, "August", 5000);
	addOfferCtrl(ctrl, "seaside", "Eforie Nord", 25, "June", 3000);
	addOfferCtrl(ctrl, "mountain", "Alpi", 23, "November", 5000);
	addOfferCtrl(ctrl, "mountain", "Straja", 3, "March", 500);

	UI* ui = createUI(ctrl);

	startUI(ui);

	
	destroyUI(ui);

	_CrtDumpMemoryLeaks();

	return 0;
}