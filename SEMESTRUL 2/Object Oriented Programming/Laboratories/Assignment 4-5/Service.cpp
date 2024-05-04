#include "Service.h"
ManagerRepository Service::getAdminRepo()
{
	return this->admin_repo;
}

bool Service::addAdmin(const Dog &dog)
{
	return this->admin_repo.addAdmin(dog);
}

bool Service::removeAdmin(Dog dog)
{
	return this->admin_repo.removeAdmin(dog);
}

bool Service::updateAdmin(Dog dog, Dog newDog)
{
	return this->admin_repo.updateAdmin(dog, newDog);
}

void Service::generate()
{
	this->admin_repo.addAdmin(Dog("Shitzu", "Jessie", 17, "https://www.akc.org/2017/11/Shih-Tzu-On-White-01.jpg"));
	this->admin_repo.addAdmin(Dog("Bichon", "Maya", 30, "https://www.akc.org/2017/11/Bichon-On-White.jpg"));
	this->admin_repo.addAdmin(Dog("Akita", "Lucky", 11, "https://www.akc.org/2017/11/Akita-01.jpg"));
	this->admin_repo.addAdmin(Dog("Terrier", "Tom", 21, "https://www.akc.org/2017/11/Terrier.jpg"));
	this->admin_repo.addAdmin(Dog("Catle", "John", 19, "https://www.akc.org/2017/11/Catle-White-01.jpg"));
	this->admin_repo.addAdmin(Dog("Sheperd", "Lon", 20, "https://www.akc.org/2017/11/Sheperd-01.jpg"));
	this->admin_repo.addAdmin(Dog("Barbet", "Terry", 40, "https://www.akc.org//2017/11/Barbet-01.jpg"));
	this->admin_repo.addAdmin(Dog("Beagle", "Atos", 19, "https://www.akc.org/2017/11/Beagle-01.jpg"));
	this->admin_repo.addAdmin(Dog("Boxer", "Tommy", 32, "https://www.akc.org/2017/11/Boxer-01.jpg"));
	this->admin_repo.addAdmin(Dog("Terrie", "Polly", 89, "https://www.akc.org/2017/11/Terrie-01.jpg"));

}

UserRepository Service::getUserRepo()
{
	return this->user_repo;
}

bool Service::addUser(Dog &dog)
{
	return this->user_repo.addUser(dog);
}
