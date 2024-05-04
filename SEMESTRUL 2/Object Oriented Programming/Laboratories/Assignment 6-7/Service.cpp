#include "Service.h"
#include "Repository.h"
#include "TextRepository.h"
using namespace std;

Service::Service(Repository* repository, const string filename) : repository{ repository }
{}

Service::~Service()
{
}

Repository *Service::getRepo()
{
	return this->repository;
}

void Service::addAdmin(const Dog& dog)
{
	this->validator.validate(dog);
	this->repository->addAdmin(dog);

}

void Service::removeAdmin(Dog dog)
{
	this->validator.validate(dog);
	this->repository->removeAdmin(dog);
}

void Service::updateAdmin(Dog dog, Dog newDog)
{
	this->validator.validate(dog);
	this->validator.validate(newDog);
	this->repository->updateAdmin(dog, newDog);
}	

void Service::generate()
{
	this->repository->addAdmin(Dog("Shitzu", "Jessie", 17, "https://www.akc.org/2017/11/Shih-Tzu-On-White-01.jpg" , false));
	this->repository->addAdmin(Dog("Bichon", "Maya", 30, "https://www.akc.org/2017/11/Bichon-On-White.jpg" , false));
	this->repository->addAdmin(Dog("Akita", "Lucky", 11, "https://www.akc.org/2017/11/Akita-01.jpg" , false));
	/*this->repository.addAdmin(Dog("Terrier", "Tom", 21, "https://www.akc.org/2017/11/Terrier.jpg" , false));
	this->repository.addAdmin(Dog("Catle", "John", 19, "https://www.akc.org/2017/11/Catle-White-01.jpg" , false));
	this->repository.addAdmin(Dog("Sheperd", "Lon", 20, "https://www.akc.org/2017/11/Sheperd-01.jpg", false));
	this->repository.addAdmin(Dog("Barbet", "Terry", 40, "https://www.akc.org//2017/11/Barbet-01.jpg", false));
	this->repository.addAdmin(Dog("Beagle", "Atos", 19, "https://www.akc.org/2017/11/Beagle-01.jpg", false));
	this->repository.addAdmin(Dog("Boxer", "Tommy", 32, "https://www.akc.org/2017/11/Boxer-01.jpg", false));
	this->repository.addAdmin(Dog("Terrie", "Polly", 89, "https://www.akc.org/2017/11/Terrie-01.jpg", false));*/

}

void Service::addUser(Dog dog)
{
	this->repository->addUser(dog);
}