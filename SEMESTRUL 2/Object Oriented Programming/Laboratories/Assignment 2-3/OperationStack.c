#define _CRT_SECURE_NO_WARNINGS
#include "OperationsStack.h"
#include <string.h>
#include <stdlib.h>
#include <assert.h>

Operation* createOperation(Offer* offer, char* operationType)
{
	Operation* operation = (Operation*)malloc(sizeof(Operation));
	operation->offer = copyOffer(offer);

	if (operationType != NULL)
	{
		operation->operationType = (char*)malloc(sizeof(char) * (strlen(operationType) + 1));
		strcpy(operation->operationType, operationType);
	}
	else
		operation->operationType = NULL;

	return operation;
}

void destroyOperation(Operation* operation)
{
	if (operation == NULL)
		return;

	// first destroy the planet
	destroyOffer(operation->offer);
	// then the operationType
	free(operation->operationType);
	// then free the operation
	free(operation);
}

Operation* copyOperation(Operation* operation)
{
	if (operation == NULL)
		return NULL;

	Operation* newOperation = createOperation(operation->offer, operation->operationType);
	return newOperation;
}

char* getOperationType(Operation* operation)
{
	return operation->operationType;
}

Offer* getOffer(Operation* operation)
{
	return operation->offer;
}

// ---------------------------------------------------------------

OperationsStack* createStack()
{
	OperationsStack* stack = (OperationsStack*)malloc(sizeof(OperationsStack));
	stack->length = 0;

	return stack;
}

void destroyStack(OperationsStack* stack)
{
	if (stack == NULL)
		return;

	// first deallocate memory of operations (this is allocated when a new operation is pushed onto the stack)
	for (int i = 0; i < stack->length; i++)
		destroyOperation(stack->operations[i]);

	// then free the stack
	free(stack);
}

void push(OperationsStack* stack, Operation* operation)
{
	if (isFull(stack))
		return;

	stack->operations[stack->length++] = copyOperation(operation);	// copies of operations are added, such that the stask manages its own operations
}

Operation* pop(OperationsStack* stack)
{
	if (isEmpty(stack))
		return NULL;
	stack->length--;
	return stack->operations[stack->length];
}

int isEmpty(OperationsStack* stack)
{
	return (stack->length == 0);
}

int isFull(OperationsStack* stack)
{
	return stack->length == 100;
}


// Tests
void testsStack()
{
	OperationsStack* stack = createStack();

	Offer* offer1 = createOffer("citybreak", "Sibiu", 2, "May", 200);
	Offer* offer2 = createOffer("citybreak", "Viena", 19, "March", 2000);
	Operation* operation1 = createOperation(offer1, "add");
	Operation* operation2 = createOperation(offer2, "add");
	Operation* operation3 = createOperation(offer1, "remove");

	// the planets may be destroyed, as the operations contain copies of these planets
	destroyOffer(offer1);
	destroyOffer(offer2);

	push(stack, operation1);
	push(stack, operation2);
	push(stack, operation3);

	// the operations may be destroyed, as the stack contains copies of these operations
	destroyOperation(operation1);
	destroyOperation(operation2);
	destroyOperation(operation3);

	assert(isFull(stack) == 0);
	assert(isEmpty(stack) == 0);
	Operation* operation = pop(stack);
	assert(strcmp(operation->operationType, "remove") == 0);
	// after each pop, the operations must be destroyed
	destroyOperation(operation);

	operation = pop(stack);
	assert(strcmp(operation->operationType, "add") == 0);
	destroyOperation(operation);

	operation = pop(stack);
	assert(strcmp(operation->operationType, "add") == 0);
	destroyOperation(operation);

	assert(isEmpty(stack) == 1);

	// destroy the stack
	destroyStack(stack);
}