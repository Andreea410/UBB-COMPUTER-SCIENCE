#pragma once
#include "service.h"

typedef struct
{
	Controller* ctrl;
} UI;

UI* createUI(Controller* ctrl);

void destroyUI(UI* ui);

void startUI(UI* ui);