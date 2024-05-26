#pragma once
#include "Offer.h"
#include "DynamicArray.h"
#include <string.h>

typedef struct
{
	Offer* offer;
	char* operationType;
} Operation;

Operation* createOperation(Offer* offer, char* operationType);

void destroyOperation(Operation* operation);

Operation* copyOperation(Operation* operation);

char* getOperationType(Operation* operation);

Offer* getOffer(Operation* operation);

// ---------------------------------------------------------------
typedef struct
{
	Operation* operations[100];
	int length;
} OperationsStack;

OperationsStack* createStack();

void destroyStack(OperationsStack* stack);

void push(OperationsStack* stack, Operation* operation);

Operation* pop(OperationsStack* stack);

int isEmpty(OperationsStack* stack);

int isFull(OperationsStack* stack);

void testsStack();